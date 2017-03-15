From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 15 Mar 2017 13:14:38 -0300
Subject: [PATCH v3] arm: install.sh: don't use /sbin/install if cross-compiling
Message-ID: <d3a0049dc4c9064213bc40594ab2cc5d9f8a9e23.1489594469.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make sense to run the local machine's install
script if the Kernel was built using a cross-compiler, as it
will try to create symlinks at the rootfs of the local machine:

ln: failed to create symbolic link '/boot/System.map': Permission denied
ln: failed to create symbolic link '/boot/vmlinuz': Permission denied
ln: failed to create symbolic link '/boot/System.map': Permission denied

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 arch/arm/boot/install.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
index 2a45092a40e3..5384f0ff91ea 100644
--- a/arch/arm/boot/install.sh
+++ b/arch/arm/boot/install.sh
@@ -36,7 +36,10 @@ verify "$3"
 
 # User may have a custom install script
 if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+
+if [ "x$CROSS_COMPILE" == "x" ]; then
+  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+fi
 
 if [ "$(basename $2)" = "zImage" ]; then
 # Compressed install
-- 
2.9.3
