From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:23:01 +0900
Subject: [PATCH 05/11] ARM: EXYNOS4: Update device support
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates device support of EXYNOS4 according to the change of
ARCH name, EXYNOS4.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../arm/{mach-s5pv310 => mach-exynos4}/dev-audio.c |  143 ++++++++++----------
 arch/arm/{mach-s5pv310 => mach-exynos4}/dev-pd.c   |   40 +++---
 .../{mach-s5pv310 => mach-exynos4}/dev-sysmmu.c    |   78 ++++++-----
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c1.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c2.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c3.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c4.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c5.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c6.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c7.c    |    4 +-
 .../setup-sdhci-gpio.c                             |   52 ++++----
 .../{mach-s5pv310 => mach-exynos4}/setup-sdhci.c   |   12 +-
 arch/arm/plat-samsung/include/plat/devs.h          |   23 ++--
 arch/arm/plat-samsung/include/plat/pd.h            |    4 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   63 +++++----
 15 files changed, 227 insertions(+), 216 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/dev-audio.c (57%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/dev-pd.c (74%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/dev-sysmmu.c (62%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c1.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c2.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c3.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c4.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c5.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c6.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c7.c (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-sdhci-gpio.c (69%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-sdhci.c (83%)

diff --git a/arch/arm/mach-s5pv310/dev-audio.c b/arch/arm/mach-exynos4/dev-audio.c
similarity index 57%
rename from arch/arm/mach-s5pv310/dev-audio.c
rename to arch/arm/mach-exynos4/dev-audio.c
index a196424..1eed5f9 100644
--- a/arch/arm/mach-s5pv310/dev-audio.c
+++ b/arch/arm/mach-exynos4/dev-audio.c
@@ -1,4 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/dev-audio.c
+/* linux/arch/arm/mach-exynos4/dev-audio.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd
  *	Jaswinder Singh <jassi.brar@samsung.com>
@@ -24,18 +27,18 @@ static const char *rclksrc[] = {
 	[1] = "i2sclk",
 };
 
-static int s5pv310_cfg_i2s(struct platform_device *pdev)
+static int exynos4_cfg_i2s(struct platform_device *pdev)
 {
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin_range(S5PV310_GPZ(0), 7, S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(EXYNOS4_GPZ(0), 7, S3C_GPIO_SFN(2));
 		break;
 	case 1:
-		s3c_gpio_cfgpin_range(S5PV310_GPC0(0), 5, S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(EXYNOS4_GPC0(0), 5, S3C_GPIO_SFN(2));
 		break;
 	case 2:
-		s3c_gpio_cfgpin_range(S5PV310_GPC1(0), 5, S3C_GPIO_SFN(4));
+		s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 5, S3C_GPIO_SFN(4));
 		break;
 	default:
 		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
@@ -46,7 +49,7 @@ static int s5pv310_cfg_i2s(struct platform_device *pdev)
 }
 
 static struct s3c_audio_pdata i2sv5_pdata = {
-	.cfg_gpio = s5pv310_cfg_i2s,
+	.cfg_gpio = exynos4_cfg_i2s,
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
@@ -56,10 +59,10 @@ static struct s3c_audio_pdata i2sv5_pdata = {
 	},
 };
 
-static struct resource s5pv310_i2s0_resource[] = {
+static struct resource exynos4_i2s0_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_I2S0,
-		.end	= S5PV310_PA_I2S0 + 0x100 - 1,
+		.start	= EXYNOS4_PA_I2S0,
+		.end	= EXYNOS4_PA_I2S0 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -79,11 +82,11 @@ static struct resource s5pv310_i2s0_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_i2s0 = {
+struct platform_device exynos4_device_i2s0 = {
 	.name = "samsung-i2s",
 	.id = 0,
-	.num_resources = ARRAY_SIZE(s5pv310_i2s0_resource),
-	.resource = s5pv310_i2s0_resource,
+	.num_resources = ARRAY_SIZE(exynos4_i2s0_resource),
+	.resource = exynos4_i2s0_resource,
 	.dev = {
 		.platform_data = &i2sv5_pdata,
 	},
@@ -95,7 +98,7 @@ static const char *rclksrc_v3[] = {
 };
 
 static struct s3c_audio_pdata i2sv3_pdata = {
-	.cfg_gpio = s5pv310_cfg_i2s,
+	.cfg_gpio = exynos4_cfg_i2s,
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_NO_MUXPSR,
@@ -104,10 +107,10 @@ static struct s3c_audio_pdata i2sv3_pdata = {
 	},
 };
 
-static struct resource s5pv310_i2s1_resource[] = {
+static struct resource exynos4_i2s1_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_I2S1,
-		.end	= S5PV310_PA_I2S1 + 0x100 - 1,
+		.start	= EXYNOS4_PA_I2S1,
+		.end	= EXYNOS4_PA_I2S1 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -122,20 +125,20 @@ static struct resource s5pv310_i2s1_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_i2s1 = {
+struct platform_device exynos4_device_i2s1 = {
 	.name = "samsung-i2s",
 	.id = 1,
-	.num_resources = ARRAY_SIZE(s5pv310_i2s1_resource),
-	.resource = s5pv310_i2s1_resource,
+	.num_resources = ARRAY_SIZE(exynos4_i2s1_resource),
+	.resource = exynos4_i2s1_resource,
 	.dev = {
 		.platform_data = &i2sv3_pdata,
 	},
 };
 
-static struct resource s5pv310_i2s2_resource[] = {
+static struct resource exynos4_i2s2_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_I2S2,
-		.end	= S5PV310_PA_I2S2 + 0x100 - 1,
+		.start	= EXYNOS4_PA_I2S2,
+		.end	= EXYNOS4_PA_I2S2 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -150,11 +153,11 @@ static struct resource s5pv310_i2s2_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_i2s2 = {
+struct platform_device exynos4_device_i2s2 = {
 	.name = "samsung-i2s",
 	.id = 2,
-	.num_resources = ARRAY_SIZE(s5pv310_i2s2_resource),
-	.resource = s5pv310_i2s2_resource,
+	.num_resources = ARRAY_SIZE(exynos4_i2s2_resource),
+	.resource = exynos4_i2s2_resource,
 	.dev = {
 		.platform_data = &i2sv3_pdata,
 	},
@@ -162,17 +165,17 @@ struct platform_device s5pv310_device_i2s2 = {
 
 /* PCM Controller platform_devices */
 
-static int s5pv310_pcm_cfg_gpio(struct platform_device *pdev)
+static int exynos4_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin_range(S5PV310_GPZ(0), 5, S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(EXYNOS4_GPZ(0), 5, S3C_GPIO_SFN(3));
 		break;
 	case 1:
-		s3c_gpio_cfgpin_range(S5PV310_GPC0(0), 5, S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(EXYNOS4_GPC0(0), 5, S3C_GPIO_SFN(3));
 		break;
 	case 2:
-		s3c_gpio_cfgpin_range(S5PV310_GPC1(0), 5, S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 5, S3C_GPIO_SFN(3));
 		break;
 	default:
 		printk(KERN_DEBUG "Invalid PCM Controller number!");
@@ -183,13 +186,13 @@ static int s5pv310_pcm_cfg_gpio(struct platform_device *pdev)
 }
 
 static struct s3c_audio_pdata s3c_pcm_pdata = {
-	.cfg_gpio = s5pv310_pcm_cfg_gpio,
+	.cfg_gpio = exynos4_pcm_cfg_gpio,
 };
 
-static struct resource s5pv310_pcm0_resource[] = {
+static struct resource exynos4_pcm0_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_PCM0,
-		.end	= S5PV310_PA_PCM0 + 0x100 - 1,
+		.start	= EXYNOS4_PA_PCM0,
+		.end	= EXYNOS4_PA_PCM0 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -204,20 +207,20 @@ static struct resource s5pv310_pcm0_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_pcm0 = {
+struct platform_device exynos4_device_pcm0 = {
 	.name = "samsung-pcm",
 	.id = 0,
-	.num_resources = ARRAY_SIZE(s5pv310_pcm0_resource),
-	.resource = s5pv310_pcm0_resource,
+	.num_resources = ARRAY_SIZE(exynos4_pcm0_resource),
+	.resource = exynos4_pcm0_resource,
 	.dev = {
 		.platform_data = &s3c_pcm_pdata,
 	},
 };
 
-static struct resource s5pv310_pcm1_resource[] = {
+static struct resource exynos4_pcm1_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_PCM1,
-		.end	= S5PV310_PA_PCM1 + 0x100 - 1,
+		.start	= EXYNOS4_PA_PCM1,
+		.end	= EXYNOS4_PA_PCM1 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -232,20 +235,20 @@ static struct resource s5pv310_pcm1_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_pcm1 = {
+struct platform_device exynos4_device_pcm1 = {
 	.name = "samsung-pcm",
 	.id = 1,
-	.num_resources = ARRAY_SIZE(s5pv310_pcm1_resource),
-	.resource = s5pv310_pcm1_resource,
+	.num_resources = ARRAY_SIZE(exynos4_pcm1_resource),
+	.resource = exynos4_pcm1_resource,
 	.dev = {
 		.platform_data = &s3c_pcm_pdata,
 	},
 };
 
-static struct resource s5pv310_pcm2_resource[] = {
+static struct resource exynos4_pcm2_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_PCM2,
-		.end	= S5PV310_PA_PCM2 + 0x100 - 1,
+		.start	= EXYNOS4_PA_PCM2,
+		.end	= EXYNOS4_PA_PCM2 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -260,11 +263,11 @@ static struct resource s5pv310_pcm2_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_pcm2 = {
+struct platform_device exynos4_device_pcm2 = {
 	.name = "samsung-pcm",
 	.id = 2,
-	.num_resources = ARRAY_SIZE(s5pv310_pcm2_resource),
-	.resource = s5pv310_pcm2_resource,
+	.num_resources = ARRAY_SIZE(exynos4_pcm2_resource),
+	.resource = exynos4_pcm2_resource,
 	.dev = {
 		.platform_data = &s3c_pcm_pdata,
 	},
@@ -272,15 +275,15 @@ struct platform_device s5pv310_device_pcm2 = {
 
 /* AC97 Controller platform devices */
 
-static int s5pv310_ac97_cfg_gpio(struct platform_device *pdev)
+static int exynos4_ac97_cfg_gpio(struct platform_device *pdev)
 {
-	return s3c_gpio_cfgpin_range(S5PV310_GPC0(0), 5, S3C_GPIO_SFN(4));
+	return s3c_gpio_cfgpin_range(EXYNOS4_GPC0(0), 5, S3C_GPIO_SFN(4));
 }
 
-static struct resource s5pv310_ac97_resource[] = {
+static struct resource exynos4_ac97_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_AC97,
-		.end	= S5PV310_PA_AC97 + 0x100 - 1,
+		.start	= EXYNOS4_PA_AC97,
+		.end	= EXYNOS4_PA_AC97 + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -306,36 +309,36 @@ static struct resource s5pv310_ac97_resource[] = {
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
-	.cfg_gpio = s5pv310_ac97_cfg_gpio,
+	.cfg_gpio = exynos4_ac97_cfg_gpio,
 };
 
-static u64 s5pv310_ac97_dmamask = DMA_BIT_MASK(32);
+static u64 exynos4_ac97_dmamask = DMA_BIT_MASK(32);
 
-struct platform_device s5pv310_device_ac97 = {
+struct platform_device exynos4_device_ac97 = {
 	.name = "samsung-ac97",
 	.id = -1,
-	.num_resources = ARRAY_SIZE(s5pv310_ac97_resource),
-	.resource = s5pv310_ac97_resource,
+	.num_resources = ARRAY_SIZE(exynos4_ac97_resource),
+	.resource = exynos4_ac97_resource,
 	.dev = {
 		.platform_data = &s3c_ac97_pdata,
-		.dma_mask = &s5pv310_ac97_dmamask,
+		.dma_mask = &exynos4_ac97_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
 /* S/PDIF Controller platform_device */
 
-static int s5pv310_spdif_cfg_gpio(struct platform_device *pdev)
+static int exynos4_spdif_cfg_gpio(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin_range(S5PV310_GPC1(0), 2, S3C_GPIO_SFN(3));
+	s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 2, S3C_GPIO_SFN(3));
 
 	return 0;
 }
 
-static struct resource s5pv310_spdif_resource[] = {
+static struct resource exynos4_spdif_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_SPDIF,
-		.end	= S5PV310_PA_SPDIF + 0x100 - 1,
+		.start	= EXYNOS4_PA_SPDIF,
+		.end	= EXYNOS4_PA_SPDIF + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -346,19 +349,19 @@ static struct resource s5pv310_spdif_resource[] = {
 };
 
 static struct s3c_audio_pdata samsung_spdif_pdata = {
-	.cfg_gpio = s5pv310_spdif_cfg_gpio,
+	.cfg_gpio = exynos4_spdif_cfg_gpio,
 };
 
-static u64 s5pv310_spdif_dmamask = DMA_BIT_MASK(32);
+static u64 exynos4_spdif_dmamask = DMA_BIT_MASK(32);
 
-struct platform_device s5pv310_device_spdif = {
+struct platform_device exynos4_device_spdif = {
 	.name = "samsung-spdif",
 	.id = -1,
-	.num_resources = ARRAY_SIZE(s5pv310_spdif_resource),
-	.resource = s5pv310_spdif_resource,
+	.num_resources = ARRAY_SIZE(exynos4_spdif_resource),
+	.resource = exynos4_spdif_resource,
 	.dev = {
 		.platform_data = &samsung_spdif_pdata,
-		.dma_mask = &s5pv310_spdif_dmamask,
+		.dma_mask = &exynos4_spdif_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
diff --git a/arch/arm/mach-s5pv310/dev-pd.c b/arch/arm/mach-exynos4/dev-pd.c
similarity index 74%
rename from arch/arm/mach-s5pv310/dev-pd.c
rename to arch/arm/mach-exynos4/dev-pd.c
index 58a50c2..3273f25 100644
--- a/arch/arm/mach-s5pv310/dev-pd.c
+++ b/arch/arm/mach-exynos4/dev-pd.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/dev-pd.c
+/* linux/arch/arm/mach-exynos4/dev-pd.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - Power Domain support
+ * EXYNOS4 - Power Domain support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,7 +19,7 @@
 
 #include <plat/pd.h>
 
-static int s5pv310_pd_enable(struct device *dev)
+static int exynos4_pd_enable(struct device *dev)
 {
 	struct samsung_pd_info *pdata =  dev->platform_data;
 	u32 timeout;
@@ -42,7 +42,7 @@ static int s5pv310_pd_enable(struct device *dev)
 	return 0;
 }
 
-static int s5pv310_pd_disable(struct device *dev)
+static int exynos4_pd_disable(struct device *dev)
 {
 	struct samsung_pd_info *pdata =  dev->platform_data;
 	u32 timeout;
@@ -64,14 +64,14 @@ static int s5pv310_pd_disable(struct device *dev)
 	return 0;
 }
 
-struct platform_device s5pv310_device_pd[] = {
+struct platform_device exynos4_device_pd[] = {
 	{
 		.name		= "samsung-pd",
 		.id		= 0,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_MFC_CONF,
 			},
 		},
@@ -80,8 +80,8 @@ struct platform_device s5pv310_device_pd[] = {
 		.id		= 1,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_G3D_CONF,
 			},
 		},
@@ -90,8 +90,8 @@ struct platform_device s5pv310_device_pd[] = {
 		.id		= 2,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_LCD0_CONF,
 			},
 		},
@@ -100,8 +100,8 @@ struct platform_device s5pv310_device_pd[] = {
 		.id		= 3,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_LCD1_CONF,
 			},
 		},
@@ -110,8 +110,8 @@ struct platform_device s5pv310_device_pd[] = {
 		.id		= 4,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_TV_CONF,
 			},
 		},
@@ -120,8 +120,8 @@ struct platform_device s5pv310_device_pd[] = {
 		.id		= 5,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_CAM_CONF,
 			},
 		},
@@ -130,8 +130,8 @@ struct platform_device s5pv310_device_pd[] = {
 		.id		= 6,
 		.dev = {
 			.platform_data = &(struct samsung_pd_info) {
-				.enable		= s5pv310_pd_enable,
-				.disable	= s5pv310_pd_disable,
+				.enable		= exynos4_pd_enable,
+				.disable	= exynos4_pd_disable,
 				.base		= S5P_PMU_GPS_CONF,
 			},
 		},
diff --git a/arch/arm/mach-s5pv310/dev-sysmmu.c b/arch/arm/mach-exynos4/dev-sysmmu.c
similarity index 62%
rename from arch/arm/mach-s5pv310/dev-sysmmu.c
rename to arch/arm/mach-exynos4/dev-sysmmu.c
index e1bb200..a10790a 100644
--- a/arch/arm/mach-s5pv310/dev-sysmmu.c
+++ b/arch/arm/mach-exynos4/dev-sysmmu.c
@@ -1,8 +1,10 @@
-/* linux/arch/arm/mach-s5pv310/dev-sysmmu.c
+/* linux/arch/arm/mach-exynos4/dev-sysmmu.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
+ * EXYNOS4 - System MMU support
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -14,10 +16,10 @@
 #include <mach/map.h>
 #include <mach/irqs.h>
 
-static struct resource s5pv310_sysmmu_resource[] = {
+static struct resource exynos4_sysmmu_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_SYSMMU_MDMA,
-		.end	= S5PV310_PA_SYSMMU_MDMA + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_MDMA,
+		.end	= EXYNOS4_PA_SYSMMU_MDMA + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -26,8 +28,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= S5PV310_PA_SYSMMU_SSS,
-		.end	= S5PV310_PA_SYSMMU_SSS + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_SSS,
+		.end	= EXYNOS4_PA_SYSMMU_SSS + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[3] = {
@@ -36,8 +38,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[4] = {
-		.start	= S5PV310_PA_SYSMMU_FIMC0,
-		.end	= S5PV310_PA_SYSMMU_FIMC0 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_FIMC0,
+		.end	= EXYNOS4_PA_SYSMMU_FIMC0 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[5] = {
@@ -46,8 +48,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[6] = {
-		.start	= S5PV310_PA_SYSMMU_FIMC1,
-		.end	= S5PV310_PA_SYSMMU_FIMC1 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_FIMC1,
+		.end	= EXYNOS4_PA_SYSMMU_FIMC1 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[7] = {
@@ -56,8 +58,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[8] = {
-		.start	= S5PV310_PA_SYSMMU_FIMC2,
-		.end	= S5PV310_PA_SYSMMU_FIMC2 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_FIMC2,
+		.end	= EXYNOS4_PA_SYSMMU_FIMC2 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[9] = {
@@ -66,8 +68,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[10] = {
-		.start	= S5PV310_PA_SYSMMU_FIMC3,
-		.end	= S5PV310_PA_SYSMMU_FIMC3 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_FIMC3,
+		.end	= EXYNOS4_PA_SYSMMU_FIMC3 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[11] = {
@@ -76,8 +78,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[12] = {
-		.start	= S5PV310_PA_SYSMMU_JPEG,
-		.end	= S5PV310_PA_SYSMMU_JPEG + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_JPEG,
+		.end	= EXYNOS4_PA_SYSMMU_JPEG + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[13] = {
@@ -86,8 +88,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[14] = {
-		.start	= S5PV310_PA_SYSMMU_FIMD0,
-		.end	= S5PV310_PA_SYSMMU_FIMD0 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_FIMD0,
+		.end	= EXYNOS4_PA_SYSMMU_FIMD0 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[15] = {
@@ -96,8 +98,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[16] = {
-		.start	= S5PV310_PA_SYSMMU_FIMD1,
-		.end	= S5PV310_PA_SYSMMU_FIMD1 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_FIMD1,
+		.end	= EXYNOS4_PA_SYSMMU_FIMD1 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[17] = {
@@ -106,8 +108,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[18] = {
-		.start	= S5PV310_PA_SYSMMU_PCIe,
-		.end	= S5PV310_PA_SYSMMU_PCIe + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_PCIe,
+		.end	= EXYNOS4_PA_SYSMMU_PCIe + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[19] = {
@@ -116,8 +118,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[20] = {
-		.start	= S5PV310_PA_SYSMMU_G2D,
-		.end	= S5PV310_PA_SYSMMU_G2D + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_G2D,
+		.end	= EXYNOS4_PA_SYSMMU_G2D + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[21] = {
@@ -126,8 +128,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[22] = {
-		.start	= S5PV310_PA_SYSMMU_ROTATOR,
-		.end	= S5PV310_PA_SYSMMU_ROTATOR + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_ROTATOR,
+		.end	= EXYNOS4_PA_SYSMMU_ROTATOR + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[23] = {
@@ -136,8 +138,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[24] = {
-		.start	= S5PV310_PA_SYSMMU_MDMA2,
-		.end	= S5PV310_PA_SYSMMU_MDMA2 + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_MDMA2,
+		.end	= EXYNOS4_PA_SYSMMU_MDMA2 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[25] = {
@@ -146,8 +148,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[26] = {
-		.start	= S5PV310_PA_SYSMMU_TV,
-		.end	= S5PV310_PA_SYSMMU_TV + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_TV,
+		.end	= EXYNOS4_PA_SYSMMU_TV + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[27] = {
@@ -156,8 +158,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[28] = {
-		.start	= S5PV310_PA_SYSMMU_MFC_L,
-		.end	= S5PV310_PA_SYSMMU_MFC_L + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_MFC_L,
+		.end	= EXYNOS4_PA_SYSMMU_MFC_L + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[29] = {
@@ -166,8 +168,8 @@ static struct resource s5pv310_sysmmu_resource[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[30] = {
-		.start	= S5PV310_PA_SYSMMU_MFC_R,
-		.end	= S5PV310_PA_SYSMMU_MFC_R + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SYSMMU_MFC_R,
+		.end	= EXYNOS4_PA_SYSMMU_MFC_R + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[31] = {
@@ -177,11 +179,11 @@ static struct resource s5pv310_sysmmu_resource[] = {
 	},
 };
 
-struct platform_device s5pv310_device_sysmmu = {
+struct platform_device exynos4_device_sysmmu = {
 	.name		= "s5p-sysmmu",
 	.id		= 32,
-	.num_resources	= ARRAY_SIZE(s5pv310_sysmmu_resource),
-	.resource	= s5pv310_sysmmu_resource,
+	.num_resources	= ARRAY_SIZE(exynos4_sysmmu_resource),
+	.resource	= exynos4_sysmmu_resource,
 };
 
-EXPORT_SYMBOL(s5pv310_device_sysmmu);
+EXPORT_SYMBOL(exynos4_device_sysmmu);
diff --git a/arch/arm/mach-s5pv310/setup-i2c1.c b/arch/arm/mach-exynos4/setup-i2c1.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c1.c
rename to arch/arm/mach-exynos4/setup-i2c1.c
index 9d07e4e..fd7235a 100644
--- a/arch/arm/mach-s5pv310/setup-i2c1.c
+++ b/arch/arm/mach-exynos4/setup-i2c1.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c1.c
+ * linux/arch/arm/mach-exynos4/setup-i2c1.c
  *
  * Copyright (C) 2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPD1(2), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPD1(2), 2,
 			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c2.c b/arch/arm/mach-exynos4/setup-i2c2.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c2.c
rename to arch/arm/mach-exynos4/setup-i2c2.c
index 4163b12..2694b19 100644
--- a/arch/arm/mach-s5pv310/setup-i2c2.c
+++ b/arch/arm/mach-exynos4/setup-i2c2.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c2.c
+ * linux/arch/arm/mach-exynos4/setup-i2c2.c
  *
  * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c2_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPA0(6), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPA0(6), 2,
 			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c3.c b/arch/arm/mach-exynos4/setup-i2c3.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c3.c
rename to arch/arm/mach-exynos4/setup-i2c3.c
index 180f153..379bd30 100644
--- a/arch/arm/mach-s5pv310/setup-i2c3.c
+++ b/arch/arm/mach-exynos4/setup-i2c3.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c3.c
+ * linux/arch/arm/mach-exynos4/setup-i2c3.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c3_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPA1(2), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPA1(2), 2,
 			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c4.c b/arch/arm/mach-exynos4/setup-i2c4.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c4.c
rename to arch/arm/mach-exynos4/setup-i2c4.c
index 909e8df..9f3c048 100644
--- a/arch/arm/mach-s5pv310/setup-i2c4.c
+++ b/arch/arm/mach-exynos4/setup-i2c4.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c4.c
+ * linux/arch/arm/mach-exynos4/setup-i2c4.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c4_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPB(2), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
 			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c5.c b/arch/arm/mach-exynos4/setup-i2c5.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c5.c
rename to arch/arm/mach-exynos4/setup-i2c5.c
index 5d0fa4a..77e1a1e 100644
--- a/arch/arm/mach-s5pv310/setup-i2c5.c
+++ b/arch/arm/mach-exynos4/setup-i2c5.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c5.c
+ * linux/arch/arm/mach-exynos4/setup-i2c5.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c5_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPB(6), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
 			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c6.c b/arch/arm/mach-exynos4/setup-i2c6.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c6.c
rename to arch/arm/mach-exynos4/setup-i2c6.c
index 34aafab..284d12b 100644
--- a/arch/arm/mach-s5pv310/setup-i2c6.c
+++ b/arch/arm/mach-exynos4/setup-i2c6.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c6.c
+ * linux/arch/arm/mach-exynos4/setup-i2c6.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c6_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPC1(3), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
 			      S3C_GPIO_SFN(4), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c7.c b/arch/arm/mach-exynos4/setup-i2c7.c
similarity index 85%
rename from arch/arm/mach-s5pv310/setup-i2c7.c
rename to arch/arm/mach-exynos4/setup-i2c7.c
index 9b25b8d..b7611ee 100644
--- a/arch/arm/mach-s5pv310/setup-i2c7.c
+++ b/arch/arm/mach-exynos4/setup-i2c7.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c7.c
+ * linux/arch/arm/mach-exynos4/setup-i2c7.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *
@@ -18,6 +18,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c7_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPD0(2), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPD0(2), 2,
 			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-sdhci-gpio.c b/arch/arm/mach-exynos4/setup-sdhci-gpio.c
similarity index 69%
rename from arch/arm/mach-s5pv310/setup-sdhci-gpio.c
rename to arch/arm/mach-exynos4/setup-sdhci-gpio.c
index 86d38cc..1b3d3a2 100644
--- a/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
+++ b/arch/arm/mach-exynos4/setup-sdhci-gpio.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
+/* linux/arch/arm/mach-exynos4/setup-sdhci-gpio.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+ * EXYNOS4 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,13 +23,13 @@
 #include <plat/regs-sdhci.h>
 #include <plat/sdhci.h>
 
-void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPK0[0:1] pins to special-function 2 */
-	for (gpio = S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); gpio++) {
+	for (gpio = EXYNOS4_GPK0(0); gpio < EXYNOS4_GPK0(2); gpio++) {
 		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
@@ -37,14 +37,14 @@ void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 
 	switch (width) {
 	case 8:
-		for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
+		for (gpio = EXYNOS4_GPK1(3); gpio <= EXYNOS4_GPK1(6); gpio++) {
 			/* Data pin GPK1[3:6] to special-funtion 3 */
 			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
 			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 		}
 	case 4:
-		for (gpio = S5PV310_GPK0(3); gpio <= S5PV310_GPK0(6); gpio++) {
+		for (gpio = EXYNOS4_GPK0(3); gpio <= EXYNOS4_GPK0(6); gpio++) {
 			/* Data pin GPK0[3:6] to special-funtion 2 */
 			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
@@ -55,25 +55,25 @@ void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(S5PV310_GPK0(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PV310_GPK0(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(EXYNOS4_GPK0(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(EXYNOS4_GPK0(2), S3C_GPIO_PULL_UP);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 	}
 }
 
-void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+void exynos4_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPK1[0:1] pins to special-function 2 */
-	for (gpio = S5PV310_GPK1(0); gpio < S5PV310_GPK1(2); gpio++) {
+	for (gpio = EXYNOS4_GPK1(0); gpio < EXYNOS4_GPK1(2); gpio++) {
 		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 	}
 
-	for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
+	for (gpio = EXYNOS4_GPK1(3); gpio <= EXYNOS4_GPK1(6); gpio++) {
 		/* Data pin GPK1[3:6] to special-function 2 */
 		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
@@ -81,19 +81,19 @@ void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(S5PV310_GPK1(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PV310_GPK1(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(EXYNOS4_GPK1(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(EXYNOS4_GPK1(2), S3C_GPIO_PULL_UP);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 	}
 }
 
-void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+void exynos4_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPK2[0:1] pins to special-function 2 */
-	for (gpio = S5PV310_GPK2(0); gpio < S5PV310_GPK2(2); gpio++) {
+	for (gpio = EXYNOS4_GPK2(0); gpio < EXYNOS4_GPK2(2); gpio++) {
 		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
@@ -101,14 +101,14 @@ void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 
 	switch (width) {
 	case 8:
-		for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
+		for (gpio = EXYNOS4_GPK3(3); gpio <= EXYNOS4_GPK3(6); gpio++) {
 			/* Data pin GPK3[3:6] to special-function 3 */
 			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
 			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 		}
 	case 4:
-		for (gpio = S5PV310_GPK2(3); gpio <= S5PV310_GPK2(6); gpio++) {
+		for (gpio = EXYNOS4_GPK2(3); gpio <= EXYNOS4_GPK2(6); gpio++) {
 			/* Data pin GPK2[3:6] to special-function 2 */
 			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
@@ -119,25 +119,25 @@ void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(S5PV310_GPK2(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PV310_GPK2(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(EXYNOS4_GPK2(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(EXYNOS4_GPK2(2), S3C_GPIO_PULL_UP);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 	}
 }
 
-void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
+void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
 {
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPK3[0:1] pins to special-function 2 */
-	for (gpio = S5PV310_GPK3(0); gpio < S5PV310_GPK3(2); gpio++) {
+	for (gpio = EXYNOS4_GPK3(0); gpio < EXYNOS4_GPK3(2); gpio++) {
 		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 	}
 
-	for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
+	for (gpio = EXYNOS4_GPK3(3); gpio <= EXYNOS4_GPK3(6); gpio++) {
 		/* Data pin GPK3[3:6] to special-function 2 */
 		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
@@ -145,8 +145,8 @@ void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
 	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_cfgpin(S5PV310_GPK3(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PV310_GPK3(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(EXYNOS4_GPK3(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(EXYNOS4_GPK3(2), S3C_GPIO_PULL_UP);
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
 	}
 }
diff --git a/arch/arm/mach-s5pv310/setup-sdhci.c b/arch/arm/mach-exynos4/setup-sdhci.c
similarity index 83%
rename from arch/arm/mach-s5pv310/setup-sdhci.c
rename to arch/arm/mach-exynos4/setup-sdhci.c
index db8358f..85f9433 100644
--- a/arch/arm/mach-s5pv310/setup-sdhci.c
+++ b/arch/arm/mach-exynos4/setup-sdhci.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/setup-sdhci.c
+/* linux/arch/arm/mach-exynos4/setup-sdhci.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - Helper functions for settign up SDHCI device(s) (HSMMC)
+ * EXYNOS4 - Helper functions for settign up SDHCI device(s) (HSMMC)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,14 +23,14 @@
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
-char *s5pv310_hsmmc_clksrcs[4] = {
+char *exynos4_hsmmc_clksrcs[4] = {
 	[0] = NULL,
 	[1] = NULL,
 	[2] = "sclk_mmc",	/* mmc_bus */
 	[3] = NULL,
 };
 
-void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev, void __iomem *r,
+void exynos4_setup_sdhci_cfg_card(struct platform_device *dev, void __iomem *r,
 				  struct mmc_ios *ios, struct mmc_card *card)
 {
 	u32 ctrl2, ctrl3;
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index b4d208b..e2b3ab9 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -1,5 +1,8 @@
 /* arch/arm/plat-samsung/include/plat/devs.h
  *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
  * Copyright (c) 2004 Simtec Electronics
  * Ben Dooks <ben@simtec.co.uk>
  *
@@ -96,15 +99,15 @@ extern struct platform_device s5pv210_device_iis1;
 extern struct platform_device s5pv210_device_iis2;
 extern struct platform_device s5pv210_device_spdif;
 
-extern struct platform_device s5pv310_device_ac97;
-extern struct platform_device s5pv310_device_pcm0;
-extern struct platform_device s5pv310_device_pcm1;
-extern struct platform_device s5pv310_device_pcm2;
-extern struct platform_device s5pv310_device_i2s0;
-extern struct platform_device s5pv310_device_i2s1;
-extern struct platform_device s5pv310_device_i2s2;
-extern struct platform_device s5pv310_device_spdif;
-extern struct platform_device s5pv310_device_pd[];
+extern struct platform_device exynos4_device_ac97;
+extern struct platform_device exynos4_device_pcm0;
+extern struct platform_device exynos4_device_pcm1;
+extern struct platform_device exynos4_device_pcm2;
+extern struct platform_device exynos4_device_i2s0;
+extern struct platform_device exynos4_device_i2s1;
+extern struct platform_device exynos4_device_i2s2;
+extern struct platform_device exynos4_device_spdif;
+extern struct platform_device exynos4_device_pd[];
 
 extern struct platform_device s5p6442_device_pcm0;
 extern struct platform_device s5p6442_device_pcm1;
@@ -137,7 +140,7 @@ extern struct platform_device s5p_device_fimc2;
 extern struct platform_device s5p_device_mipi_csis0;
 extern struct platform_device s5p_device_mipi_csis1;
 
-extern struct platform_device s5pv310_device_sysmmu;
+extern struct platform_device exynos4_device_sysmmu;
 
 /* s3c2440 specific devices */
 
diff --git a/arch/arm/plat-samsung/include/plat/pd.h b/arch/arm/plat-samsung/include/plat/pd.h
index 5f0ad85..abb4bc3 100644
--- a/arch/arm/plat-samsung/include/plat/pd.h
+++ b/arch/arm/plat-samsung/include/plat/pd.h
@@ -1,6 +1,6 @@
 /* linux/arch/arm/plat-samsung/include/plat/pd.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * This program is free software; you can redistribute it and/or modify
@@ -17,7 +17,7 @@ struct samsung_pd_info {
 	void __iomem *base;
 };
 
-enum s5pv310_pd_block {
+enum exynos4_pd_block {
 	PD_MFC,
 	PD_G3D,
 	PD_LCD0,
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 5a41a0b..b0bdf16 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -1,4 +1,7 @@
-/* linux/arch/arm/plat-s3c/include/plat/sdhci.h
+/* linux/arch/arm/plat-samsung/include/plat/sdhci.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
@@ -119,10 +122,10 @@ extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
-extern void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
-extern void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
-extern void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
-extern void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
+extern void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void exynos4_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void exynos4_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 
 /* S3C2416 SDHCI setup */
 
@@ -334,57 +337,57 @@ static inline void s5pv210_default_sdhci3(void) { }
 
 #endif /* CONFIG_S5PV210_SETUP_SDHCI */
 
-/* S5PV310 SDHCI setup */
-#ifdef CONFIG_S5PV310_SETUP_SDHCI
-extern char *s5pv310_hsmmc_clksrcs[4];
+/* EXYNOS4 SDHCI setup */
+#ifdef CONFIG_EXYNOS4_SETUP_SDHCI
+extern char *exynos4_hsmmc_clksrcs[4];
 
-extern void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev,
+extern void exynos4_setup_sdhci_cfg_card(struct platform_device *dev,
 					   void __iomem *r,
 					   struct mmc_ios *ios,
 					   struct mmc_card *card);
 
-static inline void s5pv310_default_sdhci0(void)
+static inline void exynos4_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
-	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv310_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+	s3c_hsmmc0_def_platdata.clocks = exynos4_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.cfg_gpio = exynos4_setup_sdhci0_cfg_gpio;
+	s3c_hsmmc0_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
-static inline void s5pv310_default_sdhci1(void)
+static inline void exynos4_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
-	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv310_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+	s3c_hsmmc1_def_platdata.clocks = exynos4_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.cfg_gpio = exynos4_setup_sdhci1_cfg_gpio;
+	s3c_hsmmc1_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
-static inline void s5pv310_default_sdhci2(void)
+static inline void exynos4_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
-	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv310_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+	s3c_hsmmc2_def_platdata.clocks = exynos4_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = exynos4_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
-static inline void s5pv310_default_sdhci3(void)
+static inline void exynos4_default_sdhci3(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC3
-	s3c_hsmmc3_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
-	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv310_setup_sdhci3_cfg_gpio;
-	s3c_hsmmc3_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+	s3c_hsmmc3_def_platdata.clocks = exynos4_hsmmc_clksrcs;
+	s3c_hsmmc3_def_platdata.cfg_gpio = exynos4_setup_sdhci3_cfg_gpio;
+	s3c_hsmmc3_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
 #else
-static inline void s5pv310_default_sdhci0(void) { }
-static inline void s5pv310_default_sdhci1(void) { }
-static inline void s5pv310_default_sdhci2(void) { }
-static inline void s5pv310_default_sdhci3(void) { }
+static inline void exynos4_default_sdhci0(void) { }
+static inline void exynos4_default_sdhci1(void) { }
+static inline void exynos4_default_sdhci2(void) { }
+static inline void exynos4_default_sdhci3(void) { }
 
-#endif /* CONFIG_S5PV310_SETUP_SDHCI */
+#endif /* CONFIG_EXYNOS4_SETUP_SDHCI */
 
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.7.1
