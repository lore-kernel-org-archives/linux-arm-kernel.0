From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Oct 2011 15:29:59 +0900
Subject: [PATCH RE-SEND 2/5] ARM: S3C64XX: To merge devs.c files to one devs.c
Message-ID: <00e801cc83f1$5f248e50$1d6daaf0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves regarding s3c64xx dev files to one devs.c
file in plat-samsung directory and this help to keep it more
easily.

Cc: Ben Dooks <ben-linux-fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Makefile       |    2 -
 arch/arm/mach-s3c64xx/dev-onenand1.c |   53 ----------------------------------
 arch/arm/plat-samsung/devs.c         |   35 ++++++++++++++++++++++
 3 files changed, 35 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-onenand1.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 902ab9a..cfc0b99 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -61,5 +61,3 @@ obj-$(CONFIG_MACH_WLF_CRAGG_6410) += mach-crag6410.o mach-crag6410-module.o
 obj-y				+= dev-uart.o
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
-obj-$(CONFIG_S3C64XX_DEV_TS)	+= dev-ts.o
-obj-$(CONFIG_S3C64XX_DEV_ONENAND1)	+= dev-onenand1.o
diff --git a/arch/arm/mach-s3c64xx/dev-onenand1.c b/arch/arm/mach-s3c64xx/dev-onenand1.c
deleted file mode 100644
index 999f9e1..0000000
--- a/arch/arm/mach-s3c64xx/dev-onenand1.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * linux/arch/arm/mach-s3c64xx/dev-onenand1.c
- *
- *  Copyright (c) 2008-2010 Samsung Electronics
- *  Kyungmin Park <kyungmin.park@samsung.com>
- *
- * S3C64XX series device definition for OneNAND devices
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/onenand.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-
-static struct resource s3c64xx_onenand1_resources[] = {
-	[0] = {
-		.start	= S3C64XX_PA_ONENAND1,
-		.end	= S3C64XX_PA_ONENAND1 + 0x400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S3C64XX_PA_ONENAND1_BUF,
-		.end	= S3C64XX_PA_ONENAND1_BUF + S3C64XX_SZ_ONENAND1_BUF - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND1,
-		.end	= IRQ_ONENAND1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c64xx_device_onenand1 = {
-	.name		= "samsung-onenand",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c64xx_onenand1_resources),
-	.resource	= s3c64xx_onenand1_resources,
-};
-
-void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
-{
-	s3c_set_platdata(pdata, sizeof(struct onenand_platform_data),
-			 &s3c64xx_device_onenand1);
-}
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index f87bc98..7a00dee 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
 
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
@@ -225,6 +227,39 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
+#ifdef CONFIG_S3C64XX_DEV_ONENAND1
+static struct resource s3c64xx_onenand1_resources[] = {
+	[0] = {
+		.start	= S3C64XX_PA_ONENAND1,
+		.end	= S3C64XX_PA_ONENAND1 + 0x400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= S3C64XX_PA_ONENAND1_BUF,
+		.end	= S3C64XX_PA_ONENAND1_BUF + S3C64XX_SZ_ONENAND1_BUF - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= IRQ_ONENAND1,
+		.end	= IRQ_ONENAND1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c64xx_device_onenand1 = {
+	.name		= "samsung-onenand",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c64xx_onenand1_resources),
+	.resource	= s3c64xx_onenand1_resources,
+};
+
+void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
+{
+	s3c_set_platdata(pdata, sizeof(struct onenand_platform_data),
+			 &s3c64xx_device_onenand1);
+}
+#endif /* CONFIG_S3C64XX_DEV_ONENAND1 */
+
 /* RTC */
 
 #ifdef CONFIG_PLAT_S3C24XX
-- 
1.7.1
