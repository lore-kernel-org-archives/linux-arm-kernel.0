From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:43:34 +0900
Subject: [PATCH 1/4] ARM: S5PC100: Define SPI platform devices
In-Reply-To: <1274168603-5535-1-git-send-email-jassi.brar@samsung.com>
References: <1274168603-5535-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274168614-5568-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define SPI platform devices for the SoC.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pc100/Makefile                   |    1 +
 arch/arm/mach-s5pc100/dev-spi.c                  |  233 ++++++++++++++++++++++
 arch/arm/mach-s5pc100/include/mach/map.h         |    5 +
 arch/arm/mach-s5pc100/include/mach/spi-clocks.h  |   18 ++
 arch/arm/plat-samsung/include/plat/devs.h        |    4 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 +
 6 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 create mode 100644 arch/arm/mach-s5pc100/include/mach/spi-clocks.h

diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index a81abef..abbcbe5 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
 
 # device support
 obj-y				+= dev-audio.o
+obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
new file mode 100644
index 0000000..14618c3
--- /dev/null
+++ b/arch/arm/mach-s5pc100/dev-spi.c
@@ -0,0 +1,233 @@
+/* linux/arch/arm/mach-s5pc100/dev-spi.c
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
+#include <mach/gpio.h>
+#include <mach/spi-clocks.h>
+
+#include <plat/s3c64xx-spi.h>
+#include <plat/gpio-cfg.h>
+#include <plat/irqs.h>
+
+static char *spi_src_clks[] = {
+	[S5PC100_SPI_SRCCLK_PCLK] = "pclk",
+	[S5PC100_SPI_SRCCLK_48M] = "spi_48m",
+	[S5PC100_SPI_SRCCLK_SPIBUS] = "spi_bus",
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
+static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5PC100_GPB(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5PC100_GPB(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5PC100_GPB(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5PC100_GPB(0), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5PC100_GPB(1), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5PC100_GPB(2), S3C_GPIO_PULL_UP);
+		break;
+
+	case 1:
+		s3c_gpio_cfgpin(S5PC100_GPB(4), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5PC100_GPB(5), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5PC100_GPB(6), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5PC100_GPB(4), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5PC100_GPB(5), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5PC100_GPB(6), S3C_GPIO_PULL_UP);
+		break;
+
+	case 2:
+		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5PC100_GPG3(2), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5PC100_GPG3(3), S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5PC100_GPG3(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5PC100_GPG3(3), S3C_GPIO_PULL_UP);
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
+static struct resource s5pc100_spi0_resource[] = {
+	[0] = {
+		.start = S5PC100_PA_SPI0,
+		.end   = S5PC100_PA_SPI0 + 0x100 - 1,
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
+static struct s3c64xx_spi_info s5pc100_spi0_pdata = {
+	.cfg_gpio = s5pc100_spi_cfg_gpio,
+	.fifo_lvl_mask = 0x7f,
+	.rx_lvl_offset = 13,
+	.high_speed = 1,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s5pc100_device_spi0 = {
+	.name		  = "s3c64xx-spi",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s5pc100_spi0_resource),
+	.resource	  = s5pc100_spi0_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data = &s5pc100_spi0_pdata,
+	},
+};
+
+static struct resource s5pc100_spi1_resource[] = {
+	[0] = {
+		.start = S5PC100_PA_SPI1,
+		.end   = S5PC100_PA_SPI1 + 0x100 - 1,
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
+static struct s3c64xx_spi_info s5pc100_spi1_pdata = {
+	.cfg_gpio = s5pc100_spi_cfg_gpio,
+	.fifo_lvl_mask = 0x7f,
+	.rx_lvl_offset = 13,
+	.high_speed = 1,
+};
+
+struct platform_device s5pc100_device_spi1 = {
+	.name		  = "s3c64xx-spi",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s5pc100_spi1_resource),
+	.resource	  = s5pc100_spi1_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data = &s5pc100_spi1_pdata,
+	},
+};
+
+static struct resource s5pc100_spi2_resource[] = {
+	[0] = {
+		.start = S5PC100_PA_SPI2,
+		.end   = S5PC100_PA_SPI2 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_SPI2_TX,
+		.end   = DMACH_SPI2_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_SPI2_RX,
+		.end   = DMACH_SPI2_RX,
+		.flags = IORESOURCE_DMA,
+	},
+	[3] = {
+		.start = IRQ_SPI2,
+		.end   = IRQ_SPI2,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c64xx_spi_info s5pc100_spi2_pdata = {
+	.cfg_gpio = s5pc100_spi_cfg_gpio,
+	.fifo_lvl_mask = 0x7f,
+	.rx_lvl_offset = 13,
+	.high_speed = 1,
+};
+
+struct platform_device s5pc100_device_spi2 = {
+	.name		  = "s3c64xx-spi",
+	.id		  = 2,
+	.num_resources	  = ARRAY_SIZE(s5pc100_spi2_resource),
+	.resource	  = s5pc100_spi2_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data = &s5pc100_spi2_pdata,
+	},
+};
+
+void __init s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
+{
+	struct s3c64xx_spi_info *pd;
+
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > S5PC100_SPI_SRCCLK_SPIBUS) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+
+	switch (cntrlr) {
+	case 0:
+		pd = &s5pc100_spi0_pdata;
+		break;
+	case 1:
+		pd = &s5pc100_spi1_pdata;
+		break;
+	case 2:
+		pd = &s5pc100_spi2_pdata;
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
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index de3891c..06730b2 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -82,6 +82,11 @@
 #define S5PC100_PA_I2C		(0xEC100000)
 #define S5PC100_PA_I2C1		(0xEC200000)
 
+/* SPI */
+#define S5PC100_PA_SPI0		0xEC300000
+#define S5PC100_PA_SPI1		0xEC400000
+#define S5PC100_PA_SPI2		0xEC500000
+
 /* USB HS OTG */
 #define S5PC100_PA_USB_HSOTG	(0xED200000)
 #define S5PC100_PA_USB_HSPHY	(0xED300000)
diff --git a/arch/arm/mach-s5pc100/include/mach/spi-clocks.h b/arch/arm/mach-s5pc100/include/mach/spi-clocks.h
new file mode 100644
index 0000000..65e4263
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/mach/spi-clocks.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/mach-s5pc100/include/mach/spi-clocks.h
+ *
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __S5PC100_PLAT_SPI_CLKS_H
+#define __S5PC100_PLAT_SPI_CLKS_H __FILE__
+
+#define S5PC100_SPI_SRCCLK_PCLK		0
+#define S5PC100_SPI_SRCCLK_48M		1
+#define S5PC100_SPI_SRCCLK_SPIBUS	2
+
+#endif /* __S5PC100_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 4380ca6..f5a0c4a 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -57,6 +57,10 @@ extern struct platform_device s3c_device_hsmmc2;
 extern struct platform_device s3c_device_spi0;
 extern struct platform_device s3c_device_spi1;
 
+extern struct platform_device s5pc100_device_spi0;
+extern struct platform_device s5pc100_device_spi1;
+extern struct platform_device s5pc100_device_spi2;
+
 extern struct platform_device s3c_device_hwmon;
 
 extern struct platform_device s3c_device_nand;
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index d177241..49ba71f 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -63,5 +63,6 @@ struct s3c64xx_spi_info {
  * has some chips attached to it.
  */
 extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
+extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.6.2.5
