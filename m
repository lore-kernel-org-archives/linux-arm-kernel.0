From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 12:11:04 +0200
Subject: [PATCH 3/3] ASoC: mxs-saif: Handle errors in trigger function
In-Reply-To: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381486264-1672-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/mxs/mxs-saif.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c8ead01..fc3d89b 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -494,6 +494,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
 	struct mxs_saif *master_saif;
 	u32 delay;
+	int ret;
 
 	master_saif = mxs_saif_get_master(saif);
 	if (!master_saif)
@@ -508,21 +509,32 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		dev_dbg(cpu_dai->dev, "start\n");
 
-		clk_enable(master_saif->clk);
-		if (!master_saif->mclk_in_use)
-			__raw_writel(BM_SAIF_CTRL_RUN,
-				master_saif->base + SAIF_CTRL + MXS_SET_ADDR);
+		ret = clk_enable(master_saif->clk);
+		if (ret) {
+			dev_err(saif->dev, "Failed to enable master clock\n");
+			return ret;
+		}
 
 		/*
 		 * If the saif's master is not himself, we also need to enable
 		 * itself clk for its internal basic logic to work.
 		 */
 		if (saif != master_saif) {
-			clk_enable(saif->clk);
+			ret = clk_enable(saif->clk);
+			if (ret) {
+				dev_err(saif->dev, "Failed to enable master clock\n");
+				clk_disable(master_saif->clk);
+				return ret;
+			}
+
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				saif->base + SAIF_CTRL + MXS_SET_ADDR);
 		}
 
+		if (!master_saif->mclk_in_use)
+			__raw_writel(BM_SAIF_CTRL_RUN,
+				master_saif->base + SAIF_CTRL + MXS_SET_ADDR);
+
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			/*
 			 * write data to saif data register to trigger
-- 
1.8.4.rc3
