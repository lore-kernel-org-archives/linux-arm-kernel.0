From: koro.chen@mediatek.com (Koro Chen)
Date: Tue, 10 Nov 2015 15:26:12 +0800
Subject: [PATCH] ASoC: mediatek: Move 22M/24M clock control into I2S ops
Message-ID: <1447140372-10048-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

22M/24M clocks are only required for I2S, so move the control to
I2S DAI ops.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index f5baf3c..7f71343 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -299,8 +299,6 @@ static int mtk_afe_dais_enable_clks(struct mtk_afe *afe,
 			dev_err(afe->dev, "Failed to enable m_ck\n");
 			return ret;
 		}
-		regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
-				   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	}
 
 	if (b_ck) {
@@ -340,12 +338,8 @@ static int mtk_afe_dais_set_clks(struct mtk_afe *afe,
 static void mtk_afe_dais_disable_clks(struct mtk_afe *afe,
 				      struct clk *m_ck, struct clk *b_ck)
 {
-	if (m_ck) {
-		regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
-				   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
-				   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
+	if (m_ck)
 		clk_disable_unprepare(m_ck);
-	}
 	if (b_ck)
 		clk_disable_unprepare(b_ck);
 }
@@ -360,6 +354,8 @@ static int mtk_afe_i2s_startup(struct snd_pcm_substream *substream,
 		return 0;
 
 	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	return 0;
 }
 
@@ -373,6 +369,9 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 		return;
 
 	mtk_afe_set_i2s_enable(afe, false);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
+			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
 
 	/* disable AFE */
-- 
1.7.9.5
