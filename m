From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:54 +0200
Subject: [PATCH 5/9] ARM: S5PV210: convert OneNAND to device-table
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert OneNAND platform device initialization to device-table approach.
The conversion is performed only for S5PV210 SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    2 -
 arch/arm/mach-s5pv210/Makefile      |    1 -
 arch/arm/mach-s5pv210/dev-onenand.c |   55 -----------------------------------
 arch/arm/mach-s5pv210/dev-table.c   |   24 +++++++++++++++
 arch/arm/mach-s5pv210/mach-aquila.c |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c   |    2 +-
 6 files changed, 26 insertions(+), 60 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/dev-onenand.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index d3a3895..680b55b 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -71,7 +71,6 @@ config MACH_AQUILA
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
-	select S5PC110_DEV_ONENAND
 	select S5PV210_SETUP_FB_24BPP
 	select S5PV210_SETUP_SDHCI
 	help
@@ -88,7 +87,6 @@ config MACH_GONI
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
-	select S5PC110_DEV_ONENAND
 	select S5PV210_SETUP_FB_24BPP
 	select S5PV210_SETUP_SDHCI
 	help
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index a854577..23bde19 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
 
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
-obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
diff --git a/arch/arm/mach-s5pv210/dev-onenand.c b/arch/arm/mach-s5pv210/dev-onenand.c
deleted file mode 100644
index f8ede33..0000000
--- a/arch/arm/mach-s5pv210/dev-onenand.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * linux/arch/arm/mach-s5pv210/dev-onenand.c
- *
- *  Copyright (c) 2008-2010 Samsung Electronics
- *  Kyungmin Park <kyungmin.park@samsung.com>
- *
- * S5PC110 series device definition for OneNAND devices
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
-static struct resource s5pc110_onenand_resources[] = {
-	[0] = {
-		.start	= S5PC110_PA_ONENAND,
-		.end	= S5PC110_PA_ONENAND + SZ_128K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S5PC110_PA_ONENAND_DMA,
-		.end	= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND_AUDI,
-		.end	= IRQ_ONENAND_AUDI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s5pc110_device_onenand = {
-	.name		= "s5pc110-onenand",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5pc110_onenand_resources),
-	.resource	= s5pc110_onenand_resources,
-};
-
-void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
-{
-	struct onenand_platform_data *pd;
-
-	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
-	if (!pd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	s5pc110_device_onenand.dev.platform_data = pd;
-}
diff --git a/arch/arm/mach-s5pv210/dev-table.c b/arch/arm/mach-s5pv210/dev-table.c
index 396c4a7..38e870a 100644
--- a/arch/arm/mach-s5pv210/dev-table.c
+++ b/arch/arm/mach-s5pv210/dev-table.c
@@ -26,6 +26,25 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 
+static struct resource s5pc110_onenand_resources[] __initdata = {
+	[0] = {
+		.start	= S5PC110_PA_ONENAND,
+		.end	= S5PC110_PA_ONENAND + SZ_128K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= S5PC110_PA_ONENAND_DMA,
+		.end	= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct s3c_pdev_template s5pc110_template_onenand __initdata = {
+	.resources	= s5pc110_onenand_resources,
+	.nr_res		= ARRAY_SIZE(s5pc110_onenand_resources),
+	.pdata_size	= sizeof(struct onenand_platform_data),
+};
+
 /* note, table is not ordered */
 
 struct s3c_pdev_table s5pv210_dev_table[] __initdata = {
@@ -61,6 +80,11 @@ struct s3c_pdev_table s5pv210_dev_table[] __initdata = {
 			S5P_PA_UART3,
 			IRQ_S5P_UART_RX3, IRQ_S5P_UART_TX3, IRQ_S5P_UART_ERR3,
 		},
+	}, {
+		.type	= SAMSUNG_DEVICE_ONENAND,
+		.name	= "s5pc110-onenand",
+		.index	= -1,
+		.template = &s5pc110_template_onenand,
 	},
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 7989932..5a502f3 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -479,7 +479,6 @@ static struct platform_device *aquila_devices[] __initdata = {
 	&aquila_i2c_gpio_pmic,
 	&aquila_device_gpiokeys,
 	&s3c_device_fb,
-	&s5pc110_device_onenand,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
@@ -489,6 +488,7 @@ static struct platform_device *aquila_devices[] __initdata = {
 };
 
 static struct s3c_devtable aquila_devtable[] __initdata = {
+	{ .type = SAMSUNG_DEVICE_ONENAND,	.index = -1 },
 };
 
 static void __init aquila_map_io(void)
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 6f555cf..e24b815 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -456,7 +456,6 @@ static void goni_setup_sdhci(void)
 
 static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_fb,
-	&s5pc110_device_onenand,
 	&goni_i2c_gpio_pmic,
 	&goni_device_gpiokeys,
 	&s5p_device_fimc0,
@@ -468,6 +467,7 @@ static struct platform_device *goni_devices[] __initdata = {
 };
 
 static struct s3c_devtable goni_devtable[] __initdata = {
+	{ .type = SAMSUNG_DEVICE_ONENAND, .index = -1, },
 };
 
 static void __init goni_map_io(void)
-- 
1.7.1.569.g6f426
