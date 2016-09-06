From: zyw@rock-chips.com (Chris Zhong)
Date: Mon,  5 Sep 2016 21:48:55 -0700
Subject: [PATCH 2/2] ASoC: rockchip: Add DP dai-links to the rk3399-gru
 machine driver
In-Reply-To: <1473137335-14541-1-git-send-email-zyw@rock-chips.com>
References: <1473137335-14541-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1473137335-14541-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DP audio output support to the rk3300-gru machine
driver.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
hychao at chromium.org, broonie at kernel.org
---

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   | 13 +++---
 sound/soc/rockchip/rk3399_gru_sound.c              | 48 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index f19b6c8..222124b 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -1,15 +1,16 @@
-ROCKCHIP with MAX98357A/RT5514/DA7219 codecs on GRU boards
+ROCKCHIP with MAX98357A/RT5514/DA7219 codecs and DP via spdif on GRU boards
 
 Required properties:
 - compatible: "rockchip,rk3399-gru-sound"
-- rockchip,cpu: The phandle of the Rockchip I2S controller that's
-  connected to the codecs
-- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
+- rockchip,cpu: The phandle of the Rockchip I2S controller controller that's
+  connected to the codecs, and the SPDIF controller that's connected to DP
+- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs and of the
+  DP encoder node
 
 Example:
 
 sound {
 	compatible = "rockchip,rk3399-gru-sound";
-	rockchip,cpu = <&i2s0>;
-	rockchip,codec = <&max98357a &rt5514 &da7219>;
+	rockchip,cpu = <&i2s0 &spdif>;
+	rockchip,codec = <&max98357a &rt5514 &da7219 &cdn_dp 1>;
 };
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 164b6da..50e5d9a 100644
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
@@ -226,10 +227,30 @@ static struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
+static struct snd_soc_jack cdn_dp_card_jack;
+
+static int cdn_dp_init(struct snd_soc_pcm_runtime *runtime)
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
 enum {
 	DAILINK_MAX98357A,
 	DAILINK_RT5514,
 	DAILINK_DA7219,
+	DAILINK_CDNDP,
 	DAILINK_RT5514_DSP,
 };
 
@@ -264,6 +285,14 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 	},
+	[DAILINK_CDNDP] = {
+		.name = "DP",
+		.stream_name = "DP PCM",
+		.codec_dai_name = "spdif-hifi",
+		.init = cdn_dp_init,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
 	/* RT5514 DSP for voice wakeup via spi bus */
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
@@ -334,6 +363,25 @@ static int rockchip_sound_probe(struct platform_device *pdev)
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
