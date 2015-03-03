From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Mar 2015 16:45:18 +0200
Subject: [PATCH 2/5] ASoC: davinci-i2s: Convert to use edma-pcm
In-Reply-To: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1425393921-14219-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edma-pcm can replace the old davinci-pcm as platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-i2s.c | 67 ++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 15fb28fc8e1b..56cb4d95637d 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -23,8 +23,9 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
-#include "davinci-pcm.h"
+#include "edma-pcm.h"
 #include "davinci-i2s.h"
 
 
@@ -122,7 +123,8 @@ static const unsigned char double_fmt[SNDRV_PCM_FORMAT_S32_LE + 1] = {
 
 struct davinci_mcbsp_dev {
 	struct device *dev;
-	struct davinci_pcm_dma_params	dma_params[2];
+	struct snd_dmaengine_dai_dma_data dma_data[2];
+	int dma_request[2];
 	void __iomem			*base;
 #define MOD_DSP_A	0
 #define MOD_DSP_B	1
@@ -419,8 +421,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
-	struct davinci_pcm_dma_params *dma_params =
-					&dev->dma_params[substream->stream];
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length, master;
 	unsigned int rcr, xcr, srgr, clk_div, freq, framesize;
@@ -532,8 +532,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 	}
-	dma_params->acnt = dma_params->data_type = data_type[fmt];
-	dma_params->fifo_level = 0;
 	mcbsp_word_length = asp_word_length[fmt];
 
 	switch (master) {
@@ -600,15 +598,6 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static int davinci_i2s_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
-
-	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
-	return 0;
-}
-
 static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -620,7 +609,6 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 
 static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
-	.startup	= davinci_i2s_startup,
 	.shutdown	= davinci_i2s_shutdown,
 	.prepare	= davinci_i2s_prepare,
 	.trigger	= davinci_i2s_trigger,
@@ -630,7 +618,18 @@ static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 
 };
 
+static int davinci_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	dai->playback_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dai->capture_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver davinci_i2s_dai = {
+	.probe = davinci_i2s_dai_probe,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -651,11 +650,9 @@ static const struct snd_soc_component_driver davinci_i2s_component = {
 
 static int davinci_i2s_probe(struct platform_device *pdev)
 {
-	struct snd_platform_data *pdata = pdev->dev.platform_data;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *ioarea, *res;
-	enum dma_event_q asp_chan_q = EVENTQ_0;
-	enum dma_event_q ram_chan_q = EVENTQ_1;
+	int *dma;
 	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -676,22 +673,6 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-	if (pdata) {
-		dev->enable_channel_combine = pdata->enable_channel_combine;
-		dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].sram_size =
-			pdata->sram_size_playback;
-		dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].sram_size =
-			pdata->sram_size_capture;
-		dev->clk_input_pin = pdata->clk_input_pin;
-		dev->i2s_accurate_sck = pdata->i2s_accurate_sck;
-		asp_chan_q = pdata->asp_chan_q;
-		ram_chan_q = pdata->ram_chan_q;
-	}
-
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].asp_chan_q	= asp_chan_q;
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].ram_chan_q	= ram_chan_q;
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].asp_chan_q	= asp_chan_q;
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].ram_chan_q	= ram_chan_q;
 
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
@@ -705,10 +686,10 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		goto err_release_clk;
 	}
 
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].dma_addr =
+	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
 	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
 
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].dma_addr =
+	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
 	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
 
 	/* first TX, then RX */
@@ -718,7 +699,9 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		ret = -ENXIO;
 		goto err_release_clk;
 	}
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].channel = res->start;
+	dma = &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
+	*dma = res->start;
+	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data = dma;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
@@ -726,9 +709,11 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		ret = -ENXIO;
 		goto err_release_clk;
 	}
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
-	dev->dev = &pdev->dev;
+	dma = &dev->dma_request[SNDRV_PCM_STREAM_CAPTURE];
+	*dma = res->start;
+	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data = dma;
 
+	dev->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, dev);
 
 	ret = snd_soc_register_component(&pdev->dev, &davinci_i2s_component,
@@ -736,7 +721,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_release_clk;
 
-	ret = davinci_soc_platform_register(&pdev->dev);
+	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
 		goto err_unregister_component;
-- 
2.3.0
