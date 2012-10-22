From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 22 Oct 2012 18:17:57 +0800
Subject: [PATCH 3/5] ASoC: atmel-ssc-dai: register 'platform' from DAIs
In-Reply-To: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1350901079-18307-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register platform from DAIs

Although we have different number of SSC, but
the one use for audio only need request when dai driver run probe
function. So, remove the redundant code.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel-pcm.c     |   23 +---
 sound/soc/atmel/atmel-pcm.h     |    3 +
 sound/soc/atmel/atmel_ssc_dai.c |  248 ++++++++++++---------------------------
 3 files changed, 81 insertions(+), 193 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 9b84f98..1e9cd2c 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -473,28 +473,17 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 	.resume		= atmel_pcm_resume,
 };
 
-static int __devinit atmel_soc_platform_probe(struct platform_device *pdev)
+int __devinit atmel_pcm_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(&pdev->dev, &atmel_soc_platform);
+	return snd_soc_register_platform(dev, &atmel_soc_platform);
 }
+EXPORT_SYMBOL(atmel_pcm_platform_register);
 
-static int __devexit atmel_soc_platform_remove(struct platform_device *pdev)
+void __devexit atmel_pcm_platform_unregister(struct device *dev)
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
index 5e0a95e..2d1c60f 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -80,4 +80,7 @@ struct atmel_pcm_dma_params {
 #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
 #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
 
+int __devexit atmel_pcm_platform_register(struct device *dev);
+void __devexit atmel_pcm_platform_unregister(struct device *dev);
+
 #endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 354341e..4436e09 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -42,18 +42,13 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <linux/of.h>
+
 #include <mach/hardware.h>
 
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
@@ -96,63 +91,24 @@ static struct atmel_ssc_mask ssc_rx_mask = {
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
+static struct atmel_ssc_info ssc_info = {
+	.name		= "ssc",
 	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
 	.dir_mask	= SSC_DIR_MASK_UNUSED,
 	.initialized	= 0,
-	},
-#if NUM_SSC_DEVICES == 3
-	{
-	.name		= "ssc1",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
-	.dir_mask	= SSC_DIR_MASK_UNUSED,
-	.initialized	= 0,
-	},
-	{
-	.name		= "ssc2",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
-	.dir_mask	= SSC_DIR_MASK_UNUSED,
-	.initialized	= 0,
-	},
-#endif
 };
 
 
@@ -205,7 +161,7 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
 static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	int dir_mask;
 
 	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
@@ -234,7 +190,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, dir_mask;
 
@@ -285,7 +241,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	ssc_p->daifmt = fmt;
 	return 0;
@@ -297,7 +253,7 @@ static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	switch (div_id) {
 	case ATMEL_SSC_CMR_DIV:
@@ -336,8 +292,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	int id = dai->id;
-	struct atmel_ssc_info *ssc_p = &ssc_info[id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, channels, bits;
 	u32 tfmr, rfmr, tcmr, rcmr;
@@ -354,7 +309,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
-	dma_params = &ssc_dma_params[id][dir];
+	dma_params = &ssc_dma_params[dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
 
@@ -603,7 +558,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir;
 
@@ -631,7 +586,7 @@ static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info;
 
 	/* Save the status register before disabling transmit and receive */
 	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
@@ -660,7 +615,7 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info;
 
 	/* restore SSC register settings */
 	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
@@ -689,31 +644,14 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 
 static int atmel_ssc_probe(struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	int ret = 0;
 
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
 	return ret;
 }
 
-static int atmel_ssc_remove(struct snd_soc_dai *dai)
-{
-	struct atmel_ssc_info *ssc_p = snd_soc_dai_get_drvdata(dai);
-
-	ssc_free(ssc_p->ssc);
-	return 0;
-}
-
 #define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
 
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
@@ -728,11 +666,9 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 	.set_clkdiv	= atmel_ssc_set_dai_clkdiv,
 };
 
-static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
-	{
-		.name = "atmel-ssc-dai.0",
+static struct snd_soc_dai_driver atmel_ssc_dai = {
+		.name = "atmel-ssc-dai",
 		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
@@ -746,119 +682,79 @@ static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
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
 
 static __devinit int asoc_ssc_probe(struct platform_device *pdev)
 {
-	BUG_ON(pdev->id < 0);
-	BUG_ON(pdev->id >= ARRAY_SIZE(atmel_ssc_dai));
-	return snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai[pdev->id]);
+	int ret, id;
+
+	if (pdev->dev.of_node) {
+		struct device_node *np = pdev->dev.of_node;
+		struct device_node *dai_master_np;
+
+		dai_master_np = of_parse_phandle(np, "atmel,dai-master", 0);
+		if (!dai_master_np) {
+			dev_err(&pdev->dev, "No SSC for atmel dai");
+			return -EINVAL;
+		}
+
+		id = of_alias_get_id(dai_master_np, "ssc");
+	} else {
+		id = to_platform_device(pdev->dev.parent)->id;
+	}
+
+	ssc_info.ssc = ssc_request(id);
+	if (IS_ERR(ssc_info.ssc)) {
+		dev_err(&pdev->dev, "Failed to request SSC %d\n", id);
+		return PTR_ERR(ssc_info.ssc);
+	}
+
+	ret = snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
+		goto err_unregister_dai;
+	}
+
+	ret = atmel_pcm_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
+		goto err;
+	};
+
+	return 0;
+
+err_unregister_dai:
+	snd_soc_unregister_dai(&pdev->dev);
+err:
+	return ret;
 }
 
 static int __devexit asoc_ssc_remove(struct platform_device *pdev)
 {
+	atmel_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_ssc_dai_dt_ids[] = {
+	{ .compatible = "atmel,atmel-ssc-dai", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, atmel_ssc_dai_dt_ids);
+#endif
+
 static struct platform_driver asoc_ssc_driver = {
 	.driver = {
-			.name = "atmel-ssc-dai",
-			.owner = THIS_MODULE,
+		.name		= "atmel-ssc-dai",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_ssc_dai_dt_ids),
 	},
 
 	.probe = asoc_ssc_probe,
 	.remove = __devexit_p(asoc_ssc_remove),
 };
 
-/**
- * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
- */
-int atmel_ssc_set_audio(int ssc_id)
-{
-	struct ssc_device *ssc;
-	static struct platform_device *dma_pdev;
-	struct platform_device *ssc_pdev;
-	int ret;
-
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
-	/* If we can grab the SSC briefly to parent the DAI device off it */
-	ssc = ssc_request(ssc_id);
-	if (IS_ERR(ssc))
-		pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
-			PTR_ERR(ssc));
-	else {
-		ssc_pdev->dev.parent = &(ssc->pdev->dev);
-		ssc_free(ssc);
-	}
-
-	ret = platform_device_add(ssc_pdev);
-	if (ret < 0)
-		platform_device_put(ssc_pdev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
-
 module_platform_driver(asoc_ssc_driver);
 
 /* Module information */
-- 
1.7.9.5
