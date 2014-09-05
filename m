From: rric@kernel.org (Robert Richter)
Date: Fri,  5 Sep 2014 08:48:07 +0200
Subject: [PATCH 1/6] dts, arm64: Add dtbs_install make target
In-Reply-To: <1409899692-1455-1-git-send-email-rric@kernel.org>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
Message-ID: <1409899692-1455-2-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This adds the dtbs_install make target to arm64. The target has been
introduced already to arch/arm with the following commit:

 f4d4ffc03efc kbuild: dtbs_install: new make target

Implementation for arm64 is the same as for arm.

With 'dtbs_install' all config enabled dtb files are installed to
either the INSTALL_DTBS_PATH directory or the default location:

 $INSTALL_PATH/dtbs/$KERNELRELEASE

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Makefile          | 6 ++++--
 arch/arm64/boot/dts/Makefile | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2df5e5daeebe..e0a8292bc832 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -71,8 +71,9 @@ zinstall install: vmlinux
 %.dtb: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
 
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts dtbs
+PHONY += dtbs dtbs_install
+dtbs dtbs_install: prepare scripts
+	$(Q)$(MAKE) $(build)=$(boot)/dts $@
 
 PHONY += vdso_install
 vdso_install:
@@ -86,6 +87,7 @@ define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
   echo  '* dtbs          - Build device tree blobs for enabled boards'
+  echo  '  dtbs_install  - Install dtbs to $(INSTALL_DTBS_PATH)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c52bdb051f66..82e1c4cf8780 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,9 +1,11 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
-targets += dtbs
+targets += dtbs dtbs_install
 targets += $(dtb-y)
 
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 
 clean-files := *.dtb
+
+dtbs_install: $(addsuffix _dtbinst_, $(dtb-y))
-- 
2.0.1
