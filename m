From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 8 Aug 2012 20:40:32 +0530
Subject: [PATCH] ASoC: McASP: Convert driver to use Runtime PM API
In-Reply-To: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
References: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1344438632-2604-3-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  * Add Runtime PM support to McASP host controller.
  * Use Runtime PM API to enable/disable McASP clock.

This was tested on AM18x Board using suspend/resume

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
This patch was tested on AM18x Board and is based on repo at 
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;
a=shortlog;h=refs/heads/for-3.6

:100644 100644 ce5e5cd... 6a2c54c... M	sound/soc/davinci/davinci-mcasp.c
:100644 100644 4681acc... 51479f9... M	sound/soc/davinci/davinci-mcasp.h
 sound/soc/davinci/davinci-mcasp.c |   40 +++++++++++++++++-------------------
 sound/soc/davinci/davinci-mcasp.h |    3 +-
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ce5e5cd..6a2c54c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -782,20 +782,17 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!dev->clk_active) {
-			clk_enable(dev->clk);
-			dev->clk_active = 1;
-		}
+		ret = pm_runtime_get_sync(dev->dev);
+		if (IS_ERR_VALUE(ret))
+			dev_err(dev->dev, "pm_runtime_get_sync() failed\n");
 		davinci_mcasp_start(dev, substream->stream);
 		break;
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		davinci_mcasp_stop(dev, substream->stream);
-		if (dev->clk_active) {
-			clk_disable(dev->clk);
-			dev->clk_active = 0;
-		}
-
+		ret = pm_runtime_put_sync(dev->dev);
+		if (IS_ERR_VALUE(ret))
+			dev_err(dev->dev, "pm_runtime_put_sync() failed\n");
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -892,12 +889,13 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	pdata = pdev->dev.platform_data;
-	dev->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dev->clk))
-		return -ENODEV;
+	pm_runtime_enable(&pdev->dev);
 
-	clk_enable(dev->clk);
-	dev->clk_active = 1;
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
+		return ret;
+	}
 
 	dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 	if (!dev->base) {
@@ -914,6 +912,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->version = pdata->version;
 	dev->txnumevt = pdata->txnumevt;
 	dev->rxnumevt = pdata->rxnumevt;
+	dev->dev = &pdev->dev;
 
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
@@ -955,19 +954,18 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	return 0;
 
 err_release_clk:
-	clk_disable(dev->clk);
-	clk_put(dev->clk);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
-	struct davinci_audio_dev *dev = dev_get_drvdata(&pdev->dev);
 
 	snd_soc_unregister_dai(&pdev->dev);
-	clk_disable(dev->clk);
-	clk_put(dev->clk);
-	dev->clk = NULL;
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 4681acc..51479f9 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -40,9 +40,8 @@ struct davinci_audio_dev {
 	struct davinci_pcm_dma_params dma_params[2];
 	void __iomem *base;
 	int sample_rate;
-	struct clk *clk;
+	struct device *dev;
 	unsigned int codec_fmt;
-	u8 clk_active;
 
 	/* McASP specific data */
 	int	tdm_slots;
-- 
1.7.1
