From: broonie@kernel.org (Mark Brown)
Date: Tue, 05 Jul 2016 11:55:51 +0200
Subject: Applied "ASoC: mediatek: add BT implementation" to the asoc tree
In-Reply-To: <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <E1bKN55-0002TQ-SY@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: add BT implementation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4bdc8d452c18a5b4f439a1bffdda6789c4a6c606 Mon Sep 17 00:00:00 2001
From: Garlic Tseng <garlic.tseng@mediatek.com>
Date: Mon, 4 Jul 2016 18:56:27 +0800
Subject: [PATCH] ASoC: mediatek: add BT implementation

Add BT implementation for mt2701 platform driver.

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 139 +++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index c865ba13617c..6c14d686bfa1 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -333,6 +333,86 @@ static int mt2701_afe_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt2701_afe_private *afe_priv = afe->platform_priv;
+
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_MRGIF, 0);
+
+	afe_priv->mrg_enable[substream->stream] = 1;
+	return 0;
+}
+
+static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	int stream_fs;
+	u32 val, msk;
+
+	stream_fs = params_rate(params);
+
+	if ((stream_fs != 8000) && (stream_fs != 16000)) {
+		dev_err(afe->dev, "%s() btmgr not supprt this stream_fs %d\n",
+			__func__, stream_fs);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(afe->regmap, AFE_MRGIF_CON,
+			   AFE_MRGIF_CON_I2S_MODE_MASK,
+			   AFE_MRGIF_CON_I2S_MODE_32K);
+
+	val = AFE_DAIBT_CON0_BT_FUNC_EN | AFE_DAIBT_CON0_BT_FUNC_RDY
+	      | AFE_DAIBT_CON0_MRG_USE;
+	msk = val;
+
+	if (stream_fs == 16000)
+		val |= AFE_DAIBT_CON0_BT_WIDE_MODE_EN;
+
+	msk |= AFE_DAIBT_CON0_BT_WIDE_MODE_EN;
+
+	regmap_update_bits(afe->regmap, AFE_DAIBT_CON0, msk, val);
+
+	regmap_update_bits(afe->regmap, AFE_DAIBT_CON0,
+			   AFE_DAIBT_CON0_DAIBT_EN,
+			   AFE_DAIBT_CON0_DAIBT_EN);
+	regmap_update_bits(afe->regmap, AFE_MRGIF_CON,
+			   AFE_MRGIF_CON_MRG_I2S_EN,
+			   AFE_MRGIF_CON_MRG_I2S_EN);
+	regmap_update_bits(afe->regmap, AFE_MRGIF_CON,
+			   AFE_MRGIF_CON_MRG_EN,
+			   AFE_MRGIF_CON_MRG_EN);
+	return 0;
+}
+
+static void mt2701_btmrg_shutdown(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt2701_afe_private *afe_priv = afe->platform_priv;
+
+	/* if the other direction stream is not occupied */
+	if (!afe_priv->mrg_enable[!substream->stream]) {
+		regmap_update_bits(afe->regmap, AFE_DAIBT_CON0,
+				   AFE_DAIBT_CON0_DAIBT_EN, 0);
+		regmap_update_bits(afe->regmap, AFE_MRGIF_CON,
+				   AFE_MRGIF_CON_MRG_EN, 0);
+		regmap_update_bits(afe->regmap, AFE_MRGIF_CON,
+				   AFE_MRGIF_CON_MRG_I2S_EN, 0);
+		regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+				   AUDIO_TOP_CON4_PDN_MRGIF,
+				   AUDIO_TOP_CON4_PDN_MRGIF);
+	}
+	afe_priv->mrg_enable[substream->stream] = 0;
+}
+
 static int mt2701_simple_fe_startup(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
@@ -514,6 +594,13 @@ static const struct snd_soc_dai_ops mt2701_afe_i2s_ops = {
 	.set_sysclk	= mt2701_afe_i2s_set_sysclk,
 };
 
+/* MRG BE DAIs */
+static struct snd_soc_dai_ops mt2701_btmrg_ops = {
+	.startup = mt2701_btmrg_startup,
+	.shutdown = mt2701_btmrg_shutdown,
+	.hw_params = mt2701_btmrg_hw_params,
+};
+
 static struct snd_soc_dai_driver mt2701_afe_pcm_dais[] = {
 	/* FE DAIs: memory intefaces to CPU */
 	{
@@ -566,6 +653,36 @@ static struct snd_soc_dai_driver mt2701_afe_pcm_dais[] = {
 		},
 		.ops = &mt2701_single_memif_dai_ops,
 	},
+	{
+		.name = "PCM_BT_DL",
+		.id = MT2701_MEMIF_DLBT,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
+		.playback = {
+			.stream_name = "DLBT",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = (SNDRV_PCM_RATE_8000
+				| SNDRV_PCM_RATE_16000),
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &mt2701_single_memif_dai_ops,
+	},
+	{
+		.name = "PCM_BT_UL",
+		.id = MT2701_MEMIF_ULBT,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
+		.capture = {
+			.stream_name = "ULBT",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = (SNDRV_PCM_RATE_8000
+				| SNDRV_PCM_RATE_16000),
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &mt2701_single_memif_dai_ops,
+	},
 	/* BE DAIs */
 	{
 		.name = "I2S0",
@@ -665,6 +782,28 @@ static struct snd_soc_dai_driver mt2701_afe_pcm_dais[] = {
 		.ops = &mt2701_afe_i2s_ops,
 		.symmetric_rates = 1,
 	},
+	{
+		.name = "MRG BT",
+		.id = MT2701_IO_MRG,
+		.playback = {
+			.stream_name = "BT Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = (SNDRV_PCM_RATE_8000
+				| SNDRV_PCM_RATE_16000),
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.stream_name = "BT Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = (SNDRV_PCM_RATE_8000
+				| SNDRV_PCM_RATE_16000),
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &mt2701_btmrg_ops,
+		.symmetric_rates = 1,
+	}
 };
 
 static const struct snd_kcontrol_new mt2701_afe_o00_mix[] = {
-- 
2.8.1
