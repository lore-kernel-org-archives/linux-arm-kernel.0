From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 19 Feb 2016 15:05:50 +0900
Subject: [PATCH] arm64, kbuild:  make "make install" not depend on vmlinux
Message-ID: <1455861950-21832-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the same reason as commit 19514fc665ff (arm, kbuild: make "make
install" not depend on vmlinux), the install targets should never
trigger the rebuild of the kernel.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Makefile        |  2 +-
 arch/arm64/boot/Makefile   |  4 ++--
 arch/arm64/boot/install.sh | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 307237c..b5e3f6d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -88,7 +88,7 @@ Image: vmlinux
 Image.%: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-zinstall install: vmlinux
+zinstall install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 %.dtb: scripts
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index abcbba2..305c552 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -34,10 +34,10 @@ $(obj)/Image.lzma: $(obj)/Image FORCE
 $(obj)/Image.lzo: $(obj)/Image FORCE
 	$(call if_changed,lzo)
 
-install: $(obj)/Image
+install:
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
-zinstall: $(obj)/Image.gz
+zinstall:
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/arm64/boot/install.sh b/arch/arm64/boot/install.sh
index 12ed78a..d91e1f0 100644
--- a/arch/arm64/boot/install.sh
+++ b/arch/arm64/boot/install.sh
@@ -20,6 +20,20 @@
 #   $4 - default install path (blank if root directory)
 #
 
+verify () {
+	if [ ! -f "$1" ]; then
+		echo ""                                                   1>&2
+		echo " *** Missing file: $1"                              1>&2
+		echo ' *** You need to run "make" before "make install".' 1>&2
+		echo ""                                                   1>&2
+		exit 1
+	fi
+}
+
+# Make sure the files actually exist
+verify "$2"
+verify "$3"
+
 # User may have a custom install script
 if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
 if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-- 
1.9.1
