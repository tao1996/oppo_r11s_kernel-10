#!/bin/bash
KERNEL_DIR=$(pwd)
IMAGE="${KERNEL_DIR}/out/arch/arm64/boot/Image.gz-dtb"
TANGGAL=$(date +"%Y%m%d-%H")
export ARCH=arm64
export KBUILD_BUILD_USER="tao1996"
export KBUILD_BUILD_HOST=ubuntu
# Compile plox
function compile() {
    make -j$(nproc) O=out ARCH=arm64 r11s_defconfig
    make -j$(nproc) O=out \
                      ARCH=arm64 \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi- \

    if ! [ -a "$IMAGE" ]; then
        exit 1
        echo "There are some issues"
    fi
}
# Zipping
function zipping() {
    cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
    cd AnyKernel
    rm -rf *.zip
    zip -r9 OPPO-R11S-KERNEL-${TANGGAL}.zip *
    cd ..
}
compile
zipping
