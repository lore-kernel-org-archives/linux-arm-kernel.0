From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 18 Sep 2017 19:18:01 +0800
Subject: [RESEND PATCH v2 3/3] ASoC: rockchip: Init dapm routes dynamically
In-Reply-To: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
References: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
Message-ID: <20170918111801.12881-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are using a fixed list of dapm routes.

Init dapm routes dynamically when parsing dailinks, since we are
supporting optional codecs.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
Fix DMic typo.

 sound/soc/rockchip/rk3399_gru_sound.c | 88 ++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index ad19e391c4a6..fab868850d3a 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -50,20 +50,6 @@ static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
 	SND_SOC_DAPM_LINE("HDMI", NULL),
 };
 
-static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
-	/* Input Lines */
-	{"MIC", NULL, "Headset Mic"},
-	{"DMIC1L", NULL, "Int Mic"},
-	{"DMIC1R", NULL, "Int Mic"},
-	{"DMic", NULL, "Int Mic"},
-
-	/* Output Lines */
-	{"Headphones", NULL, "HPL"},
-	{"Headphones", NULL, "HPR"},
-	{"Speakers", NULL, "Speaker"},
-	{"HDMI", NULL, "TX"},
-};
-
 static const struct snd_kcontrol_new rockchip_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Speakers"),
@@ -318,8 +304,6 @@ static struct snd_soc_card rockchip_sound_card = {
 	.owner = THIS_MODULE,
 	.dapm_widgets = rockchip_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
-	.dapm_routes = rockchip_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(rockchip_dapm_routes),
 	.controls = rockchip_controls,
 	.num_controls = ARRAY_SIZE(rockchip_controls),
 };
@@ -395,6 +379,65 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	},
 };
 
+static const struct snd_soc_dapm_route rockchip_sound_cdndp_routes[] = {
+	/* Output */
+	{"HDMI", NULL, "TX"},
+};
+
+static const struct snd_soc_dapm_route rockchip_sound_da7219_routes[] = {
+	/* Output */
+	{"Headphones", NULL, "HPL"},
+	{"Headphones", NULL, "HPR"},
+
+	/* Input */
+	{"MIC", NULL, "Headset Mic"},
+};
+
+static const struct snd_soc_dapm_route rockchip_sound_dmic_routes[] = {
+	/* Input */
+	{"DMic", NULL, "Int Mic"},
+};
+
+static const struct snd_soc_dapm_route rockchip_sound_max98357a_routes[] = {
+	/* Output */
+	{"Speakers", NULL, "Speaker"},
+};
+
+static const struct snd_soc_dapm_route rockchip_sound_rt5514_routes[] = {
+	/* Input */
+	{"DMIC1L", NULL, "Int Mic"},
+	{"DMIC1R", NULL, "Int Mic"},
+};
+
+struct rockchip_sound_route {
+	const struct snd_soc_dapm_route *routes;
+	int num_routes;
+};
+
+static const struct rockchip_sound_route rockchip_routes[] = {
+	[DAILINK_CDNDP] = {
+		.routes = rockchip_sound_cdndp_routes,
+		.num_routes = ARRAY_SIZE(rockchip_sound_cdndp_routes),
+	},
+	[DAILINK_DA7219] = {
+		.routes = rockchip_sound_da7219_routes,
+		.num_routes = ARRAY_SIZE(rockchip_sound_da7219_routes),
+	},
+	[DAILINK_DMIC] = {
+		.routes = rockchip_sound_dmic_routes,
+		.num_routes = ARRAY_SIZE(rockchip_sound_dmic_routes),
+	},
+	[DAILINK_MAX98357A] = {
+		.routes = rockchip_sound_max98357a_routes,
+		.num_routes = ARRAY_SIZE(rockchip_sound_max98357a_routes),
+	},
+	[DAILINK_RT5514] = {
+		.routes = rockchip_sound_rt5514_routes,
+		.num_routes = ARRAY_SIZE(rockchip_sound_rt5514_routes),
+	},
+	[DAILINK_RT5514_DSP] = {},
+};
+
 static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 {
 	int i;
@@ -412,6 +455,7 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 	struct device_node *np_cpu, *np_cpu0, *np_cpu1;
 	struct device_node *np_codec;
 	struct snd_soc_dai_link *dai;
+	struct snd_soc_dapm_route *routes;
 	int i, index;
 
 	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
@@ -419,9 +463,16 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 	if (!card->dai_link)
 		return -ENOMEM;
 
+	routes = devm_kzalloc(dev, sizeof(rockchip_routes),
+			      GFP_KERNEL);
+	if (!routes)
+		return -ENOMEM;
+	card->dapm_routes = routes;
+
 	np_cpu0 = of_parse_phandle(dev->of_node, "rockchip,cpu", 0);
 	np_cpu1 = of_parse_phandle(dev->of_node, "rockchip,cpu", 1);
 
+	card->num_dapm_routes = 0;
 	card->num_links = 0;
 	for (i = 0; i < ARRAY_SIZE(rockchip_dais); i++) {
 		np_codec = of_parse_phandle(dev->of_node,
@@ -449,6 +500,11 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		dai->codec_of_node = np_codec;
 		dai->platform_of_node = np_cpu;
 		dai->cpu_of_node = np_cpu;
+
+		memcpy(routes + card->num_dapm_routes,
+		       rockchip_routes[index].routes,
+		       rockchip_routes[index].num_routes * sizeof(*routes));
+		card->num_dapm_routes += rockchip_routes[index].num_routes;
 	}
 
 	return 0;
-- 
2.11.0
