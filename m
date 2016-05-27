From: pc.liao@mediatek.com (PC Liao)
Date: Fri, 27 May 2016 15:43:17 +0800
Subject: [PATCH v2] ASoC: mediatek: Change the order of MCLK clock
 configuration
Message-ID: <1464334997-42960-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because MCLK turns on later and turns off earlier than codec, this patch
changes the order of MCLK clock configuration.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
Changes since v1:
update commit message
---
 sound/soc/mediatek/mtk-afe-pcm.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index f1c58a2..440ae06 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -360,8 +360,6 @@ static int mtk_afe_i2s_startup(struct snd_pcm_substream *substream,
 	if (dai->active)
 		return 0;
 
-	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
-	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	return 0;
@@ -380,8 +378,6 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
-	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
-	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
 }
 
 static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
@@ -1132,6 +1128,8 @@ static int mtk_afe_runtime_suspend(struct device *dev)
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_AFE, AUD_TCON0_PDN_AFE);
 
+	clk_disable_unprepare(afe->clocks[MTK_CLK_I2S1_M]);
+	clk_disable_unprepare(afe->clocks[MTK_CLK_I2S2_M]);
 	clk_disable_unprepare(afe->clocks[MTK_CLK_BCK0]);
 	clk_disable_unprepare(afe->clocks[MTK_CLK_BCK1]);
 	clk_disable_unprepare(afe->clocks[MTK_CLK_TOP_PDN_AUD]);
@@ -1164,6 +1162,12 @@ static int mtk_afe_runtime_resume(struct device *dev)
 	ret = clk_prepare_enable(afe->clocks[MTK_CLK_BCK1]);
 	if (ret)
 		goto err_bck0;
+	ret = clk_prepare_enable(afe->clocks[MTK_CLK_I2S1_M]);
+	if (ret)
+		goto err_i2s1_m;
+	ret = clk_prepare_enable(afe->clocks[MTK_CLK_I2S2_M]);
+	if (ret)
+		goto err_i2s2_m;
 
 	/* enable AFE clk */
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0, AUD_TCON0_PDN_AFE, 0);
@@ -1179,6 +1183,10 @@ static int mtk_afe_runtime_resume(struct device *dev)
 	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
 	return 0;
 
+err_i2s1_m:
+	clk_disable_unprepare(afe->clocks[MTK_CLK_I2S1_M]);
+err_i2s2_m:
+	clk_disable_unprepare(afe->clocks[MTK_CLK_I2S2_M]);
 err_bck0:
 	clk_disable_unprepare(afe->clocks[MTK_CLK_BCK0]);
 err_top_aud:
-- 
1.7.9.5
