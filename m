From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:17:53 +0100
Subject: [PATCH 5/8] ASoC: samsung: i2s: Do not use platform_data for DMA
 parameters
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478791076-19528-6-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All related platforms use either devicetree or the DMA slave
map API for mapping DMA channels to slave devices so we can now
stop using platform_data for passing DMA details.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7e32cf4..95a9a3f 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -90,7 +90,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data dma_playback;
 	struct snd_dmaengine_dai_dma_data dma_capture;
 	struct snd_dmaengine_dai_dma_data idma_playback;
-	dma_filter_fn filter;
 	u32	quirks;
 	u32	suspend_i2smod;
 	u32	suspend_i2scon;
@@ -1244,7 +1243,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			return ret;
 
 		return samsung_asoc_dma_platform_register(&pdev->dev,
-					sec_dai->filter, "tx-sec", NULL);
+						NULL, "tx-sec", NULL);
 	}
 
 	pri_dai = i2s_alloc_dai(pdev, false);
@@ -1262,10 +1261,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		pri_dai->dma_playback.filter_data = i2s_pdata->dma_playback;
-		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
-		pri_dai->filter = i2s_pdata->dma_filter;
-
 		if (&i2s_pdata->type)
 			i2s_cfg = &i2s_pdata->type.i2s;
 
@@ -1327,11 +1322,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
 
-		if (!np) {
-			sec_dai->dma_playback.filter_data = i2s_pdata->dma_play_sec;
-			sec_dai->filter = i2s_pdata->dma_filter;
-		}
-
 		sec_dai->dma_playback.addr_width = 4;
 		sec_dai->addr = pri_dai->addr;
 		sec_dai->clk = pri_dai->clk;
@@ -1353,7 +1343,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_free_dai;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
 						 NULL, NULL);
 	if (ret < 0)
 		goto err_free_dai;
-- 
1.9.1
