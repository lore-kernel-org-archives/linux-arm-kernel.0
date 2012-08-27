From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 27 Aug 2012 18:56:39 +0530
Subject: [PATCH V2 1/6] ASoC: davinci: davinci-pcm does not need to be a
 plaform_driver
In-Reply-To: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same as the commit 518de86 (ASoC: tegra: register 'platform' from DAIs,
get rid of pdev). It makes davinci-pcm not a platform_driver but helper
to register "platform", so that the platform_device for davinci-pcm can
be saved completely.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes from V1:
	- New Commit. Instanciate seudo-device (davinci-pcm) directly from DAI
	  driver rather than having a separate virtual-device registered

:100644 100644 c80c20a... 4b37e2a... M	sound/soc/davinci/davinci-evm.c
:100644 100644 0a74b95... 407df72... M	sound/soc/davinci/davinci-i2s.c
:100644 100644 6a2c54c... 34ee2f1... M	sound/soc/davinci/davinci-mcasp.c
:100644 100644 97d77b2... 4b70828... M	sound/soc/davinci/davinci-pcm.c
:100644 100644 c0d6c9b... 5e55164... M	sound/soc/davinci/davinci-pcm.h
:100644 100644 f71175b... 5be65aa... M	sound/soc/davinci/davinci-sffsdr.c
:100644 100644 da030ff... 07bde2e... M	sound/soc/davinci/davinci-vcif.c
 sound/soc/davinci/davinci-evm.c    |   15 ++++++++-------
 sound/soc/davinci/davinci-i2s.c    |   10 ++++++++++
 sound/soc/davinci/davinci-mcasp.c  |   10 ++++++++++
 sound/soc/davinci/davinci-pcm.c    |   23 ++++++-----------------
 sound/soc/davinci/davinci-pcm.h    |    3 +++
 sound/soc/davinci/davinci-sffsdr.c |    2 +-
 sound/soc/davinci/davinci-vcif.c   |    8 ++++++++
 7 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index c80c20a..4b37e2a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -159,7 +159,7 @@ static struct snd_soc_dai_link dm6446_evm_dai = {
 	.cpu_dai_name = "davinci-mcbsp",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.codec_name = "tlv320aic3x-codec.1-001b",
-	.platform_name = "davinci-pcm-audio",
+	.platform_name = "davinci-mcbsp",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -170,7 +170,7 @@ static struct snd_soc_dai_link dm355_evm_dai = {
 	.cpu_dai_name = "davinci-mcbsp.1",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.codec_name = "tlv320aic3x-codec.1-001b",
-	.platform_name = "davinci-pcm-audio",
+	.platform_name = "davinci-mcbsp.1",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -184,14 +184,15 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 	.init = evm_aic3x_init,
 	.codec_name = "tlv320aic3x-codec.1-0018",
 	.ops = &evm_ops,
+	.platform_name = "davinci-mcbsp",
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
 	.stream_name = "CQ93",
 	.cpu_dai_name = "davinci-vcif",
 	.codec_dai_name = "cq93vc-hifi",
 	.codec_name = "cq93vc-codec",
+	.platform_name = "avinci-vcif",
 #endif
-	.platform_name = "davinci-pcm-audio",
 };
 
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
@@ -200,7 +201,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.stream_name = "AIC3X",
 		.cpu_dai_name= "davinci-mcasp.0",
 		.codec_dai_name = "tlv320aic3x-hifi",
-		.platform_name ="davinci-pcm-audio",
+		.platform_name = "davinci-mcasp.0",
 		.codec_name = "tlv320aic3x-codec.0-001a",
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
@@ -211,7 +212,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.cpu_dai_name= "davinci-mcasp.1",
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif_dit",
-		.platform_name = "davinci-pcm-audio",
+		.platform_name = "davinci-mcasp.1",
 		.ops = &evm_spdif_ops,
 	},
 };
@@ -222,7 +223,7 @@ static struct snd_soc_dai_link da830_evm_dai = {
 	.cpu_dai_name = "davinci-mcasp.1",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.codec_name = "tlv320aic3x-codec.1-0018",
-	.platform_name = "davinci-pcm-audio",
+	.platform_name = "davinci-mcasp.1",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -233,7 +234,7 @@ static struct snd_soc_dai_link da850_evm_dai = {
 	.cpu_dai_name= "davinci-mcasp.0",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.codec_name = "tlv320aic3x-codec.1-0018",
-	.platform_name = "davinci-pcm-audio",
+	.platform_name = "davinci-mcasp.0",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 0a74b95..407df72 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -732,8 +732,16 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_release_clk;
 
+	ret = davinci_soc_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		goto err_unregister_dai;
+	}
+
 	return 0;
 
+err_unregister_dai:
+	snd_soc_unregister_dai(&pdev->dev);
 err_release_clk:
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
@@ -745,6 +753,8 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	struct davinci_mcbsp_dev *dev = dev_get_drvdata(&pdev->dev);
 
 	snd_soc_unregister_dai(&pdev->dev);
+	davinci_soc_platform_unregister(&pdev->dev);
+
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 6a2c54c..34ee2f1 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -951,8 +951,17 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	if (ret != 0)
 		goto err_release_clk;
+
+	ret = davinci_soc_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		goto err_unregister_dai;
+	}
+
 	return 0;
 
+err_unregister_dai:
+	snd_soc_unregister_dai(&pdev->dev);
 err_release_clk:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -963,6 +972,7 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 {
 
 	snd_soc_unregister_dai(&pdev->dev);
+	davinci_soc_platform_unregister(&pdev->dev);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 97d77b2..4b70828 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -864,28 +864,17 @@ static struct snd_soc_platform_driver davinci_soc_platform = {
 	.pcm_free = 	davinci_pcm_free,
 };
 
-static int __devinit davinci_soc_platform_probe(struct platform_device *pdev)
+int davinci_soc_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(&pdev->dev, &davinci_soc_platform);
+	return snd_soc_register_platform(dev, &davinci_soc_platform);
 }
+EXPORT_SYMBOL_GPL(davinci_soc_platform_register);
 
-static int __devexit davinci_soc_platform_remove(struct platform_device *pdev)
+void davinci_soc_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	snd_soc_unregister_platform(dev);
 }
-
-static struct platform_driver davinci_pcm_driver = {
-	.driver = {
-			.name = "davinci-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = davinci_soc_platform_probe,
-	.remove = __devexit_p(davinci_soc_platform_remove),
-};
-
-module_platform_driver(davinci_pcm_driver);
+EXPORT_SYMBOL_GPL(davinci_soc_platform_unregister);
 
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI PCM DMA module");
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index c0d6c9b..5e55164 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -28,4 +28,7 @@ struct davinci_pcm_dma_params {
 	unsigned int fifo_level;
 };
 
+int davinci_soc_platform_register(struct device *dev);
+void davinci_soc_platform_unregister(struct device *dev);
+
 #endif
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index f71175b..5be65aa 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -86,7 +86,7 @@ static struct snd_soc_dai_link sffsdr_dai = {
 	.cpu_dai_name = "davinci-mcbsp",
 	.codec_dai_name = "pcm3008-hifi",
 	.codec_name = "pcm3008-codec",
-	.platform_name = "davinci-pcm-audio",
+	.platform_name = "davinci-mcbsp",
 	.ops = &sffsdr_ops,
 };
 
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index da030ff..07bde2e 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -240,12 +240,20 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = davinci_soc_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		snd_soc_unregister_dai(&pdev->dev);
+		return ret;
+	}
+
 	return 0;
 }
 
 static int davinci_vcif_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
+	davinci_soc_platform_unregister(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.1
