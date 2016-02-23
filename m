From: pc.liao@mediatek.com (PC Liao)
Date: Tue, 23 Feb 2016 16:20:24 +0800
Subject: [PATCH] ASoC: mediatek: remove soft reset and add second I2S clock
Message-ID: <1456215624-40383-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve I2S flow, this patch removes soft reset and adds second
I2S clock to use.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 689c51f..3456bfa 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -283,20 +283,13 @@ static void mtk_afe_set_i2s_enable(struct mtk_afe *afe, bool enable)
 
 	regmap_read(afe->regmap, AFE_I2S_CON2, &val);
 	if (!!(val & AFE_I2S_CON2_EN) == enable)
-		return; /* must skip soft reset */
-
-	/* I2S soft reset begin */
-	regmap_update_bits(afe->regmap, AUDIO_TOP_CON1, 0x4, 0x4);
+		return;
 
 	/* input */
 	regmap_update_bits(afe->regmap, AFE_I2S_CON2, 0x1, enable);
 
 	/* output */
 	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 0x1, enable);
-
-	/* I2S soft reset end */
-	udelay(1);
-	regmap_update_bits(afe->regmap, AUDIO_TOP_CON1, 0x4, 0);
 }
 
 static int mtk_afe_dais_enable_clks(struct mtk_afe *afe,
@@ -365,6 +358,7 @@ static int mtk_afe_i2s_startup(struct snd_pcm_substream *substream,
 		return 0;
 
 	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
+	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	return 0;
@@ -384,6 +378,7 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
+	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
 }
 
 static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
@@ -397,6 +392,9 @@ static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
 	mtk_afe_dais_set_clks(afe,
 			      afe->clocks[MTK_CLK_I2S1_M], runtime->rate * 256,
 			      NULL, 0);
+	mtk_afe_dais_set_clks(afe,
+			      afe->clocks[MTK_CLK_I2S2_M], runtime->rate * 256,
+			      NULL, 0);
 	/* config I2S */
 	ret = mtk_afe_set_i2s(afe, substream->runtime->rate);
 	if (ret)
-- 
1.7.9.5
