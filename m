From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 22 Aug 2017 23:35:54 +0800
Subject: [RESENT PATCH v6 7/8] ASoC: rockchip: Add support for DMIC codec
In-Reply-To: <20170822153555.20735-1-jeffy.chen@rock-chips.com>
References: <20170822153555.20735-1-jeffy.chen@rock-chips.com>
Message-ID: <20170822153555.20735-8-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for optional dmic codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6:
Add dmic wakeup delay(not used for now).

Changes in v5: None
Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/Kconfig            |  1 +
 sound/soc/rockchip/rk3399_gru_sound.c | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 8f0d0d8d34e6..b0825370d262 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -69,6 +69,7 @@ config SND_SOC_RK3399_GRU_SOUND
 	select SND_SOC_DA7219
 	select SND_SOC_RT5514_SPI
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_DMIC
 	help
 	  Say Y or M here if you want to add support multiple codecs for SoC
 	  audio on Rockchip RK3399 GRU boards.
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 91aab5c18f3b..5ab25962cabd 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -267,6 +267,28 @@ static int rockchip_sound_cdndp_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int rockchip_sound_dmic_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int mclk;
+	int ret;
+
+	mclk = params_rate(params) * SOUND_FS;
+
+	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, 0, mclk, 0);
+	if (ret) {
+		dev_err(rtd->card->dev, "%s() error setting sysclk to %u: %d\n",
+				__func__, mclk, ret);
+		return ret;
+	}
+
+	/* Wait for DMIC stable */
+	msleep(dmic_wakeup_delay);
+
+	return 0;
+}
+
 static const struct snd_soc_ops rockchip_sound_max98357a_ops = {
 	.hw_params = rockchip_sound_max98357a_hw_params,
 };
@@ -283,6 +305,10 @@ static struct snd_soc_ops rockchip_sound_cdndp_ops = {
 	.hw_params = rockchip_sound_cdndp_hw_params,
 };
 
+static struct snd_soc_ops rockchip_sound_dmic_ops = {
+	.hw_params = rockchip_sound_dmic_hw_params,
+};
+
 static struct snd_soc_card rockchip_sound_card = {
 	.name = "rk3399-gru-sound",
 	.owner = THIS_MODULE,
@@ -297,6 +323,7 @@ static struct snd_soc_card rockchip_sound_card = {
 enum {
 	DAILINK_CDNDP,
 	DAILINK_DA7219,
+	DAILINK_DMIC,
 	DAILINK_MAX98357A,
 	DAILINK_RT5514,
 	DAILINK_RT5514_DSP,
@@ -305,6 +332,7 @@ enum {
 static const char * const dailink_compat[] = {
 	[DAILINK_CDNDP] = "rockchip,rk3399-cdn-dp",
 	[DAILINK_DA7219] = "dlg,da7219",
+	[DAILINK_DMIC] = "dmic-codec",
 	[DAILINK_MAX98357A] = "maxim,max98357a",
 	[DAILINK_RT5514] = "realtek,rt5514-i2c",
 	[DAILINK_RT5514_DSP] = "realtek,rt5514-spi",
@@ -329,6 +357,14 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 	},
+	[DAILINK_DMIC] = {
+		.name = "DMIC",
+		.stream_name = "DMIC PCM",
+		.codec_dai_name = "dmic-hifi",
+		.ops = &rockchip_sound_dmic_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
 	[DAILINK_MAX98357A] = {
 		.name = "MAX98357A",
 		.stream_name = "MAX98357A PCM",
-- 
2.11.0
