From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Mar 2015 16:45:19 +0200
Subject: [PATCH 3/5] ASoC: davinci-vcif: Convert to use edma-pcm
In-Reply-To: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1425393921-14219-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edma-pcm can replace the old davinci-pcm as platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-vcif.c | 55 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 5bee04279ebe..fabd05f24aeb 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -33,8 +33,9 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
-#include "davinci-pcm.h"
+#include "edma-pcm.h"
 #include "davinci-i2s.h"
 
 #define MOD_REG_BIT(val, mask, set) do { \
@@ -47,7 +48,8 @@
 
 struct davinci_vcif_dev {
 	struct davinci_vc *davinci_vc;
-	struct davinci_pcm_dma_params	dma_params[2];
+	struct snd_dmaengine_dai_dma_data dma_data[2];
+	int dma_request[2];
 };
 
 static void davinci_vcif_start(struct snd_pcm_substream *substream)
@@ -93,8 +95,6 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 {
 	struct davinci_vcif_dev *davinci_vcif_dev = snd_soc_dai_get_drvdata(dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
-	struct davinci_pcm_dma_params *dma_params =
-			&davinci_vcif_dev->dma_params[substream->stream];
 	u32 w;
 
 	/* Restart the codec before setup */
@@ -113,16 +113,12 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 	/* Determine xfer data type */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
-		dma_params->data_type = 0;
-
 		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
 			    DAVINCI_VC_CTRL_RD_UNSIGNED |
 			    DAVINCI_VC_CTRL_WD_BITS_8 |
 			    DAVINCI_VC_CTRL_WD_UNSIGNED, 1);
 		break;
 	case SNDRV_PCM_FORMAT_S8:
-		dma_params->data_type = 1;
-
 		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
 			    DAVINCI_VC_CTRL_WD_BITS_8, 1);
 
@@ -130,8 +126,6 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 			    DAVINCI_VC_CTRL_WD_UNSIGNED, 0);
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		dma_params->data_type = 2;
-
 		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
 			    DAVINCI_VC_CTRL_RD_UNSIGNED |
 			    DAVINCI_VC_CTRL_WD_BITS_8 |
@@ -142,8 +136,6 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	dma_params->acnt  = dma_params->data_type;
-
 	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
 
 	return 0;
@@ -172,24 +164,25 @@ static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static int davinci_vcif_startup(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
-{
-	struct davinci_vcif_dev *dev = snd_soc_dai_get_drvdata(dai);
-
-	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
-	return 0;
-}
-
 #define DAVINCI_VCIF_RATES	SNDRV_PCM_RATE_8000_48000
 
 static const struct snd_soc_dai_ops davinci_vcif_dai_ops = {
-	.startup	= davinci_vcif_startup,
 	.trigger	= davinci_vcif_trigger,
 	.hw_params	= davinci_vcif_hw_params,
 };
 
+static int davinci_vcif_dai_probe(struct snd_soc_dai *dai)
+{
+	struct davinci_vcif_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	dai->playback_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dai->capture_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver davinci_vcif_dai = {
+	.probe = davinci_vcif_dai_probe,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -225,16 +218,16 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 
 	/* DMA tx params */
 	davinci_vcif_dev->davinci_vc = davinci_vc;
-	davinci_vcif_dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].channel =
-					davinci_vc->davinci_vcif.dma_tx_channel;
-	davinci_vcif_dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].dma_addr =
-					davinci_vc->davinci_vcif.dma_tx_addr;
+	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data =
+				&davinci_vc->davinci_vcif.dma_tx_channel;
+	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
+				davinci_vc->davinci_vcif.dma_tx_addr;
 
 	/* DMA rx params */
-	davinci_vcif_dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel =
-					davinci_vc->davinci_vcif.dma_rx_channel;
-	davinci_vcif_dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].dma_addr =
-					davinci_vc->davinci_vcif.dma_rx_addr;
+	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data =
+				&davinci_vc->davinci_vcif.dma_rx_channel;
+	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
+				davinci_vc->davinci_vcif.dma_rx_addr;
 
 	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
 
@@ -245,7 +238,7 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = davinci_soc_platform_register(&pdev->dev);
+	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
 		snd_soc_unregister_component(&pdev->dev);
-- 
2.3.0
