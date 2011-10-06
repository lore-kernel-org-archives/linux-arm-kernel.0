From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Oct 2011 15:30:18 +0900
Subject: [PATCH RE-SEND 4/5] ARM: SAMSUNG: Cleanup plat-samsung/devs.c and
	devs.h
Message-ID: <00ea01cc83f1$6aeebe90$40cc3bb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch merges each dev files to one devs.c file in
plat-samsung directory and this help to keep it more
easily to reduce plat- directories such as plat-s3c24xx
and plat-s5p.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/Makefile            |   28 +-
 arch/arm/plat-samsung/dev-adc.c           |   46 --
 arch/arm/plat-samsung/dev-asocdma.c       |   35 -
 arch/arm/plat-samsung/dev-fb.c            |   63 --
 arch/arm/plat-samsung/dev-hsmmc.c         |   62 --
 arch/arm/plat-samsung/dev-hsmmc1.c        |   62 --
 arch/arm/plat-samsung/dev-hsmmc2.c        |   63 --
 arch/arm/plat-samsung/dev-hsmmc3.c        |   66 --
 arch/arm/plat-samsung/dev-hwmon.c         |   32 -
 arch/arm/plat-samsung/dev-i2c0.c          |   70 --
 arch/arm/plat-samsung/dev-i2c1.c          |   61 --
 arch/arm/plat-samsung/dev-i2c2.c          |   62 --
 arch/arm/plat-samsung/dev-i2c3.c          |   60 --
 arch/arm/plat-samsung/dev-i2c4.c          |   60 --
 arch/arm/plat-samsung/dev-i2c5.c          |   60 --
 arch/arm/plat-samsung/dev-i2c6.c          |   60 --
 arch/arm/plat-samsung/dev-i2c7.c          |   60 --
 arch/arm/plat-samsung/dev-ide.c           |   44 --
 arch/arm/plat-samsung/dev-keypad.c        |   50 --
 arch/arm/plat-samsung/dev-nand.c          |  125 ----
 arch/arm/plat-samsung/dev-onenand.c       |   43 --
 arch/arm/plat-samsung/dev-pwm.c           |   53 --
 arch/arm/plat-samsung/dev-rtc.c           |   43 --
 arch/arm/plat-samsung/dev-ts.c            |   59 --
 arch/arm/plat-samsung/dev-usb-hsotg.c     |   48 --
 arch/arm/plat-samsung/dev-usb.c           |   65 --
 arch/arm/plat-samsung/dev-wdt.c           |   40 --
 arch/arm/plat-samsung/devs.c              |  987 +++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |  156 ++---
 29 files changed, 1058 insertions(+), 1605 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/dev-adc.c
 delete mode 100644 arch/arm/plat-samsung/dev-asocdma.c
 delete mode 100644 arch/arm/plat-samsung/dev-fb.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc1.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc2.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc3.c
 delete mode 100644 arch/arm/plat-samsung/dev-hwmon.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c0.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c1.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c2.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c3.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c4.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c5.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c6.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c7.c
 delete mode 100644 arch/arm/plat-samsung/dev-ide.c
 delete mode 100644 arch/arm/plat-samsung/dev-keypad.c
 delete mode 100644 arch/arm/plat-samsung/dev-nand.c
 delete mode 100644 arch/arm/plat-samsung/dev-onenand.c
 delete mode 100644 arch/arm/plat-samsung/dev-pwm.c
 delete mode 100644 arch/arm/plat-samsung/dev-rtc.c
 delete mode 100644 arch/arm/plat-samsung/dev-ts.c
 delete mode 100644 arch/arm/plat-samsung/dev-usb-hsotg.c
 delete mode 100644 arch/arm/plat-samsung/dev-usb.c
 delete mode 100644 arch/arm/plat-samsung/dev-wdt.c

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 410a090..a524fab 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -15,7 +15,6 @@ obj-y				+= init.o cpu.o
 obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
-obj-y				+= dev-asocdma.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 
@@ -31,33 +30,8 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 obj-y				+= platformdata.o
 
 obj-y				+= devs.o
-obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
-obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
-obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
-obj-$(CONFIG_S3C_DEV_HSMMC3)	+= dev-hsmmc3.o
-obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
-obj-y				+= dev-i2c0.o
-obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
-obj-$(CONFIG_S3C_DEV_I2C2)	+= dev-i2c2.o
-obj-$(CONFIG_S3C_DEV_I2C3)	+= dev-i2c3.o
-obj-$(CONFIG_S3C_DEV_I2C4)	+= dev-i2c4.o
-obj-$(CONFIG_S3C_DEV_I2C5)	+= dev-i2c5.o
-obj-$(CONFIG_S3C_DEV_I2C6)	+= dev-i2c6.o
-obj-$(CONFIG_S3C_DEV_I2C7)	+= dev-i2c7.o
-obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-y				+= dev-uart.o
-obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
-obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
-obj-$(CONFIG_S3C_DEV_WDT)	+= dev-wdt.o
-obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
-obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
-obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
-
-obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
-obj-$(CONFIG_SAMSUNG_DEV_IDE)	+= dev-ide.o
-obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
-obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)	+= dev-keypad.o
-obj-$(CONFIG_SAMSUNG_DEV_PWM)	+= dev-pwm.o
+
 obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
 
 # DMA support
diff --git a/arch/arm/plat-samsung/dev-adc.c b/arch/arm/plat-samsung/dev-adc.c
deleted file mode 100644
index 9d903d4..0000000
--- a/arch/arm/plat-samsung/dev-adc.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-adc.c
- *
- * Copyright 2010 Maurus Cuelenaere
- *
- * S3C64xx series device definition for ADC device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/adc.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_adc_resource[] = {
-	[0] = {
-		.start = SAMSUNG_PA_ADC,
-		.end   = SAMSUNG_PA_ADC + SZ_256 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_TC,
-		.end   = IRQ_TC,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start = IRQ_ADC,
-		.end   = IRQ_ADC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_adc = {
-	.name		= "samsung-adc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
-	.resource	= s3c_adc_resource,
-};
diff --git a/arch/arm/plat-samsung/dev-asocdma.c b/arch/arm/plat-samsung/dev-asocdma.c
deleted file mode 100644
index 97e35d3..0000000
--- a/arch/arm/plat-samsung/dev-asocdma.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-asocdma.c
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
-#include <plat/devs.h>
-
-static u64 audio_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device samsung_asoc_dma = {
-	.name		  = "samsung-audio",
-	.id		  = -1,
-	.dev              = {
-		.dma_mask = &audio_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	}
-};
-EXPORT_SYMBOL(samsung_asoc_dma);
-
-struct platform_device samsung_asoc_idma = {
-	.name		= "samsung-idma",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &audio_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-EXPORT_SYMBOL(samsung_asoc_idma);
diff --git a/arch/arm/plat-samsung/dev-fb.c b/arch/arm/plat-samsung/dev-fb.c
deleted file mode 100644
index 49a1362..0000000
--- a/arch/arm/plat-samsung/dev-fb.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-fb.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for framebuffer device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-#include <linux/fb.h>
-#include <linux/gfp.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/fb.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_fb_resource[] = {
-	[0] = {
-		.start = S3C_PA_FB,
-		.end   = S3C_PA_FB + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_LCD_VSYNC,
-		.end   = IRQ_LCD_VSYNC,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start = IRQ_LCD_FIFO,
-		.end   = IRQ_LCD_FIFO,
-		.flags = IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start = IRQ_LCD_SYSTEM,
-		.end   = IRQ_LCD_SYSTEM,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_fb = {
-	.name		  = "s3c-fb",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_fb_resource),
-	.resource	  = s3c_fb_resource,
-	.dev.dma_mask	  = &s3c_device_fb.dev.coherent_dma_mask,
-	.dev.coherent_dma_mask = 0xffffffffUL,
-};
-
-void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
-{
-	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata),
-			 &s3c_device_fb);
-}
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
deleted file mode 100644
index 06825c4..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-hsmmc.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for hsmmc devices
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc_resource[] = {
-	[0] = {
-		.start = S3C_PA_HSMMC0,
-		.end   = S3C_PA_HSMMC0 + S3C_SZ_HSMMC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_HSMMC0,
-		.end   = IRQ_HSMMC0,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
-};
-
-struct platform_device s3c_device_hsmmc0 = {
-	.name		= "s3c-sdhci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc_resource),
-	.resource	= s3c_hsmmc_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc0_def_platdata,
-	},
-};
-
-void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	s3c_sdhci_set_platdata(pd, &s3c_hsmmc0_def_platdata);
-}
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
deleted file mode 100644
index 4524ef4..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-hsmmc1.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for hsmmc device 1
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc1_resource[] = {
-	[0] = {
-		.start = S3C_PA_HSMMC1,
-		.end   = S3C_PA_HSMMC1 + S3C_SZ_HSMMC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_HSMMC1,
-		.end   = IRQ_HSMMC1,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc1_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
-};
-
-struct platform_device s3c_device_hsmmc1 = {
-	.name		= "s3c-sdhci",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc1_resource),
-	.resource	= s3c_hsmmc1_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc1_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc1_def_platdata,
-	},
-};
-
-void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	s3c_sdhci_set_platdata(pd, &s3c_hsmmc1_def_platdata);
-}
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
deleted file mode 100644
index 9cede96..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-hsmmc2.c
- *
- * Copyright (c) 2009 Samsung Electronics
- * Copyright (c) 2009 Maurus Cuelenaere
- *
- * Based on arch/arm/plat-s3c/dev-hsmmc1.c
- * original file Copyright (c) 2008 Simtec Electronics
- *
- * S3C series device definition for hsmmc device 2
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc2_resource[] = {
-	[0] = {
-		.start = S3C_PA_HSMMC2,
-		.end   = S3C_PA_HSMMC2 + S3C_SZ_HSMMC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_HSMMC2,
-		.end   = IRQ_HSMMC2,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc2_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
-};
-
-struct platform_device s3c_device_hsmmc2 = {
-	.name		= "s3c-sdhci",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc2_resource),
-	.resource	= s3c_hsmmc2_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc2_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc2_def_platdata,
-	},
-};
-
-void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	s3c_sdhci_set_platdata(pd, &s3c_hsmmc2_def_platdata);
-}
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
deleted file mode 100644
index 0358ef4..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-hsmmc3.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Based on arch/arm/plat-samsung/dev-hsmmc1.c
- *
- * Samsung device definition for hsmmc device 3
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc3_resource[] = {
-	[0] = {
-		.start	= S3C_PA_HSMMC3,
-		.end	= S3C_PA_HSMMC3 + S3C_SZ_HSMMC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HSMMC3,
-		.end	= IRQ_HSMMC3,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc3_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
-};
-
-struct platform_device s3c_device_hsmmc3 = {
-	.name		= "s3c-sdhci",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc3_resource),
-	.resource	= s3c_hsmmc3_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc3_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc3_def_platdata,
-	},
-};
-
-void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	s3c_sdhci_set_platdata(pd, &s3c_hsmmc3_def_platdata);
-}
diff --git a/arch/arm/plat-samsung/dev-hwmon.c b/arch/arm/plat-samsung/dev-hwmon.c
deleted file mode 100644
index c91a79c..0000000
--- a/arch/arm/plat-samsung/dev-hwmon.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-hwmon.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Adapted for HWMON by Maurus Cuelenaere
- *
- * Samsung series device definition for HWMON
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <plat/devs.h>
-#include <plat/hwmon.h>
-
-struct platform_device s3c_device_hwmon = {
-	.name		= "s3c-hwmon",
-	.id		= -1,
-	.dev.parent	= &s3c_device_adc.dev,
-};
-
-void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd)
-{
-	s3c_set_platdata(pd, sizeof(struct s3c_hwmon_pdata),
-			 &s3c_device_hwmon);
-}
diff --git a/arch/arm/plat-samsung/dev-i2c0.c b/arch/arm/plat-samsung/dev-i2c0.c
deleted file mode 100644
index f8251f5..0000000
--- a/arch/arm/plat-samsung/dev-i2c0.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-i2c0.c
- *
- * Copyright 2008-2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for i2c device 0
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start = S3C_PA_IIC,
-		.end   = S3C_PA_IIC + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_IIC,
-		.end   = IRQ_IIC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c0 = {
-	.name		  = "s3c2410-i2c",
-#ifdef CONFIG_S3C_DEV_I2C1
-	.id		  = 0,
-#else
-	.id		  = -1,
-#endif
-	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
-	.resource	  = s3c_i2c_resource,
-};
-
-struct s3c2410_platform_i2c default_i2c_data __initdata = {
-	.flags		= 0,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
-void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd)
-		pd = &default_i2c_data;
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c0);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
deleted file mode 100644
index 3b7c7be..0000000
--- a/arch/arm/plat-samsung/dev-i2c1.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-i2c1.c
- *
- * Copyright 2008-2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for i2c device 1
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start = S3C_PA_IIC1,
-		.end   = S3C_PA_IIC1 + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_IIC1,
-		.end   = IRQ_IIC1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c1 = {
-	.name		  = "s3c2410-i2c",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
-	.resource	  = s3c_i2c_resource,
-};
-
-void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 1;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c1);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
deleted file mode 100644
index 07e9fd0..0000000
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-i2c2.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S3C series device definition for i2c device 2
- *
- * Based on plat-samsung/dev-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start = S3C_PA_IIC2,
-		.end   = S3C_PA_IIC2 + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_IIC2,
-		.end   = IRQ_IIC2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c2 = {
-	.name		  = "s3c2410-i2c",
-	.id		  = 2,
-	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
-	.resource	  = s3c_i2c_resource,
-};
-
-void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 2;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c2);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c3.c b/arch/arm/plat-samsung/dev-i2c3.c
deleted file mode 100644
index d48efa9..0000000
--- a/arch/arm/plat-samsung/dev-i2c3.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-i2c3.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P series device definition for i2c device 3
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC3,
-		.end	= S3C_PA_IIC3 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC3,
-		.end	= IRQ_IIC3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c3 = {
-	.name		= "s3c2440-i2c",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
-	.resource	= s3c_i2c_resource,
-};
-
-void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 3;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c3);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c3_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c4.c b/arch/arm/plat-samsung/dev-i2c4.c
deleted file mode 100644
index 07e2644..0000000
--- a/arch/arm/plat-samsung/dev-i2c4.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-i2c4.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P series device definition for i2c device 3
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC4,
-		.end	= S3C_PA_IIC4 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC4,
-		.end	= IRQ_IIC4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c4 = {
-	.name		= "s3c2440-i2c",
-	.id		= 4,
-	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
-	.resource	= s3c_i2c_resource,
-};
-
-void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 4;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c4);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c4_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c5.c b/arch/arm/plat-samsung/dev-i2c5.c
deleted file mode 100644
index f496557..0000000
--- a/arch/arm/plat-samsung/dev-i2c5.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-i2c3.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P series device definition for i2c device 3
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC5,
-		.end	= S3C_PA_IIC5 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC5,
-		.end	= IRQ_IIC5,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c5 = {
-	.name		= "s3c2440-i2c",
-	.id		= 5,
-	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
-	.resource	= s3c_i2c_resource,
-};
-
-void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 5;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c5);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c5_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c6.c b/arch/arm/plat-samsung/dev-i2c6.c
deleted file mode 100644
index 141d799..0000000
--- a/arch/arm/plat-samsung/dev-i2c6.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-i2c6.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P series device definition for i2c device 6
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC6,
-		.end	= S3C_PA_IIC6 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC6,
-		.end	= IRQ_IIC6,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c6 = {
-	.name		= "s3c2440-i2c",
-	.id		= 6,
-	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
-	.resource	= s3c_i2c_resource,
-};
-
-void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 6;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c6);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c6_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c7.c b/arch/arm/plat-samsung/dev-i2c7.c
deleted file mode 100644
index 9dddcd1..0000000
--- a/arch/arm/plat-samsung/dev-i2c7.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-i2c7.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P series device definition for i2c device 7
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC7,
-		.end	= S3C_PA_IIC7 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC7,
-		.end	= IRQ_IIC7,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c7 = {
-	.name		= "s3c2440-i2c",
-	.id		= 7,
-	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
-	.resource	= s3c_i2c_resource,
-};
-
-void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 7;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s3c_device_i2c7);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c7_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-ide.c b/arch/arm/plat-samsung/dev-ide.c
deleted file mode 100644
index b497982..0000000
--- a/arch/arm/plat-samsung/dev-ide.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-ide.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Samsung CF-ATA device definition.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-
-#include <mach/map.h>
-#include <plat/ata.h>
-#include <plat/devs.h>
-
-static struct resource s3c_cfcon_resource[] = {
-	[0] = {
-		.start	= SAMSUNG_PA_CFCON,
-		.end	= SAMSUNG_PA_CFCON + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CFCON,
-		.end	= IRQ_CFCON,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_cfcon = {
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_cfcon_resource),
-	.resource	= s3c_cfcon_resource,
-};
-
-void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
-{
-	s3c_set_platdata(pdata, sizeof(struct s3c_ide_platdata),
-			 &s3c_device_cfcon);
-}
diff --git a/arch/arm/plat-samsung/dev-keypad.c b/arch/arm/plat-samsung/dev-keypad.c
deleted file mode 100644
index 677c2d7..0000000
--- a/arch/arm/plat-samsung/dev-keypad.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * linux/arch/arm/plat-samsung/dev-keypad.c
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/platform_device.h>
-#include <mach/irqs.h>
-#include <mach/map.h>
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/keypad.h>
-
-static struct resource samsung_keypad_resources[] = {
-	[0] = {
-		.start	= SAMSUNG_PA_KEYPAD,
-		.end	= SAMSUNG_PA_KEYPAD + 0x20 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_KEYPAD,
-		.end	= IRQ_KEYPAD,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device samsung_device_keypad = {
-	.name		= "samsung-keypad",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(samsung_keypad_resources),
-	.resource	= samsung_keypad_resources,
-};
-
-void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
-{
-	struct samsung_keypad_platdata *npd;
-
-	npd = s3c_set_platdata(pd, sizeof(struct samsung_keypad_platdata),
-			&samsung_device_keypad);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = samsung_keypad_cfg_gpio;
-}
diff --git a/arch/arm/plat-samsung/dev-nand.c b/arch/arm/plat-samsung/dev-nand.c
deleted file mode 100644
index b8e30ec..0000000
--- a/arch/arm/plat-samsung/dev-nand.c
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * S3C series device definition for nand device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-
-#include <mach/map.h>
-#include <plat/devs.h>
-#include <plat/nand.h>
-
-static struct resource s3c_nand_resource[] = {
-	[0] = {
-		.start = S3C_PA_NAND,
-		.end   = S3C_PA_NAND + SZ_1M,
-		.flags = IORESOURCE_MEM,
-	}
-};
-
-struct platform_device s3c_device_nand = {
-	.name		  = "s3c2410-nand",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_nand_resource),
-	.resource	  = s3c_nand_resource,
-};
-
-EXPORT_SYMBOL(s3c_device_nand);
-
-/**
- * s3c_nand_copy_set() - copy nand set data
- * @set: The new structure, directly copied from the old.
- *
- * Copy all the fields from the NAND set field from what is probably __initdata
- * to new kernel memory. The code returns 0 if the copy happened correctly or
- * an error code for the calling function to display.
- *
- * Note, we currently do not try and look to see if we've already copied the
- * data in a previous set.
- */
-static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
-{
-	void *ptr;
-	int size;
-
-	size = sizeof(struct mtd_partition) * set->nr_partitions;
-	if (size) {
-		ptr = kmemdup(set->partitions, size, GFP_KERNEL);
-		set->partitions = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-	
-	if (set->nr_map && set->nr_chips) {
-		size = sizeof(int) * set->nr_chips;
-		ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
-		set->nr_map = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-
-	if (set->ecc_layout) {
-		ptr = kmemdup(set->ecc_layout,
-			      sizeof(struct nand_ecclayout), GFP_KERNEL);
-		set->ecc_layout = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-	
-	return 0;
-}
-
-void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
-{
-	struct s3c2410_platform_nand *npd;
-	int size;
-	int ret;
-
-	/* note, if we get a failure in allocation, we simply drop out of the
-	 * function. If there is so little memory available at initialisation
-	 * time then there is little chance the system is going to run.
-	 */ 
-
-	npd = s3c_set_platdata(nand, sizeof(struct s3c2410_platform_nand),
-				&s3c_device_nand);
-	if (!npd)
-		return;
-
-	/* now see if we need to copy any of the nand set data */
-
-	size = sizeof(struct s3c2410_nand_set) * npd->nr_sets;
-	if (size) {
-		struct s3c2410_nand_set *from = npd->sets;
-		struct s3c2410_nand_set *to;
-		int i;
-
-		to = kmemdup(from, size, GFP_KERNEL);
-		npd->sets = to;	/* set, even if we failed */
-
-		if (!to) {
-			printk(KERN_ERR "%s: no memory for sets\n", __func__);
-			return;
-		}
-		
-		for (i = 0; i < npd->nr_sets; i++) {
-			ret = s3c_nand_copy_set(to);
-			if (ret) {
-				printk(KERN_ERR "%s: failed to copy set %d\n",
-				__func__, i);
-				return;
-			}
-			to++;
-		}
-	}
-}
diff --git a/arch/arm/plat-samsung/dev-onenand.c b/arch/arm/plat-samsung/dev-onenand.c
deleted file mode 100644
index f54ae71..0000000
--- a/arch/arm/plat-samsung/dev-onenand.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * linux/arch/arm/plat-samsung/dev-onenand.c
- *
- *  Copyright (c) 2008-2010 Samsung Electronics
- *  Kyungmin Park <kyungmin.park@samsung.com>
- *
- * S3C64XX/S5PC100 series device definition for OneNAND devices
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-static struct resource s3c_onenand_resources[] = {
-	[0] = {
-		.start	= S3C_PA_ONENAND,
-		.end	= S3C_PA_ONENAND + 0x400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S3C_PA_ONENAND_BUF,
-		.end	= S3C_PA_ONENAND_BUF + S3C_SZ_ONENAND_BUF - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND,
-		.end	= IRQ_ONENAND,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_onenand = {
-	.name		= "samsung-onenand",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_onenand_resources),
-	.resource	= s3c_onenand_resources,
-};
diff --git a/arch/arm/plat-samsung/dev-pwm.c b/arch/arm/plat-samsung/dev-pwm.c
deleted file mode 100644
index dab47b0..0000000
--- a/arch/arm/plat-samsung/dev-pwm.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-pwm.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright (c) 2007 Ben Dooks
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
- *
- * S3C series device definition for the PWM timer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-
-#include <plat/devs.h>
-
-#define TIMER_RESOURCE_SIZE (1)
-
-#define TIMER_RESOURCE(_tmr, _irq)			\
-	(struct resource [TIMER_RESOURCE_SIZE]) {	\
-		[0] = {					\
-			.start	= _irq,			\
-			.end	= _irq,			\
-			.flags	= IORESOURCE_IRQ	\
-		}					\
-	}
-
-#define DEFINE_S3C_TIMER(_tmr_no, _irq)			\
-	.name		= "s3c24xx-pwm",		\
-	.id		= _tmr_no,			\
-	.num_resources	= TIMER_RESOURCE_SIZE,		\
-	.resource	= TIMER_RESOURCE(_tmr_no, _irq),	\
-
-/*
- * since we already have an static mapping for the timer,
- * we do not bother setting any IO resource for the base.
- */
-
-struct platform_device s3c_device_timer[] = {
-	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
-	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
-	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
-	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
-	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
-};
-EXPORT_SYMBOL(s3c_device_timer);
diff --git a/arch/arm/plat-samsung/dev-rtc.c b/arch/arm/plat-samsung/dev-rtc.c
deleted file mode 100644
index bf4e226..0000000
--- a/arch/arm/plat-samsung/dev-rtc.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-rtc.c
- *
- * Copyright 2009 by Maurus Cuelenaere <mcuelenaere@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-
-static struct resource s3c_rtc_resource[] = {
-	[0] = {
-		.start	= S3C_PA_RTC,
-		.end	= S3C_PA_RTC + 0xff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_RTC_ALARM,
-		.end	= IRQ_RTC_ALARM,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_RTC_TIC,
-		.end	= IRQ_RTC_TIC,
-		.flags	= IORESOURCE_IRQ
-	}
-};
-
-struct platform_device s3c_device_rtc = {
-	.name		= "s3c64xx-rtc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_rtc_resource),
-	.resource	= s3c_rtc_resource,
-};
-EXPORT_SYMBOL(s3c_device_rtc);
diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
deleted file mode 100644
index 5f3d46a..0000000
--- a/arch/arm/plat-samsung/dev-ts.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/dev-ts.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
- *
- * Adapted by Maurus Cuelenaere for s3c64xx
- *
- * S3C64XX series device definition for touchscreen device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-#include <plat/ts.h>
-
-static struct resource s3c_ts_resource[] = {
-	[0] = {
-		.start = SAMSUNG_PA_ADC,
-		.end   = SAMSUNG_PA_ADC + SZ_256 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_TC,
-		.end   = IRQ_TC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_ts = {
-	.name		= "s3c64xx-ts",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
-	.resource	= s3c_ts_resource,
-};
-
-static struct s3c2410_ts_mach_info default_ts_data __initdata = {
-	.delay			= 10000,
-	.presc			= 49,
-	.oversampling_shift	= 2,
-};
-
-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
-{
-	if (!pd)
-		pd = &default_ts_data;
-
-	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
-			 &s3c_device_ts);
-}
diff --git a/arch/arm/plat-samsung/dev-usb-hsotg.c b/arch/arm/plat-samsung/dev-usb-hsotg.c
deleted file mode 100644
index 33a844a..0000000
--- a/arch/arm/plat-samsung/dev-usb-hsotg.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-usb-hsotg.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for USB high-speed UDC/OtG block
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-
-static struct resource s3c_usb_hsotg_resources[] = {
-	[0] = {
-		.start	= S3C_PA_USB_HSOTG,
-		.end	= S3C_PA_USB_HSOTG + 0x10000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_OTG,
-		.end	= IRQ_OTG,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 s3c_hsotg_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s3c_device_usb_hsotg = {
-	.name		= "s3c-hsotg",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_usb_hsotg_resources),
-	.resource	= s3c_usb_hsotg_resources,
-	.dev		= {
-		.dma_mask		= &s3c_hsotg_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/plat-samsung/dev-usb.c b/arch/arm/plat-samsung/dev-usb.c
deleted file mode 100644
index 33fbaa9..0000000
--- a/arch/arm/plat-samsung/dev-usb.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-usb.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for USB host
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-#include <plat/usb-control.h>
-
-static struct resource s3c_usb_resource[] = {
-	[0] = {
-		.start = S3C_PA_USBHOST,
-		.end   = S3C_PA_USBHOST + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_USBH,
-		.end   = IRQ_USBH,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_usb_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_ohci = {
-	.name		  = "s3c2410-ohci",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_usb_resource),
-	.resource	  = s3c_usb_resource,
-	.dev              = {
-		.dma_mask = &s3c_device_usb_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_ohci);
-
-/**
- * s3c_ohci_set_platdata - initialise OHCI device platform data
- * @info: The platform data.
- *
- * This call copies the @info passed in and sets the device .platform_data
- * field to that copy. The @info is copied so that the original can be marked
- * __initdata.
- */
-void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
-{
-	s3c_set_platdata(info, sizeof(struct s3c2410_hcd_info),
-			 &s3c_device_ohci);
-}
diff --git a/arch/arm/plat-samsung/dev-wdt.c b/arch/arm/plat-samsung/dev-wdt.c
deleted file mode 100644
index 019b5b8..0000000
--- a/arch/arm/plat-samsung/dev-wdt.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-wdt.c
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C series device definition for the watchdog timer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-
-static struct resource s3c_wdt_resource[] = {
-	[0] = {
-		.start	= S3C_PA_WDT,
-		.end	= S3C_PA_WDT + SZ_1K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_WDT,
-		.end	= IRQ_WDT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device s3c_device_wdt = {
-	.name		= "s3c2410-wdt",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_wdt_resource),
-	.resource	= s3c_wdt_resource,
-};
-EXPORT_SYMBOL(s3c_device_wdt);
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index d8bd7ad..a2112aa 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -26,6 +26,8 @@
 #include <linux/gfp.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mmc/host.h>
 #include <linux/ioport.h>
 
 #include <asm/irq.h>
@@ -41,13 +43,20 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/adc.h>
+#include <plat/ata.h>
 #include <plat/ehci.h>
 #include <plat/fb.h>
 #include <plat/fb-s3c2410.h>
+#include <plat/hwmon.h>
 #include <plat/iic.h>
+#include <plat/keypad.h>
 #include <plat/mci.h>
+#include <plat/nand.h>
+#include <plat/sdhci.h>
 #include <plat/ts.h>
 #include <plat/udc.h>
+#include <plat/usb-control.h>
 #include <plat/usb-phy.h>
 #include <plat/regs-iic.h>
 #include <plat/regs-serial.h>
@@ -129,6 +138,33 @@ struct platform_device s3c_device_adc = {
 };
 #endif /* CONFIG_PLAT_S3C24XX */
 
+#if defined(CONFIG_SAMSUNG_DEV_ADC)
+static struct resource s3c_adc_resource[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_ADC,
+		.end	= SAMSUNG_PA_ADC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_TC,
+		.end	= IRQ_TC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_ADC,
+		.end	= IRQ_ADC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_adc = {
+	.name		= "samsung-adc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
+	.resource	= s3c_adc_resource,
+};
+#endif /* CONFIG_SAMSUNG_DEV_ADC */
+
 /* Camif Controller */
 
 #ifdef CONFIG_CPU_S3C2440
@@ -157,6 +193,70 @@ struct platform_device s3c_device_camif = {
 };
 #endif /* CONFIG_CPU_S3C2440 */
 
+/* ASOC DMA */
+
+struct platform_device samsung_asoc_dma = {
+	.name		= "samsung-audio",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+struct platform_device samsung_asoc_idma = {
+	.name		= "samsung-idma",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+/* FB */
+
+#ifdef CONFIG_S3C_DEV_FB
+static struct resource s3c_fb_resource[] = {
+	[0] = {
+		.start	= S3C_PA_FB,
+		.end	= S3C_PA_FB + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_LCD_VSYNC,
+		.end	= IRQ_LCD_VSYNC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_LCD_FIFO,
+		.end	= IRQ_LCD_FIFO,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_LCD_SYSTEM,
+		.end	= IRQ_LCD_SYSTEM,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_fb = {
+	.name		= "s3c-fb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_fb_resource),
+	.resource	= s3c_fb_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
+{
+	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata),
+			 &s3c_device_fb);
+}
+#endif /* CONFIG_S3C_DEV_FB */
+
 /* FIMC */
 
 #ifdef CONFIG_S5P_DEV_FIMC0
@@ -307,6 +407,497 @@ void __init s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd)
 }
 #endif /* CONFIG_S5P_DEV_FIMD0 */
 
+/* HWMON */
+
+#ifdef CONFIG_S3C_DEV_HWMON
+struct platform_device s3c_device_hwmon = {
+	.name		= "s3c-hwmon",
+	.id		= -1,
+	.dev.parent	= &s3c_device_adc.dev,
+};
+
+void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd)
+{
+	s3c_set_platdata(pd, sizeof(struct s3c_hwmon_pdata),
+			 &s3c_device_hwmon);
+}
+#endif /* CONFIG_S3C_DEV_HWMON */
+
+/* HSMMC */
+
+#define S3C_SZ_HSMMC	0x1000
+
+#ifdef CONFIG_S3C_DEV_HSMMC
+static struct resource s3c_hsmmc_resource[] = {
+	[0] = {
+		.start	= S3C_PA_HSMMC0,
+		.end	= S3C_PA_HSMMC0 + S3C_SZ_HSMMC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_HSMMC0,
+		.end	= IRQ_HSMMC0,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
+};
+
+struct platform_device s3c_device_hsmmc0 = {
+	.name		= "s3c-sdhci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc_resource),
+	.resource	= s3c_hsmmc_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_hsmmc0_def_platdata,
+	},
+};
+
+void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	s3c_sdhci_set_platdata(pd, &s3c_hsmmc0_def_platdata);
+}
+#endif /* CONFIG_S3C_DEV_HSMMC */
+
+#ifdef CONFIG_S3C_DEV_HSMMC1
+static struct resource s3c_hsmmc1_resource[] = {
+	[0] = {
+		.start	= S3C_PA_HSMMC1,
+		.end	= S3C_PA_HSMMC1 + S3C_SZ_HSMMC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_HSMMC1,
+		.end	= IRQ_HSMMC1,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
+};
+
+struct platform_device s3c_device_hsmmc1 = {
+	.name		= "s3c-sdhci",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc1_resource),
+	.resource	= s3c_hsmmc1_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_hsmmc1_def_platdata,
+	},
+};
+
+void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	s3c_sdhci_set_platdata(pd, &s3c_hsmmc1_def_platdata);
+}
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+
+/* HSMMC2 */
+
+#ifdef CONFIG_S3C_DEV_HSMMC2
+static struct resource s3c_hsmmc2_resource[] = {
+	[0] = {
+		.start	= S3C_PA_HSMMC2,
+		.end	= S3C_PA_HSMMC2 + S3C_SZ_HSMMC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_HSMMC2,
+		.end	= IRQ_HSMMC2,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
+};
+
+struct platform_device s3c_device_hsmmc2 = {
+	.name		= "s3c-sdhci",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc2_resource),
+	.resource	= s3c_hsmmc2_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_hsmmc2_def_platdata,
+	},
+};
+
+void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	s3c_sdhci_set_platdata(pd, &s3c_hsmmc2_def_platdata);
+}
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+
+#ifdef CONFIG_S3C_DEV_HSMMC3
+static struct resource s3c_hsmmc3_resource[] = {
+	[0] = {
+		.start	= S3C_PA_HSMMC3,
+		.end	= S3C_PA_HSMMC3 + S3C_SZ_HSMMC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_HSMMC3,
+		.end	= IRQ_HSMMC3,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
+};
+
+struct platform_device s3c_device_hsmmc3 = {
+	.name		= "s3c-sdhci",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc3_resource),
+	.resource	= s3c_hsmmc3_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_hsmmc3_def_platdata,
+	},
+};
+
+void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	s3c_sdhci_set_platdata(pd, &s3c_hsmmc3_def_platdata);
+}
+#endif /* CONFIG_S3C_DEV_HSMMC3 */
+
+/* I2C */
+
+static struct resource s3c_i2c0_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC,
+		.end	= S3C_PA_IIC + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC,
+		.end	= IRQ_IIC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c0 = {
+	.name		= "s3c2410-i2c",
+#ifdef CONFIG_S3C_DEV_I2C1
+	.id		= 0,
+#else
+	.id		= -1,
+#endif
+	.num_resources	= ARRAY_SIZE(s3c_i2c0_resource),
+	.resource	= s3c_i2c0_resource,
+};
+
+struct s3c2410_platform_i2c default_i2c_data __initdata = {
+	.flags		= 0,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c0);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
+}
+
+#ifdef CONFIG_S3C_DEV_I2C1
+static struct resource s3c_i2c1_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC1,
+		.end	= S3C_PA_IIC1 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC1,
+		.end	= IRQ_IIC1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c1 = {
+	.name		= "s3c2410-i2c",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c_i2c1_resource),
+	.resource	= s3c_i2c1_resource,
+};
+
+void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 1;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c1);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
+}
+#endif /* CONFIG_S3C_DEV_I2C1 */
+
+#ifdef CONFIG_S3C_DEV_I2C2
+static struct resource s3c_i2c2_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC2,
+		.end	= S3C_PA_IIC2 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC2,
+		.end	= IRQ_IIC2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c2 = {
+	.name		= "s3c2410-i2c",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s3c_i2c2_resource),
+	.resource	= s3c_i2c2_resource,
+};
+
+void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 2;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c2);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
+}
+#endif /* CONFIG_S3C_DEV_I2C2 */
+
+#ifdef CONFIG_S3C_DEV_I2C3
+static struct resource s3c_i2c3_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC3,
+		.end	= S3C_PA_IIC3 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC3,
+		.end	= IRQ_IIC3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c3 = {
+	.name		= "s3c2440-i2c",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(s3c_i2c3_resource),
+	.resource	= s3c_i2c3_resource,
+};
+
+void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 3;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c3);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c3_cfg_gpio;
+}
+#endif /*CONFIG_S3C_DEV_I2C3 */
+
+#ifdef CONFIG_S3C_DEV_I2C4
+static struct resource s3c_i2c4_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC4,
+		.end	= S3C_PA_IIC4 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC4,
+		.end	= IRQ_IIC4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c4 = {
+	.name		= "s3c2440-i2c",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(s3c_i2c4_resource),
+	.resource	= s3c_i2c4_resource,
+};
+
+void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 4;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c4);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c4_cfg_gpio;
+}
+#endif /*CONFIG_S3C_DEV_I2C4 */
+
+#ifdef CONFIG_S3C_DEV_I2C5
+static struct resource s3c_i2c5_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC5,
+		.end	= S3C_PA_IIC5 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC5,
+		.end	= IRQ_IIC5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c5 = {
+	.name		= "s3c2440-i2c",
+	.id		= 5,
+	.num_resources	= ARRAY_SIZE(s3c_i2c5_resource),
+	.resource	= s3c_i2c5_resource,
+};
+
+void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 5;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c5);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c5_cfg_gpio;
+}
+#endif /*CONFIG_S3C_DEV_I2C5 */
+
+#ifdef CONFIG_S3C_DEV_I2C6
+static struct resource s3c_i2c6_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC6,
+		.end	= S3C_PA_IIC6 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC6,
+		.end	= IRQ_IIC6,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c6 = {
+	.name		= "s3c2440-i2c",
+	.id		= 6,
+	.num_resources	= ARRAY_SIZE(s3c_i2c6_resource),
+	.resource	= s3c_i2c6_resource,
+};
+
+void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 6;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c6);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c6_cfg_gpio;
+}
+#endif /* CONFIG_S3C_DEV_I2C6 */
+
+#ifdef CONFIG_S3C_DEV_I2C7
+static struct resource s3c_i2c7_resource[] = {
+	[0] = {
+		.start	= S3C_PA_IIC7,
+		.end	= S3C_PA_IIC7 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC7,
+		.end	= IRQ_IIC7,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c7 = {
+	.name		= "s3c2440-i2c",
+	.id		= 7,
+	.num_resources	= ARRAY_SIZE(s3c_i2c7_resource),
+	.resource	= s3c_i2c7_resource,
+};
+
+void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 7;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s3c_device_i2c7);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c7_cfg_gpio;
+}
+#endif /* CONFIG_S3C_DEV_I2C7 */
+
 /* I2C HDMIPHY */
 
 #ifdef CONFIG_S5P_DEV_I2C_HDMIPHY
@@ -384,6 +975,70 @@ struct platform_device s3c2412_device_iis = {
 };
 #endif /* CONFIG_CPU_S3C2440 */
 
+/* IDE CFCON */
+
+#ifdef CONFIG_SAMSUNG_DEV_IDE
+static struct resource s3c_cfcon_resource[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_CFCON,
+		.end	= SAMSUNG_PA_CFCON + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_CFCON,
+		.end	= IRQ_CFCON,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_cfcon = {
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_cfcon_resource),
+	.resource	= s3c_cfcon_resource,
+};
+
+void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
+{
+	s3c_set_platdata(pdata, sizeof(struct s3c_ide_platdata),
+			 &s3c_device_cfcon);
+}
+#endif /* CONFIG_SAMSUNG_DEV_IDE */
+
+/* KEYPAD */
+
+#ifdef CONFIG_SAMSUNG_DEV_KEYPAD
+static struct resource samsung_keypad_resources[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_KEYPAD,
+		.end	= SAMSUNG_PA_KEYPAD + 0x20 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_KEYPAD,
+		.end	= IRQ_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device samsung_device_keypad = {
+	.name		= "samsung-keypad",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(samsung_keypad_resources),
+	.resource	= samsung_keypad_resources,
+};
+
+void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
+{
+	struct samsung_keypad_platdata *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct samsung_keypad_platdata),
+			&samsung_device_keypad);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = samsung_keypad_cfg_gpio;
+}
+#endif /* CONFIG_SAMSUNG_DEV_KEYPAD */
+
 /* LCD Controller */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -526,6 +1181,144 @@ struct platform_device s5p_device_mipi_csis1 = {
 };
 #endif
 
+/* NAND */
+
+#ifdef CONFIG_S3C_DEV_NAND
+static struct resource s3c_nand_resource[] = {
+	[0] = {
+		.start	= S3C_PA_NAND,
+		.end	= S3C_PA_NAND + SZ_1M,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+struct platform_device s3c_device_nand = {
+	.name		= "s3c2410-nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_nand_resource),
+	.resource	= s3c_nand_resource,
+};
+
+/*
+ * s3c_nand_copy_set() - copy nand set data
+ * @set: The new structure, directly copied from the old.
+ *
+ * Copy all the fields from the NAND set field from what is probably __initdata
+ * to new kernel memory. The code returns 0 if the copy happened correctly or
+ * an error code for the calling function to display.
+ *
+ * Note, we currently do not try and look to see if we've already copied the
+ * data in a previous set.
+ */
+static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
+{
+	void *ptr;
+	int size;
+
+	size = sizeof(struct mtd_partition) * set->nr_partitions;
+	if (size) {
+		ptr = kmemdup(set->partitions, size, GFP_KERNEL);
+		set->partitions = ptr;
+
+		if (!ptr)
+			return -ENOMEM;
+	}
+
+	if (set->nr_map && set->nr_chips) {
+		size = sizeof(int) * set->nr_chips;
+		ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
+		set->nr_map = ptr;
+
+		if (!ptr)
+			return -ENOMEM;
+	}
+
+	if (set->ecc_layout) {
+		ptr = kmemdup(set->ecc_layout,
+			      sizeof(struct nand_ecclayout), GFP_KERNEL);
+		set->ecc_layout = ptr;
+
+		if (!ptr)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
+{
+	struct s3c2410_platform_nand *npd;
+	int size;
+	int ret;
+
+	/* note, if we get a failure in allocation, we simply drop out of the
+	 * function. If there is so little memory available at initialisation
+	 * time then there is little chance the system is going to run.
+	 */
+
+	npd = s3c_set_platdata(nand, sizeof(struct s3c2410_platform_nand),
+				&s3c_device_nand);
+	if (!npd)
+		return;
+
+	/* now see if we need to copy any of the nand set data */
+
+	size = sizeof(struct s3c2410_nand_set) * npd->nr_sets;
+	if (size) {
+		struct s3c2410_nand_set *from = npd->sets;
+		struct s3c2410_nand_set *to;
+		int i;
+
+		to = kmemdup(from, size, GFP_KERNEL);
+		npd->sets = to;	/* set, even if we failed */
+
+		if (!to) {
+			printk(KERN_ERR "%s: no memory for sets\n", __func__);
+			return;
+		}
+
+		for (i = 0; i < npd->nr_sets; i++) {
+			ret = s3c_nand_copy_set(to);
+			if (ret) {
+				printk(KERN_ERR "%s: failed to copy set %d\n",
+				__func__, i);
+				return;
+			}
+			to++;
+		}
+	}
+}
+#endif /* CONFIG_S3C_DEV_NAND */
+
+/* ONENAND */
+
+#ifdef CONFIG_S3C_DEV_ONENAND
+static struct resource s3c_onenand_resources[] = {
+	[0] = {
+		.start	= S3C_PA_ONENAND,
+		.end	= S3C_PA_ONENAND + 0x400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= S3C_PA_ONENAND_BUF,
+		.end	= S3C_PA_ONENAND_BUF + S3C_SZ_ONENAND_BUF - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= IRQ_ONENAND,
+		.end	= IRQ_ONENAND,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_onenand = {
+	.name		= "samsung-onenand",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_onenand_resources),
+	.resource	= s3c_onenand_resources,
+};
+#endif /* CONFIG_S3C_DEV_ONENAND */
+
 #ifdef CONFIG_S3C64XX_DEV_ONENAND1
 static struct resource s3c64xx_onenand1_resources[] = {
 	[0] = {
@@ -610,6 +1403,41 @@ static int __init s5p_pmu_init(void)
 arch_initcall(s5p_pmu_init);
 #endif /* CONFIG_PLAT_S5P */
 
+/* PWM Timer */
+
+#ifdef CONFIG_SAMSUNG_DEV_PWM
+
+#define TIMER_RESOURCE_SIZE (1)
+
+#define TIMER_RESOURCE(_tmr, _irq)			\
+	(struct resource [TIMER_RESOURCE_SIZE]) {	\
+		[0] = {					\
+			.start	= _irq,			\
+			.end	= _irq,			\
+			.flags	= IORESOURCE_IRQ	\
+		}					\
+	}
+
+#define DEFINE_S3C_TIMER(_tmr_no, _irq)			\
+	.name		= "s3c24xx-pwm",		\
+	.id		= _tmr_no,			\
+	.num_resources	= TIMER_RESOURCE_SIZE,		\
+	.resource	= TIMER_RESOURCE(_tmr_no, _irq),	\
+
+/*
+ * since we already have an static mapping for the timer,
+ * we do not bother setting any IO resource for the base.
+ */
+
+struct platform_device s3c_device_timer[] = {
+	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
+	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
+	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
+	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
+	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
+};
+#endif /* CONFIG_SAMSUNG_DEV_PWM */
+
 /* RTC */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -639,6 +1467,33 @@ struct platform_device s3c_device_rtc = {
 };
 #endif /* CONFIG_PLAT_S3C24XX */
 
+#ifdef CONFIG_S3C_DEV_RTC
+static struct resource s3c_rtc_resource[] = {
+	[0] = {
+		.start	= S3C_PA_RTC,
+		.end	= S3C_PA_RTC + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_RTC_ALARM,
+		.end	= IRQ_RTC_ALARM,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_RTC_TIC,
+		.end	= IRQ_RTC_TIC,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
+struct platform_device s3c_device_rtc = {
+	.name		= "s3c64xx-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_rtc_resource),
+	.resource	= s3c_rtc_resource,
+};
+#endif /* CONFIG_S3C_DEV_RTC */
+
 /* SDI */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -753,6 +1608,43 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
+#ifdef CONFIG_SAMSUNG_DEV_TS
+static struct resource s3c_ts_resource[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_ADC,
+		.end	= SAMSUNG_PA_ADC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_TC,
+		.end	= IRQ_TC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c2410_ts_mach_info default_ts_data __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
+};
+
+struct platform_device s3c_device_ts = {
+	.name		= "s3c64xx-ts",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
+	.resource	= s3c_ts_resource,
+};
+
+void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
+{
+	if (!pd)
+		pd = &default_ts_data;
+
+	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
+			 &s3c_device_ts);
+}
+#endif /* CONFIG_SAMSUNG_DEV_TS */
+
 /* TV */
 
 #ifdef CONFIG_S5P_DEV_TV
@@ -830,6 +1722,49 @@ struct platform_device s5p_device_mixer = {
 };
 #endif /* CONFIG_S5P_DEV_TV */
 
+/* USB */
+
+#ifdef CONFIG_S3C_DEV_USB_HOST
+static struct resource s3c_usb_resource[] = {
+	[0] = {
+		.start	= S3C_PA_USBHOST,
+		.end	= S3C_PA_USBHOST + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USBH,
+		.end	= IRQ_USBH,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_ohci = {
+	.name		= "s3c2410-ohci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_usb_resource),
+	.resource	= s3c_usb_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+/*
+ * s3c_ohci_set_platdata - initialise OHCI device platform data
+ * @info: The platform data.
+ *
+ * This call copies the @info passed in and sets the device .platform_data
+ * field to that copy. The @info is copied so that the original can be marked
+ * __initdata.
+ */
+
+void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
+{
+	s3c_set_platdata(info, sizeof(struct s3c2410_hcd_info),
+			 &s3c_device_ohci);
+}
+#endif /* CONFIG_S3C_DEV_USB_HOST */
+
 /* USB Device (Gadget) */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -900,6 +1835,34 @@ void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
 }
 #endif /* CONFIG_S5P_DEV_USB_EHCI */
 
+/* USB HSOTG */
+
+#ifdef CONFIG_S3C_DEV_USB_HSOTG
+static struct resource s3c_usb_hsotg_resources[] = {
+	[0] = {
+		.start	= S3C_PA_USB_HSOTG,
+		.end	= S3C_PA_USB_HSOTG + 0x10000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_OTG,
+		.end	= IRQ_OTG,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_usb_hsotg = {
+	.name		= "s3c-hsotg",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_usb_hsotg_resources),
+	.resource	= s3c_usb_hsotg_resources,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+#endif /* CONFIG_S3C_DEV_USB_HSOTG */
+
 /* USB High Spped 2.0 Device (Gadget) */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -932,3 +1895,27 @@ void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
 	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
 }
 #endif /* CONFIG_PLAT_S3C24XX */
+
+/* WDT */
+
+#ifdef CONFIG_S3C_DEV_WDT
+static struct resource s3c_wdt_resource[] = {
+	[0] = {
+		.start	= S3C_PA_WDT,
+		.end	= S3C_PA_WDT + SZ_1K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_WDT,
+		.end	= IRQ_WDT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_wdt = {
+	.name		= "s3c2410-wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_wdt_resource),
+	.resource	= s3c_wdt_resource,
+};
+#endif /* CONFIG_S3C_DEV_WDT */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index ee5014a..8f19241 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -30,30 +30,24 @@ extern struct s3c24xx_uart_resources s5p_uart_resources[];
 extern struct platform_device *s3c24xx_uart_devs[];
 extern struct platform_device *s3c24xx_uart_src[];
 
-extern struct platform_device s3c_device_timer[];
-
+extern struct platform_device s3c64xx_device_ac97;
 extern struct platform_device s3c64xx_device_iis0;
 extern struct platform_device s3c64xx_device_iis1;
 extern struct platform_device s3c64xx_device_iisv4;
-
-extern struct platform_device s3c64xx_device_spi0;
-extern struct platform_device s3c64xx_device_spi1;
-
-extern struct platform_device samsung_asoc_dma;
-extern struct platform_device samsung_asoc_idma;
-
+extern struct platform_device s3c64xx_device_onenand1;
 extern struct platform_device s3c64xx_device_pcm0;
 extern struct platform_device s3c64xx_device_pcm1;
+extern struct platform_device s3c64xx_device_spi0;
+extern struct platform_device s3c64xx_device_spi1;
 
-extern struct platform_device s3c64xx_device_ac97;
-
-extern struct platform_device s3c_device_ts;
-
+extern struct platform_device s3c_device_adc;
+extern struct platform_device s3c_device_cfcon;
 extern struct platform_device s3c_device_fb;
-extern struct platform_device s5p_device_fimd0;
-extern struct platform_device s3c_device_ohci;
-extern struct platform_device s3c_device_lcd;
-extern struct platform_device s3c_device_wdt;
+extern struct platform_device s3c_device_hwmon;
+extern struct platform_device s3c_device_hsmmc0;
+extern struct platform_device s3c_device_hsmmc1;
+extern struct platform_device s3c_device_hsmmc2;
+extern struct platform_device s3c_device_hsmmc3;
 extern struct platform_device s3c_device_i2c0;
 extern struct platform_device s3c_device_i2c1;
 extern struct platform_device s3c_device_i2c2;
@@ -62,99 +56,89 @@ extern struct platform_device s3c_device_i2c4;
 extern struct platform_device s3c_device_i2c5;
 extern struct platform_device s3c_device_i2c6;
 extern struct platform_device s3c_device_i2c7;
-extern struct platform_device s5p_device_i2c_hdmiphy;
+extern struct platform_device s3c_device_iis;
+extern struct platform_device s3c_device_lcd;
+extern struct platform_device s3c_device_nand;
+extern struct platform_device s3c_device_ohci;
+extern struct platform_device s3c_device_onenand;
 extern struct platform_device s3c_device_rtc;
-extern struct platform_device s3c_device_adc;
 extern struct platform_device s3c_device_sdi;
-extern struct platform_device s3c_device_iis;
-extern struct platform_device s3c_device_hwmon;
-extern struct platform_device s3c_device_hsmmc0;
-extern struct platform_device s3c_device_hsmmc1;
-extern struct platform_device s3c_device_hsmmc2;
-extern struct platform_device s3c_device_hsmmc3;
-extern struct platform_device s3c_device_cfcon;
-
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
-
-extern struct platform_device s3c_device_hwmon;
-
-extern struct platform_device s3c_device_nand;
-extern struct platform_device s3c_device_onenand;
-extern struct platform_device s3c64xx_device_onenand1;
-extern struct platform_device s5p_device_onenand;
-
+extern struct platform_device s3c_device_ts;
+extern struct platform_device s3c_device_timer[];
 extern struct platform_device s3c_device_usbgadget;
-extern struct platform_device s3c_device_usb_hsudc;
 extern struct platform_device s3c_device_usb_hsotg;
+extern struct platform_device s3c_device_usb_hsudc;
+extern struct platform_device s3c_device_wdt;
 
-extern struct platform_device s5pv210_device_ac97;
-extern struct platform_device s5pv210_device_pcm0;
-extern struct platform_device s5pv210_device_pcm1;
-extern struct platform_device s5pv210_device_pcm2;
-extern struct platform_device s5pv210_device_iis0;
-extern struct platform_device s5pv210_device_iis1;
-extern struct platform_device s5pv210_device_iis2;
-extern struct platform_device s5pv210_device_spdif;
-
-extern struct platform_device exynos4_device_ac97;
-extern struct platform_device exynos4_device_pcm0;
-extern struct platform_device exynos4_device_pcm1;
-extern struct platform_device exynos4_device_pcm2;
-extern struct platform_device exynos4_device_i2s0;
-extern struct platform_device exynos4_device_i2s1;
-extern struct platform_device exynos4_device_i2s2;
-extern struct platform_device exynos4_device_spdif;
-extern struct platform_device exynos4_device_pd[];
-extern struct platform_device exynos4_device_ahci;
-extern struct platform_device exynos4_device_dwmci;
+extern struct platform_device s5p_device_ehci;
+extern struct platform_device s5p_device_fimc0;
+extern struct platform_device s5p_device_fimc1;
+extern struct platform_device s5p_device_fimc2;
+extern struct platform_device s5p_device_fimc3;
+extern struct platform_device s5p_device_fimd0;
+extern struct platform_device s5p_device_hdmi;
+extern struct platform_device s5p_device_i2c_hdmiphy;
+extern struct platform_device s5p_device_mfc;
+extern struct platform_device s5p_device_mfc_l;
+extern struct platform_device s5p_device_mfc_r;
+extern struct platform_device s5p_device_mipi_csis0;
+extern struct platform_device s5p_device_mipi_csis1;
+extern struct platform_device s5p_device_mixer;
+extern struct platform_device s5p_device_onenand;
+extern struct platform_device s5p_device_sdo;
 
-extern struct platform_device s5p6440_device_pcm;
 extern struct platform_device s5p6440_device_iis;
+extern struct platform_device s5p6440_device_pcm;
 
 extern struct platform_device s5p6450_device_iis0;
 extern struct platform_device s5p6450_device_iis1;
 extern struct platform_device s5p6450_device_iis2;
 extern struct platform_device s5p6450_device_pcm0;
 
+extern struct platform_device s5p64x0_device_spi0;
+extern struct platform_device s5p64x0_device_spi1;
+
 extern struct platform_device s5pc100_device_ac97;
-extern struct platform_device s5pc100_device_pcm0;
-extern struct platform_device s5pc100_device_pcm1;
 extern struct platform_device s5pc100_device_iis0;
 extern struct platform_device s5pc100_device_iis1;
 extern struct platform_device s5pc100_device_iis2;
+extern struct platform_device s5pc100_device_pcm0;
+extern struct platform_device s5pc100_device_pcm1;
 extern struct platform_device s5pc100_device_spdif;
+extern struct platform_device s5pc100_device_spi0;
+extern struct platform_device s5pc100_device_spi1;
+extern struct platform_device s5pc100_device_spi2;
 
-extern struct platform_device samsung_device_keypad;
-
-extern struct platform_device s5p_device_fimc0;
-extern struct platform_device s5p_device_fimc1;
-extern struct platform_device s5p_device_fimc2;
-extern struct platform_device s5p_device_fimc3;
-
-extern struct platform_device s5p_device_mfc;
-extern struct platform_device s5p_device_mfc_l;
-extern struct platform_device s5p_device_mfc_r;
-
-extern struct platform_device s5p_device_hdmi;
-extern struct platform_device s5p_device_mixer;
-extern struct platform_device s5p_device_sdo;
-
-extern struct platform_device s5p_device_mipi_csis0;
-extern struct platform_device s5p_device_mipi_csis1;
-
-extern struct platform_device s5p_device_ehci;
+extern struct platform_device s5pv210_device_ac97;
+extern struct platform_device s5pv210_device_iis0;
+extern struct platform_device s5pv210_device_iis1;
+extern struct platform_device s5pv210_device_iis2;
+extern struct platform_device s5pv210_device_pcm0;
+extern struct platform_device s5pv210_device_pcm1;
+extern struct platform_device s5pv210_device_pcm2;
+extern struct platform_device s5pv210_device_spdif;
+extern struct platform_device s5pv210_device_spi0;
+extern struct platform_device s5pv210_device_spi1;
 
+extern struct platform_device exynos4_device_ac97;
+extern struct platform_device exynos4_device_ahci;
+extern struct platform_device exynos4_device_dwmci;
+extern struct platform_device exynos4_device_i2s0;
+extern struct platform_device exynos4_device_i2s1;
+extern struct platform_device exynos4_device_i2s2;
+extern struct platform_device exynos4_device_pcm0;
+extern struct platform_device exynos4_device_pcm1;
+extern struct platform_device exynos4_device_pcm2;
+extern struct platform_device exynos4_device_pd[];
+extern struct platform_device exynos4_device_spdif;
 extern struct platform_device exynos4_device_sysmmu;
 
+extern struct platform_device samsung_asoc_dma;
+extern struct platform_device samsung_asoc_idma;
+extern struct platform_device samsung_device_keypad;
+
 /* s3c2440 specific devices */
 
 #ifdef CONFIG_CPU_S3C2440
-- 
1.7.1
