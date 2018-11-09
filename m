From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  8 Nov 2018 20:31:35 -0800
Subject: [PATCH] ASoC: sun8i-codec: fix crash on module removal
Message-ID: <20181109043135.26200-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drvdata is actually sun8i_codec, not snd_soc_card, so it crashes
when calling snd_soc_card_get_drvdata().

Drop card and scodec vars anyway since we don't need to
disable/unprepare clocks - it's already done by calling
runtime_suspend()

Drop clk_disable_unprepare() calls for the same reason.

Fixes: 36c684936fae7 ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 522a72fde78d..c4196d4e5915 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -605,16 +605,10 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 
 static int sun8i_codec_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct sun8i_codec *scodec = snd_soc_card_get_drvdata(card);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun8i_codec_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(scodec->clk_module);
-	clk_disable_unprepare(scodec->clk_bus);
-
 	return 0;
 }
 
-- 
2.19.1
