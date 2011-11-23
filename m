From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:25 -0700
Subject: [PATCH 17/17] ASoC: Tegra+WM8903 machine: Add device tree binding
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-18-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Bonesio <bones@secretlab.ca>

This driver is parameterized in two ways:

a) Platform data, which supplies a set of GPIOs used by the driver.
   These GPIOs can now be parsed out of device tree.

b) Machine-specific DAPM route arrays embedded into the ASoC machine
   driver itself. The driver picks the appropriate array to use using
   machine_is_*(). This array can now be parsed straight out of device
   tree, allowing the machine driver to be completely machine agnostic.

swarren applied the following modifications:
* Moved all pdata and DT parsing into one place.
* Added DAPM route parsing from DT.
* Added tegra_pcm device registration.
* Documented DT binding.

Signed-off-by: John Bonesio <bones@secretlab.ca>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../bindings/sound/tegra-audio-wm8903.txt          |   63 +++++++++
 sound/soc/tegra/tegra_wm8903.c                     |  133 ++++++++++++++++----
 2 files changed, 171 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt

diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
new file mode 100644
index 0000000..f22bdf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
@@ -0,0 +1,63 @@
+NVIDIA Tegra audio complex
+
+Required properties:
+- compatible : "nvidia,tegra-audio-wm8903"
+- nvidia,routing : A list of the connections between audio components. Each
+  entry is a pair of strings, the first being the connection's sink, the
+  second being the connection's source pin. Valid names for sources and sinks
+  are the WM8903's pins, and the connectors on the board:
+
+  WM8903 pins:
+
+  * IN1L
+  * IN1R
+  * IN2L
+  * IN2R
+  * IN3L
+  * IN3R
+  * DMICDAT
+  * HPOUTL
+  * HPOUTR
+  * LINEOUTL
+  * LINEOUTR
+  * LOP
+  * LON
+  * ROP
+  * RON
+  * Mic Bias
+
+  Board connectors:
+
+  * Headphone Jack
+  * Int Spk
+  * Mic Jack
+
+Optional properties:
+- nvidia,spkr-en-gpios : The GPIO that enables the speakers
+- nvidia,hp-mute-gpios : The GPIO that mutes the headphones
+- nvidia,hp-det-gpios : The GPIO that detect headphones are plugged in
+- nvidia,int-mic-en-gpios : The GPIO that enables the internal microphone
+- nvidia,ext-mic-en-gpios : The GPIO that enables the external microphone
+
+Example:
+
+sound {
+	compatible = "nvidia,tegra-audio-wm8903-seaboard",
+		     "nvidia,tegra-audio-wm8903";
+
+	nvidia,spkr-en-gpios = <&codec 2 0>;
+	nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+	nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+	nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+	nvidia,routing =
+		"Headphone Jack", "HPOUTR",
+		"Headphone Jack", "HPOUTL",
+		"Int Spk", "ROP",
+		"Int Spk", "RON",
+		"Int Spk", "LOP",
+		"Int Spk", "LON",
+		"Mic Bias", "Mic Jack",
+		"IN1R", "Mic Bias";
+};
+
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 8791c69..b3abf32 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <mach/tegra_wm8903_pdata.h>
 
@@ -59,8 +60,9 @@
 #define GPIO_HP_DET     BIT(4)
 
 struct tegra_wm8903 {
+	struct tegra_wm8903_platform_data pdata;
+	struct platform_device *pcm_dev;
 	struct tegra_asoc_utils_data util_data;
-	struct tegra_wm8903_platform_data *pdata;
 	int gpio_requested;
 };
 
@@ -160,7 +162,7 @@ static int tegra_wm8903_event_int_spk(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
-	struct tegra_wm8903_platform_data *pdata = machine->pdata;
+	struct tegra_wm8903_platform_data *pdata = &machine->pdata;
 
 	if (!(machine->gpio_requested & GPIO_SPKR_EN))
 		return 0;
@@ -177,7 +179,7 @@ static int tegra_wm8903_event_hp(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
-	struct tegra_wm8903_platform_data *pdata = machine->pdata;
+	struct tegra_wm8903_platform_data *pdata = &machine->pdata;
 
 	if (!(machine->gpio_requested & GPIO_HP_MUTE))
 		return 0;
@@ -246,8 +248,10 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_card *card = codec->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
-	struct tegra_wm8903_platform_data *pdata = machine->pdata;
-	int ret;
+	struct tegra_wm8903_platform_data *pdata;
+	struct device_node *np;
+	struct snd_soc_dapm_route *routes;
+	int ret, i;
 
 	ret = tegra_das_connect_dap_to_dac(TEGRA_DAS_DAP_ID_1,
 					   TEGRA_DAS_DAP_SEL_DAC1);
@@ -262,6 +266,83 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	pdata = &machine->pdata;
+	np = card->dev->of_node;
+
+	if (card->dev->platform_data) {
+		*pdata = *(struct tegra_wm8903_platform_data *)
+						card->dev->platform_data;
+	} else if (np) {
+		/*
+		 * This part must be in init() rather than probe() in order to
+		 * guarantee that the WM8903 has been probed, and hence its
+		 * GPIO controller registered, which is a pre-condition for
+		 * of_get_named_gpio() to be able to map the phandles in the
+		 * properties to the controller node. Given this, all
+		 * pdata & OF handling is in init() for consistency.
+		 */
+		pdata->gpio_spkr_en = of_get_named_gpio(np,
+						"nvidia,spkr-en-gpios", 0);
+		pdata->gpio_hp_mute = of_get_named_gpio(np,
+						"nvidia,hp-mute-gpios", 0);
+		pdata->gpio_hp_det = of_get_named_gpio(np,
+						"nvidia,hp-det-gpios", 0);
+		pdata->gpio_int_mic_en = of_get_named_gpio(np,
+						"nvidia,int-mic-en-gpios", 0);
+		pdata->gpio_ext_mic_en = of_get_named_gpio(np,
+						"nvidia,ext-mic-en-gpios", 0);
+	} else {
+		dev_err(card->dev, "No platform data supplied\n");
+		return -EINVAL;
+	}
+
+	if (np) {
+		card->num_dapm_routes =
+			of_property_count_strings(np, "nvidia,routing");
+		if (card->num_dapm_routes & 1) {
+			dev_err(card->dev,
+				"Property 'nvidia,routing's length is odd\n");
+			return -EINVAL;
+		}
+		card->num_dapm_routes /= 2;
+		if (!card->num_dapm_routes) {
+			dev_err(card->dev,
+				"Property 'nvidia,routing' is zero length\n");
+			return -EINVAL;
+		}
+
+		routes = devm_kzalloc(card->dev,
+			card->num_dapm_routes * sizeof(*card->dapm_routes),
+			GFP_KERNEL);
+		if (!routes) {
+			dev_err(card->dev,
+				"Could not allocate DAPM route table\n");
+			return -EINVAL;
+		}
+		card->dapm_routes = routes;
+
+		for (i = 0; i < card->num_dapm_routes; i++) {
+			of_property_read_string_index(np, "nvidia,routing",
+				2 * i, &routes[i].sink);
+			of_property_read_string_index(np, "nvidia,routing",
+				(2 * i) + 1, &routes[i].source);
+		}
+	} else {
+		if (machine_is_harmony()) {
+			card->dapm_routes = harmony_audio_map;
+			card->num_dapm_routes = ARRAY_SIZE(harmony_audio_map);
+		} else if (machine_is_seaboard()) {
+			card->dapm_routes = seaboard_audio_map;
+			card->num_dapm_routes = ARRAY_SIZE(seaboard_audio_map);
+		} else if (machine_is_kaen()) {
+			card->dapm_routes = kaen_audio_map;
+			card->num_dapm_routes = ARRAY_SIZE(kaen_audio_map);
+		} else {
+			card->dapm_routes = aebl_audio_map;
+			card->num_dapm_routes = ARRAY_SIZE(aebl_audio_map);
+		}
+	}
+
 	if (gpio_is_valid(pdata->gpio_spkr_en)) {
 		ret = gpio_request(pdata->gpio_spkr_en, "spkr_en");
 		if (ret) {
@@ -361,11 +442,9 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_tegra_wm8903;
 	struct tegra_wm8903 *machine;
-	struct tegra_wm8903_platform_data *pdata;
 	int ret;
 
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
+	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
 		dev_err(&pdev->dev, "No platform data supplied\n");
 		return -EINVAL;
 	}
@@ -378,30 +457,24 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	machine->pdata = pdata;
+	if (pdev->dev.of_node) {
+		machine->pcm_dev = platform_device_register_simple(
+					"tegra-pcm-audio", -1, NULL, 0);
+		if (IS_ERR(machine->pcm_dev)) {
+			dev_err(&pdev->dev, "Can't instantiate ASoC DMA\n");
+			ret = PTR_ERR(machine->pcm_dev);
+			goto err;
+		}
+	}
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_unregister;
 
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 
-	if (machine_is_harmony()) {
-		card->dapm_routes = harmony_audio_map;
-		card->num_dapm_routes = ARRAY_SIZE(harmony_audio_map);
-	} else if (machine_is_seaboard()) {
-		card->dapm_routes = seaboard_audio_map;
-		card->num_dapm_routes = ARRAY_SIZE(seaboard_audio_map);
-	} else if (machine_is_kaen()) {
-		card->dapm_routes = kaen_audio_map;
-		card->num_dapm_routes = ARRAY_SIZE(kaen_audio_map);
-	} else {
-		card->dapm_routes = aebl_audio_map;
-		card->num_dapm_routes = ARRAY_SIZE(aebl_audio_map);
-	}
-
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
@@ -413,6 +486,8 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&machine->util_data);
+err_unregister:
+	platform_device_unregister(machine->pcm_dev);
 err:
 	return ret;
 }
@@ -421,7 +496,7 @@ static int __devexit tegra_wm8903_driver_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
-	struct tegra_wm8903_platform_data *pdata = machine->pdata;
+	struct tegra_wm8903_platform_data *pdata = &machine->pdata;
 
 	if (machine->gpio_requested & GPIO_HP_DET)
 		snd_soc_jack_free_gpios(&tegra_wm8903_hp_jack,
@@ -440,15 +515,22 @@ static int __devexit tegra_wm8903_driver_remove(struct platform_device *pdev)
 	snd_soc_unregister_card(card);
 
 	tegra_asoc_utils_fini(&machine->util_data);
+	platform_device_unregister(machine->pcm_dev);
 
 	return 0;
 }
 
+static const struct of_device_id tegra_wm8903_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,tegra-audio-wm8903", },
+	{},
+};
+
 static struct platform_driver tegra_wm8903_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
+		.of_match_table = tegra_wm8903_of_match,
 	},
 	.probe = tegra_wm8903_driver_probe,
 	.remove = __devexit_p(tegra_wm8903_driver_remove),
@@ -459,3 +541,4 @@ MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra+WM8903 machine ASoC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, tegra_wm8903_of_match);
-- 
1.7.0.4
