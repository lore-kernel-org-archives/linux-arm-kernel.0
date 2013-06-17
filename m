From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:33:52 +0200
Subject: [PATCH v2 07/38] ARM: EXYNOS: Remove legacy dev- and setup- files
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes now unused files containing old device and GPIO setup
code that was needed for ATAGS based boot, which is not supported on
Exynos any more.

The only exception is setup-i2c0.c that will be removed later, since it
has dependencies in plat-samsung/ directory.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Makefile           |   3 -
 arch/arm/mach-exynos/dev-audio.c        | 254 --------------------------------
 arch/arm/mach-exynos/dev-uart.c         |  55 -------
 arch/arm/mach-exynos/setup-fimc.c       |  44 ------
 arch/arm/mach-exynos/setup-fimd0.c      |  43 ------
 arch/arm/mach-exynos/setup-i2c0.c       |  10 --
 arch/arm/mach-exynos/setup-i2c1.c       |  23 ---
 arch/arm/mach-exynos/setup-i2c2.c       |  23 ---
 arch/arm/mach-exynos/setup-i2c3.c       |  23 ---
 arch/arm/mach-exynos/setup-i2c4.c       |  23 ---
 arch/arm/mach-exynos/setup-i2c5.c       |  23 ---
 arch/arm/mach-exynos/setup-i2c6.c       |  23 ---
 arch/arm/mach-exynos/setup-i2c7.c       |  23 ---
 arch/arm/mach-exynos/setup-keypad.c     |  36 -----
 arch/arm/mach-exynos/setup-sdhci-gpio.c | 152 -------------------
 arch/arm/mach-exynos/setup-spi.c        |  45 ------
 arch/arm/mach-exynos/setup-usb-phy.c    | 223 ----------------------------
 17 files changed, 1026 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/dev-audio.c
 delete mode 100644 arch/arm/mach-exynos/dev-uart.c
 delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
 delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
 delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
 delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/mach-exynos/setup-spi.c
 delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 9811f87..5fc6cfd 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -37,7 +37,4 @@ obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 
 # device support
 
-obj-y					+= dev-uart.o
-obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
-
 obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
deleted file mode 100644
index c662c89..0000000
--- a/arch/arm/mach-exynos/dev-audio.c
+++ /dev/null
@@ -1,254 +0,0 @@
-/* linux/arch/arm/mach-exynos4/dev-audio.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
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
-#include <linux/platform_data/asoc-s3c.h>
-
-#include <plat/gpio-cfg.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-#include <mach/irqs.h>
-
-#define EXYNOS4_AUDSS_INT_MEM	(0x03000000)
-
-static int exynos4_cfg_i2s(struct platform_device *pdev)
-{
-	/* configure GPIO for i2s port */
-	switch (pdev->id) {
-	case 0:
-		s3c_gpio_cfgpin_range(EXYNOS4_GPZ(0), 7, S3C_GPIO_SFN(2));
-		break;
-	case 1:
-		s3c_gpio_cfgpin_range(EXYNOS4_GPC0(0), 5, S3C_GPIO_SFN(2));
-		break;
-	case 2:
-		s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 5, S3C_GPIO_SFN(4));
-		break;
-	default:
-		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct s3c_audio_pdata i2sv5_pdata = {
-	.cfg_gpio = exynos4_cfg_i2s,
-	.type = {
-		.i2s = {
-			.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
-					 | QUIRK_NEED_RSTCLR,
-			.idma_addr = EXYNOS4_AUDSS_INT_MEM,
-		},
-	},
-};
-
-static struct resource exynos4_i2s0_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S0, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_I2S0_TX),
-	[2] = DEFINE_RES_DMA(DMACH_I2S0_RX),
-	[3] = DEFINE_RES_DMA(DMACH_I2S0S_TX),
-};
-
-struct platform_device exynos4_device_i2s0 = {
-	.name = "samsung-i2s",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(exynos4_i2s0_resource),
-	.resource = exynos4_i2s0_resource,
-	.dev = {
-		.platform_data = &i2sv5_pdata,
-	},
-};
-
-static struct s3c_audio_pdata i2sv3_pdata = {
-	.cfg_gpio = exynos4_cfg_i2s,
-	.type = {
-		.i2s = {
-			.quirks = QUIRK_NO_MUXPSR,
-		},
-	},
-};
-
-static struct resource exynos4_i2s1_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S1, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_I2S1_TX),
-	[2] = DEFINE_RES_DMA(DMACH_I2S1_RX),
-};
-
-struct platform_device exynos4_device_i2s1 = {
-	.name = "samsung-i2s",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(exynos4_i2s1_resource),
-	.resource = exynos4_i2s1_resource,
-	.dev = {
-		.platform_data = &i2sv3_pdata,
-	},
-};
-
-static struct resource exynos4_i2s2_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S2, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_I2S2_TX),
-	[2] = DEFINE_RES_DMA(DMACH_I2S2_RX),
-};
-
-struct platform_device exynos4_device_i2s2 = {
-	.name = "samsung-i2s",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(exynos4_i2s2_resource),
-	.resource = exynos4_i2s2_resource,
-	.dev = {
-		.platform_data = &i2sv3_pdata,
-	},
-};
-
-/* PCM Controller platform_devices */
-
-static int exynos4_pcm_cfg_gpio(struct platform_device *pdev)
-{
-	switch (pdev->id) {
-	case 0:
-		s3c_gpio_cfgpin_range(EXYNOS4_GPZ(0), 5, S3C_GPIO_SFN(3));
-		break;
-	case 1:
-		s3c_gpio_cfgpin_range(EXYNOS4_GPC0(0), 5, S3C_GPIO_SFN(3));
-		break;
-	case 2:
-		s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 5, S3C_GPIO_SFN(3));
-		break;
-	default:
-		printk(KERN_DEBUG "Invalid PCM Controller number!");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct s3c_audio_pdata s3c_pcm_pdata = {
-	.cfg_gpio = exynos4_pcm_cfg_gpio,
-};
-
-static struct resource exynos4_pcm0_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_PCM0, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_PCM0_TX),
-	[2] = DEFINE_RES_DMA(DMACH_PCM0_RX),
-};
-
-struct platform_device exynos4_device_pcm0 = {
-	.name = "samsung-pcm",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(exynos4_pcm0_resource),
-	.resource = exynos4_pcm0_resource,
-	.dev = {
-		.platform_data = &s3c_pcm_pdata,
-	},
-};
-
-static struct resource exynos4_pcm1_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_PCM1, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_PCM1_TX),
-	[2] = DEFINE_RES_DMA(DMACH_PCM1_RX),
-};
-
-struct platform_device exynos4_device_pcm1 = {
-	.name = "samsung-pcm",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(exynos4_pcm1_resource),
-	.resource = exynos4_pcm1_resource,
-	.dev = {
-		.platform_data = &s3c_pcm_pdata,
-	},
-};
-
-static struct resource exynos4_pcm2_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_PCM2, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_PCM2_TX),
-	[2] = DEFINE_RES_DMA(DMACH_PCM2_RX),
-};
-
-struct platform_device exynos4_device_pcm2 = {
-	.name = "samsung-pcm",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(exynos4_pcm2_resource),
-	.resource = exynos4_pcm2_resource,
-	.dev = {
-		.platform_data = &s3c_pcm_pdata,
-	},
-};
-
-/* AC97 Controller platform devices */
-
-static int exynos4_ac97_cfg_gpio(struct platform_device *pdev)
-{
-	return s3c_gpio_cfgpin_range(EXYNOS4_GPC0(0), 5, S3C_GPIO_SFN(4));
-}
-
-static struct resource exynos4_ac97_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_AC97, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_AC97_PCMOUT),
-	[2] = DEFINE_RES_DMA(DMACH_AC97_PCMIN),
-	[3] = DEFINE_RES_DMA(DMACH_AC97_MICIN),
-	[4] = DEFINE_RES_IRQ(EXYNOS4_IRQ_AC97),
-};
-
-static struct s3c_audio_pdata s3c_ac97_pdata = {
-	.cfg_gpio = exynos4_ac97_cfg_gpio,
-};
-
-static u64 exynos4_ac97_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device exynos4_device_ac97 = {
-	.name = "samsung-ac97",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(exynos4_ac97_resource),
-	.resource = exynos4_ac97_resource,
-	.dev = {
-		.platform_data = &s3c_ac97_pdata,
-		.dma_mask = &exynos4_ac97_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
-/* S/PDIF Controller platform_device */
-
-static int exynos4_spdif_cfg_gpio(struct platform_device *pdev)
-{
-	s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 2, S3C_GPIO_SFN(4));
-
-	return 0;
-}
-
-static struct resource exynos4_spdif_resource[] = {
-	[0] = DEFINE_RES_MEM(EXYNOS4_PA_SPDIF, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_SPDIF),
-};
-
-static struct s3c_audio_pdata samsung_spdif_pdata = {
-	.cfg_gpio = exynos4_spdif_cfg_gpio,
-};
-
-static u64 exynos4_spdif_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device exynos4_device_spdif = {
-	.name = "samsung-spdif",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(exynos4_spdif_resource),
-	.resource = exynos4_spdif_resource,
-	.dev = {
-		.platform_data = &samsung_spdif_pdata,
-		.dma_mask = &exynos4_spdif_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/mach-exynos/dev-uart.c b/arch/arm/mach-exynos/dev-uart.c
deleted file mode 100644
index c48aff0..0000000
--- a/arch/arm/mach-exynos/dev-uart.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Base EXYNOS UART resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <mach/irqs.h>
-
-#include <plat/devs.h>
-
-#define EXYNOS_UART_RESOURCE(_series, _nr)	\
-static struct resource exynos##_series##_uart##_nr##_resource[] = {	\
-	[0] = DEFINE_RES_MEM(EXYNOS##_series##_PA_UART##_nr, EXYNOS##_series##_SZ_UART),	\
-	[1] = DEFINE_RES_IRQ(EXYNOS##_series##_IRQ_UART##_nr),	\
-};
-
-EXYNOS_UART_RESOURCE(4, 0)
-EXYNOS_UART_RESOURCE(4, 1)
-EXYNOS_UART_RESOURCE(4, 2)
-EXYNOS_UART_RESOURCE(4, 3)
-
-struct s3c24xx_uart_resources exynos4_uart_resources[] __initdata = {
-	[0] = {
-		.resources	= exynos4_uart0_resource,
-		.nr_resources	= ARRAY_SIZE(exynos4_uart0_resource),
-	},
-	[1] = {
-		.resources	= exynos4_uart1_resource,
-		.nr_resources	= ARRAY_SIZE(exynos4_uart1_resource),
-	},
-	[2] = {
-		.resources	= exynos4_uart2_resource,
-		.nr_resources	= ARRAY_SIZE(exynos4_uart2_resource),
-	},
-	[3] = {
-		.resources	= exynos4_uart3_resource,
-		.nr_resources	= ARRAY_SIZE(exynos4_uart3_resource),
-	},
-};
diff --git a/arch/arm/mach-exynos/setup-fimc.c b/arch/arm/mach-exynos/setup-fimc.c
deleted file mode 100644
index 6a45078..0000000
--- a/arch/arm/mach-exynos/setup-fimc.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co., Ltd.
- *
- * Exynos4 camera interface GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gpio.h>
-#include <plat/gpio-cfg.h>
-#include <plat/camport.h>
-
-int exynos4_fimc_setup_gpio(enum s5p_camport_id id)
-{
-	u32 gpio8, gpio5;
-	u32 sfn;
-	int ret;
-
-	switch (id) {
-	case S5P_CAMPORT_A:
-		gpio8 = EXYNOS4_GPJ0(0); /* PCLK, VSYNC, HREF, DATA[0:4] */
-		gpio5 = EXYNOS4_GPJ1(0); /* DATA[5:7], CLKOUT, FIELD */
-		sfn = S3C_GPIO_SFN(2);
-		break;
-
-	case S5P_CAMPORT_B:
-		gpio8 = EXYNOS4_GPE0(0); /* DATA[0:7] */
-		gpio5 = EXYNOS4_GPE1(0); /* PCLK, VSYNC, HREF, CLKOUT, FIELD */
-		sfn = S3C_GPIO_SFN(3);
-		break;
-
-	default:
-		WARN(1, "Wrong camport id: %d\n", id);
-		return -EINVAL;
-	}
-
-	ret = s3c_gpio_cfgall_range(gpio8, 8, sfn, S3C_GPIO_PULL_UP);
-	if (ret)
-		return ret;
-
-	return s3c_gpio_cfgall_range(gpio5, 5, sfn, S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-fimd0.c b/arch/arm/mach-exynos/setup-fimd0.c
deleted file mode 100644
index 5665bb4..0000000
--- a/arch/arm/mach-exynos/setup-fimd0.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* linux/arch/arm/mach-exynos4/setup-fimd0.c
- *
- * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
- *             http://www.samsung.com
- *
- * Base Exynos4 FIMD 0 configuration
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/fb.h>
-#include <linux/gpio.h>
-
-#include <video/samsung_fimd.h>
-#include <plat/gpio-cfg.h>
-
-#include <mach/map.h>
-
-void exynos4_fimd0_gpio_setup_24bpp(void)
-{
-	unsigned int reg;
-
-	s3c_gpio_cfgrange_nopull(EXYNOS4_GPF0(0), 8, S3C_GPIO_SFN(2));
-	s3c_gpio_cfgrange_nopull(EXYNOS4_GPF1(0), 8, S3C_GPIO_SFN(2));
-	s3c_gpio_cfgrange_nopull(EXYNOS4_GPF2(0), 8, S3C_GPIO_SFN(2));
-	s3c_gpio_cfgrange_nopull(EXYNOS4_GPF3(0), 4, S3C_GPIO_SFN(2));
-
-	/*
-	 * Set DISPLAY_CONTROL register for Display path selection.
-	 *
-	 * DISPLAY_CONTROL[1:0]
-	 * ---------------------
-	 *  00 | MIE
-	 *  01 | MDINE
-	 *  10 | FIMD : selected
-	 *  11 | FIMD
-	 */
-	reg = __raw_readl(S3C_VA_SYS + 0x0210);
-	reg |= (1 << 1);
-	__raw_writel(reg, S3C_VA_SYS + 0x0210);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
index e2d9dfb..ede6ceb 100644
--- a/arch/arm/mach-exynos/setup-i2c0.c
+++ b/arch/arm/mach-exynos/setup-i2c0.c
@@ -13,17 +13,7 @@
 
 struct platform_device; /* don't need the contents */
 
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-#include <plat/cpu.h>
-
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	if (soc_is_exynos5250() || soc_is_exynos5440())
-		/* will be implemented with gpio function */
-		return;
 
-	s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c1.c b/arch/arm/mach-exynos/setup-i2c1.c
deleted file mode 100644
index 8d2279c..0000000
--- a/arch/arm/mach-exynos/setup-i2c1.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c1.c
- *
- * Copyright (C) 2010 Samsung Electronics Co., Ltd.
- *
- * I2C1 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c1_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPD1(2), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c2.c b/arch/arm/mach-exynos/setup-i2c2.c
deleted file mode 100644
index 0ed62fc..0000000
--- a/arch/arm/mach-exynos/setup-i2c2.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c2.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *
- * I2C2 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c2_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPA0(6), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c3.c b/arch/arm/mach-exynos/setup-i2c3.c
deleted file mode 100644
index 7787fd2..0000000
--- a/arch/arm/mach-exynos/setup-i2c3.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c3.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *
- * I2C3 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c3_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPA1(2), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c4.c b/arch/arm/mach-exynos/setup-i2c4.c
deleted file mode 100644
index edc847f..0000000
--- a/arch/arm/mach-exynos/setup-i2c4.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c4.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *
- * I2C4 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c4_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c5.c b/arch/arm/mach-exynos/setup-i2c5.c
deleted file mode 100644
index d88af7f..0000000
--- a/arch/arm/mach-exynos/setup-i2c5.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c5.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *
- * I2C5 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c5_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c6.c b/arch/arm/mach-exynos/setup-i2c6.c
deleted file mode 100644
index c590286..0000000
--- a/arch/arm/mach-exynos/setup-i2c6.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c6.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *
- * I2C6 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c6_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
-			      S3C_GPIO_SFN(4), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-i2c7.c b/arch/arm/mach-exynos/setup-i2c7.c
deleted file mode 100644
index 1bba755..0000000
--- a/arch/arm/mach-exynos/setup-i2c7.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * linux/arch/arm/mach-exynos4/setup-i2c7.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *
- * I2C7 GPIO configuration.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c7_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(EXYNOS4_GPD0(2), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-exynos/setup-keypad.c b/arch/arm/mach-exynos/setup-keypad.c
deleted file mode 100644
index 7862bfb..0000000
--- a/arch/arm/mach-exynos/setup-keypad.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/mach-exynos4/setup-keypad.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * GPIO configuration for Exynos4 KeyPad device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gpio.h>
-#include <plat/gpio-cfg.h>
-
-void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
-{
-	/* Keypads can be of various combinations, Just making sure */
-
-	if (rows > 8) {
-		/* Set all the necessary GPX2 pins: KP_ROW[0~7] */
-		s3c_gpio_cfgall_range(EXYNOS4_GPX2(0), 8, S3C_GPIO_SFN(3),
-					S3C_GPIO_PULL_UP);
-
-		/* Set all the necessary GPX3 pins: KP_ROW[8~] */
-		s3c_gpio_cfgall_range(EXYNOS4_GPX3(0), (rows - 8),
-					 S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-	} else {
-		/* Set all the necessary GPX2 pins: KP_ROW[x] */
-		s3c_gpio_cfgall_range(EXYNOS4_GPX2(0), rows, S3C_GPIO_SFN(3),
-					S3C_GPIO_PULL_UP);
-	}
-
-	/* Set all the necessary GPX1 pins to special-function 3: KP_COL[x] */
-	s3c_gpio_cfgrange_nopull(EXYNOS4_GPX1(0), cols, S3C_GPIO_SFN(3));
-}
diff --git a/arch/arm/mach-exynos/setup-sdhci-gpio.c b/arch/arm/mach-exynos/setup-sdhci-gpio.c
deleted file mode 100644
index d5b98c8..0000000
--- a/arch/arm/mach-exynos/setup-sdhci-gpio.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/* linux/arch/arm/mach-exynos4/setup-sdhci-gpio.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/card.h>
-
-#include <mach/gpio.h>
-#include <plat/gpio-cfg.h>
-#include <plat/sdhci.h>
-
-void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPK0[0:1] pins to special-function 2 */
-	for (gpio = EXYNOS4_GPK0(0); gpio < EXYNOS4_GPK0(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	switch (width) {
-	case 8:
-		for (gpio = EXYNOS4_GPK1(3); gpio <= EXYNOS4_GPK1(6); gpio++) {
-			/* Data pin GPK1[3:6] to special-function 3 */
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
-			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-		}
-	case 4:
-		for (gpio = EXYNOS4_GPK0(3); gpio <= EXYNOS4_GPK0(6); gpio++) {
-			/* Data pin GPK0[3:6] to special-function 2 */
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
-			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-		}
-	default:
-		break;
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(EXYNOS4_GPK0(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(EXYNOS4_GPK0(2), S3C_GPIO_PULL_UP);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-}
-
-void exynos4_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPK1[0:1] pins to special-function 2 */
-	for (gpio = EXYNOS4_GPK1(0); gpio < EXYNOS4_GPK1(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	for (gpio = EXYNOS4_GPK1(3); gpio <= EXYNOS4_GPK1(6); gpio++) {
-		/* Data pin GPK1[3:6] to special-function 2 */
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(EXYNOS4_GPK1(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(EXYNOS4_GPK1(2), S3C_GPIO_PULL_UP);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-}
-
-void exynos4_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPK2[0:1] pins to special-function 2 */
-	for (gpio = EXYNOS4_GPK2(0); gpio < EXYNOS4_GPK2(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	switch (width) {
-	case 8:
-		for (gpio = EXYNOS4_GPK3(3); gpio <= EXYNOS4_GPK3(6); gpio++) {
-			/* Data pin GPK3[3:6] to special-function 3 */
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
-			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-		}
-	case 4:
-		for (gpio = EXYNOS4_GPK2(3); gpio <= EXYNOS4_GPK2(6); gpio++) {
-			/* Data pin GPK2[3:6] to special-function 2 */
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
-			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-		}
-	default:
-		break;
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(EXYNOS4_GPK2(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(EXYNOS4_GPK2(2), S3C_GPIO_PULL_UP);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-}
-
-void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPK3[0:1] pins to special-function 2 */
-	for (gpio = EXYNOS4_GPK3(0); gpio < EXYNOS4_GPK3(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	for (gpio = EXYNOS4_GPK3(3); gpio <= EXYNOS4_GPK3(6); gpio++) {
-		/* Data pin GPK3[3:6] to special-function 2 */
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(EXYNOS4_GPK3(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(EXYNOS4_GPK3(2), S3C_GPIO_PULL_UP);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-}
diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
deleted file mode 100644
index 4999829..0000000
--- a/arch/arm/mach-exynos/setup-spi.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/* linux/arch/arm/mach-exynos4/setup-spi.c
- *
- * Copyright (C) 2011 Samsung Electronics Ltd.
- *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gpio.h>
-#include <plat/gpio-cfg.h>
-
-#ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(void)
-{
-	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(void)
-{
-	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_S3C64XX_DEV_SPI2
-int s3c64xx_spi2_cfg_gpio(void)
-{
-	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
-	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
-			      S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
-	return 0;
-}
-#endif
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
deleted file mode 100644
index 6af4066..0000000
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <mach/regs-pmu.h>
-#include <mach/regs-usb-phy.h>
-#include <plat/cpu.h>
-#include <plat/usb-phy.h>
-
-static atomic_t host_usage;
-
-static int exynos4_usb_host_phy_is_on(void)
-{
-	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
-}
-
-static void exynos4210_usb_phy_clkset(struct platform_device *pdev)
-{
-	struct clk *xusbxti_clk;
-	u32 phyclk;
-
-	xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
-	if (xusbxti_clk && !IS_ERR(xusbxti_clk)) {
-		if (soc_is_exynos4210()) {
-			/* set clock frequency for PLL */
-			phyclk = readl(EXYNOS4_PHYCLK) & ~EXYNOS4210_CLKSEL_MASK;
-
-			switch (clk_get_rate(xusbxti_clk)) {
-			case 12 * MHZ:
-				phyclk |= EXYNOS4210_CLKSEL_12M;
-				break;
-			case 48 * MHZ:
-				phyclk |= EXYNOS4210_CLKSEL_48M;
-				break;
-			default:
-			case 24 * MHZ:
-				phyclk |= EXYNOS4210_CLKSEL_24M;
-				break;
-			}
-			writel(phyclk, EXYNOS4_PHYCLK);
-		} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
-			/* set clock frequency for PLL */
-			phyclk = readl(EXYNOS4_PHYCLK) & ~EXYNOS4X12_CLKSEL_MASK;
-
-			switch (clk_get_rate(xusbxti_clk)) {
-			case 9600 * KHZ:
-				phyclk |= EXYNOS4X12_CLKSEL_9600K;
-				break;
-			case 10 * MHZ:
-				phyclk |= EXYNOS4X12_CLKSEL_10M;
-				break;
-			case 12 * MHZ:
-				phyclk |= EXYNOS4X12_CLKSEL_12M;
-				break;
-			case 19200 * KHZ:
-				phyclk |= EXYNOS4X12_CLKSEL_19200K;
-				break;
-			case 20 * MHZ:
-				phyclk |= EXYNOS4X12_CLKSEL_20M;
-				break;
-			default:
-			case 24 * MHZ:
-				/* default reference clock */
-				phyclk |= EXYNOS4X12_CLKSEL_24M;
-				break;
-			}
-			writel(phyclk, EXYNOS4_PHYCLK);
-		}
-		clk_put(xusbxti_clk);
-	}
-}
-
-static int exynos4210_usb_phy0_init(struct platform_device *pdev)
-{
-	u32 rstcon;
-
-	writel(readl(S5P_USBDEVICE_PHY_CONTROL) | S5P_USBDEVICE_PHY_ENABLE,
-			S5P_USBDEVICE_PHY_CONTROL);
-
-	exynos4210_usb_phy_clkset(pdev);
-
-	/* set to normal PHY0 */
-	writel((readl(EXYNOS4_PHYPWR) & ~PHY0_NORMAL_MASK), EXYNOS4_PHYPWR);
-
-	/* reset PHY0 and Link */
-	rstcon = readl(EXYNOS4_RSTCON) | PHY0_SWRST_MASK;
-	writel(rstcon, EXYNOS4_RSTCON);
-	udelay(10);
-
-	rstcon &= ~PHY0_SWRST_MASK;
-	writel(rstcon, EXYNOS4_RSTCON);
-
-	return 0;
-}
-
-static int exynos4210_usb_phy0_exit(struct platform_device *pdev)
-{
-	writel((readl(EXYNOS4_PHYPWR) | PHY0_ANALOG_POWERDOWN |
-				PHY0_OTG_DISABLE), EXYNOS4_PHYPWR);
-
-	writel(readl(S5P_USBDEVICE_PHY_CONTROL) & ~S5P_USBDEVICE_PHY_ENABLE,
-			S5P_USBDEVICE_PHY_CONTROL);
-
-	return 0;
-}
-
-static int exynos4210_usb_phy1_init(struct platform_device *pdev)
-{
-	struct clk *otg_clk;
-	u32 rstcon;
-	int err;
-
-	atomic_inc(&host_usage);
-
-	otg_clk = clk_get(&pdev->dev, "otg");
-	if (IS_ERR(otg_clk)) {
-		dev_err(&pdev->dev, "Failed to get otg clock\n");
-		return PTR_ERR(otg_clk);
-	}
-
-	err = clk_enable(otg_clk);
-	if (err) {
-		clk_put(otg_clk);
-		return err;
-	}
-
-	if (exynos4_usb_host_phy_is_on())
-		return 0;
-
-	writel(readl(S5P_USBHOST_PHY_CONTROL) | S5P_USBHOST_PHY_ENABLE,
-			S5P_USBHOST_PHY_CONTROL);
-
-	exynos4210_usb_phy_clkset(pdev);
-
-	/* floating prevention logic: disable */
-	writel((readl(EXYNOS4_PHY1CON) | FPENABLEN), EXYNOS4_PHY1CON);
-
-	/* set to normal HSIC 0 and 1 of PHY1 */
-	writel((readl(EXYNOS4_PHYPWR) & ~PHY1_HSIC_NORMAL_MASK),
-			EXYNOS4_PHYPWR);
-
-	/* set to normal standard USB of PHY1 */
-	writel((readl(EXYNOS4_PHYPWR) & ~PHY1_STD_NORMAL_MASK), EXYNOS4_PHYPWR);
-
-	/* reset all ports of both PHY and Link */
-	rstcon = readl(EXYNOS4_RSTCON) | HOST_LINK_PORT_SWRST_MASK |
-		PHY1_SWRST_MASK;
-	writel(rstcon, EXYNOS4_RSTCON);
-	udelay(10);
-
-	rstcon &= ~(HOST_LINK_PORT_SWRST_MASK | PHY1_SWRST_MASK);
-	writel(rstcon, EXYNOS4_RSTCON);
-	udelay(80);
-
-	clk_disable(otg_clk);
-	clk_put(otg_clk);
-
-	return 0;
-}
-
-static int exynos4210_usb_phy1_exit(struct platform_device *pdev)
-{
-	struct clk *otg_clk;
-	int err;
-
-	if (atomic_dec_return(&host_usage) > 0)
-		return 0;
-
-	otg_clk = clk_get(&pdev->dev, "otg");
-	if (IS_ERR(otg_clk)) {
-		dev_err(&pdev->dev, "Failed to get otg clock\n");
-		return PTR_ERR(otg_clk);
-	}
-
-	err = clk_enable(otg_clk);
-	if (err) {
-		clk_put(otg_clk);
-		return err;
-	}
-
-	writel((readl(EXYNOS4_PHYPWR) | PHY1_STD_ANALOG_POWERDOWN),
-			EXYNOS4_PHYPWR);
-
-	writel(readl(S5P_USBHOST_PHY_CONTROL) & ~S5P_USBHOST_PHY_ENABLE,
-			S5P_USBHOST_PHY_CONTROL);
-
-	clk_disable(otg_clk);
-	clk_put(otg_clk);
-
-	return 0;
-}
-
-int s5p_usb_phy_init(struct platform_device *pdev, int type)
-{
-	if (type == USB_PHY_TYPE_DEVICE)
-		return exynos4210_usb_phy0_init(pdev);
-	else if (type == USB_PHY_TYPE_HOST)
-		return exynos4210_usb_phy1_init(pdev);
-
-	return -EINVAL;
-}
-
-int s5p_usb_phy_exit(struct platform_device *pdev, int type)
-{
-	if (type == USB_PHY_TYPE_DEVICE)
-		return exynos4210_usb_phy0_exit(pdev);
-	else if (type == USB_PHY_TYPE_HOST)
-		return exynos4210_usb_phy1_exit(pdev);
-
-	return -EINVAL;
-}
-- 
1.8.2.1
