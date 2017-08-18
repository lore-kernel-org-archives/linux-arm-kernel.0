From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 11:11:45 +0800
Subject: [PATCH v4 7/9] ASoC: rockchip: Add support for DP codec
In-Reply-To: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Message-ID: <20170818031147.16810-8-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for optional cdn dp codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/Kconfig            |  1 +
 sound/soc/rockchip/rk3399_gru_sound.c | 59 +++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index c84487805876..8f0d0d8d34e6 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -68,6 +68,7 @@ config SND_SOC_RK3399_GRU_SOUND
 	select SND_SOC_RT5514
 	select SND_SOC_DA7219
 	select SND_SOC_RT5514_SPI
+	select SND_SOC_HDMI_CODEC
 	help
 	  Say Y or M here if you want to add support multiple codecs for SoC
 	  audio on Rockchip RK3399 GRU boards.
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index d532336871d7..8ffae1934b94 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -223,6 +223,45 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int rockchip_sound_cdndp_hw_params(struct snd_pcm_substream *substream,
+					  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int mclk, ret;
+
+	/* in bypass mode, the mclk has to be one of the frequencies below */
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 48000:
+	case 64000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set cpu clock out %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_ops rockchip_sound_max98357a_ops = {
 	.hw_params = rockchip_sound_max98357a_hw_params,
 };
@@ -235,6 +274,10 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
+static struct snd_soc_ops rockchip_sound_cdndp_ops = {
+	.hw_params = rockchip_sound_cdndp_hw_params,
+};
+
 static struct snd_soc_card rockchip_sound_card = {
 	.name = "rk3399-gru-sound",
 	.owner = THIS_MODULE,
@@ -247,6 +290,7 @@ static struct snd_soc_card rockchip_sound_card = {
 };
 
 enum {
+	DAILINK_CDNDP,
 	DAILINK_DA7219,
 	DAILINK_MAX98357A,
 	DAILINK_RT5514,
@@ -254,6 +298,7 @@ enum {
 };
 
 static const char * const dailink_compat[] = {
+	[DAILINK_CDNDP] = "rockchip,rk3399-cdn-dp",
 	[DAILINK_DA7219] = "dlg,da7219",
 	[DAILINK_MAX98357A] = "maxim,max98357a",
 	[DAILINK_RT5514] = "realtek,rt5514-i2c",
@@ -261,6 +306,14 @@ static const char * const dailink_compat[] = {
 };
 
 static const struct snd_soc_dai_link rockchip_dais[] = {
+	[DAILINK_CDNDP] = {
+		.name = "DP",
+		.stream_name = "DP PCM",
+		.codec_dai_name = "i2s-hifi",
+		.ops = &rockchip_sound_cdndp_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
 	[DAILINK_DA7219] = {
 		.name = "DA7219",
 		.stream_name = "DA7219 PCM",
@@ -311,7 +364,7 @@ static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 static int rockchip_sound_of_parse_dais(struct device *dev,
 					struct snd_soc_card *card)
 {
-	struct device_node *np_cpu;
+	struct device_node *np_cpu, *np_cpu0, *np_cpu1;
 	struct device_node *np_codec;
 	struct snd_soc_dai_link *dai;
 	int i, index;
@@ -321,7 +374,8 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 	if (!card->dai_link)
 		return -ENOMEM;
 
-	np_cpu = of_parse_phandle(dev->of_node, "rockchip,cpu", 0);
+	np_cpu0 = of_parse_phandle(dev->of_node, "rockchip,cpu", 0);
+	np_cpu1 = of_parse_phandle(dev->of_node, "rockchip,cpu", 1);
 
 	card->num_links = 0;
 	for (i = 0; i < ARRAY_SIZE(rockchip_dais); i++) {
@@ -337,6 +391,7 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		if (index < 0)
 			continue;
 
+		np_cpu = (index == DAILINK_CDNDP) ? np_cpu1 : np_cpu0;
 		if (!np_cpu) {
 			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
 				rockchip_dais[index].name);
-- 
2.11.0
