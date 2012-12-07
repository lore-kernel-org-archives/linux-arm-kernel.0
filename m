From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  7 Dec 2012 21:06:27 +0000
Subject: [PATCH 2/7] arm64: Add dtbs target for building all the enabled dtb
 files
In-Reply-To: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1354914392-9634-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Rob Herring's patches for arch/arm, this patch adds a dtbs
target to arch/arm64/boot/Makefile. In the process, also clean up the
unused MACHINE variable.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

I'll drop this patch once Rob pushes his version into linux-next (or
mainline).

 arch/arm64/Makefile        | 17 +++++++++++------
 arch/arm64/boot/.gitignore |  1 +
 arch/arm64/boot/Makefile   |  8 +++++++-
 3 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/Makefile

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 364191f..64089bc 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -41,20 +41,24 @@ libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
 # Default target when executing plain make
-KBUILD_IMAGE := Image.gz
+KBUILD_IMAGE	:= Image.gz
+KBUILD_DTBS	:= dtbs
 
-all:	$(KBUILD_IMAGE)
+all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
 
 boot := arch/arm64/boot
 
 Image Image.gz: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 zinstall install: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
+	$(Q)$(MAKE) $(build)=$(boot) $@
 
-%.dtb:
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+%.dtb: scripts
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
@@ -63,6 +67,7 @@ archclean:
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+  echo  '* dtbs          - Build device tree blobs for enabled boards'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
index 8dab0bb..98af90a 100644
--- a/arch/arm64/boot/.gitignore
+++ b/arch/arm64/boot/.gitignore
@@ -1,2 +1,3 @@
 Image
 Image.gz
+*.dtb
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index eca209b..1ab9bf1 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -14,6 +14,8 @@
 # Based on the ia64 boot/Makefile.
 #
 
+include $(srctree)/arch/arm64/boot/dts/Makefile
+
 targets := Image Image.gz
 
 $(obj)/Image: vmlinux FORCE
@@ -22,9 +24,13 @@ $(obj)/Image: vmlinux FORCE
 $(obj)/Image.gz: $(obj)/Image FORCE
 	$(call if_changed,gzip)
 
-$(obj)/%.dtb: $(src)/dts/%.dts
+targets += $(dtb-y)
+
+$(obj)/%.dtb: $(src)/dts/%.dts FORCE
 	$(call cmd,dtc)
 
+$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
+
 install: $(obj)/Image
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
new file mode 100644
index 0000000..e69de29
