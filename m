From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 07 Dec 2012 13:59:21 +0530
Subject: [PATCH RESEND V2 1/2] ASoC: Samsung: Do not register samsung audio dma
 device as pdev
In-Reply-To: <1354868962-7862-1-git-send-email-padma.v@samsung.com>
References: <1354868962-7862-1-git-send-email-padma.v@samsung.com>
Message-ID: <1354868962-7862-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the ASoC 'platform' (PCM/DMA) object was instantiated via a
platform_device. This didn't represent the hardware well, since there
was no separate hardware associated with this platform_device; it was a
virtual device with sole purpose to call snd_soc_register_platform().

This change removes the platform_device completely. Each Samsung DAI now
registers the ASoC 'platform' itself. Machine drivers are adjusted for
the new 'platform' name.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos/mach-armlex4210.c         |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c           |    1 -
 arch/arm/mach-s3c24xx/mach-gta02.c             |    1 -
 arch/arm/mach-s3c24xx/mach-h1940.c             |    1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c          |    1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c            |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c          |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c          |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c          |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c          |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c          |    1 -
 arch/arm/mach-s5pv210/mach-smdkc110.c          |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c          |    1 -
 arch/arm/plat-samsung/devs.c                   |    9 ---------
 arch/arm/plat-samsung/include/plat/devs.h      |    1 -
 sound/soc/samsung/ac97.c                       |   10 +++++++++-
 sound/soc/samsung/bells.c                      |    6 +++---
 sound/soc/samsung/dma.c                        |   24 ++++++------------------
 sound/soc/samsung/dma.h                        |    3 +++
 sound/soc/samsung/goni_wm8994.c                |    2 +-
 sound/soc/samsung/h1940_uda1380.c              |    2 +-
 sound/soc/samsung/i2s.c                        |    4 ++++
 sound/soc/samsung/jive_wm8750.c                |    2 +-
 sound/soc/samsung/littlemill.c                 |    2 +-
 sound/soc/samsung/ln2440sbc_alc650.c           |    2 +-
 sound/soc/samsung/lowland.c                    |    2 +-
 sound/soc/samsung/neo1973_wm8753.c             |    2 +-
 sound/soc/samsung/pcm.c                        |    9 +++++++++
 sound/soc/samsung/rx1950_uda1380.c             |    2 +-
 sound/soc/samsung/s3c2412-i2s.c                |   20 +++++++++++++++++++-
 sound/soc/samsung/s3c24xx-i2s.c                |   20 +++++++++++++++++++-
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/samsung/s3c24xx_uda134x.c            |    2 +-
 sound/soc/samsung/smartq_wm8987.c              |    2 +-
 sound/soc/samsung/smdk2443_wm9710.c            |    2 +-
 sound/soc/samsung/smdk_spdif.c                 |    2 +-
 sound/soc/samsung/smdk_wm8580.c                |    6 +++---
 sound/soc/samsung/smdk_wm8580pcm.c             |    2 +-
 sound/soc/samsung/smdk_wm8994.c                |    4 ++--
 sound/soc/samsung/smdk_wm8994pcm.c             |    2 +-
 sound/soc/samsung/smdk_wm9713.c                |    2 +-
 sound/soc/samsung/spdif.c                      |   10 +++++++++-
 sound/soc/samsung/speyside.c                   |    2 +-
 sound/soc/samsung/tobermory.c                  |    2 +-
 45 files changed, 105 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 3f37a5e..b938f9f 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -147,7 +147,6 @@ static struct platform_device *armlex4210_devices[] __initdata = {
 	&s3c_device_hsmmc3,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
-	&samsung_asoc_dma,
 	&armlex4210_smsc911x,
 	&exynos4_device_ahci,
 };
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index ee4fb1a..5de9ee2 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -311,7 +311,6 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
 	&exynos4_device_spdif,
-	&samsung_asoc_dma,
 	&samsung_asoc_idma,
 	&s5p_device_fimd0,
 	&smdkv310_device_audio,
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 4a96346..973b87c 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -521,7 +521,6 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&gta02_nor_flash,
 	&s3c24xx_pwm_device,
 	&s3c_device_iis,
-	&samsung_asoc_dma,
 	&s3c_device_i2c0,
 	&gta02_dfbmcs320_device,
 	&gta02_buttons_device,
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 63aaf07..b23dd1b 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -632,7 +632,6 @@ static struct platform_device *h1940_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
-	&samsung_asoc_dma,
 	&s3c_device_usbgadget,
 	&h1940_device_leds,
 	&h1940_device_bluetooth,
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 393c0f1..a31d5b8 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -519,7 +519,6 @@ static struct platform_device *mini2440_devices[] __initdata = {
 	&s3c_device_iis,
 	&uda1340_codec,
 	&mini2440_audio,
-	&samsung_asoc_dma,
 };
 
 static void __init mini2440_map_io(void)
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 379fde5..0606f2f 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -712,7 +712,6 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
-	&samsung_asoc_dma,
 	&s3c_device_usbgadget,
 	&s3c_device_rtc,
 	&s3c_device_nand,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 13b7eaa..ef2117d 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -357,7 +357,6 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&s3c_device_timer[0],
 	&s3c64xx_device_iis0,
 	&s3c64xx_device_iis1,
-	&samsung_asoc_dma,
 	&samsung_device_keypad,
 	&crag6410_gpio_keydev,
 	&crag6410_dm9k_device,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index da1a771..574a9ee 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -275,7 +275,6 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
-	&samsung_asoc_dma,
 	&s3c64xx_device_iisv4,
 	&samsung_device_keypad,
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 96ea1fe..1af8235 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -165,7 +165,6 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_ts,
 	&s3c_device_wdt,
-	&samsung_asoc_dma,
 	&s5p6440_device_iis,
 	&s3c_device_fb,
 	&smdk6440_lcd_lte480wv,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 12748b6..62526cc 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -183,7 +183,6 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_ts,
 	&s3c_device_wdt,
-	&samsung_asoc_dma,
 	&s5p6450_device_iis0,
 	&s3c_device_fb,
 	&smdk6450_lcd_lte480wv,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index dba7384..9abe95e 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -197,7 +197,6 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_ts,
 	&s3c_device_wdt,
 	&smdkc100_lcd_powerdev,
-	&samsung_asoc_dma,
 	&s5pc100_device_iis0,
 	&samsung_device_keypad,
 	&s5pc100_device_ac97,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index d9c99fc..f1f3bd3 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -85,7 +85,6 @@ static struct s3c_ide_platdata smdkc110_ide_pdata __initdata = {
 };
 
 static struct platform_device *smdkc110_devices[] __initdata = {
-	&samsung_asoc_dma,
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s5pv210_device_spdif,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 4cdb5bb..6bc8404 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -234,7 +234,6 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_ac97,
 	&s5pv210_device_iis0,
 	&s5pv210_device_spdif,
-	&samsung_asoc_dma,
 	&samsung_asoc_idma,
 	&samsung_device_keypad,
 	&smdkv210_dm9000,
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 03f654d..7d27a24 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -146,15 +146,6 @@ struct platform_device s3c_device_camif = {
 
 /* ASOC DMA */
 
-struct platform_device samsung_asoc_dma = {
-	.name		= "samsung-audio",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-
 struct platform_device samsung_asoc_idma = {
 	.name		= "samsung-idma",
 	.id		= -1,
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 5da4b4f..c45f70c 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -135,7 +135,6 @@ extern struct platform_device exynos4_device_spdif;
 
 extern struct platform_device exynos_device_drm;
 
-extern struct platform_device samsung_asoc_dma;
 extern struct platform_device samsung_asoc_idma;
 extern struct platform_device samsung_device_keypad;
 
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 386bab1..cd6c707 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -462,8 +462,15 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 	if (ret)
 		goto err5;
 
-	return 0;
+	ret = asoc_dma_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
+		goto err6;
+	}
 
+	return 0;
+err6:
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(s3c_ac97_dai));
 err5:
 	free_irq(irq_res->start, NULL);
 err4:
@@ -482,6 +489,7 @@ static __devexit int s3c_ac97_remove(struct platform_device *pdev)
 {
 	struct resource *mem_res, *irq_res;
 
+	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(s3c_ac97_dai));
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 59ffd6c..01c1c5a 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -233,7 +233,7 @@ static struct snd_soc_dai_link bells_dai_wm2200[] = {
 		.stream_name = "CPU-DSP",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm0010-sdi1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "spi0.0",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
@@ -257,7 +257,7 @@ static struct snd_soc_dai_link bells_dai_wm5102[] = {
 		.stream_name = "CPU-DSP",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm0010-sdi1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "spi0.0",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
@@ -303,7 +303,7 @@ static struct snd_soc_dai_link bells_dai_wm5110[] = {
 		.stream_name = "CPU-DSP",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm0010-sdi1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "spi0.0",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index b70964e..6452990 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -432,30 +432,18 @@ static struct snd_soc_platform_driver samsung_asoc_platform = {
 	.pcm_free	= dma_free_dma_buffers,
 };
 
-static int __devinit samsung_asoc_platform_probe(struct platform_device *pdev)
+int __devinit asoc_dma_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(&pdev->dev, &samsung_asoc_platform);
+	return snd_soc_register_platform(dev, &samsung_asoc_platform);
 }
+EXPORT_SYMBOL_GPL(asoc_dma_platform_register);
 
-static int __devexit samsung_asoc_platform_remove(struct platform_device *pdev)
+void __devexit asoc_dma_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	snd_soc_unregister_platform(dev);
 }
-
-static struct platform_driver asoc_dma_driver = {
-	.driver = {
-		.name = "samsung-audio",
-		.owner = THIS_MODULE,
-	},
-
-	.probe = samsung_asoc_platform_probe,
-	.remove = __devexit_p(samsung_asoc_platform_remove),
-};
-
-module_platform_driver(asoc_dma_driver);
+EXPORT_SYMBOL_GPL(asoc_dma_platform_unregister);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung ASoC DMA Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:samsung-audio");
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 7d1ead7..73d8c7c 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -21,4 +21,7 @@ struct s3c_dma_params {
 	struct samsung_dma_ops *ops;
 };
 
+int asoc_dma_platform_register(struct device *dev);
+void asoc_dma_platform_unregister(struct device *dev);
+
 #endif
diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index c23c2ae..d37ede5 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -228,7 +228,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.stream_name = "WM8994 HiFi",
 	.cpu_dai_name = "samsung-i2s.0",
 	.codec_dai_name = "wm8994-aif1",
-	.platform_name = "samsung-audio",
+	.platform_name = "samsung-i2s.0",
 	.codec_name = "wm8994-codec.0-001a",
 	.init = goni_wm8994_init,
 	.ops = &goni_hifi_ops,
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 6e32577..3870e96 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -207,7 +207,7 @@ static struct snd_soc_dai_link h1940_uda1380_dai[] = {
 		.cpu_dai_name	= "s3c24xx-iis",
 		.codec_dai_name	= "uda1380-hifi",
 		.init		= h1940_uda1380_init,
-		.platform_name	= "samsung-audio",
+		.platform_name	= "s3c24xx-iis",
 		.codec_name	= "uda1380-codec.0-001a",
 		.ops		= &h1940_ops,
 	},
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index aaf57b7..0aa0451 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1009,6 +1009,7 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai = dev_get_drvdata(&pdev->dev);
 		snd_soc_register_dai(&sec_dai->pdev->dev,
 			&sec_dai->i2s_dai_drv);
+		asoc_dma_platform_register(&pdev->dev);
 		return 0;
 	}
 
@@ -1107,6 +1108,8 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
+	asoc_dma_platform_register(&pdev->dev);
+
 	return 0;
 err:
 	release_mem_region(regs_base, resource_size(res));
@@ -1135,6 +1138,7 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 	i2s->pri_dai = NULL;
 	i2s->sec_dai = NULL;
 
+	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 
 	return 0;
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 1578663..b5f6abd 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -118,7 +118,7 @@ static struct snd_soc_dai_link jive_dai = {
 	.stream_name	= "WM8750",
 	.cpu_dai_name	= "s3c2412-i2s",
 	.codec_dai_name = "wm8750-hifi",
-	.platform_name	= "samsung-audio",
+	.platform_name	= "s3c2412-i2s",
 	.codec_name	= "wm8750.0-001a",
 	.init		= jive_wm8750_init,
 	.ops		= &jive_ops,
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index ee52c8a0..0908bb0 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -145,7 +145,7 @@ static struct snd_soc_dai_link littlemill_dai[] = {
 		.stream_name = "CPU",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8994-codec",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
diff --git a/sound/soc/samsung/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
index 69c4a59..9342fc2 100644
--- a/sound/soc/samsung/ln2440sbc_alc650.c
+++ b/sound/soc/samsung/ln2440sbc_alc650.c
@@ -28,7 +28,7 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 	.cpu_dai_name = "samsung-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
-	.platform_name = "samsung-audio",
+	.platform_name = "samsung-ac97",
 },
 };
 
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 6abf341..a71c31a 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -99,7 +99,7 @@ static struct snd_soc_dai_link lowland_dai[] = {
 		.stream_name = "CPU",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm5100-aif1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm5100.1-001a",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				SND_SOC_DAIFMT_CBM_CFM,
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 321d511..c7e965f 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -364,7 +364,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Hifi Playback - for similatious use with voice below */
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
-	.platform_name = "samsung-audio",
+	.platform_name = "s3c24xx-iis",
 	.cpu_dai_name = "s3c24xx-iis",
 	.codec_dai_name = "wm8753-hifi",
 	.codec_name = "wm8753.0-001a",
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 45f4a75..ecd5090 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -589,8 +589,16 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 		goto err5;
 	}
 
+	ret = asoc_dma_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
+		goto err6;
+	}
+
 	return 0;
 
+err6:
+	snd_soc_unregister_dai(&pdev->dev);
 err5:
 	clk_disable_unprepare(pcm->pclk);
 	clk_put(pcm->pclk);
@@ -610,6 +618,7 @@ static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
 	struct s3c_pcm_info *pcm = &s3c_pcm[pdev->id];
 	struct resource *mem_res;
 
+	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 21e1236..a5826ea 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -85,7 +85,7 @@ static struct snd_soc_dai_link rx1950_uda1380_dai[] = {
 		.cpu_dai_name	= "s3c24xx-iis",
 		.codec_dai_name	= "uda1380-hifi",
 		.init		= rx1950_uda1380_init,
-		.platform_name	= "samsung-audio",
+		.platform_name	= "s3c24xx-iis",
 		.codec_name	= "uda1380-codec.0-001a",
 		.ops		= &rx1950_ops,
 	},
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index ac7701b..edf5f52 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -162,11 +162,29 @@ static struct snd_soc_dai_driver s3c2412_i2s_dai = {
 
 static __devinit int s3c2412_iis_dev_probe(struct platform_device *pdev)
 {
-	return s3c_i2sv2_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
+	int ret = 0;
+
+	ret = s3c_i2sv2_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
+	if (ret) {
+		pr_err("failed to register the dai\n");
+		return ret;
+	}
+
+	ret = asoc_dma_platform_register(&pdev->dev);
+	if (ret) {
+		pr_err("failed to register the DMA: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	snd_soc_unregister_dai(&pdev->dev);
+	return ret;
 }
 
 static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
 {
+	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 0aae3a3..0022d51 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -467,11 +467,29 @@ static struct snd_soc_dai_driver s3c24xx_i2s_dai = {
 
 static __devinit int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_dai(&pdev->dev, &s3c24xx_i2s_dai);
+	int ret = 0;
+
+	ret = s3c_i2sv2_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
+	if (ret) {
+		pr_err("failed to register the dai\n");
+		return ret;
+	}
+
+	ret = asoc_dma_platform_register(&pdev->dev);
+	if (ret) {
+		pr_err("failed to register the dma: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	snd_soc_unregister_dai(&pdev->dev);
+	return ret;
 }
 
 static __devexit int s3c24xx_iis_dev_remove(struct platform_device *pdev)
 {
+	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index 7ace6a8..befabe8 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -82,7 +82,7 @@ static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.codec_name	= "tlv320aic3x-codec.0-001a",
 	.cpu_dai_name	= "s3c24xx-iis",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.platform_name	= "samsung-audio",
+	.platform_name	= "s3c24xx-iis",
 	.init		= simtec_hermes_init,
 };
 
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index c42d5f0..5552f82 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -71,7 +71,7 @@ static struct snd_soc_dai_link simtec_dai_aic23 = {
 	.codec_name	= "tlv320aic3x-codec.0-001a",
 	.cpu_dai_name	= "s3c24xx-iis",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.platform_name	= "samsung-audio",
+	.platform_name	= "s3c24xx-iis",
 	.init		= simtec_tlv320aic23_init,
 };
 
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index d731042..333e1b7 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -224,7 +224,7 @@ static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
 	.codec_dai_name = "uda134x-hifi",
 	.cpu_dai_name = "s3c24xx-iis",
 	.ops = &s3c24xx_uda134x_ops,
-	.platform_name	= "samsung-audio",
+	.platform_name	= "s3c24xx-iis",
 };
 
 static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index f2dcb42..58ae323 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -189,7 +189,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 		.stream_name	= "SmartQ Hi-Fi",
 		.cpu_dai_name	= "samsung-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
-		.platform_name	= "samsung-audio",
+		.platform_name	= "samsung-i2s.0",
 		.codec_name	= "wm8750.0-0x1a",
 		.init		= smartq_wm8987_init,
 		.ops		= &smartq_hifi_ops,
diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
index 720ba29..c390aad6 100644
--- a/sound/soc/samsung/smdk2443_wm9710.c
+++ b/sound/soc/samsung/smdk2443_wm9710.c
@@ -24,7 +24,7 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 	.cpu_dai_name = "samsung-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
-	.platform_name = "samsung-audio",
+	.platform_name = "samsung-ac97",
 },
 };
 
diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
index beaa9c1..a2f2363 100644
--- a/sound/soc/samsung/smdk_spdif.c
+++ b/sound/soc/samsung/smdk_spdif.c
@@ -151,7 +151,7 @@ static struct snd_soc_ops smdk_spdif_ops = {
 static struct snd_soc_dai_link smdk_dai = {
 	.name = "S/PDIF",
 	.stream_name = "S/PDIF PCM Playback",
-	.platform_name = "samsung-audio",
+	.platform_name = "samsung-spdif",
 	.cpu_dai_name = "samsung-spdif",
 	.codec_dai_name = "dit-hifi",
 	.codec_name = "spdif-dit",
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index ade2809..7e2b710 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -176,7 +176,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Playback",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8580-hifi-playback",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
 		.ops = &smdk_ops,
 	},
@@ -185,7 +185,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Capture",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8580-hifi-capture",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
 		.init = smdk_wm8580_init_paiftx,
 		.ops = &smdk_ops,
@@ -195,7 +195,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Playback",
 		.cpu_dai_name = "samsung-i2s.x",
 		.codec_dai_name = "wm8580-hifi-playback",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.x",
 		.codec_name = "wm8580.0-001b",
 		.ops = &smdk_ops,
 	},
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index fab5322..34239fe 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -135,7 +135,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Capture",
 		.cpu_dai_name = "samsung-pcm.0",
 		.codec_dai_name = "wm8580-hifi-capture",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-pcm.0",
 		.codec_name = "wm8580.0-001b",
 		.ops = &smdk_wm8580_pcm_ops,
 	},
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 48dd4dd..dd0aa8c 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -127,7 +127,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Pri_Dai",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8994-codec",
 		.init = smdk_wm8994_init_paiftx,
 		.ops = &smdk_ops,
@@ -136,7 +136,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Sec_Dai",
 		.cpu_dai_name = "samsung-i2s.4",
 		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.4",
 		.codec_name = "wm8994-codec",
 		.ops = &smdk_ops,
 	},
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 77ecba9..15f6b44 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -116,7 +116,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.stream_name = "Primary PCM",
 		.cpu_dai_name = "samsung-pcm.0",
 		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-pcm.0",
 		.codec_name = "wm8994-codec",
 		.ops = &smdk_wm8994_pcm_ops,
 	},
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
index 55b2ca7..0d20e4e 100644
--- a/sound/soc/samsung/smdk_wm9713.c
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -42,7 +42,7 @@ static struct snd_soc_card smdk;
 static struct snd_soc_dai_link smdk_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 PCM",
-	.platform_name = "samsung-audio",
+	.platform_name = "samsung-ac97",
 	.cpu_dai_name = "samsung-ac97",
 	.codec_dai_name = "wm9713-hifi",
 	.codec_name = "wm9713-codec",
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 5f3b06d..8606fc6 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -437,8 +437,15 @@ static __devinit int spdif_probe(struct platform_device *pdev)
 
 	spdif->dma_playback = &spdif_stereo_out;
 
-	return 0;
+	ret = asoc_dma_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register DMA: %d\n", ret);
+		goto err5;
+	}
 
+	return 0;
+err5:
+	snd_soc_unregister_dai(&pdev->dev);
 err4:
 	iounmap(spdif->regs);
 err3:
@@ -458,6 +465,7 @@ static __devexit int spdif_remove(struct platform_device *pdev)
 	struct samsung_spdif_info *spdif = &spdif_info;
 	struct resource *mem_res;
 
+	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 
 	iounmap(spdif->regs);
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index c7e1c28..d7906a1 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -198,7 +198,7 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.stream_name = "CPU-DSP",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm0010-sdi1",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "spi0.0",
 		.init = speyside_wm0010_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 9199649..42e4c8e 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -110,7 +110,7 @@ static struct snd_soc_dai_link tobermory_dai[] = {
 		.stream_name = "CPU",
 		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8962",
-		.platform_name = "samsung-audio",
+		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8962.1-001a",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
-- 
1.7.4.4
