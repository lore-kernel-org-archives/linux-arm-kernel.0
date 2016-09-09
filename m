From: zyw@rock-chips.com (Chris Zhong)
Date: Thu,  8 Sep 2016 21:43:55 -0700
Subject: [PATCH v3 2/2] ASoC: rockchip: Add DP dai-links to the rk3399-gru
 machine driver
In-Reply-To: <1473181792-15398-1-git-send-email-zyw@rock-chips.com>
References: <1473181792-15398-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1473396235-11769-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DP audio output support to the rk3399-gru machine
driver.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v3:
- change spdif to i2s2

Changes in v2:
- correct the commit message

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   | 11 +--
 sound/soc/rockchip/rk3399_gru_sound.c              | 93 ++++++++++++++++++++++
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index f19b6c8..83af540 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -1,15 +1,16 @@
-ROCKCHIP with MAX98357A/RT5514/DA7219 codecs on GRU boards
+ROCKCHIP with MAX98357A/RT5514/DA7219 codecs and DP via spdif on GRU boards
 
 Required properties:
 - compatible: "rockchip,rk3399-gru-sound"
-- rockchip,cpu: The phandle of the Rockchip I2S controller that's
+- rockchip,cpu: The phandle of the Rockchip I2S controller controller that's
   connected to the codecs
-- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
+- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs and of the
+  DP encoder node
 
 Example:
 
 sound {
 	compatible = "rockchip,rk3399-gru-sound";
-	rockchip,cpu = <&i2s0>;
-	rockchip,codec = <&max98357a &rt5514 &da7219>;
+	rockchip,cpu = <&i2s0 &i2s2>;
+	rockchip,codec = <&max98357a &rt5514 &da7219 &cdn_dp>;
 };
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 164b6da..d9aa2e0 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
+#include <sound/hdmi-codec.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -214,6 +215,65 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+
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
+static struct snd_soc_jack cdn_dp_card_jack;
+
+static int rockchip_sound_cdndp_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_codec *codec = runtime->codec;
+	int ret;
+
+	/* enable jack detection */
+	ret = snd_soc_card_jack_new(card, "DP Jack", SND_JACK_LINEOUT,
+				    &cdn_dp_card_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't new DP Jack %d\n", ret);
+		return ret;
+	}
+
+	return hdmi_codec_set_jack_detect(codec, &cdn_dp_card_jack);
+}
+
 static struct snd_soc_ops rockchip_sound_max98357a_ops = {
 	.hw_params = rockchip_sound_max98357a_hw_params,
 };
@@ -226,10 +286,15 @@ static struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
+static struct snd_soc_ops rockchip_sound_cdndp_ops = {
+	.hw_params = rockchip_sound_cdndp_hw_params,
+};
+
 enum {
 	DAILINK_MAX98357A,
 	DAILINK_RT5514,
 	DAILINK_DA7219,
+	DAILINK_CDNDP,
 	DAILINK_RT5514_DSP,
 };
 
@@ -264,6 +329,15 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 	},
+	[DAILINK_CDNDP] = {
+		.name = "DP",
+		.stream_name = "DP PCM",
+		.codec_dai_name = "i2s-hifi",
+		.init = rockchip_sound_cdndp_init,
+		.ops = &rockchip_sound_cdndp_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
 	/* RT5514 DSP for voice wakeup via spi bus */
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
@@ -334,6 +408,25 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	cpu_node = of_parse_phandle(pdev->dev.of_node, "rockchip,cpu", 1);
+	if (!cpu_node) {
+		dev_err(&pdev->dev, "Property 'rockchip,cpu 1' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	rockchip_dailinks[DAILINK_CDNDP].platform_of_node = cpu_node;
+	rockchip_dailinks[DAILINK_CDNDP].cpu_of_node = cpu_node;
+
+	rockchip_dailinks[DAILINK_CDNDP].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "rockchip,codec",
+				 DAILINK_CDNDP);
+	if (!rockchip_dailinks[DAILINK_CDNDP].codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property[%d] 'rockchip,codec' missing or invalid\n",
+			DAILINK_CDNDP);
+		return -EINVAL;
+	}
+
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-- 
1.9.1
