From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 15 Mar 2017 09:43:21 -0300
Subject: [PATCH] arm: install.sh: don't use /sbin/install if cross-compiling
Message-ID: <ca1a7552e8c3705dbcb64ff3b2e6ad5616a1073a.1489581503.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make sense to run the local machine's install
script if the Kernel was built using a cross-compiler, as it
will try to create symlinks at the rootfs on the local machine:

$ export ROOTDIR=/devel/arm_rootdir/
$ make CROSS_COMPILE=arm-linux- ARCH=arm INSTALL_PATH=$ROOTDIR INSTALL_MOD_PATH=$ROOTDIR INSTALL_FW_PATH=$ROOTDIR INSTALL_HDR_PATH=$ROOTDIR zinstall
/bin/sh ./arch/arm/boot/install.sh "4.11.0-rc1-00545-g940f6daec092-dirty" \
arch/arm/boot/zImage System.map "/devel/arm_rootdir/"
ln: failed to create symbolic link '/boot/System.map': Permission denied
ln: failed to create symbolic link '/boot/vmlinuz': Permission denied
ln: failed to create symbolic link '/boot/System.map': Permission denied

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 arch/arm/boot/install.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
index 2a45092a40e3..32f821df524d 100644
--- a/arch/arm/boot/install.sh
+++ b/arch/arm/boot/install.sh
@@ -35,8 +35,11 @@ verify "$2"
 verify "$3"
 
 # User may have a custom install script
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+
+if [ "x$CROSS_COMPILE" == "x" ]; then
+  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
+  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+fi
 
 if [ "$(basename $2)" = "zImage" ]; then
 # Compressed install
-- 
2.9.3
