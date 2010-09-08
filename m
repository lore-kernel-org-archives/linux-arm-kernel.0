From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  8 Sep 2010 20:06:38 +0900
Subject: [PATCH v3 07/13] ARM: S5P64X0: Update Audio support
Message-ID: <1283943998-6849-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates Audio and SPI for S5P6440 and S5P6450 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
Changes since v2:
- Merged platform_device for spi

Changes since v1:
- Fix mis-name s3c64x0-xxx
- Fix mis-name S5P6440_SPI_SRCCLK
- Build tested with modifying Makefile for test
- Merged s5p6440_spi_set_info and s5p6450_xxx to one function

 arch/arm/mach-s5p6440/dev-audio.c                |  127 ------------
 arch/arm/mach-s5p6440/dev-spi.c                  |  176 ----------------
 arch/arm/mach-s5p6440/include/mach/spi-clocks.h  |   17 --
 arch/arm/mach-s5p64x0/dev-audio.c                |  164 +++++++++++++++
 arch/arm/mach-s5p64x0/dev-spi.c                  |  232 ++++++++++++++++++++++
 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h  |   20 ++
 arch/arm/plat-samsung/include/plat/devs.h        |    5 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 +-
 8 files changed, 422 insertions(+), 321 deletions(-)
 delete mode 100644 arch/arm/mach-s5p6440/dev-audio.c
 delete mode 100644 arch/arm/mach-s5p6440/dev-spi.c
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-s5p64x0/dev-audio.c
 create mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h

diff --git a/arch/arm/mach-s5p6440/dev-audio.c b/arch/arm/mach-s5p6440/dev-audio.c
deleted file mode 100644
index 3ca0d2b..0000000
--- a/arch/arm/mach-s5p6440/dev-audio.c
+++ /dev/null
@@ -1,127 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/dev-audio.c
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-
-#include <plat/gpio-cfg.h>
-#include <plat/audio.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-#include <mach/irqs.h>
-
-static int s5p6440_cfg_i2s(struct platform_device *pdev)
-{
-	/* configure GPIO for i2s port */
-	switch (pdev->id) {
-	case -1:
-		s3c_gpio_cfgpin(S5P6440_GPR(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(5), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(5));
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct s3c_audio_pdata s3c_i2s_pdata = {
-	.cfg_gpio = s5p6440_cfg_i2s,
-};
-
-static struct resource s5p6440_iis0_resource[] = {
-	[0] = {
-		.start = S5P6440_PA_I2S,
-		.end   = S5P6440_PA_I2S + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S0_TX,
-		.end   = DMACH_I2S0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S0_RX,
-		.end   = DMACH_I2S0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-struct platform_device s5p6440_device_iis = {
-	.name		  = "s3c64xx-iis-v4",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s5p6440_iis0_resource),
-	.resource	  = s5p6440_iis0_resource,
-	.dev = {
-		.platform_data = &s3c_i2s_pdata,
-	},
-};
-
-/* PCM Controller platform_devices */
-
-static int s5p6440_pcm_cfg_gpio(struct platform_device *pdev)
-{
-	switch (pdev->id) {
-	case 0:
-		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(2));
-		break;
-
-	default:
-		printk(KERN_DEBUG "Invalid PCM Controller number!");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct s3c_audio_pdata s3c_pcm_pdata = {
-	.cfg_gpio = s5p6440_pcm_cfg_gpio,
-};
-
-static struct resource s5p6440_pcm0_resource[] = {
-	[0] = {
-		.start = S5P6440_PA_PCM,
-		.end   = S5P6440_PA_PCM + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_PCM0_TX,
-		.end   = DMACH_PCM0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_PCM0_RX,
-		.end   = DMACH_PCM0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-struct platform_device s5p6440_device_pcm = {
-	.name		  = "samsung-pcm",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5p6440_pcm0_resource),
-	.resource	  = s5p6440_pcm0_resource,
-	.dev = {
-		.platform_data = &s3c_pcm_pdata,
-	},
-};
diff --git a/arch/arm/mach-s5p6440/dev-spi.c b/arch/arm/mach-s5p6440/dev-spi.c
deleted file mode 100644
index 510af44..0000000
--- a/arch/arm/mach-s5p6440/dev-spi.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/dev-spi.c
- *
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-
-#include <mach/dma.h>
-#include <mach/map.h>
-#include <mach/irqs.h>
-#include <mach/spi-clocks.h>
-
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
-
-static char *spi_src_clks[] = {
-	[S5P6440_SPI_SRCCLK_PCLK] = "pclk",
-	[S5P6440_SPI_SRCCLK_SCLK] = "spi_epll",
-};
-
-/* SPI Controller platform_devices */
-
-/* Since we emulate multi-cs capability, we do not touch the CS.
- * The emulated CS is toggled by board specific mechanism, as it can
- * be either some immediate GPIO or some signal out of some other
- * chip in between ... or some yet another way.
- * We simply do not assume anything about CS.
- */
-static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
-{
-	switch (pdev->id) {
-	case 0:
-		s3c_gpio_cfgpin(S5P6440_GPC(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5P6440_GPC(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(1), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(2), S3C_GPIO_PULL_UP);
-		break;
-
-	case 1:
-		s3c_gpio_cfgpin(S5P6440_GPC(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(6), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5P6440_GPC(4), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(5), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(6), S3C_GPIO_PULL_UP);
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Invalid SPI Controller number!");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct resource s5p6440_spi0_resource[] = {
-	[0] = {
-		.start = S5P6440_PA_SPI0,
-		.end   = S5P6440_PA_SPI0 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_SPI0_TX,
-		.end   = DMACH_SPI0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_SPI0_RX,
-		.end   = DMACH_SPI0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = IRQ_SPI0,
-		.end   = IRQ_SPI0,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c64xx_spi_info s5p6440_spi0_pdata = {
-	.cfg_gpio = s5p6440_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x1ff,
-	.rx_lvl_offset = 15,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5p6440_device_spi0 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5p6440_spi0_resource),
-	.resource	  = s5p6440_spi0_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5p6440_spi0_pdata,
-	},
-};
-
-static struct resource s5p6440_spi1_resource[] = {
-	[0] = {
-		.start = S5P6440_PA_SPI1,
-		.end   = S5P6440_PA_SPI1 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_SPI1_TX,
-		.end   = DMACH_SPI1_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_SPI1_RX,
-		.end   = DMACH_SPI1_RX,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = IRQ_SPI1,
-		.end   = IRQ_SPI1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c64xx_spi_info s5p6440_spi1_pdata = {
-	.cfg_gpio = s5p6440_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 15,
-};
-
-struct platform_device s5p6440_device_spi1 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s5p6440_spi1_resource),
-	.resource	  = s5p6440_spi1_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5p6440_spi1_pdata,
-	},
-};
-
-void __init s5p6440_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info *pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0
-			|| src_clk_nr > S5P6440_SPI_SRCCLK_SCLK) {
-		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	switch (cntrlr) {
-	case 0:
-		pd = &s5p6440_spi0_pdata;
-		break;
-	case 1:
-		pd = &s5p6440_spi1_pdata;
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
-							__func__, cntrlr);
-		return;
-	}
-
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
-}
diff --git a/arch/arm/mach-s5p6440/include/mach/spi-clocks.h b/arch/arm/mach-s5p6440/include/mach/spi-clocks.h
deleted file mode 100644
index 5fbca50..0000000
--- a/arch/arm/mach-s5p6440/include/mach/spi-clocks.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/spi-clocks.h
- *
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __S5P6440_PLAT_SPI_CLKS_H
-#define __S5P6440_PLAT_SPI_CLKS_H __FILE__
-
-#define S5P6440_SPI_SRCCLK_PCLK		0
-#define S5P6440_SPI_SRCCLK_SCLK		1
-
-#endif /* __S5P6440_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
new file mode 100644
index 0000000..fa097bd
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -0,0 +1,164 @@
+/* linux/arch/arm/mach-s5p64x0/dev-audio.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/audio.h>
+
+#include <mach/map.h>
+#include <mach/dma.h>
+#include <mach/irqs.h>
+
+static int s5p6440_cfg_i2s(struct platform_device *pdev)
+{
+	/* configure GPIO for i2s port */
+	switch (pdev->id) {
+	case -1:
+		s3c_gpio_cfgpin(S5P6440_GPR(4), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(5), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(5));
+		break;
+
+	default:
+		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int s5p6450_cfg_i2s(struct platform_device *pdev)
+{
+	/* configure GPIO for i2s port */
+	switch (pdev->id) {
+	case -1:
+		s3c_gpio_cfgpin(S5P6450_GPB(4), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(4), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(5), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(6), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(7), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(8), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(13), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6450_GPR(14), S3C_GPIO_SFN(5));
+		break;
+
+	default:
+		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct s3c_audio_pdata s5p6440_i2s_pdata = {
+	.cfg_gpio = s5p6440_cfg_i2s,
+};
+
+static struct s3c_audio_pdata s5p6450_i2s_pdata = {
+	.cfg_gpio = s5p6450_cfg_i2s,
+};
+
+static struct resource s5p64x0_iis0_resource[] = {
+	[0] = {
+		.start	= S5P64X0_PA_I2S,
+		.end	= S5P64X0_PA_I2S + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMACH_I2S0_TX,
+		.end	= DMACH_I2S0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMACH_I2S0_RX,
+		.end	= DMACH_I2S0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s5p6440_device_iis = {
+	.name		= "s3c64xx-iis-v4",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
+	.resource	= s5p64x0_iis0_resource,
+	.dev = {
+		.platform_data = &s5p6440_i2s_pdata,
+	},
+};
+
+struct platform_device s5p6450_device_iis0 = {
+	.name		= "s3c64xx-iis-v4",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
+	.resource	= s5p64x0_iis0_resource,
+	.dev = {
+		.platform_data = &s5p6450_i2s_pdata,
+	},
+};
+
+/* PCM Controller platform_devices */
+
+static int s5p6440_pcm_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(2));
+		break;
+
+	default:
+		printk(KERN_DEBUG "Invalid PCM Controller number!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct s3c_audio_pdata s5p6440_pcm_pdata = {
+	.cfg_gpio = s5p6440_pcm_cfg_gpio,
+};
+
+static struct resource s5p6440_pcm0_resource[] = {
+	[0] = {
+		.start	= S5P64X0_PA_PCM,
+		.end	= S5P64X0_PA_PCM + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMACH_PCM0_TX,
+		.end	= DMACH_PCM0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMACH_PCM0_RX,
+		.end	= DMACH_PCM0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s5p6440_device_pcm = {
+	.name		= "samsung-pcm",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p6440_pcm0_resource),
+	.resource	= s5p6440_pcm0_resource,
+	.dev = {
+		.platform_data = &s5p6440_pcm_pdata,
+	},
+};
diff --git a/arch/arm/mach-s5p64x0/dev-spi.c b/arch/arm/mach-s5p64x0/dev-spi.c
new file mode 100644
index 0000000..5b69ec4
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/dev-spi.c
@@ -0,0 +1,232 @@
+/* linux/arch/arm/mach-s5p64x0/dev-spi.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+
+#include <mach/dma.h>
+#include <mach/map.h>
+#include <mach/irqs.h>
+#include <mach/regs-clock.h>
+#include <mach/spi-clocks.h>
+
+#include <plat/s3c64xx-spi.h>
+#include <plat/gpio-cfg.h>
+
+static char *s5p64x0_spi_src_clks[] = {
+	[S5P64X0_SPI_SRCCLK_PCLK] = "pclk",
+	[S5P64X0_SPI_SRCCLK_SCLK] = "sclk_spi",
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
+static int s5p6450_spi_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5P6450_GPC(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6450_GPC(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6450_GPC(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5P6450_GPC(0), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6450_GPC(1), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6450_GPC(2), S3C_GPIO_PULL_UP);
+		break;
+
+	case 1:
+		s3c_gpio_cfgpin(S5P6450_GPC(4), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6450_GPC(5), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6450_GPC(6), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5P6450_GPC(4), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6450_GPC(5), S3C_GPIO_PULL_UP);
+		s3c_gpio_setpull(S5P6450_GPC(6), S3C_GPIO_PULL_UP);
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
+static struct resource s5p64x0_spi0_resource[] = {
+	[0] = {
+		.start	= S5P64X0_PA_SPI0,
+		.end	= S5P64X0_PA_SPI0 + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMACH_SPI0_TX,
+		.end	= DMACH_SPI0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMACH_SPI0_RX,
+		.end	= DMACH_SPI0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= IRQ_SPI0,
+		.end	= IRQ_SPI0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c64xx_spi_info s5p6440_spi0_pdata = {
+	.cfg_gpio	= s5p6440_spi_cfg_gpio,
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+};
+
+static struct s3c64xx_spi_info s5p6450_spi0_pdata = {
+	.cfg_gpio	= s5p6450_spi_cfg_gpio,
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s5p64x0_device_spi0 = {
+	.name		= "s3c64xx-spi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p64x0_spi0_resource),
+	.resource	= s5p64x0_spi0_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+static struct resource s5p64x0_spi1_resource[] = {
+	[0] = {
+		.start	= S5P64X0_PA_SPI1,
+		.end	= S5P64X0_PA_SPI1 + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMACH_SPI1_TX,
+		.end	= DMACH_SPI1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMACH_SPI1_RX,
+		.end	= DMACH_SPI1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= IRQ_SPI1,
+		.end	= IRQ_SPI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c64xx_spi_info s5p6440_spi1_pdata = {
+	.cfg_gpio	= s5p6440_spi_cfg_gpio,
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+};
+
+static struct s3c64xx_spi_info s5p6450_spi1_pdata = {
+	.cfg_gpio	= s5p6450_spi_cfg_gpio,
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+};
+
+struct platform_device s5p64x0_device_spi1 = {
+	.name		= "s3c64xx-spi",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5p64x0_spi1_resource),
+	.resource	= s5p64x0_spi1_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
+{
+	unsigned int id;
+	struct s3c64xx_spi_info *pd;
+
+	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
+
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > S5P64X0_SPI_SRCCLK_SCLK) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+
+	switch (cntrlr) {
+	case 0:
+		if (id == 0x50000)
+			pd = &s5p6450_spi0_pdata;
+		else
+			pd = &s5p6440_spi0_pdata;
+
+		s5p64x0_device_spi0.dev.platform_data = pd;
+		break;
+	case 1:
+		if (id == 0x50000)
+			pd = &s5p6450_spi1_pdata;
+		else
+			pd = &s5p6440_spi1_pdata;
+
+		s5p64x0_device_spi1.dev.platform_data = pd;
+		break;
+	default:
+		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
+							__func__, cntrlr);
+		return;
+	}
+
+	pd->num_cs = num_cs;
+	pd->src_clk_nr = src_clk_nr;
+	pd->src_clk_name = s5p64x0_spi_src_clks[src_clk_nr];
+}
diff --git a/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h b/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
new file mode 100644
index 0000000..170a20a
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
@@ -0,0 +1,20 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_SPI_CLKS_H
+#define __ASM_ARCH_SPI_CLKS_H __FILE__
+
+#define S5P64X0_SPI_SRCCLK_PCLK		0
+#define S5P64X0_SPI_SRCCLK_SCLK		1
+
+#endif /* __ASM_ARCH_SPI_CLKS_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 85f6f23..10d0d3c 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -67,6 +67,8 @@ extern struct platform_device s5pv210_device_spi0;
 extern struct platform_device s5pv210_device_spi1;
 extern struct platform_device s5p6440_device_spi0;
 extern struct platform_device s5p6440_device_spi1;
+extern struct platform_device s5p6450_device_spi0;
+extern struct platform_device s5p6450_device_spi1;
 
 extern struct platform_device s3c_device_hwmon;
 
@@ -95,6 +97,9 @@ extern struct platform_device s5p6442_device_spi;
 extern struct platform_device s5p6440_device_pcm;
 extern struct platform_device s5p6440_device_iis;
 
+extern struct platform_device s5p6450_device_iis0;
+extern struct platform_device s5p6450_device_pcm0;
+
 extern struct platform_device s5pc100_device_ac97;
 extern struct platform_device s5pc100_device_pcm0;
 extern struct platform_device s5pc100_device_pcm1;
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index e5aba8f..ae8e802 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -65,7 +65,7 @@ struct s3c64xx_spi_info {
 extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
-extern void s5p6440_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
+extern void s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5p6442_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.6.2.5
