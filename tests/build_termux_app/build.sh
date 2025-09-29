#!/bin/sh
set -eu

SCRIPT_DIR=$(dirname $(realpath $0))
ROOT_DIR=$(dirname $(dirname "${SCRIPT_DIR}"))

. ${PREFIX-}/etc/profile.d/android_build.sh

## Clone termux
if ! test -d "${SCRIPT_DIR}/termux-app"; then
    git clone https://github.com/zongou/termux-app "${SCRIPT_DIR}/termux-app" --depth=1
fi

cd "${SCRIPT_DIR}/termux-app"
git clean -xdf

## Gradle properties files
## https://developer.android.google.cn/build?hl=en#properties-files
rm -f local.properties
cat <<-EOF >local.properties
# sdk.dir=${ANDROID_HOME}
ndk.dir=${ANDROID_NDK_ROOT}
EOF

unset ANDROID_SDK_ROOT
${GRADLE} assembleRelease "$@"
