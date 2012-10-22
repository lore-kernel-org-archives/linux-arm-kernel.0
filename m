From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 14:32:04 +0200
Subject: [PATCH 1/2] ASoC: Ux500: Fixup use of clocks
Message-ID: <1350909125-20189-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Make sure clocks are being prepared and unprepared as well
as enabled and disabled.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 sound/soc/ux500/ux500_msp_dai.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index be94bf9..e11187f 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -398,11 +398,13 @@ static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* Enable clock */
+	/* Prepare and enable clock */
 	dev_dbg(dai->dev, "%s: Enabling MSP-clock.\n", __func__);
-	clk_enable(drvdata->clk);
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		regulator_disable(drvdata->reg_vape);
 
-	return 0;
+	return ret;
 }
 
 static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
@@ -428,8 +430,8 @@ static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
 			__func__, dai->id, snd_pcm_stream_str(substream));
 	}
 
-	/* Disable clock */
-	clk_disable(drvdata->clk);
+	/* Disable and unprepare clock */
+	clk_disable_unprepare(drvdata->clk);
 
 	/* Disable regulator */
 	ret = regulator_disable(drvdata->reg_vape);
-- 
1.7.10
