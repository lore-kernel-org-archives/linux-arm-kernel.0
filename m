From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 31 Aug 2013 12:44:37 +0200
Subject: [PATCH 2/3] ASoC: generic simple sound card DT bindings
In-Reply-To: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
References: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1377945878-13322-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simple sound card initialized using DT. When used with AC97, ac97-codec
is used to automatically discover the used codec.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../bindings/sound/generic,simple-dt-card.txt      |  28 +++
 sound/soc/generic/Kconfig                          |   1 +
 sound/soc/generic/simple-card.c                    | 195 +++++++++++++++++++--
 3 files changed, 206 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt

diff --git a/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
new file mode 100644
index 0000000..6b41dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
@@ -0,0 +1,28 @@
+ASoC Simple Sound Card
+
+A simple generic driver that connects a CPU DAI with a CODEC.
+
+Required properties:
+ - compatible: "asoc-simple-card" used for standard ssi, codec
+   combinations, or "asoc-simple-ac97-card" to use ac97 to discover the
+   codec.
+ - cpu-dai: CPU DAI connected to the codec.
+
+Required properties for "asoc-simple-card":
+ - audio-codec: Codec phandle.
+ - codec-dai-name: DAI name within the codec.
+
+Examples:
+
+sound {
+	compatible = "asoc-simple-card";
+	cpu-dai = <&ssi1>;
+	audio-codec = <&wm9712>;
+};
+
+For AC97:
+
+sound {
+	compatible = "asoc-simple-ac97-card";
+	cpu-dai = <&ssi1>;
+};
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 610f612..8718ac6 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -1,4 +1,5 @@
 config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
+	select SND_SOC_AC97_BUS
 	help
 	  This option enables generic simple sound card support
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 63cbf3e..9c9c080 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -11,15 +11,141 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <sound/simple_card.h>
 
-#define asoc_simple_get_card_info(p) \
-	container_of(p->dai_link, struct asoc_simple_card_info, snd_link)
 struct asoc_simple_card_data {
 	struct snd_soc_dai_link snd_link;
 	struct snd_soc_card snd_card;
+
+	struct device_node *cpu_np;
+	struct device_node *codec_np;
+	struct platform_device *ac97_codec;
+};
+
+static struct snd_soc_dai_link simple_ac97_dt_card_dai = {
+	.name		= "HiFi",
+	.stream_name	= "HiFi",
+	.codec_dai_name	= "ac97-hifi",
+	.codec_name	= "ac97-codec",
+};
+
+static const struct snd_soc_card simple_ac97_dt_card = {
+	.name		= "ASoC simple AC97 sound card",
+	.owner		= THIS_MODULE,
+};
+
+static struct snd_soc_dai_link simple_dt_card_dai = {
+	.name		= "simple-link",
+	.stream_name	= "simple-link",
+};
+
+static const struct snd_soc_card simple_dt_card = {
+	.name		= "ASoC simple sound card",
+	.owner		= THIS_MODULE,
 };
 
+enum asoc_simple_card_type {
+	SIMPLE_CARD,
+	SIMPLE_CARD_AC97,
+};
+
+static const struct of_device_id asoc_simple_card_of_dev_ids[] = {
+	{
+		.compatible = "asoc-simple-card",
+		.data = (void *)SIMPLE_CARD,
+	}, {
+		.compatible = "asoc-simple-ac97-card",
+		.data = (void *)SIMPLE_CARD_AC97,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, asoc_simple_card_of_dev_ids);
+
+static int asoc_simple_card_dt_probe(struct platform_device *pdev,
+		struct asoc_simple_card_data *priv)
+{
+	const struct of_device_id *of_id = of_match_device(
+			asoc_simple_card_of_dev_ids, &pdev->dev);
+	enum asoc_simple_card_type type =
+			(enum asoc_simple_card_type)of_id->data;
+	int ret;
+
+	priv->cpu_np = of_parse_phandle(pdev->dev.of_node, "cpu-dai", 0);
+	if (!priv->cpu_np) {
+		dev_err(&pdev->dev, "No valid CPU DAI phandle found\n");
+		return -EINVAL;
+	}
+
+	if (type == SIMPLE_CARD_AC97) {
+		struct platform_device *ac97_codec;
+		memcpy(&priv->snd_card, &simple_ac97_dt_card,
+				sizeof(simple_ac97_dt_card));
+		memcpy(&priv->snd_link, &simple_ac97_dt_card_dai,
+				sizeof(simple_ac97_dt_card_dai));
+
+		ac97_codec = platform_device_register_simple("ac97-codec", -1,
+				NULL, 0);
+		if (IS_ERR(ac97_codec)) {
+			dev_err(&pdev->dev, "Failed to register ac97-codec device\n");
+			ret = PTR_ERR(priv->ac97_codec);
+			goto err;
+		}
+		priv->ac97_codec = ac97_codec;
+	} else {
+		priv->codec_np = of_parse_phandle(pdev->dev.of_node,
+				"audio-codec", 0);
+		if (!priv->codec_np) {
+			dev_err(&pdev->dev, "No valid codec phandle found\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		memcpy(&priv->snd_link, &simple_dt_card_dai,
+				sizeof(simple_dt_card_dai));
+		memcpy(&priv->snd_card, &simple_dt_card,
+				sizeof(simple_dt_card));
+		priv->snd_link.codec_of_node = priv->codec_np;
+
+		ret = of_property_read_string(pdev->dev.of_node,
+				"codec-dai-name", &priv->snd_link.stream_name);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to parse codec-dai-name string\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	priv->snd_link.cpu_of_node = priv->cpu_np;
+	priv->snd_link.platform_of_node = priv->cpu_np;
+
+	return 0;
+
+err:
+	if (priv->cpu_np)
+		of_node_put(priv->cpu_np);
+	if (priv->codec_np)
+		of_node_put(priv->codec_np);
+	if (priv->ac97_codec)
+		platform_device_unregister(priv->ac97_codec);
+	return ret;
+}
+
+static int asoc_simple_card_dt_remove(struct platform_device *pdev,
+		struct asoc_simple_card_data *priv)
+{
+	if (priv->cpu_np)
+		of_node_put(priv->cpu_np);
+	if (priv->codec_np)
+		of_node_put(priv->codec_np);
+	if (priv->ac97_codec)
+		platform_device_unregister(priv->ac97_codec);
+
+	return 0;
+}
+
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set,
 				       unsigned int daifmt)
@@ -57,21 +183,10 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int asoc_simple_card_probe(struct platform_device *pdev)
+static int asoc_simple_card_pdata_probe(struct device *dev,
+		struct asoc_simple_card_info *cinfo,
+		struct asoc_simple_card_data *priv)
 {
-	struct asoc_simple_card_info *cinfo = pdev->dev.platform_data;
-	struct asoc_simple_card_data *priv;
-	struct device *dev = &pdev->dev;
-
-	if (!cinfo) {
-		dev_err(dev, "no info for asoc-simple-card\n");
-		return -EINVAL;
-	}
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	if (!cinfo->name	||
 	    !cinfo->card	||
 	    !cinfo->codec	||
@@ -97,6 +212,28 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	 * init snd_soc_card
 	 */
 	priv->snd_card.name		= cinfo->card;
+
+	return 0;
+}
+
+static int asoc_simple_card_probe(struct platform_device *pdev)
+{
+	struct asoc_simple_card_info *cinfo = pdev->dev.platform_data;
+	struct asoc_simple_card_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (cinfo)
+		ret = asoc_simple_card_pdata_probe(&pdev->dev, cinfo, priv);
+	else
+		ret = asoc_simple_card_dt_probe(pdev, priv);
+
+	if (ret)
+		return ret;
+
 	priv->snd_card.owner		= THIS_MODULE;
 	priv->snd_card.dai_link		= &priv->snd_link;
 	priv->snd_card.num_links	= 1;
@@ -104,19 +241,40 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-	return snd_soc_register_card(&priv->snd_card);
+	ret = snd_soc_register_card(&priv->snd_card);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register soc card\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	if (priv->cpu_np)
+		of_node_put(priv->cpu_np);
+	if (priv->codec_np)
+		of_node_put(priv->codec_np);
+	if (priv->ac97_codec)
+		platform_device_unregister(priv->ac97_codec);
+	return ret;
 }
 
 static int asoc_simple_card_remove(struct platform_device *pdev)
 {
 	struct asoc_simple_card_data *priv = dev_get_drvdata(&pdev->dev);
 
-	return snd_soc_unregister_card(&priv->snd_card);
+	snd_soc_unregister_card(&priv->snd_card);
+
+	if (!pdev->dev.platform_data)
+		asoc_simple_card_dt_remove(pdev, priv);
+
+	return 0;
 }
 
 static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name	= "asoc-simple-card",
+		.owner	= THIS_MODULE,
+		.of_match_table = asoc_simple_card_of_dev_ids,
 	},
 	.probe		= asoc_simple_card_probe,
 	.remove		= asoc_simple_card_remove,
@@ -127,3 +285,4 @@ module_platform_driver(asoc_simple_card);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ASoC Simple Sound Card");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
-- 
1.8.4.rc3
