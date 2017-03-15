From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 15 Mar 2017 12:48:59 -0300
Subject: [PATCH v2] arm: install.sh: don't use /sbin/install if cross-compiling
Message-ID: <6675ef47aaa7a186f066c506a564e71c54559776.1489592885.git.mchehab@s-opensource.com>
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

v2: keep calling a ~/bin/${INSTALLKERNEL} script, as it can be used to cope with
cross builds.

 arch/arm/boot/install.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
index 2a45092a40e3..831e63ac8b0f 100644
--- a/arch/arm/boot/install.sh
+++ b/arch/arm/boot/install.sh
@@ -35,8 +35,11 @@ verify "$2"
 verify "$3"
 
 # User may have a custom install script
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+
+  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/ "$@"; fi
+if [ "x$CROSS_COMPILE" == "x" ]; then
+  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+fi
 
 if [ "$(basename $2)" = "zImage" ]; then
 # Compressed install
-- 
2.9.3
