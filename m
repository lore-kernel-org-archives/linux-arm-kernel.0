From: robherring2@gmail.com (Rob Herring)
Date: Thu, 10 Mar 2011 13:46:21 -0600
Subject: [PATCH] arm/dt: Add dtb make rule
Message-ID: <1299786381-8925-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a make rule to compile dt blobs for ARM.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Makefile      |    3 +++
 arch/arm/boot/Makefile |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b49dea6..566763f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -284,6 +284,9 @@ zImage Image xipImage bootpImage uImage: vmlinux
 zinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
+%.dtb:
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index dcf323d..bb63922 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -13,6 +13,8 @@
 
 MKIMAGE         := $(srctree)/scripts/mkuboot.sh
 
+DTC_FLAGS := -p 1024
+
 ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
 endif
@@ -59,6 +61,10 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 
 endif
 
+# Rule to build device tree blobs
+$(obj)/%.dtb: $(src)/dts/%.dts
+	$(call cmd,dtc)
+
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
 		   -C none -a $(LOADADDR) -e $(STARTADDR) \
-- 
1.7.1
