From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 04 Nov 2011 08:43:49 -0400
Subject: [PATCH 1/6] ARM: SAMSUNG: Consolidation of SPI platform devices to
	plat-samsung
In-Reply-To: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
References: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320410634-10788-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI platform device definitions consolidated from respective machine
folder to plat-samsung

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/Makefile                   |    1 -
 arch/arm/mach-s3c64xx/dev-spi.c                  |  172 -----------------
 arch/arm/mach-s5p64x0/Makefile                   |    1 -
 arch/arm/mach-s5p64x0/dev-spi.c                  |  218 ---------------------
 arch/arm/mach-s5pc100/Makefile                   |    1 -
 arch/arm/mach-s5pc100/dev-spi.c                  |  220 ----------------------
 arch/arm/mach-s5pv210/Makefile                   |    1 -
 arch/arm/mach-s5pv210/dev-spi.c                  |  169 -----------------
 arch/arm/plat-samsung/Kconfig                    |   14 ++-
 arch/arm/plat-samsung/devs.c                     |  112 +++++++++++
 arch/arm/plat-samsung/include/plat/devs.h        |    8 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   13 +-
 12 files changed, 133 insertions(+), 797 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-spi.c
 delete mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
 delete mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 delete mode 100644 arch/arm/mach-s5pv210/dev-spi.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index e32093c..d1d0f09 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -59,4 +59,3 @@ obj-$(CONFIG_MACH_WLF_CRAGG_6410) += mach-crag6410.o mach-crag6410-module.o
 
 obj-y				+= dev-uart.o
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
deleted file mode 100644
index 86fb130..0000000
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/* linux/arch/arm/plat-s3c64xx/dev-spi.c
- *
- * Copyright (C) 2009 Samsung Electronics Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-
-#include <mach/dma.h>
-#include <mach/map.h>
-#include <mach/spi-clocks.h>
-#include <mach/irqs.h>
-
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-
-/* SPI Controller platform_devices */
-
-/* Since we emulate multi-cs capability, we do not touch the GPC-3,7.
- * The emulated CS is toggled by board specific mechanism, as it can
- * be either some immediate GPIO or some signal out of some other
- * chip in between ... or some yet another way.
- * We simply do not assume anything about CS.
- */
-static int s3c64xx_spi_cfg_gpio(struct platform_device *pdev)
-{
-	unsigned int base;
-
-	switch (pdev->id) {
-	case 0:
-		base = S3C64XX_GPC(0);
-		break;
-
-	case 1:
-		base = S3C64XX_GPC(4);
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Invalid SPI Controller number!");
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgall_range(base, 3,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-
-	return 0;
-}
-
-static struct resource s3c64xx_spi0_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_SPI0,
-		.end   = S3C64XX_PA_SPI0 + 0x100 - 1,
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
-static struct s3c64xx_spi_info s3c64xx_spi0_pdata = {
-	.cfg_gpio = s3c64xx_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 13,
-	.tx_st_done = 21,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s3c64xx_device_spi0 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s3c64xx_spi0_resource),
-	.resource	  = s3c64xx_spi0_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s3c64xx_spi0_pdata,
-	},
-};
-EXPORT_SYMBOL(s3c64xx_device_spi0);
-
-static struct resource s3c64xx_spi1_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_SPI1,
-		.end   = S3C64XX_PA_SPI1 + 0x100 - 1,
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
-static struct s3c64xx_spi_info s3c64xx_spi1_pdata = {
-	.cfg_gpio = s3c64xx_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 13,
-	.tx_st_done = 21,
-};
-
-struct platform_device s3c64xx_device_spi1 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s3c64xx_spi1_resource),
-	.resource	  = s3c64xx_spi1_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s3c64xx_spi1_pdata,
-	},
-};
-EXPORT_SYMBOL(s3c64xx_device_spi1);
-
-void __init s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info *pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0
-			|| src_clk_nr > S3C64XX_SPI_SRCCLK_48M) {
-		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	switch (cntrlr) {
-	case 0:
-		pd = &s3c64xx_spi0_pdata;
-		break;
-	case 1:
-		pd = &s3c64xx_spi1_pdata;
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
-							__func__, cntrlr);
-		return;
-	}
-
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-}
diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index a1324d8..e24d316 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_MACH_SMDK6450)	+= mach-smdk6450.o
 # device support
 
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5P64X0_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
diff --git a/arch/arm/mach-s5p64x0/dev-spi.c b/arch/arm/mach-s5p64x0/dev-spi.c
deleted file mode 100644
index 5b5d3c0..0000000
--- a/arch/arm/mach-s5p64x0/dev-spi.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/dev-spi.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-
-#include <mach/dma.h>
-#include <mach/map.h>
-#include <mach/irqs.h>
-#include <mach/regs-clock.h>
-#include <mach/spi-clocks.h>
-
-#include <plat/cpu.h>
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
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
-	unsigned int base;
-
-	switch (pdev->id) {
-	case 0:
-		base = S5P6440_GPC(0);
-		break;
-
-	case 1:
-		base = S5P6440_GPC(4);
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Invalid SPI Controller number!");
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgall_range(base, 3,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-
-	return 0;
-}
-
-static int s5p6450_spi_cfg_gpio(struct platform_device *pdev)
-{
-	unsigned int base;
-
-	switch (pdev->id) {
-	case 0:
-		base = S5P6450_GPC(0);
-		break;
-
-	case 1:
-		base = S5P6450_GPC(4);
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Invalid SPI Controller number!");
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgall_range(base, 3,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-
-	return 0;
-}
-
-static struct resource s5p64x0_spi0_resource[] = {
-	[0] = {
-		.start	= S5P64X0_PA_SPI0,
-		.end	= S5P64X0_PA_SPI0 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_SPI0_TX,
-		.end	= DMACH_SPI0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_SPI0_RX,
-		.end	= DMACH_SPI0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= IRQ_SPI0,
-		.end	= IRQ_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c64xx_spi_info s5p6440_spi0_pdata = {
-	.cfg_gpio	= s5p6440_spi_cfg_gpio,
-	.fifo_lvl_mask	= 0x1ff,
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
-static struct s3c64xx_spi_info s5p6450_spi0_pdata = {
-	.cfg_gpio	= s5p6450_spi_cfg_gpio,
-	.fifo_lvl_mask	= 0x1ff,
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5p64x0_device_spi0 = {
-	.name		= "s3c64xx-spi",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s5p64x0_spi0_resource),
-	.resource	= s5p64x0_spi0_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-static struct resource s5p64x0_spi1_resource[] = {
-	[0] = {
-		.start	= S5P64X0_PA_SPI1,
-		.end	= S5P64X0_PA_SPI1 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_SPI1_TX,
-		.end	= DMACH_SPI1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_SPI1_RX,
-		.end	= DMACH_SPI1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= IRQ_SPI1,
-		.end	= IRQ_SPI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c64xx_spi_info s5p6440_spi1_pdata = {
-	.cfg_gpio	= s5p6440_spi_cfg_gpio,
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
-static struct s3c64xx_spi_info s5p6450_spi1_pdata = {
-	.cfg_gpio	= s5p6450_spi_cfg_gpio,
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
-struct platform_device s5p64x0_device_spi1 = {
-	.name		= "s3c64xx-spi",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s5p64x0_spi1_resource),
-	.resource	= s5p64x0_spi1_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info *pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0
-			|| src_clk_nr > S5P64X0_SPI_SRCCLK_SCLK) {
-		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	switch (cntrlr) {
-	case 0:
-		if (soc_is_s5p6450())
-			pd = &s5p6450_spi0_pdata;
-		else
-			pd = &s5p6440_spi0_pdata;
-
-		s5p64x0_device_spi0.dev.platform_data = pd;
-		break;
-	case 1:
-		if (soc_is_s5p6450())
-			pd = &s5p6450_spi1_pdata;
-		else
-			pd = &s5p6440_spi1_pdata;
-
-		s5p64x0_device_spi1.dev.platform_data = pd;
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
-							__func__, cntrlr);
-		return;
-	}
-
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-}
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 2320e54..238a836 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # device support
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
deleted file mode 100644
index 155f50d..0000000
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ /dev/null
@@ -1,220 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/dev-spi.c
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
-#include <mach/spi-clocks.h>
-#include <mach/irqs.h>
-
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
-#include <plat/irqs.h>
-
-/* SPI Controller platform_devices */
-
-/* Since we emulate multi-cs capability, we do not touch the CS.
- * The emulated CS is toggled by board specific mechanism, as it can
- * be either some immediate GPIO or some signal out of some other
- * chip in between ... or some yet another way.
- * We simply do not assume anything about CS.
- */
-static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
-{
-	switch (pdev->id) {
-	case 0:
-		s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
-				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-		break;
-
-	case 1:
-		s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
-				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-		break;
-
-	case 2:
-		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_cfgall_range(S5PC100_GPB(2), 2,
-				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
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
-static struct resource s5pc100_spi0_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_SPI0,
-		.end   = S5PC100_PA_SPI0 + 0x100 - 1,
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
-static struct s3c64xx_spi_info s5pc100_spi0_pdata = {
-	.cfg_gpio = s5pc100_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 13,
-	.high_speed = 1,
-	.tx_st_done = 21,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5pc100_device_spi0 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5pc100_spi0_resource),
-	.resource	  = s5pc100_spi0_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5pc100_spi0_pdata,
-	},
-};
-
-static struct resource s5pc100_spi1_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_SPI1,
-		.end   = S5PC100_PA_SPI1 + 0x100 - 1,
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
-static struct s3c64xx_spi_info s5pc100_spi1_pdata = {
-	.cfg_gpio = s5pc100_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 13,
-	.high_speed = 1,
-	.tx_st_done = 21,
-};
-
-struct platform_device s5pc100_device_spi1 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s5pc100_spi1_resource),
-	.resource	  = s5pc100_spi1_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5pc100_spi1_pdata,
-	},
-};
-
-static struct resource s5pc100_spi2_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_SPI2,
-		.end   = S5PC100_PA_SPI2 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_SPI2_TX,
-		.end   = DMACH_SPI2_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_SPI2_RX,
-		.end   = DMACH_SPI2_RX,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = IRQ_SPI2,
-		.end   = IRQ_SPI2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c64xx_spi_info s5pc100_spi2_pdata = {
-	.cfg_gpio = s5pc100_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 13,
-	.high_speed = 1,
-	.tx_st_done = 21,
-};
-
-struct platform_device s5pc100_device_spi2 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 2,
-	.num_resources	  = ARRAY_SIZE(s5pc100_spi2_resource),
-	.resource	  = s5pc100_spi2_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5pc100_spi2_pdata,
-	},
-};
-
-void __init s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info *pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0
-			|| src_clk_nr > S5PC100_SPI_SRCCLK_SPIBUS) {
-		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	switch (cntrlr) {
-	case 0:
-		pd = &s5pc100_spi0_pdata;
-		break;
-	case 1:
-		pd = &s5pc100_spi1_pdata;
-		break;
-	case 2:
-		pd = &s5pc100_spi2_pdata;
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
-							__func__, cntrlr);
-		return;
-	}
-
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-}
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 53c346a..7eb8677 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
 # device support
 
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_FIMC)	+= setup-fimc.o
diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
deleted file mode 100644
index 39bef19..0000000
--- a/arch/arm/mach-s5pv210/dev-spi.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/dev-spi.c
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
-/* SPI Controller platform_devices */
-
-/* Since we emulate multi-cs capability, we do not touch the CS.
- * The emulated CS is toggled by board specific mechanism, as it can
- * be either some immediate GPIO or some signal out of some other
- * chip in between ... or some yet another way.
- * We simply do not assume anything about CS.
- */
-static int s5pv210_spi_cfg_gpio(struct platform_device *pdev)
-{
-	unsigned int base;
-
-	switch (pdev->id) {
-	case 0:
-		base = S5PV210_GPB(0);
-		break;
-
-	case 1:
-		base = S5PV210_GPB(4);
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Invalid SPI Controller number!");
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgall_range(base, 3,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-
-	return 0;
-}
-
-static struct resource s5pv210_spi0_resource[] = {
-	[0] = {
-		.start = S5PV210_PA_SPI0,
-		.end   = S5PV210_PA_SPI0 + 0x100 - 1,
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
-static struct s3c64xx_spi_info s5pv210_spi0_pdata = {
-	.cfg_gpio = s5pv210_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x1ff,
-	.rx_lvl_offset = 15,
-	.high_speed = 1,
-	.tx_st_done = 25,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5pv210_device_spi0 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5pv210_spi0_resource),
-	.resource	  = s5pv210_spi0_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5pv210_spi0_pdata,
-	},
-};
-
-static struct resource s5pv210_spi1_resource[] = {
-	[0] = {
-		.start = S5PV210_PA_SPI1,
-		.end   = S5PV210_PA_SPI1 + 0x100 - 1,
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
-static struct s3c64xx_spi_info s5pv210_spi1_pdata = {
-	.cfg_gpio = s5pv210_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x7f,
-	.rx_lvl_offset = 15,
-	.high_speed = 1,
-	.tx_st_done = 25,
-};
-
-struct platform_device s5pv210_device_spi1 = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s5pv210_spi1_resource),
-	.resource	  = s5pv210_spi1_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5pv210_spi1_pdata,
-	},
-};
-
-void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info *pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0
-			|| src_clk_nr > S5PV210_SPI_SRCCLK_SCLK) {
-		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	switch (cntrlr) {
-	case 0:
-		pd = &s5pv210_spi0_pdata;
-		break;
-	case 1:
-		pd = &s5pv210_spi1_pdata;
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
-							__func__, cntrlr);
-		return;
-	}
-
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 313eb26..8a2b23a 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -226,7 +226,19 @@ config SAMSUNG_DEV_IDE
 	help
 	  Compile in platform device definitions for IDE
 
-config S3C64XX_DEV_SPI
+config S3C64XX_DEV_SPI0
+	bool
+	help
+	  Compile in platform device definitions for S3C64XX's type
+	  SPI controllers.
+
+config S3C64XX_DEV_SPI1
+	bool
+	help
+	  Compile in platform device definitions for S3C64XX's type
+	  SPI controllers.
+
+config S3C64XX_DEV_SPI2
 	bool
 	help
 	  Compile in platform device definitions for S3C64XX's type
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 4ca8b57..76e374d 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -61,6 +61,7 @@
 #include <plat/regs-iic.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-spi.h>
+#include <plat/s3c64xx-spi.h>
 
 static u64 samsung_device_dma_mask = DMA_BIT_MASK(32);
 
@@ -1461,3 +1462,114 @@ struct platform_device s3c_device_wdt = {
 	.resource	= s3c_wdt_resource,
 };
 #endif /* CONFIG_S3C_DEV_WDT */
+
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+static struct resource s3c64xx_spi0_resource[] = {
+	[0] = DEFINE_RES_MEM(S3C_PA_SPI0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_SPI0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_SPI0_RX),
+	[3] = DEFINE_RES_IRQ(IRQ_SPI0),
+};
+
+struct platform_device s3c64xx_device_spi0 = {
+	.name		= "s3c64xx-spi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c64xx_spi0_resource),
+	.resource	= s3c64xx_spi0_resource,
+	.dev = {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s3c64xx_spi0_set_info(struct s3c64xx_spi_info *pd,
+					int src_clk_nr, int num_cs)
+{
+	if (!pd) {
+		pr_err("%s:Need to pass platform data\n", __func__);
+		return;
+	}
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0) {
+		pr_err("%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+	pd->num_cs = num_cs;
+	pd->src_clk_nr = src_clk_nr;
+	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi0);
+}
+#endif /* CONFIG_S3C64XX_DEV_SPI0 */
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+static struct resource s3c64xx_spi1_resource[] = {
+	[0] = DEFINE_RES_MEM(S3C_PA_SPI1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_SPI1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_SPI1_RX),
+	[3] = DEFINE_RES_IRQ(IRQ_SPI1),
+};
+
+struct platform_device s3c64xx_device_spi1 = {
+	.name		= "s3c64xx-spi",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c64xx_spi1_resource),
+	.resource	= s3c64xx_spi1_resource,
+	.dev = {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s3c64xx_spi1_set_info(struct s3c64xx_spi_info *pd,
+					int src_clk_nr, int num_cs)
+{
+	if (!pd) {
+		pr_err("%s:Need to pass platform data\n", __func__);
+		return;
+	}
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0) {
+		pr_err("%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+	pd->num_cs = num_cs;
+	pd->src_clk_nr = src_clk_nr;
+	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi1);
+}
+#endif /* CONFIG_S3C64XX_DEV_SPI1 */
+
+#ifdef CONFIG_S3C64XX_DEV_SPI2
+static struct resource s3c64xx_spi2_resource[] = {
+	[0] = DEFINE_RES_MEM(S3C_PA_SPI2, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_SPI2_TX),
+	[2] = DEFINE_RES_DMA(DMACH_SPI2_RX),
+	[3] = DEFINE_RES_IRQ(IRQ_SPI2),
+};
+
+struct platform_device s3c64xx_device_spi2 = {
+	.name		= "s3c64xx-spi",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s3c64xx_spi2_resource),
+	.resource	= s3c64xx_spi2_resource,
+	.dev = {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s3c64xx_spi2_set_info(struct s3c64xx_spi_info *pd,
+					int src_clk_nr, int num_cs)
+{
+	if (!pd) {
+		pr_err("%s:Need to pass platform data\n", __func__);
+		return;
+	}
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0) {
+		pr_err("%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+	pd->num_cs = num_cs;
+	pd->src_clk_nr = src_clk_nr;
+	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi2);
+}
+#endif /* CONFIG_S3C64XX_DEV_SPI2 */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index ab633c9..83b1e31 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -39,6 +39,7 @@ extern struct platform_device s3c64xx_device_pcm0;
 extern struct platform_device s3c64xx_device_pcm1;
 extern struct platform_device s3c64xx_device_spi0;
 extern struct platform_device s3c64xx_device_spi1;
+extern struct platform_device s3c64xx_device_spi2;
 
 extern struct platform_device s3c_device_adc;
 extern struct platform_device s3c_device_cfcon;
@@ -98,8 +99,6 @@ extern struct platform_device s5p6450_device_iis1;
 extern struct platform_device s5p6450_device_iis2;
 extern struct platform_device s5p6450_device_pcm0;
 
-extern struct platform_device s5p64x0_device_spi0;
-extern struct platform_device s5p64x0_device_spi1;
 
 extern struct platform_device s5pc100_device_ac97;
 extern struct platform_device s5pc100_device_iis0;
@@ -108,9 +107,6 @@ extern struct platform_device s5pc100_device_iis2;
 extern struct platform_device s5pc100_device_pcm0;
 extern struct platform_device s5pc100_device_pcm1;
 extern struct platform_device s5pc100_device_spdif;
-extern struct platform_device s5pc100_device_spi0;
-extern struct platform_device s5pc100_device_spi1;
-extern struct platform_device s5pc100_device_spi2;
 
 extern struct platform_device s5pv210_device_ac97;
 extern struct platform_device s5pv210_device_iis0;
@@ -120,8 +116,6 @@ extern struct platform_device s5pv210_device_pcm0;
 extern struct platform_device s5pv210_device_pcm1;
 extern struct platform_device s5pv210_device_pcm2;
 extern struct platform_device s5pv210_device_spdif;
-extern struct platform_device s5pv210_device_spi0;
-extern struct platform_device s5pv210_device_spi1;
 
 extern struct platform_device exynos4_device_ac97;
 extern struct platform_device exynos4_device_ahci;
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index c3d82a5..0dc37ad 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -58,16 +58,17 @@ struct s3c64xx_spi_info {
 /**
  * s3c64xx_spi_set_info - SPI Controller configure callback by the board
  *				initialization code.
- * @cntrlr: SPI controller number the configuration is for.
+ * @pd: SPI platform data to set.
  * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
  * @num_cs: Number of elements in the 'cs' array.
  *
  * Call this from machine init code for each SPI Controller that
  * has some chips attached to it.
  */
-extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
-extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
-extern void s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
-extern void s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
-
+extern void s3c64xx_spi0_set_info(struct s3c64xx_spi_info *pd, int src_clk_nr,
+					int num_cs);
+extern void s3c64xx_spi1_set_info(struct s3c64xx_spi_info *pd, int src_clk_nr,
+					int num_cs);
+extern void s3c64xx_spi2_set_info(struct s3c64xx_spi_info *pd, int src_clk_nr,
+					int num_cs);
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.7.0.4
