From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:11:29 +0200
Subject: [PATCH 1/7] ARM: nuc900: move regs-ldm.h to video driver
Message-ID: <20160714111135.2476095-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is one of only three nuc900 drivers that use mach/*.h headers,
and it's fairly easy to avoid if we separate the LCM_DCCS_VA_SRC
definition that is needed for platform data from the other registers:

The global mach/regs-ldm.h file becomes a local nuc900fb-regs.h
header, and is only used by that one driver, while the LCM_DCCS_VA_SRC
enum gets moved into the platform_data header that uses it, to let
the device definition see the values.

The only other reference to a header in the framebuffer driver is for
the pin configuration, and we can simply avoid that by passing the
address along with the data and mask.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-w90x900/dev.c                               |  3 ++-
 .../regs-ldm.h => drivers/video/fbdev/nuc900fb-regs.h     | 15 ---------------
 drivers/video/fbdev/nuc900fb.c                            |  8 +++-----
 drivers/video/fbdev/nuc900fb.h                            |  1 -
 include/linux/platform_data/video-nuc900fb.h              | 14 +++++++++++++-
 5 files changed, 18 insertions(+), 23 deletions(-)
 rename arch/arm/mach-w90x900/include/mach/regs-ldm.h => drivers/video/fbdev/nuc900fb-regs.h (94%)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index e65a80a1ac75..ea84f053bcd3 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -38,7 +38,6 @@
 #include <linux/platform_data/spi-nuc900.h>
 #include <mach/map.h>
 #include <linux/platform_data/video-nuc900fb.h>
-#include <mach/regs-ldm.h>
 #include <linux/platform_data/keypad-w90p910.h>
 
 #include "cpu.h"
@@ -455,8 +454,10 @@ static struct nuc900fb_mach_info nuc900_fb_info = {
 #endif
 	.num_displays		= ARRAY_SIZE(nuc900_lcd_info),
 	.default_display	= 0,
+	.gpio_dir_addr		= W90X900_VA_GPIO + 0x54,
 	.gpio_dir		= 0x00000004,
 	.gpio_dir_mask		= 0xFFFFFFFD,
+	.gpio_data_addr		= W90X900_VA_GPIO + 0x58,
 	.gpio_data		= 0x00000004,
 	.gpio_data_mask		= 0xFFFFFFFD,
 };
diff --git a/arch/arm/mach-w90x900/include/mach/regs-ldm.h b/drivers/video/fbdev/nuc900fb-regs.h
similarity index 94%
rename from arch/arm/mach-w90x900/include/mach/regs-ldm.h
rename to drivers/video/fbdev/nuc900fb-regs.h
index e9d480a5b232..c6ba567bb11f 100644
--- a/arch/arm/mach-w90x900/include/mach/regs-ldm.h
+++ b/drivers/video/fbdev/nuc900fb-regs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-w90x900/include/mach/regs-serial.h
- *
  * Copyright (c) 2009 Nuvoton technology corporation
  * All rights reserved.
  *
@@ -19,8 +17,6 @@
 #ifndef __ASM_ARM_W90X900_REGS_LDM_H
 #define __ASM_ARM_W90X900_REGS_LDM_H
 
-#include <mach/map.h>
-
 /* Display Controller Control/Status Register */
 #define REG_LCM_DCCS			(0x00)
 
@@ -33,17 +29,6 @@
 #define LCM_DCCS_FIELD_INTR		(1 << 6)
 #define LCM_DCCS_SINGLE			(1 << 7)
 
-enum LCM_DCCS_VA_SRC {
-	LCM_DCCS_VA_SRC_YUV422		= (0 << 8),
-	LCM_DCCS_VA_SRC_YCBCR422	= (1 << 8),
-	LCM_DCCS_VA_SRC_RGB888		= (2 << 8),
-	LCM_DCCS_VA_SRC_RGB666		= (3 << 8),
-	LCM_DCCS_VA_SRC_RGB565		= (4 << 8),
-	LCM_DCCS_VA_SRC_RGB444LOW	= (5 << 8),
-	LCM_DCCS_VA_SRC_RGB444HIGH 	= (7 << 8)
-};
-
-
 /* Display Device Control Register */
 #define REG_LCM_DEV_CTRL		(0x04)
 
diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
index 6680edae4696..d29777d85518 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -35,11 +35,9 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-ldm.h>
 #include <linux/platform_data/video-nuc900fb.h>
 
+#include "nuc900fb-regs.h"
 #include "nuc900fb.h"
 
 
@@ -373,9 +371,9 @@ static int nuc900fb_init_registers(struct fb_info *info)
 	writel(0, regs + REG_LCM_DEV_CTRL);
 
 	/* config gpio output */
-	modify_gpio(W90X900_VA_GPIO + 0x54, mach_info->gpio_dir,
+	modify_gpio(mach_info->gpio_dir_addr, mach_info->gpio_dir,
 		    mach_info->gpio_dir_mask);
-	modify_gpio(W90X900_VA_GPIO + 0x58, mach_info->gpio_data,
+	modify_gpio(mach_info->gpio_data_addr, mach_info->gpio_data,
 		    mach_info->gpio_data_mask);
 
 	return 0;
diff --git a/drivers/video/fbdev/nuc900fb.h b/drivers/video/fbdev/nuc900fb.h
index 9a1ca6dbb6b2..a904ef17c122 100644
--- a/drivers/video/fbdev/nuc900fb.h
+++ b/drivers/video/fbdev/nuc900fb.h
@@ -15,7 +15,6 @@
 #ifndef __NUC900FB_H
 #define __NUC900FB_H
 
-#include <mach/map.h>
 #include <linux/platform_data/video-nuc900fb.h>
 
 enum nuc900_lcddrv_type {
diff --git a/include/linux/platform_data/video-nuc900fb.h b/include/linux/platform_data/video-nuc900fb.h
index cec5ece765ed..dbce9dd7a294 100644
--- a/include/linux/platform_data/video-nuc900fb.h
+++ b/include/linux/platform_data/video-nuc900fb.h
@@ -38,10 +38,20 @@ struct nuc900fb_hw {
 	unsigned int lcd_va_stuff;
 };
 
+enum LCM_DCCS_VA_SRC {
+	LCM_DCCS_VA_SRC_YUV422		= (0 << 8),
+	LCM_DCCS_VA_SRC_YCBCR422	= (1 << 8),
+	LCM_DCCS_VA_SRC_RGB888		= (2 << 8),
+	LCM_DCCS_VA_SRC_RGB666		= (3 << 8),
+	LCM_DCCS_VA_SRC_RGB565		= (4 << 8),
+	LCM_DCCS_VA_SRC_RGB444LOW	= (5 << 8),
+	LCM_DCCS_VA_SRC_RGB444HIGH 	= (7 << 8)
+};
+
 /* LCD Display Description */
 struct nuc900fb_display {
 	/* LCD Image type */
-	unsigned type;
+	enum LCM_DCCS_VA_SRC type;
 
 	/* LCD Screen Size */
 	unsigned short width;
@@ -72,8 +82,10 @@ struct nuc900fb_mach_info {
 	unsigned num_displays;
 	unsigned default_display;
 	/* GPIO Setting  Info */
+	void __iomem *gpio_dir_addr;
 	unsigned gpio_dir;
 	unsigned gpio_dir_mask;
+	void __iomem *gpio_data_addr;
 	unsigned gpio_data;
 	unsigned gpio_data_mask;
 };
-- 
2.9.0
