From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 12 Nov 2012 15:40:26 +0800
Subject: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1352706028-750-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change the method for register dai and pcm
  - let the atmel-ssc-dai no longer as a standalone platform device
  - remap ssc and then register dai directly
  - register pcm from dai directly

Modify the code which related with this change

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change since v4 RFC
  - no change
Change since v3 RFC
  - remap ssc and then register dai and pcm directly
Change since v2
  - Register dai and pcm directly according to Mark Brown's suggestion
    - using name to distinguish ssc register for audio or library
      if for audio, the name with dai subfix
      if for library, the name without dai subfix
  - fix the issue for sam9g20-wm8731
    - when register dai and pcm cause the sam9g20-wm8731 doesn't work,
      so fix it
  - Add device tree support
    - Detail information reference atmel-ssc-dai.txt binding document
Change since v1
  No change
---
 arch/arm/mach-at91/at91sam9260_devices.c |    9 --
 arch/arm/mach-at91/board-sam9g20ek.c     |    8 +-
 sound/soc/atmel/atmel-pcm.c              |   23 +--
 sound/soc/atmel/atmel-pcm.h              |    3 +
 sound/soc/atmel/atmel_ssc_dai.c          |  228 +++++++-----------------------
 sound/soc/atmel/atmel_ssc_dai.h          |    1 +
 sound/soc/atmel/sam9g20_wm8731.c         |   13 +-
 7 files changed, 76 insertions(+), 209 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index df7bebf..6959fd2 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -768,14 +768,6 @@ static inline void configure_ssc_pins(unsigned pins)
 		at91_set_A_periph(AT91_PIN_PB21, 1);
 }
 
-static struct platform_device at91sam9260_ssc_dai_device = {
-	.name	= "atmel-ssc-dai",
-	.id	= 0,
-	.dev	= {
-		.parent	= &(at91sam9260_ssc_device.dev),
-	},
-};
-
 /*
  * SSC controllers are accessed through library code, instead of any
  * kind of all-singing/all-dancing driver.  For example one could be
@@ -800,7 +792,6 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	}
 
 	platform_device_register(pdev);
-	platform_device_register(&at91sam9260_ssc_dai_device);
 }
 
 #else
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 5b6a6f9..f3faf54 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -353,19 +353,13 @@ static struct i2c_board_info __initdata ek_i2c_devices[] = {
         },
 };
 
-static struct platform_device sam9g20ek_pcm_device = {
-	.name	= "atmel-pcm-audio",
-	.id = -1,
-};
-
 static struct platform_device sam9g20ek_audio_device = {
 	.name   = "at91sam9g20ek-audio",
-	.id     = -1,
+	.id     = 0,
 };
 
 static void __init ek_add_device_audio(void)
 {
-	platform_device_register(&sam9g20ek_pcm_device);
 	platform_device_register(&sam9g20ek_audio_device);
 }
 
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 9b84f98..40e17d1 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -473,28 +473,17 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 	.resume		= atmel_pcm_resume,
 };
 
-static int __devinit atmel_soc_platform_probe(struct platform_device *pdev)
+int atmel_pcm_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(&pdev->dev, &atmel_soc_platform);
+	return snd_soc_register_platform(dev, &atmel_soc_platform);
 }
+EXPORT_SYMBOL(atmel_pcm_platform_register);
 
-static int __devexit atmel_soc_platform_remove(struct platform_device *pdev)
+void atmel_pcm_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	snd_soc_unregister_platform(dev);
 }
-
-static struct platform_driver atmel_pcm_driver = {
-	.driver = {
-			.name = "atmel-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = atmel_soc_platform_probe,
-	.remove = __devexit_p(atmel_soc_platform_remove),
-};
-
-module_platform_driver(atmel_pcm_driver);
+EXPORT_SYMBOL(atmel_pcm_platform_unregister);
 
 MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
 MODULE_DESCRIPTION("Atmel PCM module");
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 5e0a95e..e6d67b3 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -80,4 +80,7 @@ struct atmel_pcm_dma_params {
 #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
 #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
 
+int atmel_pcm_platform_register(struct device *dev);
+void atmel_pcm_platform_unregister(struct device *dev);
+
 #endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 354341e..4435e19 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -47,13 +47,6 @@
 #include "atmel-pcm.h"
 #include "atmel_ssc_dai.h"
 
-
-#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
-#define NUM_SSC_DEVICES		1
-#else
-#define NUM_SSC_DEVICES		3
-#endif
-
 /*
  * SSC PDC registers required by the PCM DMA engine.
  */
@@ -96,63 +89,24 @@ static struct atmel_ssc_mask ssc_rx_mask = {
 /*
  * DMA parameters.
  */
-static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
-	{{
-	.name		= "SSC0 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
-	},
+static struct atmel_pcm_dma_params ssc_dma_params[2] = {
 	{
-	.name		= "SSC0 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	} },
-#if NUM_SSC_DEVICES == 3
-	{{
-	.name		= "SSC1 PCM out",
+	.name		= "SSC PCM out",
 	.pdc		= &pdc_tx_reg,
 	.mask		= &ssc_tx_mask,
 	},
 	{
-	.name		= "SSC1 PCM in",
+	.name		= "SSC PCM in",
 	.pdc		= &pdc_rx_reg,
 	.mask		= &ssc_rx_mask,
-	} },
-	{{
-	.name		= "SSC2 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
 	},
-	{
-	.name		= "SSC2 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	} },
-#endif
 };
 
-
-static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
-	{
-	.name		= "ssc0",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
-	.dir_mask	= SSC_DIR_MASK_UNUSED,
-	.initialized	= 0,
-	},
-#if NUM_SSC_DEVICES == 3
-	{
-	.name		= "ssc1",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
+static struct atmel_ssc_info ssc_info = {
+	.name		= "ssc",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info.lock),
 	.dir_mask	= SSC_DIR_MASK_UNUSED,
 	.initialized	= 0,
-	},
-	{
-	.name		= "ssc2",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
-	.dir_mask	= SSC_DIR_MASK_UNUSED,
-	.initialized	= 0,
-	},
-#endif
 };
 
 
@@ -205,7 +159,7 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
 static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	int dir_mask;
 
 	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
@@ -234,7 +188,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, dir_mask;
 
@@ -285,7 +239,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	ssc_p->daifmt = fmt;
 	return 0;
@@ -297,7 +251,7 @@ static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	switch (div_id) {
 	case ATMEL_SSC_CMR_DIV:
@@ -336,8 +290,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	int id = dai->id;
-	struct atmel_ssc_info *ssc_p = &ssc_info[id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, channels, bits;
 	u32 tfmr, rfmr, tcmr, rcmr;
@@ -354,7 +307,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
-	dma_params = &ssc_dma_params[id][dir];
+	dma_params = &ssc_dma_params[dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
 
@@ -603,7 +556,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir;
 
@@ -631,7 +584,7 @@ static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info;
 
 	/* Save the status register before disabling transmit and receive */
 	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
@@ -660,7 +613,7 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info;
 
 	/* restore SSC register settings */
 	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
@@ -689,28 +642,10 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 
 static int atmel_ssc_probe(struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
-	int ret = 0;
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	snd_soc_dai_set_drvdata(dai, ssc_p);
 
-	/*
-	 * Request SSC device
-	 */
-	ssc_p->ssc = ssc_request(dai->id);
-	if (IS_ERR(ssc_p->ssc)) {
-		printk(KERN_ERR "ASoC: Failed to request SSC %d\n", dai->id);
-		ret = PTR_ERR(ssc_p->ssc);
-	}
-
-	return ret;
-}
-
-static int atmel_ssc_remove(struct snd_soc_dai *dai)
-{
-	struct atmel_ssc_info *ssc_p = snd_soc_dai_get_drvdata(dai);
-
-	ssc_free(ssc_p->ssc);
 	return 0;
 }
 
@@ -728,11 +663,8 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 	.set_clkdiv	= atmel_ssc_set_dai_clkdiv,
 };
 
-static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
-	{
-		.name = "atmel-ssc-dai.0",
+static struct snd_soc_dai_driver atmel_ssc_dai = {
 		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
@@ -746,69 +678,37 @@ static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.rates = ATMEL_SSC_RATES,
 			.formats = ATMEL_SSC_FORMATS,},
 		.ops = &atmel_ssc_dai_ops,
-	},
-#if NUM_SSC_DEVICES == 3
-	{
-		.name = "atmel-ssc-dai.1",
-		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
-		.suspend = atmel_ssc_suspend,
-		.resume = atmel_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.ops = &atmel_ssc_dai_ops,
-	},
-	{
-		.name = "atmel-ssc-dai.2",
-		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
-		.suspend = atmel_ssc_suspend,
-		.resume = atmel_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.ops = &atmel_ssc_dai_ops,
-	},
-#endif
 };
 
-static __devinit int asoc_ssc_probe(struct platform_device *pdev)
+static int asoc_ssc_init(struct device *dev)
 {
-	BUG_ON(pdev->id < 0);
-	BUG_ON(pdev->id >= ARRAY_SIZE(atmel_ssc_dai));
-	return snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai[pdev->id]);
-}
+	int ret;
+
+	ret = snd_soc_register_dai(dev, &atmel_ssc_dai);
+	if (ret) {
+		dev_err(dev, "Could not register DAI: %d\n", ret);
+		goto err;
+	}
+
+	ret = atmel_pcm_platform_register(dev);
+	if (ret) {
+		dev_err(dev, "Could not register PCM: %d\n", ret);
+		goto err_unregister_dai;
+	};
 
-static int __devexit asoc_ssc_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
-}
 
-static struct platform_driver asoc_ssc_driver = {
-	.driver = {
-			.name = "atmel-ssc-dai",
-			.owner = THIS_MODULE,
-	},
+err_unregister_dai:
+	snd_soc_unregister_dai(dev);
+err:
+	return ret;
+}
 
-	.probe = asoc_ssc_probe,
-	.remove = __devexit_p(asoc_ssc_remove),
-};
+static void asoc_ssc_exit(struct device *dev)
+{
+	atmel_pcm_platform_unregister(dev);
+	snd_soc_unregister_dai(dev);
+}
 
 /**
  * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
@@ -816,50 +716,32 @@ static struct platform_driver asoc_ssc_driver = {
 int atmel_ssc_set_audio(int ssc_id)
 {
 	struct ssc_device *ssc;
-	static struct platform_device *dma_pdev;
-	struct platform_device *ssc_pdev;
 	int ret;
 
-	if (ssc_id < 0 || ssc_id >= ARRAY_SIZE(atmel_ssc_dai))
-		return -EINVAL;
-
-	/* Allocate a dummy device for DMA if we don't have one already */
-	if (!dma_pdev) {
-		dma_pdev = platform_device_alloc("atmel-pcm-audio", -1);
-		if (!dma_pdev)
-			return -ENOMEM;
-
-		ret = platform_device_add(dma_pdev);
-		if (ret < 0) {
-			platform_device_put(dma_pdev);
-			dma_pdev = NULL;
-			return ret;
-		}
-	}
-
-	ssc_pdev = platform_device_alloc("atmel-ssc-dai", ssc_id);
-	if (!ssc_pdev)
-		return -ENOMEM;
-
 	/* If we can grab the SSC briefly to parent the DAI device off it */
 	ssc = ssc_request(ssc_id);
-	if (IS_ERR(ssc))
-		pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
+	if (IS_ERR(ssc)) {
+		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
 			PTR_ERR(ssc));
-	else {
-		ssc_pdev->dev.parent = &(ssc->pdev->dev);
-		ssc_free(ssc);
+		return PTR_ERR(ssc);
+	} else {
+		ssc_info.ssc = ssc;
 	}
 
-	ret = platform_device_add(ssc_pdev);
-	if (ret < 0)
-		platform_device_put(ssc_pdev);
+	ret = asoc_ssc_init(&ssc->pdev->dev);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
 
-module_platform_driver(asoc_ssc_driver);
+void atmel_ssc_put_audio(void)
+{
+	struct ssc_device *ssc = ssc_info.ssc;
+
+	ssc_free(ssc);
+	asoc_ssc_exit(&ssc->pdev->dev);
+}
+EXPORT_SYMBOL_GPL(atmel_ssc_put_audio);
 
 /* Module information */
 MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou at atmel.com, www.atmel.com");
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index 5d4f0f9..70c66dd 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -118,5 +118,6 @@ struct atmel_ssc_info {
 };
 
 int atmel_ssc_set_audio(int ssc);
+void atmel_ssc_put_audio(void);
 
 #endif /* _AT91_SSC_DAI_H */
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 228ca6a..eef6eed 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -179,10 +179,10 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731 PCM",
-	.cpu_dai_name = "atmel-ssc-dai.0",
+	.cpu_dai_name = "at91rm9200_ssc.0",
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
-	.platform_name = "atmel-pcm-audio",
+	.platform_name = "at91rm9200_ssc.0",
 	.codec_name = "wm8731.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
@@ -204,6 +204,10 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
 		return -ENODEV;
 
+	ret = atmel_ssc_set_audio(pdev->id);
+	if (ret)
+		goto err;
+
 	/*
 	 * Codec MCLK is supplied by PCK0 - set it up.
 	 */
@@ -211,7 +215,7 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	if (IS_ERR(mclk)) {
 		printk(KERN_ERR "ASoC: Failed to get MCLK\n");
 		ret = PTR_ERR(mclk);
-		goto err;
+		goto err_ssc_put_audio;
 	}
 
 	pllb = clk_get(NULL, "pllb");
@@ -240,6 +244,8 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 err_mclk:
 	clk_put(mclk);
 	mclk = NULL;
+err_ssc_put_audio:
+	atmel_ssc_put_audio();
 err:
 	return ret;
 }
@@ -248,6 +254,7 @@ static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
+	atmel_ssc_put_audio();
 	snd_soc_unregister_card(card);
 	clk_put(mclk);
 	mclk = NULL;
-- 
1.7.9.5
