From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:05:56 +0200
Subject: [PATCH v11 3/8] ASoC: generic: simple DT sound card
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simple sound card initialized using DT. When used with AC97, ac97-codec
is used to automatically discover the used codec.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../bindings/sound/generic,simple-dt-card.txt      |  28 ++++
 sound/soc/generic/Kconfig                          |   1 +
 sound/soc/generic/Makefile                         |   3 +-
 sound/soc/generic/simple-dt-card.c                 | 186 +++++++++++++++++++++
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
 create mode 100644 sound/soc/generic/simple-dt-card.c

diff --git a/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
new file mode 100644
index 0000000..189d754
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
@@ -0,0 +1,28 @@
+Simple DT card
+
+A simple generic driver that connects a CPU DAI with a CODEC.
+
+Required properties:
+ - compatible: "asoc-simple-dt-card" used for standard ssi, codec
+   combinations, or "asoc-simple-ac97-dt-card" to use ac97 to discover the
+   codec.
+ - cpu-dai: CPU DAI connected to the codec.
+
+Required properties for "asoc-simple-dt-card":
+ - audio-codec: Codec phandle.
+ - codec-dai-name: DAI name within the codec.
+
+Examples:
+
+sound {
+	compatible = "asoc-simple-dt-card";
+	cpu-dai = <&ssi1>;
+	audio-codec = <&wm9712>;
+};
+
+For AC97:
+
+sound {
+	compatible = "asoc-simple-ac97-dt-card";
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
diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
index 9c3b246..9ccf864 100644
--- a/sound/soc/generic/Makefile
+++ b/sound/soc/generic/Makefile
@@ -1,3 +1,4 @@
 snd-soc-simple-card-objs	:= simple-card.o
+snd-soc-simple-dt-card-objs	:= simple-dt-card.o
 
-obj-$(CONFIG_SND_SIMPLE_CARD)	+= snd-soc-simple-card.o
+obj-$(CONFIG_SND_SIMPLE_CARD)	+= snd-soc-simple-card.o snd-soc-simple-dt-card.o
diff --git a/sound/soc/generic/simple-dt-card.c b/sound/soc/generic/simple-dt-card.c
new file mode 100644
index 0000000..532be0f
--- /dev/null
+++ b/sound/soc/generic/simple-dt-card.c
@@ -0,0 +1,186 @@
+/*
+ * phycore-ac97-dt.c  --  SoC audio for imx_phycore in AC97 mode
+ *
+ * Copyright 2013 Markus Pargmann, Pengutronix <mpa@pengutronix.de>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+struct simple_dt_card_data {
+	struct snd_soc_dai_link link;
+	struct snd_soc_card card;
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
+	.name		= "ASoC simple AC97 DT card",
+	.owner		= THIS_MODULE,
+};
+
+static struct snd_soc_dai_link simple_dt_card_dai = {
+	.name		= "simple-link",
+	.stream_name	= "simple-link",
+};
+
+static const struct snd_soc_card simple_dt_card = {
+	.name		= "ASoC simple DT card",
+	.owner		= THIS_MODULE,
+};
+
+enum simple_dt_card_type {
+	SIMPLE_CARD,
+	SIMPLE_CARD_AC97,
+};
+
+static const struct of_device_id simple_dt_card_of_dev_ids[] = {
+	{
+		.compatible = "asoc-simple-dt-card",
+		.data = (void *)SIMPLE_CARD,
+	}, {
+		.compatible = "asoc-simple-ac97-dt-card",
+		.data = (void *)SIMPLE_CARD_AC97,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, simple_dt_card_of_dev_id);
+
+static int simple_dt_card_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+			of_match_device(simple_dt_card_of_dev_ids, &pdev->dev);
+	enum simple_dt_card_type type = (enum simple_dt_card_type)of_id->data;
+	int ret;
+	struct simple_dt_card_data *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->card.dev = &pdev->dev;
+
+	priv->cpu_np = of_parse_phandle(pdev->dev.of_node, "cpu-dai", 0);
+	if (!priv->cpu_np) {
+		dev_err(&pdev->dev, "No valid CPU DAI phandle found\n");
+		return -EINVAL;
+	}
+
+	if (type == SIMPLE_CARD_AC97) {
+		struct platform_device *ac97_codec;
+		memcpy(&priv->card, &simple_ac97_dt_card,
+				sizeof(simple_ac97_dt_card));
+		memcpy(&priv->link, &simple_ac97_dt_card_dai,
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
+		memcpy(&priv->link, &simple_dt_card_dai,
+				sizeof(simple_dt_card_dai));
+		memcpy(&priv->card, &simple_dt_card, sizeof(simple_dt_card));
+		priv->link.codec_of_node = priv->codec_np;
+
+		ret = of_property_read_string(pdev->dev.of_node,
+				"codec-dai-name", &priv->link.stream_name);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to parse codec-dai-name string\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	priv->link.cpu_of_node = priv->cpu_np;
+	priv->link.platform_of_node = priv->cpu_np;
+
+	priv->card.dai_link = &priv->link;
+	priv->card.num_links = 1;
+	priv->card.dev = &pdev->dev;
+
+	ret = snd_soc_register_card(&priv->card);
+	if (ret) {
+		dev_err(&pdev->dev, "ASoC: soc card registration failed\n");
+		goto err;
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
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
+static int simple_dt_card_remove(struct platform_device *pdev)
+{
+	struct simple_dt_card_data *priv = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_card(&priv->card);
+
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
+static struct platform_driver simple_dt_card_driver = {
+	.probe		= simple_dt_card_probe,
+	.remove		= simple_dt_card_remove,
+	.driver		= {
+		.name	= "asoc-simple-dt-card",
+		.owner	= THIS_MODULE,
+		.of_match_table = simple_dt_card_of_dev_ids,
+	},
+};
+
+module_platform_driver(simple_dt_card_driver);
+
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_DESCRIPTION("ASoC Simple DT Sound Card");
+MODULE_LICENSE("GPL");
-- 
1.8.4.rc3
