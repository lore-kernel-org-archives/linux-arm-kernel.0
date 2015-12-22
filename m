From: koro.chen@mediatek.com (Koro Chen)
Date: Tue, 22 Dec 2015 11:11:34 +0800
Subject: [PATCH] ASoC: mediatek: Turn AFE on/off in runtime resume/suspend
Message-ID: <1450753894-8087-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AFE is actually allowed to be turn on before configuration of DAIs
since each DAI has its own enabling control. Turn on/off AFE in
runtime resume/suspend to avoid AFE being shut down when closing a DAI
while other DAIs are still active.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 5399a0e..08af9f5 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -382,9 +382,6 @@ static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
-
-	/* disable AFE */
-	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
 }
 
 static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
@@ -433,9 +430,6 @@ static void mtk_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
 
 	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S3_M],
 				  afe->clocks[MTK_CLK_I2S3_B]);
-
-	/* disable AFE */
-	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
 }
 
 static int mtk_afe_hdmi_prepare(struct snd_pcm_substream *substream,
@@ -679,17 +673,6 @@ static int mtk_afe_dais_hw_free(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static int mtk_afe_dais_prepare(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-
-	/* enable AFE */
-	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
-	return 0;
-}
-
 static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
@@ -757,7 +740,6 @@ static const struct snd_soc_dai_ops mtk_afe_dai_ops = {
 	.shutdown	= mtk_afe_dais_shutdown,
 	.hw_params	= mtk_afe_dais_hw_params,
 	.hw_free	= mtk_afe_dais_hw_free,
-	.prepare	= mtk_afe_dais_prepare,
 	.trigger	= mtk_afe_dais_trigger,
 };
 
@@ -1118,6 +1100,9 @@ static int mtk_afe_runtime_suspend(struct device *dev)
 {
 	struct mtk_afe *afe = dev_get_drvdata(dev);
 
+	/* disable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
+
 	/* disable AFE clk */
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_AFE, AUD_TCON0_PDN_AFE);
@@ -1164,6 +1149,9 @@ static int mtk_afe_runtime_resume(struct device *dev)
 
 	/* unmask all IRQs */
 	regmap_update_bits(afe->regmap, AFE_IRQ_MCU_EN, 0xff, 0xff);
+
+	/* enable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
 	return 0;
 
 err_bck0:
-- 
1.7.9.5
