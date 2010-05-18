From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:43:40 +0900
Subject: [PATCH 3/4] ARM: S5P6440: Define SPI platform devices
Message-ID: <1274168620-5633-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define SPI platform devices for the SoC.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6440/Makefile                   |    1 +
 arch/arm/mach-s5p6440/dev-spi.c                  |  176 ++++++++++++++++++++++
 arch/arm/mach-s5p6440/include/mach/map.h         |    3 +
 arch/arm/mach-s5p6440/include/mach/spi-clocks.h  |   17 ++
 arch/arm/plat-samsung/include/plat/devs.h        |    2 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 +
 6 files changed, 200 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/dev-spi.c
 create mode 100644 arch/arm/mach-s5p6440/include/mach/spi-clocks.h

diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
index 5fd17d3..06725a3 100644
--- a/arch/arm/mach-s5p6440/Makefile
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
 
 # device support
 obj-y				+= dev-audio.o
+obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
diff --git a/arch/arm/mach-s5p6440/dev-spi.c b/arch/arm/mach-s5p6440/dev-spi.c
new file mode 100644
index 0000000..0a30280
--- /dev/null
+++ b/arch/arm/mach-s5p6440/dev-spi.c
@@ -0,0 +1,176 @@
+/* linux/arch/arm/mach-s5p6440/dev-spi.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/dma.h>
+#include <mach/map.h>
+#include <mach/irqs.h>
+#include <mach/gpio.h>
+#include <mach/spi-clocks.h>
+
+#include <plat/s3c64xx-spi.h>
+#include <plat/gpio-cfg.h>
+
+static char *spi_src_clks[] = {
+	[S5P6440_SPI_SRCCLK_PCLK] = "pclk",
+	[S5P6440_SPI_SRCCLK_SCLK] = "spi_epll",
+};
+
+/* SPI Controller platform_devices */
+
+/* Since we emulate multi-cs capability, we do not touch the CS.
+ * The emulated CS is toggled by board specific mechanism, as it can
+ * be either some immediate GPIO or some signal out of some other
+ * chip in between ... or some yet another way.
+ * We simply do not assume anything about CS.
+ */
+static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5P6440_GPC(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPC(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPC(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5P6440_GPC(0), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6440_GPC(1), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6440_GPC(2), S3C_GPIO_PULL_UP);
+		break;
+
+	case 1:
+		s3c_gpio_cfgpin(S5P6440_GPC(4), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPC(5), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPC(6), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5P6440_GPC(4), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6440_GPC(5), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6440_GPC(6), S3C_GPIO_PULL_UP);
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Invalid SPI Controller number!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct resource s5p6440_spi0_resource[] = {
+	[0] = {
+		.start = S5P6440_PA_SPI0,
+		.end   = S5P6440_PA_SPI0 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_SPI0_TX,
+		.end   = DMACH_SPI0_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_SPI0_RX,
+		.end   = DMACH_SPI0_RX,
+		.flags = IORESOURCE_DMA,
+	},
+	[3] = {
+		.start = IRQ_SPI0,
+		.end   = IRQ_SPI0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c64xx_spi_info s5p6440_spi0_pdata = {
+	.cfg_gpio = s5p6440_spi_cfg_gpio,
+	.fifo_lvl_mask = 0x1ff,
+	.rx_lvl_offset = 15,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s5p6440_device_spi0 = {
+	.name		  = "s3c64xx-spi",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s5p6440_spi0_resource),
+	.resource	  = s5p6440_spi0_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data = &s5p6440_spi0_pdata,
+	},
+};
+
+static struct resource s5p6440_spi1_resource[] = {
+	[0] = {
+		.start = S5P6440_PA_SPI1,
+		.end   = S5P6440_PA_SPI1 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_SPI1_TX,
+		.end   = DMACH_SPI1_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_SPI1_RX,
+		.end   = DMACH_SPI1_RX,
+		.flags = IORESOURCE_DMA,
+	},
+	[3] = {
+		.start = IRQ_SPI1,
+		.end   = IRQ_SPI1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c64xx_spi_info s5p6440_spi1_pdata = {
+	.cfg_gpio = s5p6440_spi_cfg_gpio,
+	.fifo_lvl_mask = 0x7f,
+	.rx_lvl_offset = 15,
+};
+
+struct platform_device s5p6440_device_spi1 = {
+	.name		  = "s3c64xx-spi",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s5p6440_spi1_resource),
+	.resource	  = s5p6440_spi1_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data = &s5p6440_spi1_pdata,
+	},
+};
+
+void __init s5p6440_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
+{
+	struct s3c64xx_spi_info *pd;
+
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > S5P6440_SPI_SRCCLK_SCLK) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+
+	switch (cntrlr) {
+	case 0:
+		pd = &s5p6440_spi0_pdata;
+		break;
+	case 1:
+		pd = &s5p6440_spi1_pdata;
+		break;
+	default:
+		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
+							__func__, cntrlr);
+		return;
+	}
+
+	pd->num_cs = num_cs;
+	pd->src_clk_nr = src_clk_nr;
+	pd->src_clk_name = spi_src_clks[src_clk_nr];
+}
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 72aedad..8246895 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -54,6 +54,9 @@
 
 #define S5P6440_PA_IIC0		(0xEC104000)
 
+#define S5P6440_PA_SPI0		0xEC400000
+#define S5P6440_PA_SPI1		0xEC500000
+
 #define S5P6440_PA_HSOTG	(0xED100000)
 
 #define S5P6440_PA_HSMMC0	(0xED800000)
diff --git a/arch/arm/mach-s5p6440/include/mach/spi-clocks.h b/arch/arm/mach-s5p6440/include/mach/spi-clocks.h
new file mode 100644
index 0000000..5fbca50
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/spi-clocks.h
@@ -0,0 +1,17 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/spi-clocks.h
+ *
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __S5P6440_PLAT_SPI_CLKS_H
+#define __S5P6440_PLAT_SPI_CLKS_H __FILE__
+
+#define S5P6440_SPI_SRCCLK_PCLK		0
+#define S5P6440_SPI_SRCCLK_SCLK		1
+
+#endif /* __S5P6440_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 0759c50..01bd80e 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -62,6 +62,8 @@ extern struct platform_device s5pc100_device_spi1;
 extern struct platform_device s5pc100_device_spi2;
 extern struct platform_device s5pv210_device_spi0;
 extern struct platform_device s5pv210_device_spi1;
+extern struct platform_device s5p6440_device_spi0;
+extern struct platform_device s5p6440_device_spi1;
 
 extern struct platform_device s3c_device_hwmon;
 
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index fdb40c3..043e9f6 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -65,5 +65,6 @@ struct s3c64xx_spi_info {
 extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
+extern void s5p6440_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.6.2.5
