From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 28 Feb 2012 17:03:23 -0700
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T kernel_noload
Message-ID: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uImage files typically encode a single absolute load and entry address.
This is inconvenient when attempting to share that uImage across multiple
SoCs with different physical RAM addresses. Recent versions of mkimage
implement a "kernel_noload" image type which encodes no absolute load
address, and a relative entry address. This works well for uImage-wrapped
ARM zImages, since they are relocatable.

This is enabled by commit b9b50e89d317c58becd0e2d7fac2e21e3a81dd0a
"image: Implement IH_TYPE_KERNEL_NOLOAD" in U-Boot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I assume I should put this into the ARM patch tracker if it's OK?

 arch/arm/Kconfig       |   15 +++++++++++++++
 arch/arm/boot/Makefile |   15 ++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0884b67..27e7672 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2066,6 +2066,21 @@ config AUTO_ZRELADDR
 	  0xf8000000. This assumes the zImage being placed in the first 128MB
 	  from start of memory.
 
+config UIMAGE_NOLOAD
+	bool "Using mkimage's kernel_noload image type"
+	depends on AUTO_ZRELADDR
+	help
+	  Say Y here to build a uImage using type "kernel_noload" instead of
+	  "kernel".
+
+	  uImage files typically encode a single absolute load and entry
+	  address. This is inconvenient when attempting to share that uImage
+	  across multiple SoCs with different physical RAM addresses. Recent
+	  versions of mkimage implement a "kernel_noload" image type which
+	  encodes no absolute load address, and a relative entry address.
+	  This works well for uImage-wrapped ARM zImages, since they are
+	  relocatable.
+
 endmenu
 
 menu "CPU Power Management"
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index fc871e7..45c3cbe 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -70,10 +70,21 @@ $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
 clean-files := *.dtb
 
 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
+      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux \
+		   -T $(UIMAGE_TYPE) \
 		   -C none -a $(LOADADDR) -e $(STARTADDR) \
 		   -n 'Linux-$(KERNELRELEASE)' -d $< $@
 
+ifeq ($(CONFIG_UIMAGE_NOLOAD),y)
+
+$(obj)/uImage: UIMAGE_TYPE := kernel_noload
+$(obj)/uImage: override LOADADDR := 0
+$(obj)/uImage: STARTADDR := 0 # Relative to load address
+
+else
+
+$(obj)/uImage: UIMAGE_TYPE := kernel
+
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
 else
@@ -82,6 +93,8 @@ endif
 
 $(obj)/uImage: STARTADDR=$(LOADADDR)
 
+endif
+
 check_for_multiple_loadaddr = \
 if [ $(words $(LOADADDR)) -gt 1 ]; then \
 	echo 'multiple load addresses: $(LOADADDR)'; \
-- 
1.7.0.4
