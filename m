From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue,  9 Nov 2010 14:50:56 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
Message-ID: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/boot/Makefile |   10 ++++++++--
 init/Kconfig           |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..37618b8 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -77,11 +77,17 @@ else
 $(obj)/uImage: STARTADDR=$(LOADADDR)
 endif
 
-$(obj)/uImage:	$(obj)/zImage FORCE
+ifeq ($(CONFIG_KERNEL_NONE),y)
+ARM_IMAGE := Image
+else
+ARM_IMAGE := zImage
+endif
+
+$(obj)/uImage:	$(obj)/$(ARM_IMAGE) FORCE
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
 
-$(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
+$(obj)/bootp/bootp: $(obj)/$(ARM_IMAGE) initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 	@:
 
diff --git a/init/Kconfig b/init/Kconfig
index 88c1046..355d7a5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -155,6 +155,13 @@ choice
 
 	  If in doubt, select 'gzip'
 
+config KERNEL_NONE
+	bool "None"
+	depends on ARM
+	help
+	  If you want to use get a fast startup at the cost of kernel size
+	  you can use an uncompressed kernel.
+
 config KERNEL_GZIP
 	bool "Gzip"
 	depends on HAVE_KERNEL_GZIP
-- 
1.7.2.2
