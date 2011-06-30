From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 30 Jun 2011 08:25:17 -0400
Subject: [PATCH 1/7] ARM: SAMSUNG: Move SPI device definitions to plat-samsung
In-Reply-To: <1309436723-662-1-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
Message-ID: <1309436723-662-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all SPI platform device definitions from respective machine
folder to plat-samsung

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-spi.c                  |  177 -----------------
 arch/arm/mach-s5p64x0/dev-spi.c                  |  222 ---------------------
 arch/arm/mach-s5pc100/dev-spi.c                  |  223 ----------------------
 arch/arm/mach-s5pv210/dev-spi.c                  |  173 -----------------
 arch/arm/plat-samsung/Kconfig                    |   15 ++-
 arch/arm/plat-samsung/Makefile                   |    3 +
 arch/arm/plat-samsung/dev-spi0.c                 |   87 +++++++++
 arch/arm/plat-samsung/dev-spi1.c                 |   87 +++++++++
 arch/arm/plat-samsung/dev-spi2.c                 |   87 +++++++++
 arch/arm/plat-samsung/include/plat/devs.h        |   12 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   18 ++-
 11 files changed, 289 insertions(+), 815 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-spi.c
 delete mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
 delete mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 delete mode 100644 arch/arm/mach-s5pv210/dev-spi.c
 create mode 100644 arch/arm/plat-samsung/dev-spi0.c
 create mode 100644 arch/arm/plat-samsung/dev-spi1.c
 create mode 100644 arch/arm/plat-samsung/dev-spi2.c

diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
deleted file mode 100644
index 82db072..0000000
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ /dev/null
@@ -1,177 +0,0 @@
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
-static char *spi_src_clks[] = {
-	[S3C64XX_SPI_SRCCLK_PCLK] = "pclk",
-	[S3C64XX_SPI_SRCCLK_SPIBUS] = "spi-bus",
-	[S3C64XX_SPI_SRCCLK_48M] = "spi_48m",
-};
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
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
-}
diff --git a/arch/arm/mach-s5p64x0/dev-spi.c b/arch/arm/mach-s5p64x0/dev-spi.c
deleted file mode 100644
index e78ee18..0000000
--- a/arch/arm/mach-s5p64x0/dev-spi.c
+++ /dev/null
@@ -1,222 +0,0 @@
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
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
-
-static char *s5p64x0_spi_src_clks[] = {
-	[S5P64X0_SPI_SRCCLK_PCLK] = "pclk",
-	[S5P64X0_SPI_SRCCLK_SCLK] = "sclk_spi",
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
-};
-
-static struct s3c64xx_spi_info s5p6450_spi0_pdata = {
-	.cfg_gpio	= s5p6450_spi_cfg_gpio,
-	.fifo_lvl_mask	= 0x1ff,
-	.rx_lvl_offset	= 15,
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
-};
-
-static struct s3c64xx_spi_info s5p6450_spi1_pdata = {
-	.cfg_gpio	= s5p6450_spi_cfg_gpio,
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
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
-	unsigned int id;
-	struct s3c64xx_spi_info *pd;
-
-	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
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
-		if (id == 0x50000)
-			pd = &s5p6450_spi0_pdata;
-		else
-			pd = &s5p6440_spi0_pdata;
-
-		s5p64x0_device_spi0.dev.platform_data = pd;
-		break;
-	case 1:
-		if (id == 0x50000)
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
-	pd->src_clk_name = s5p64x0_spi_src_clks[src_clk_nr];
-}
diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
deleted file mode 100644
index 57b1979..0000000
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ /dev/null
@@ -1,223 +0,0 @@
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
-
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
-#include <plat/irqs.h>
-
-static char *spi_src_clks[] = {
-	[S5PC100_SPI_SRCCLK_PCLK] = "pclk",
-	[S5PC100_SPI_SRCCLK_48M] = "spi_48m",
-	[S5PC100_SPI_SRCCLK_SPIBUS] = "spi_bus",
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
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
-}
diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
deleted file mode 100644
index e3249a4..0000000
--- a/arch/arm/mach-s5pv210/dev-spi.c
+++ /dev/null
@@ -1,173 +0,0 @@
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
-static char *spi_src_clks[] = {
-	[S5PV210_SPI_SRCCLK_PCLK] = "pclk",
-	[S5PV210_SPI_SRCCLK_SCLK] = "sclk_spi",
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
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
-}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 4d79519..0feb5ed 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -258,11 +258,20 @@ config SAMSUNG_DEV_IDE
 	help
 	  Compile in platform device definitions for IDE
 
-config S3C64XX_DEV_SPI
+config SAMSUNG_DEV_SPI0
 	bool
 	help
-	  Compile in platform device definitions for S3C64XX's type
-	  SPI controllers.
+	  Compile in platform device definitions for SPI channel 0
+
+config SAMSUNG_DEV_SPI1
+	bool
+	help
+	  Compile in platform device definitions for SPI channel 1
+
+config SAMSUNG_DEV_SPI2
+	bool
+	help
+	  Compile in platform device definitions for SPI channel 2
 
 config SAMSUNG_DEV_TS
 	bool
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 53eb15b..f226283 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -53,6 +53,9 @@ obj-$(CONFIG_S3C_DEV_WDT)	+= dev-wdt.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
 obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
+obj-$(CONFIG_SAMSUNG_DEV_SPI0)	+= dev-spi0.o
+obj-$(CONFIG_SAMSUNG_DEV_SPI1)	+= dev-spi1.o
+obj-$(CONFIG_SAMSUNG_DEV_SPI2)	+= dev-spi2.o
 
 obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_IDE)	+= dev-ide.o
diff --git a/arch/arm/plat-samsung/dev-spi0.c b/arch/arm/plat-samsung/dev-spi0.c
new file mode 100644
index 0000000..3d2c8bf
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-spi0.c
@@ -0,0 +1,87 @@
+/* linux/arch/arm/plat-samsung/dev-spi0.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/dma.h>
+#include <mach/map.h>
+#include <mach/spi-clocks.h>
+#include <mach/irqs.h>
+
+#include <plat/s3c64xx-spi.h>
+#include <plat/devs.h>
+
+static struct resource s3c_spi0_resource[] = {
+	[0] = {
+		.start	= S3C_PA_SPI0,
+		.end	= S3C_PA_SPI0 + SZ_256 - 1,
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
+static struct s3c64xx_spi_info s3c_spi0_def_pdata = {
+	.cfg_gpio	= s3c_spi0_cfg_gpio,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s3c_device_spi0 = {
+	.name		= "s3c64xx-spi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_spi0_resource),
+	.resource	= s3c_spi0_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_spi0_def_pdata,
+	},
+};
+
+void __init s3c_spi0_set_info(struct s3c64xx_spi_info *pd,
+				int src_clk_nr, int num_cs)
+{
+	struct s3c64xx_spi_info *spi_info = &s3c_spi0_def_pdata;
+	if (NULL == pd) {
+		printk(KERN_ERR "%s: Need to pass platform data\n", __func__);
+		return;
+	}
+	spi_info->fifo_lvl_mask = pd->fifo_lvl_mask;
+	spi_info->rx_lvl_offset = pd->rx_lvl_offset;
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > ARRAY_SIZE(spi_src_clks)) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+	spi_info->num_cs = num_cs;
+	spi_info->src_clk_nr = src_clk_nr;
+	spi_info->src_clk_name = spi_src_clks[src_clk_nr];
+	if (pd->high_speed)
+		spi_info->high_speed = pd->high_speed;
+	if (pd->clk_from_cmu)
+		spi_info->clk_from_cmu = pd->clk_from_cmu;
+}
diff --git a/arch/arm/plat-samsung/dev-spi1.c b/arch/arm/plat-samsung/dev-spi1.c
new file mode 100644
index 0000000..2aaa251
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-spi1.c
@@ -0,0 +1,87 @@
+/* linux/arch/arm/plat-samsung/dev-spi1.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/dma.h>
+#include <mach/map.h>
+#include <mach/spi-clocks.h>
+#include <mach/irqs.h>
+
+#include <plat/s3c64xx-spi.h>
+#include <plat/devs.h>
+
+static struct resource s3c_spi1_resource[] = {
+	[0] = {
+		.start	= S3C_PA_SPI1,
+		.end	= S3C_PA_SPI1 + SZ_256 - 1,
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
+static struct s3c64xx_spi_info s3c_spi1_def_pdata = {
+	.cfg_gpio	= s3c_spi1_cfg_gpio,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s3c_device_spi1 = {
+	.name		= "s3c64xx-spi",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c_spi1_resource),
+	.resource	= s3c_spi1_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_spi1_def_pdata,
+	},
+};
+
+void __init s3c_spi1_set_info(struct s3c64xx_spi_info *pd,
+				int src_clk_nr, int num_cs)
+{
+	struct s3c64xx_spi_info *spi_info = &s3c_spi1_def_pdata;
+	if (NULL == pd) {
+		printk(KERN_ERR "%s: Need to pass platform data\n", __func__);
+		return;
+	}
+	spi_info->fifo_lvl_mask = pd->fifo_lvl_mask;
+	spi_info->rx_lvl_offset = pd->rx_lvl_offset;
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > ARRAY_SIZE(spi_src_clks)) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+	spi_info->num_cs = num_cs;
+	spi_info->src_clk_nr = src_clk_nr;
+	spi_info->src_clk_name = spi_src_clks[src_clk_nr];
+	if (pd->high_speed)
+		spi_info->high_speed = pd->high_speed;
+	if (pd->clk_from_cmu)
+		spi_info->clk_from_cmu = pd->clk_from_cmu;
+}
diff --git a/arch/arm/plat-samsung/dev-spi2.c b/arch/arm/plat-samsung/dev-spi2.c
new file mode 100644
index 0000000..15218b5
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-spi2.c
@@ -0,0 +1,87 @@
+/* linux/arch/arm/plat-samsung/dev-spi2.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/dma.h>
+#include <mach/map.h>
+#include <mach/spi-clocks.h>
+#include <mach/irqs.h>
+
+#include <plat/s3c64xx-spi.h>
+#include <plat/devs.h>
+
+static struct resource s3c_spi2_resource[] = {
+	[0] = {
+		.start	= S3C_PA_SPI2,
+		.end	= S3C_PA_SPI2 + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMACH_SPI2_TX,
+		.end	= DMACH_SPI2_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMACH_SPI2_RX,
+		.end	= DMACH_SPI2_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= IRQ_SPI2,
+		.end	= IRQ_SPI2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c64xx_spi_info s3c_spi2_def_pdata = {
+	.cfg_gpio	= s3c_spi2_cfg_gpio,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s3c_device_spi2 = {
+	.name		= "s3c64xx-spi",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s3c_spi2_resource),
+	.resource	= s3c_spi2_resource,
+	.dev = {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_spi2_def_pdata,
+	},
+};
+
+void __init s3c_spi2_set_info(struct s3c64xx_spi_info *pd,
+				int src_clk_nr, int num_cs)
+{
+	struct s3c64xx_spi_info *spi_info = &s3c_spi2_def_pdata;
+	if (NULL == pd) {
+		printk(KERN_ERR "%s: Need to pass platform data\n", __func__);
+		return;
+	}
+	spi_info->fifo_lvl_mask = pd->fifo_lvl_mask;
+	spi_info->rx_lvl_offset = pd->rx_lvl_offset;
+	/* Reject invalid configuration */
+	if (!num_cs || src_clk_nr < 0
+			|| src_clk_nr > ARRAY_SIZE(spi_src_clks)) {
+		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
+		return;
+	}
+	spi_info->num_cs = num_cs;
+	spi_info->src_clk_nr = src_clk_nr;
+	spi_info->src_clk_name = spi_src_clks[src_clk_nr];
+	if (pd->high_speed)
+		spi_info->high_speed = pd->high_speed;
+	if (pd->clk_from_cmu)
+		spi_info->clk_from_cmu = pd->clk_from_cmu;
+}
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e3b31c2..96fc424 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -36,9 +36,6 @@ extern struct platform_device s3c64xx_device_iis0;
 extern struct platform_device s3c64xx_device_iis1;
 extern struct platform_device s3c64xx_device_iisv4;
 
-extern struct platform_device s3c64xx_device_spi0;
-extern struct platform_device s3c64xx_device_spi1;
-
 extern struct platform_device samsung_asoc_dma;
 
 extern struct platform_device s3c64xx_device_pcm0;
@@ -73,14 +70,7 @@ extern struct platform_device s3c_device_cfcon;
 
 extern struct platform_device s3c_device_spi0;
 extern struct platform_device s3c_device_spi1;
-
-extern struct platform_device s5pc100_device_spi0;
-extern struct platform_device s5pc100_device_spi1;
-extern struct platform_device s5pc100_device_spi2;
-extern struct platform_device s5pv210_device_spi0;
-extern struct platform_device s5pv210_device_spi1;
-extern struct platform_device s5p64x0_device_spi0;
-extern struct platform_device s5p64x0_device_spi1;
+extern struct platform_device s3c_device_spi2;
 
 extern struct platform_device s3c_device_hwmon;
 
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 0ffe34a..b9f6a4b 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -56,18 +56,24 @@ struct s3c64xx_spi_info {
 };
 
 /**
- * s3c64xx_spi_set_info - SPI Controller configure callback by the board
+ * s3c_spi_set_info - SPI Controller configure callback by the board
  *				initialization code.
- * @cntrlr: SPI controller number the configuration is for.
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
+extern void s3c_spi0_set_info(struct s3c64xx_spi_info *pd,
+				int src_clk_nr, int num_cs);
+extern void s3c_spi1_set_info(struct s3c64xx_spi_info *pd,
+				int src_clk_nr, int num_cs);
+extern void s3c_spi2_set_info(struct s3c64xx_spi_info *pd,
+				int src_clk_nr, int num_cs);
+
+/* defined by architecture to configure gpio */
+extern int s3c_spi0_cfg_gpio(struct platform_device *dev);
+extern int s3c_spi1_cfg_gpio(struct platform_device *dev);
+extern int s3c_spi2_cfg_gpio(struct platform_device *dev);
 
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.7.0.4
