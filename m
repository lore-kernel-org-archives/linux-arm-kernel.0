From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Fri, 29 Apr 2016 21:00:47 +0800
Subject: [alsa-devel] [PATCH 6/7] ASoC: mediatek: add BT implementation
In-Reply-To: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1461934848-60011-7-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add BT implementation for mt2701 platform driver.

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 138 ++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 6cdc25e..88a6c1b 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -387,6 +387,86 @@ static int mt2701_afe_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mt2701_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_MRGIF, 0);
+
+	afe->mrg_enable[substream->stream] = 1;
+	return 0;
+}
+
+static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mt2701_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	int stream_fs;
+	u32 val, msk;
+
+	pr_debug("%s() cpu_dai id %d\n", __func__, dai->id);
+	stream_fs = params_rate(params);
+
+	if ((stream_fs != 8000) && (stream_fs != 16000)) {
+		pr_err("%s() btmgr not supprt this stream_fs %d\n",
+		       __func__, stream_fs);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(afe->regmap,
+			   AFE_MRGIF_CON,
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
+	regmap_write(afe->regmap, AFE_BT_SECURITY0, AFE_BT_SECURITY0_INIT_VAL);
+	regmap_write(afe->regmap, AFE_BT_SECURITY1, AFE_BT_SECURITY1_INIT_VAL);
+	regmap_update_bits(afe->regmap, AFE_DAIBT_CON0, AFE_DAIBT_CON0_DAIBT_EN,
+			   AFE_DAIBT_CON0_DAIBT_EN);
+	regmap_update_bits(afe->regmap, AFE_MRGIF_CON, AFE_MRGIF_CON_MRG_I2S_EN,
+			   AFE_MRGIF_CON_MRG_I2S_EN);
+	regmap_update_bits(afe->regmap, AFE_MRGIF_CON, AFE_MRGIF_CON_MRG_EN,
+			   AFE_MRGIF_CON_MRG_EN);
+	return 0;
+}
+
+static void mt2701_btmrg_shutdown(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mt2701_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+
+	pr_debug("%s() cpu_dai id %d\n", __func__, dai->id);
+	/* if the other direction stream is not occupied */
+	if (!afe->mrg_enable[!substream->stream]) {
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
+	afe->mrg_enable[substream->stream] = 0;
+}
+
 static int mt2701_playback_mem_avail(struct mt2701_afe *afe, int memif_num)
 {
 	struct mt2701_afe_memif *memif_tmp;
@@ -554,8 +634,12 @@ static int mt2701_afe_dais_hw_params(struct snd_pcm_substream *substream,
 	/* set rate */
 	if (memif->data->fs_shift < 0)
 		return 0;
+	if (rtd->cpu_dai->id != MT2701_MEMIF_BT ||
+	    stream_dir != SNDRV_PCM_STREAM_CAPTURE)
+		fs = mt2701_afe_i2s_fs(params_rate(params));
+	else
+		fs = (params_rate(params) == 16000) ? 1 : 0;
 
-	fs = mt2701_afe_i2s_fs(params_rate(params));
 	if (fs < 0)
 		return -EINVAL;
 
@@ -746,6 +830,13 @@ static const struct snd_soc_dai_ops mt2701_afe_i2s_ops = {
 	.set_fmt	= mt2701_afe_i2s_set_fmt,
 };
 
+/* MRG BE DAIs*/
+static struct snd_soc_dai_ops mt2701_btmrg_ops = {
+	.startup = mt2701_btmrg_startup,
+	.shutdown = mt2701_btmrg_shutdown,
+	.hw_params = mt2701_btmrg_hw_params,
+};
+
 static int mt2701_afe_runtime_suspend(struct device *dev);
 static int mt2701_afe_runtime_resume(struct device *dev);
 
@@ -845,6 +936,29 @@ static struct snd_soc_dai_driver mt2701_afe_pcm_dais[] = {
 		},
 		.ops = &mt2701_afe_dai_ops,
 	},
+	{
+		.name = "PCM_BT",
+		.id = MT2701_MEMIF_BT,
+		.suspend = mt2701_afe_dai_suspend,
+		.resume = mt2701_afe_dai_resume,
+		.playback = {
+			.stream_name = "DLBT",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = (SNDRV_PCM_RATE_8000
+				| SNDRV_PCM_RATE_16000),
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.stream_name = "ULBT",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = (SNDRV_PCM_RATE_8000
+				| SNDRV_PCM_RATE_16000),
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &mt2701_afe_dai_ops,
+	},
 	/* BE DAIs */
 	{
 		.name = "I2S0",
@@ -944,6 +1058,28 @@ static struct snd_soc_dai_driver mt2701_afe_pcm_dais[] = {
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
1.9.1
