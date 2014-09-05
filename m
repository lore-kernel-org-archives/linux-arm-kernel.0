From: rric@kernel.org (Robert Richter)
Date: Fri,  5 Sep 2014 08:48:10 +0200
Subject: [PATCH 4/6] dts, kbuild: Implement support for dtb vendor subdirs
In-Reply-To: <1409899692-1455-1-git-send-email-rric@kernel.org>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
Message-ID: <1409899692-1455-5-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch adds support of vendor sub directories for dtb files.
Subdirectories can be specified in $(dts-dirs). Kbuild traverses over
all directories while building and installing dtb files. The directory
tree is also reflected in the install path.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/boot/dts/Makefile |  1 +
 scripts/Makefile.dtbinst     | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index d116da5f2f20..9b8622532068 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -2,4 +2,5 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
 always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 54286cccc289..909ed7a2ac61 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -6,6 +6,7 @@
 #
 #   $INSTALL_PATH/dtbs/$KERNELRELEASE
 #
+# Traverse through subdirectories listed in $(dts-dirs).
 # ==========================================================================
 
 src := $(obj)
@@ -13,26 +14,38 @@ src := $(obj)
 PHONY := __dtbs_install
 __dtbs_install:
 
+export dtbinst-root ?= $(obj)
+
 include include/config/auto.conf
 include scripts/Kbuild.include
 include $(srctree)/$(obj)/Makefile
 
 PHONY += __dtbs_install_prep
 __dtbs_install_prep:
+ifeq ("$(dtbinst-root)", "$(obj)")
 	$(Q)if [ -d $(INSTALL_DTBS_PATH).old ]; then rm -rf $(INSTALL_DTBS_PATH).old; fi
 	$(Q)if [ -d $(INSTALL_DTBS_PATH) ]; then mv $(INSTALL_DTBS_PATH) $(INSTALL_DTBS_PATH).old; fi
 	$(Q)mkdir -p $(INSTALL_DTBS_PATH)
+endif
 
 dtbinst-files	:= $(dtb-y)
+dtbinst-dirs	:= $(dts-dirs)
 
 # Helper targets for Installing DTBs into the boot directory
 quiet_cmd_dtb_install =	INSTALL $<
-      cmd_dtb_install =	cp $< $(2)
+      cmd_dtb_install =	mkdir -p $(2); cp $< $(2)
+
+install-dir = $(patsubst $(dtbinst-root)%,$(INSTALL_DTBS_PATH)%,$(obj))
+
+$(dtbinst-files) $(dtbinst-dirs): | __dtbs_install_prep
+
+$(dtbinst-files): %.dtb: $(obj)/%.dtb
+	$(call cmd,dtb_install,$(install-dir))
 
-$(dtbinst-files): %.dtb: $(obj)/%.dtb | __dtbs_install_prep
-	$(call cmd,dtb_install,$(INSTALL_DTBS_PATH))
+$(dtbinst-dirs):
+	$(Q)$(MAKE) $(dtbinst)=$(obj)/$@
 
-PHONY += $(dtbinst-files)
-__dtbs_install: $(dtbinst-files)
+PHONY += $(dtbinst-files) $(dtbinst-dirs)
+__dtbs_install: $(dtbinst-files) $(dtbinst-dirs)
 
 .PHONY: $(PHONY)
-- 
2.0.1
