From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Wed,  9 Dec 2009 13:32:03 +0900
Subject: [PATCH 3/7] ARM: S3C64XX: Add I2S resources in platform code
Message-ID: <1260333123-11609-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Define resources needed by the I2S drivers in platform code.
Audio cfg_gpio callback and IORESOURCE_DMA are added.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dev-audio.c |   91 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 90 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
index a21a88f..cdba3a7 100644
--- a/arch/arm/plat-s3c64xx/dev-audio.c
+++ b/arch/arm/plat-s3c64xx/dev-audio.c
@@ -3,7 +3,6 @@
  * Copyright 2009 Wolfson Microelectronics
  *      Mark Brown <broonie@opensource.wolfsonmicro.com>
  *
-
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -20,16 +19,69 @@
 
 #include <plat/devs.h>
 #include <plat/audio.h>
+#include <plat/gpio-bank-c.h>
 #include <plat/gpio-bank-d.h>
 #include <plat/gpio-bank-e.h>
+#include <plat/gpio-bank-h.h>
 #include <plat/gpio-cfg.h>
 
+static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
+		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
+		break;
+	case 1:
+		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
+		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+	default:
+		printk(KERN_DEBUG "Invalid I2S Controller number!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
+{
+	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S0_V40_DO);
+	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S1_V40_DO);
+	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S2_V40_DO);
+	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
+
+	return 0;
+}
+
 static struct resource s3c64xx_iis0_resource[] = {
 	[0] = {
 		.start = S3C64XX_PA_IIS0,
 		.end   = S3C64XX_PA_IIS0 + 0x100 - 1,
 		.flags = IORESOURCE_MEM,
 	},
+	[1] = {
+		.start = DMACH_I2S0_OUT,
+		.end   = DMACH_I2S0_OUT,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_I2S0_IN,
+		.end   = DMACH_I2S0_IN,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct s3c_audio_pdata s3c_i2s0_pdata = {
+	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
 };
 
 struct platform_device s3c64xx_device_iis0 = {
@@ -37,6 +89,9 @@ struct platform_device s3c64xx_device_iis0 = {
 	.id		  = 0,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis0_resource),
 	.resource	  = s3c64xx_iis0_resource,
+	.dev = {
+		.platform_data = &s3c_i2s0_pdata,
+	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis0);
 
@@ -46,6 +101,20 @@ static struct resource s3c64xx_iis1_resource[] = {
 		.end   = S3C64XX_PA_IIS1 + 0x100 - 1,
 		.flags = IORESOURCE_MEM,
 	},
+	[1] = {
+		.start = DMACH_I2S1_OUT,
+		.end   = DMACH_I2S1_OUT,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_I2S1_IN,
+		.end   = DMACH_I2S1_IN,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct s3c_audio_pdata s3c_i2s1_pdata = {
+	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
 };
 
 struct platform_device s3c64xx_device_iis1 = {
@@ -53,6 +122,9 @@ struct platform_device s3c64xx_device_iis1 = {
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis1_resource),
 	.resource	  = s3c64xx_iis1_resource,
+	.dev = {
+		.platform_data = &s3c_i2s1_pdata,
+	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis1);
 
@@ -62,6 +134,20 @@ static struct resource s3c64xx_iisv4_resource[] = {
 		.end   = S3C64XX_PA_IISV4 + 0x100 - 1,
 		.flags = IORESOURCE_MEM,
 	},
+	[1] = {
+		.start = DMACH_HSI_I2SV40_TX,
+		.end   = DMACH_HSI_I2SV40_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_HSI_I2SV40_RX,
+		.end   = DMACH_HSI_I2SV40_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct s3c_audio_pdata s3c_i2sv4_pdata = {
+	.cfg_gpio = s3c64xx_i2sv4_cfg_gpio,
 };
 
 struct platform_device s3c64xx_device_iisv4 = {
@@ -69,6 +155,9 @@ struct platform_device s3c64xx_device_iisv4 = {
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
 	.resource	  = s3c64xx_iisv4_resource,
+	.dev = {
+		.platform_data = &s3c_i2sv4_pdata,
+	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iisv4);
 
-- 
1.6.2.5
