From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:57 +0200
Subject: [RFC PATCH 15/16] tegra-max98090: Use devm_resource
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-16-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 sound/soc/tegra/tegra_max98090.c | 69 +++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index 902da36581d1..e5767559aae7 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -41,8 +41,10 @@
 
 struct tegra_max98090 {
 	struct tegra_asoc_utils_data util_data;
-	int gpio_hp_det;
-	int gpio_mic_det;
+	struct gpio_desc *gpio_hp_det;
+	struct gpio_desc *gpio_mic_det;
+	struct fwnode_handle *codec_node;
+	struct fwnode_handle *cpu_node;
 };
 
 static int tegra_max98090_asoc_hw_params(struct snd_pcm_substream *substream,
@@ -147,27 +149,29 @@ static int tegra_max98090_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
 
-	if (gpio_is_valid(machine->gpio_hp_det)) {
+	if (machine->gpio_hp_det) {
 		snd_soc_card_jack_new(rtd->card, "Headphones",
 				      SND_JACK_HEADPHONE,
 				      &tegra_max98090_hp_jack,
 				      tegra_max98090_hp_jack_pins,
 				      ARRAY_SIZE(tegra_max98090_hp_jack_pins));
 
-		tegra_max98090_hp_jack_gpio.gpio = machine->gpio_hp_det;
+		tegra_max98090_hp_jack_gpio.gpio =
+			desc_to_gpio(machine->gpio_hp_det);
 		snd_soc_jack_add_gpios(&tegra_max98090_hp_jack,
 					1,
 					&tegra_max98090_hp_jack_gpio);
 	}
 
-	if (gpio_is_valid(machine->gpio_mic_det)) {
+	if (machine->gpio_mic_det) {
 		snd_soc_card_jack_new(rtd->card, "Mic Jack",
 				      SND_JACK_MICROPHONE,
 				      &tegra_max98090_mic_jack,
 				      tegra_max98090_mic_jack_pins,
 				      ARRAY_SIZE(tegra_max98090_mic_jack_pins));
 
-		tegra_max98090_mic_jack_gpio.gpio = machine->gpio_mic_det;
+		tegra_max98090_mic_jack_gpio.gpio =
+			desc_to_gpio(machine->gpio_mic_det);
 		snd_soc_jack_add_gpios(&tegra_max98090_mic_jack,
 				       1,
 				       &tegra_max98090_mic_jack_gpio);
@@ -180,12 +184,12 @@ static int tegra_max98090_card_remove(struct snd_soc_card *card)
 {
 	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(card);
 
-	if (gpio_is_valid(machine->gpio_hp_det)) {
+	if (machine->gpio_hp_det) {
 		snd_soc_jack_free_gpios(&tegra_max98090_hp_jack, 1,
 					&tegra_max98090_hp_jack_gpio);
 	}
 
-	if (gpio_is_valid(machine->gpio_mic_det)) {
+	if (machine->gpio_mic_det) {
 		snd_soc_jack_free_gpios(&tegra_max98090_mic_jack, 1,
 					&tegra_max98090_mic_jack_gpio);
 	}
@@ -218,31 +222,14 @@ static struct snd_soc_card snd_soc_tegra_max98090 = {
 
 static int tegra_max98090_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct snd_soc_card *card = &snd_soc_tegra_max98090;
-	struct tegra_max98090 *machine;
+	struct tegra_max98090 *machine = platform_get_drvdata(pdev);
 	int ret;
 
-	machine = devm_kzalloc(&pdev->dev,
-			sizeof(struct tegra_max98090), GFP_KERNEL);
-	if (!machine) {
-		dev_err(&pdev->dev, "Can't allocate tegra_max98090\n");
-		return -ENOMEM;
-	}
-
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 
-	machine->gpio_hp_det = of_get_named_gpio(np, "nvidia,hp-det-gpios", 0);
-	if (machine->gpio_hp_det == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	machine->gpio_mic_det =
-			of_get_named_gpio(np, "nvidia,mic-det-gpios", 0);
-	if (machine->gpio_mic_det == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
 	ret = snd_soc_of_parse_card_name(card, "nvidia,model");
 	if (ret)
 		goto err;
@@ -251,24 +238,8 @@ static int tegra_max98090_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	tegra_max98090_dai.codec_of_node = of_parse_phandle(np,
-			"nvidia,audio-codec", 0);
-	if (!tegra_max98090_dai.codec_of_node) {
-		dev_err(&pdev->dev,
-			"Property 'nvidia,audio-codec' missing or invalid\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	tegra_max98090_dai.cpu_of_node = of_parse_phandle(np,
-			"nvidia,i2s-controller", 0);
-	if (!tegra_max98090_dai.cpu_of_node) {
-		dev_err(&pdev->dev,
-			"Property 'nvidia,i2s-controller' missing or invalid\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
+	tegra_max98090_dai.codec_of_node = to_of_node(machine->codec_node);
+	tegra_max98090_dai.cpu_of_node = to_of_node(machine->cpu_node);
 	tegra_max98090_dai.platform_of_node = tegra_max98090_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
@@ -307,11 +278,21 @@ static const struct of_device_id tegra_max98090_of_match[] = {
 	{},
 };
 
+static const struct devm_resource tegra_max98090_resources[] = {
+	DEVM_ALLOC(tegra_max98090),
+	DEVM_GPIO_NAMED(tegra_max98090, gpio_hp_det, "nvidia,hp-det"),
+	DEVM_GPIO_NAMED(tegra_max98090, gpio_mic_det, "nvidia,mic-det"),
+	DEVM_FWNODE(tegra_max98090, codec_node, "nvidia,audio-codec"),
+	DEVM_FWNODE(tegra_max98090, cpu_node, "nvidia,i2s-controller"),
+	{},
+};
+
 static struct platform_driver tegra_max98090_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = tegra_max98090_of_match,
+		.resources = tegra_max98090_resources,
 	},
 	.probe = tegra_max98090_probe,
 	.remove = tegra_max98090_remove,
-- 
2.4.3
