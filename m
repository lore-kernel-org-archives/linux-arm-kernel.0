From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:43:45 +0900
Subject: [PATCH 4/4] ARM: S5P6442: Define SPI platform devices
In-Reply-To: <1274168603-5535-1-git-send-email-jassi.brar@samsung.com>
References: <1274168603-5535-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274168625-5665-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define SPI platform devices for the SoC.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/Makefile                   |    1 +
 arch/arm/mach-s5p6442/dev-spi.c                  |  123 ++++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/map.h         |    2 +
 arch/arm/mach-s5p6442/include/mach/spi-clocks.h  |   17 +++
 arch/arm/plat-samsung/include/plat/devs.h        |    1 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 +
 6 files changed, 145 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6442/dev-spi.c
 create mode 100644 arch/arm/mach-s5p6442/include/mach/spi-clocks.h

diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
index bf30550..1cd2cd6 100644
--- a/arch/arm/mach-s5p6442/Makefile
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_MACH_SMDK6442)	+= mach-smdk6442.o
 
 # device support
 obj-y				+= dev-audio.o
+obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
diff --git a/arch/arm/mach-s5p6442/dev-spi.c b/arch/arm/mach-s5p6442/dev-spi.c
new file mode 100644
index 0000000..3019952
--- /dev/null
+++ b/arch/arm/mach-s5p6442/dev-spi.c
@@ -0,0 +1,123 @@
+/* linux/arch/arm/mach-s5p6442/dev-spi.c
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
+	[S5P6442_SPI_SRCCLK_PCLK] = "pclk",
+	[S5P6442_SPI_SRCCLK_SCLK] = "spi_epll",
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
+static int s5p6442_spi_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5P6442_GPB(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPB(2), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPB(3), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5P6442_GPB(0), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6442_GPB(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6442_GPB(3), S3C_GPIO_PULL_UP);
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
+static struct resource s5p6442_spi0_resource[] = {
+	[0] = {
+		.start = S5P6442_PA_SPI,
+		.end   = S5P6442_PA_SPI + 0x100 - 1,
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
+static struct s3c64xx_spi_info s5p6442_spi0_pdata = {
+	.cfg_gpio = s5p6442_spi_cfg_gpio,
+	.fifo_lvl_mask = 0x1ff,
+	.rx_lvl_offset = 15,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s5p6442_device_spi = {
+	.name		  = "s3c64xx-spi",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s5p6442_spi0_resource),
+	.resource	  = s5p6442_spi0_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data = &s5p6442_spi0_pdata,
+	},
+};
+
+void __init s5p6442_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
+{
+	struct s3c64xx_spi_info *pd;
+
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > S5P6442_SPI_SRCCLK_SCLK) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+
+	switch (cntrlr) {
+	case 0:
+		pd = &s5p6442_spi0_pdata;
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
diff --git a/arch/arm/mach-s5p6442/include/mach/map.h b/arch/arm/mach-s5p6442/include/mach/map.h
index 7568dc0..32ca424 100644
--- a/arch/arm/mach-s5p6442/include/mach/map.h
+++ b/arch/arm/mach-s5p6442/include/mach/map.h
@@ -54,6 +54,8 @@
 #define S5P6442_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5P6442_PA_SDRAM
 
+#define S5P6442_PA_SPI		0xEC300000
+
 /* I2S */
 #define S5P6442_PA_I2S0		0xC0B00000
 #define S5P6442_PA_I2S1		0xF2200000
diff --git a/arch/arm/mach-s5p6442/include/mach/spi-clocks.h b/arch/arm/mach-s5p6442/include/mach/spi-clocks.h
new file mode 100644
index 0000000..7fd8820
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/spi-clocks.h
@@ -0,0 +1,17 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/spi-clocks.h
+ *
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __S5P6442_PLAT_SPI_CLKS_H
+#define __S5P6442_PLAT_SPI_CLKS_H __FILE__
+
+#define S5P6442_SPI_SRCCLK_PCLK		0
+#define S5P6442_SPI_SRCCLK_SCLK		1
+
+#endif /* __S5P6442_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 01bd80e..c6975e5 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -64,6 +64,7 @@ extern struct platform_device s5pv210_device_spi0;
 extern struct platform_device s5pv210_device_spi1;
 extern struct platform_device s5p6440_device_spi0;
 extern struct platform_device s5p6440_device_spi1;
+extern struct platform_device s5p6442_device_spi;
 
 extern struct platform_device s3c_device_hwmon;
 
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 043e9f6..e5aba8f 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -66,5 +66,6 @@ extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5p6440_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
+extern void s5p6442_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.6.2.5
