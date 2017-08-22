From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 22 Aug 2017 15:57:25 +0800
Subject: [PATCH v5 6/9] ASoC: rockchip: Parse dai links from dts
In-Reply-To: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Message-ID: <20170822075729.8438-7-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor rockchip_sound_probe, parse dai links from dts instead of
hard coding them.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
Use compatible to match audio codecs
        -- Suggested-by Matthias Kaehlcke <mka@chromium.org>

Changes in v2:
Let rockchip,codec-names be a required property, because we plan to
add more supported codecs to the fixed dai link list in the driver.

 sound/soc/rockchip/rk3399_gru_sound.c | 139 ++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 48 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 9b7e28703bfb..d532336871d7 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -235,14 +235,42 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
+static struct snd_soc_card rockchip_sound_card = {
+	.name = "rk3399-gru-sound",
+	.owner = THIS_MODULE,
+	.dapm_widgets = rockchip_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
+	.dapm_routes = rockchip_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rockchip_dapm_routes),
+	.controls = rockchip_controls,
+	.num_controls = ARRAY_SIZE(rockchip_controls),
+};
+
 enum {
+	DAILINK_DA7219,
 	DAILINK_MAX98357A,
 	DAILINK_RT5514,
-	DAILINK_DA7219,
 	DAILINK_RT5514_DSP,
 };
 
-static struct snd_soc_dai_link rockchip_dailinks[] = {
+static const char * const dailink_compat[] = {
+	[DAILINK_DA7219] = "dlg,da7219",
+	[DAILINK_MAX98357A] = "maxim,max98357a",
+	[DAILINK_RT5514] = "realtek,rt5514-i2c",
+	[DAILINK_RT5514_DSP] = "realtek,rt5514-spi",
+};
+
+static const struct snd_soc_dai_link rockchip_dais[] = {
+	[DAILINK_DA7219] = {
+		.name = "DA7219",
+		.stream_name = "DA7219 PCM",
+		.codec_dai_name = "da7219-hifi",
+		.init = rockchip_sound_da7219_init,
+		.ops = &rockchip_sound_da7219_ops,
+		/* set da7219 as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
 	[DAILINK_MAX98357A] = {
 		.name = "MAX98357A",
 		.stream_name = "MAX98357A PCM",
@@ -261,16 +289,6 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 	},
-	[DAILINK_DA7219] = {
-		.name = "DA7219",
-		.stream_name = "DA7219 PCM",
-		.codec_dai_name = "da7219-hifi",
-		.init = rockchip_sound_da7219_init,
-		.ops = &rockchip_sound_da7219_ops,
-		/* set da7219 as slave */
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-	},
 	/* RT5514 DSP for voice wakeup via spi bus */
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
@@ -279,53 +297,78 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 	},
 };
 
-static struct snd_soc_card rockchip_sound_card = {
-	.name = "rk3399-gru-sound",
-	.owner = THIS_MODULE,
-	.dai_link = rockchip_dailinks,
-	.num_links =  ARRAY_SIZE(rockchip_dailinks),
-	.dapm_widgets = rockchip_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
-	.dapm_routes = rockchip_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(rockchip_dapm_routes),
-	.controls = rockchip_controls,
-	.num_controls = ARRAY_SIZE(rockchip_controls),
-};
-
-static int rockchip_sound_probe(struct platform_device *pdev)
+static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 {
-	struct snd_soc_card *card = &rockchip_sound_card;
-	struct device_node *cpu_node;
-	int i, ret;
+	int i;
 
-	cpu_node = of_parse_phandle(pdev->dev.of_node, "rockchip,cpu", 0);
-	if (!cpu_node) {
-		dev_err(&pdev->dev, "Property 'rockchip,cpu' missing or invalid\n");
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(dailink_compat); i++) {
+		if (of_device_is_compatible(np_codec, dailink_compat[i]))
+			return i;
 	}
+	return -1;
+}
 
-	for (i = 0; i < ARRAY_SIZE(rockchip_dailinks); i++) {
-		rockchip_dailinks[i].platform_of_node = cpu_node;
-		rockchip_dailinks[i].cpu_of_node = cpu_node;
-
-		rockchip_dailinks[i].codec_of_node =
-			of_parse_phandle(pdev->dev.of_node, "rockchip,codec", i);
-		if (!rockchip_dailinks[i].codec_of_node) {
-			dev_err(&pdev->dev,
-				"Property[%d] 'rockchip,codec' missing or invalid\n", i);
+static int rockchip_sound_of_parse_dais(struct device *dev,
+					struct snd_soc_card *card)
+{
+	struct device_node *np_cpu;
+	struct device_node *np_codec;
+	struct snd_soc_dai_link *dai;
+	int i, index;
+
+	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
+				      GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	np_cpu = of_parse_phandle(dev->of_node, "rockchip,cpu", 0);
+
+	card->num_links = 0;
+	for (i = 0; i < ARRAY_SIZE(rockchip_dais); i++) {
+		np_codec = of_parse_phandle(dev->of_node,
+					    "rockchip,codec", i);
+		if (!np_codec)
+			break;
+
+		if (!of_device_is_available(np_codec))
+			continue;
+
+		index = rockchip_sound_codec_node_match(np_codec);
+		if (index < 0)
+			continue;
+
+		if (!np_cpu) {
+			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
+				rockchip_dais[index].name);
 			return -EINVAL;
 		}
+
+		dai = &card->dai_link[card->num_links++];
+		*dai = rockchip_dais[index];
+
+		dai->codec_of_node = np_codec;
+		dai->platform_of_node = np_cpu;
+		dai->cpu_of_node = np_cpu;
+	}
+
+	return 0;
+}
+
+static int rockchip_sound_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &rockchip_sound_card;
+	int ret;
+
+	ret = rockchip_sound_of_parse_dais(&pdev->dev, card);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to parse dais: %d\n", ret);
+		return ret;
 	}
 
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-			__func__, ret);
-
-	return ret;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 static const struct of_device_id rockchip_sound_of_match[] = {
-- 
2.11.0
