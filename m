From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 18:24:42 +0100
Subject: [PATCH 3/3] ASoC: samsung: pass filter function as pointer
In-Reply-To: <5466463.9HBcuLFGQf@wuerfel>
References: <5466463.9HBcuLFGQf@wuerfel>
Message-ID: <8896684.3di3I3vzeA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are now passing the filter data as pointers to the drivers,
we can take the final step and also pass the filter function the
same way. I'm keeping this change separate, as there it's less
obvious that this is a net win.

Upsides of this are:

- The ASoC drivers are completely independent from the DMA engine
  implementation, which simplifies the Kconfig logic and in theory
  allows the same sound drivers to be built in a kernel that supports
  different kinds of dmaengine drivers.

- Consistency with other subsystems and drivers

On the other hand, we have a few downsides:

- The s3c24xx-dma driver now needs to be built-in for the ac97 platform
  device to be instantiated on s3c2440.

- samsung_dmaengine_pcm_config cannot be marked 'const' any more
  because the filter function pointer needs to be set at runtime.
  This is safe as long we don't have multiple different DMA engines
  in thet same system at runtime, but is nonetheless ugly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 9a42736ef4ac..b57783371d52 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -58,6 +58,7 @@ static struct resource s3c64xx_iis0_resource[] = {
 
 static struct s3c_audio_pdata i2s0_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_I2S0_OUT,
 	.dma_capture = DMACH_I2S0_IN,
 };
@@ -79,6 +80,7 @@ static struct resource s3c64xx_iis1_resource[] = {
 
 static struct s3c_audio_pdata i2s1_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_I2S1_OUT,
 	.dma_capture = DMACH_I2S1_IN,
 };
@@ -100,6 +102,7 @@ static struct resource s3c64xx_iisv4_resource[] = {
 
 static struct s3c_audio_pdata i2sv4_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_HSI_I2SV40_TX,
 	.dma_capture = DMACH_HSI_I2SV40_RX,
 	.type = {
@@ -150,6 +153,7 @@ static struct resource s3c64xx_pcm0_resource[] = {
 
 static struct s3c_audio_pdata s3c_pcm0_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_capture = DMACH_PCM0_RX,
 	.dma_playback = DMACH_PCM0_TX,
 };
@@ -171,6 +175,7 @@ static struct resource s3c64xx_pcm1_resource[] = {
 
 static struct s3c_audio_pdata s3c_pcm1_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_PCM1_TX,
 	.dma_capture = DMACH_PCM1_RX,
 };
@@ -205,6 +210,7 @@ static struct resource s3c64xx_ac97_resource[] = {
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
 	.dma_playback = DMACH_AC97_PCMOUT,
+	.dma_filter = pl08x_filter_id,
 	.dma_capture = DMACH_AC97_PCMIN,
 	.dma_capture_mic = DMACH_AC97_MICIN,
 };
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e5e91669dd2b..314131a4525d 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -78,6 +78,9 @@ static struct resource s3c_ac97_resource[] = {
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
+#ifdef CONFIG_S3C24XX_DMAC
+	.dma_filter = s3c24xx_dma_filter,
+#endif
 	.dma_playback = (void *)DMACH_PCM_OUT,
 	.dma_capture = (void *)DMACH_PCM_IN,
 	.dma_capture_mic = (void *)DMACH_MIC_IN,
@@ -572,6 +575,9 @@ static struct resource s3c_iis_resource[] = {
 };
 
 static struct s3c_audio_pdata s3c_iis_platdata = {
+#ifdef CONFIG_S3C24XX_DMAC
+	.dma_filter = s3c24xx_dma_filter,
+#endif
 	.dma_playback = (void *)DMACH_I2S_OUT,
 	.dma_capture = (void *)DMACH_I2S_IN,
 };
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b93b75bf0a2d..e5ee0ce41054 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -431,7 +431,7 @@ config STE_DMA40
 	  Support for ST-Ericsson DMA40 controller
 
 config S3C24XX_DMAC
-	tristate "Samsung S3C24XX DMA support"
+	bool "Samsung S3C24XX DMA support"
 	depends on ARCH_S3C24XX
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 33f88b4479e4..15bf56ee8af7 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -13,6 +13,9 @@
  */
 #define S3C64XX_AC97_GPD  0
 #define S3C64XX_AC97_GPE  1
+
+#include <linux/dmaengine.h>
+
 extern void s3c64xx_ac97_setup_gpio(int);
 
 struct samsung_i2s {
@@ -39,6 +42,7 @@ struct samsung_i2s {
  */
 struct s3c_audio_pdata {
 	int (*cfg_gpio)(struct platform_device *);
+	dma_filter_fn dma_filter;
 	void *dma_playback;
 	void *dma_capture;
 	void *dma_play_sec;
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 3744c9ed5370..78baa26e938b 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,8 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
-	depends on S3C64XX_PL080 || !ARCH_S3C64XX
-	depends on S3C24XX_DMAC || !ARCH_S3C24XX
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 9c5219392460..4a7a503fe13c 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -388,7 +388,8 @@ static int s3c_ac97_probe(struct platform_device *pdev)
 	if (ret)
 		goto err5;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 ac97_pdata->dma_filter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err5;
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 085ef30f5ca2..a7616cc9b39e 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -13,6 +13,7 @@
 #define _S3C_AUDIO_H
 
 #include <sound/dmaengine_pcm.h>
+#include <linux/dmaengine.h>
 
 struct s3c_dma_params {
 	void *slave;				/* Channel ID */
@@ -25,6 +26,7 @@ struct s3c_dma_params {
 void samsung_asoc_init_dma_data(struct snd_soc_dai *dai,
 				struct s3c_dma_params *playback,
 				struct s3c_dma_params *capture);
-int samsung_asoc_dma_platform_register(struct device *dev);
+int samsung_asoc_dma_platform_register(struct device *dev,
+				       dma_filter_fn fn);
 
 #endif
diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 727008d57d14..063125937311 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -28,17 +28,8 @@
 
 #include "dma.h"
 
-#ifdef CONFIG_ARCH_S3C64XX
-#define filter_fn pl08x_filter_id
-#elif defined(CONFIG_ARCH_S3C24XX)
-#define filter_fn s3c24xx_dma_filter
-#else
-#define filter_fn NULL
-#endif
-
-static const struct snd_dmaengine_pcm_config samsung_dmaengine_pcm_config = {
+static struct snd_dmaengine_pcm_config samsung_dmaengine_pcm_config = {
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = filter_fn,
 };
 
 void samsung_asoc_init_dma_data(struct snd_soc_dai *dai,
@@ -67,8 +58,11 @@ void samsung_asoc_init_dma_data(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(samsung_asoc_init_dma_data);
 
-int samsung_asoc_dma_platform_register(struct device *dev)
+int samsung_asoc_dma_platform_register(struct device *dev,
+				       dma_filter_fn filter)
 {
+	samsung_dmaengine_pcm_config.compat_filter_fn = filter;
+
 	return devm_snd_dmaengine_pcm_register(dev,
 			&samsung_dmaengine_pcm_config,
 			SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME |
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0945b5de39e7..5a4133b6e6a6 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1244,7 +1244,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		if (ret != 0)
 			return ret;
 
-		return samsung_asoc_dma_platform_register(&pdev->dev);
+		return samsung_asoc_dma_platform_register(&pdev->dev,
+						  i2s_pdata->dma_filter);
 	}
 
 	pri_dai = i2s_alloc_dai(pdev, false);
@@ -1348,7 +1349,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+					i2s_pdata->dma_filter);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index b5ee054dddc9..e188f2e7d7fd 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -571,7 +571,8 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 		goto err5;
 	}
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 pcm_pdata->dma_filter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err5;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 455a0be2278e..b926002d71b2 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -25,7 +25,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 #include <plat/gpio-cfg.h>
 
@@ -172,7 +171,8 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 pdata->dma_filter);
 	if (ret)
 		pr_err("failed to register the DMA: %d\n", ret);
 
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 807dcc0d7421..580072f21055 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -23,7 +23,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 #include <plat/gpio-cfg.h>
 #include "regs-iis.h"
@@ -477,7 +476,8 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 pdata->dma_filter);
 	if (ret)
 		pr_err("failed to register the dma: %d\n", ret);
 
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 087d49d1787c..2069d2008033 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -430,7 +430,8 @@ static int spdif_probe(struct platform_device *pdev)
 
 	spdif->dma_playback = &spdif_stereo_out;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 spdif_pdata->dma_filter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DMA: %d\n", ret);
 		goto err4;
