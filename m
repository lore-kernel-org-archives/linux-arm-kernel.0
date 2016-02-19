From: pc.liao@mediatek.com (PC Liao)
Date: Fri, 19 Feb 2016 10:35:59 +0800
Subject: [PATCH] ASoC: mediatek: Add machine driver for ALC5650 codec
Message-ID: <1455849359-14581-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koro Chen <koro.chen@mediatek.com>

This is the DPCM based machine driver with rt5650

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |   15 ++
 sound/soc/mediatek/Kconfig                         |   10 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt8173-rt5650.c                 |  236 ++++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
 create mode 100644 sound/soc/mediatek/mt8173-rt5650.c

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
new file mode 100644
index 0000000..fe5a5ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -0,0 +1,15 @@
+MT8173 with RT5650 CODECS
+
+Required properties:
+- compatible : "mediatek,mt8173-rt5650"
+- mediatek,audio-codec: the phandles of rt5650 codecs
+- mediatek,platform: the phandle of MT8173 ASoC platform
+
+Example:
+
+	sound {
+		compatible = "mediatek,mt8173-rt5650";
+		mediatek,audio-codec = <&rt5650>;
+		mediatek,platform = <&afe>;
+	};
+
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 9769676..6c88087 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -17,6 +17,16 @@ config SND_SOC_MT8173_MAX98090
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT8173_RT5650
+        tristate "ASoC Audio driver for MT8173 with RT5650 codec"
+        depends on SND_SOC_MEDIATEK && I2C
+        select SND_SOC_RT5645
+        help
+          This adds ASoC driver for Mediatek MT8173 boards
+          with the RT5650 audio codec.
+          Select Y if you have such device.
+          If unsure select "N".
+
 config SND_SOC_MT8173_RT5650_RT5676
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5676 codecs"
 	depends on SND_SOC_MEDIATEK && I2C
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 75effbe..bcdcb06 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
 # Machine support
 obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
 obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
new file mode 100644
index 0000000..bb09bb1
--- /dev/null
+++ b/sound/soc/mediatek/mt8173-rt5650.c
@@ -0,0 +1,236 @@
+/*
+ * mt8173-rt5650.c  --  MT8173 machine driver with RT5650 codecs
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Koro Chen <koro.chen@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../codecs/rt5645.h"
+
+#define MCLK_FOR_CODECS		12288000
+
+static const struct snd_soc_dapm_widget mt8173_rt5650_widgets[] = {
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route mt8173_rt5650_routes[] = {
+	{"Speaker", NULL, "SPOL"},
+	{"Speaker", NULL, "SPOR"},
+	{"DMIC L1", NULL, "Int Mic"},
+	{"DMIC R1", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Headset Mic", NULL, "micbias1"},
+	{"Headset Mic", NULL, "micbias2"},
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN1N", NULL, "Headset Mic"},
+};
+
+static const struct snd_kcontrol_new mt8173_rt5650_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static int mt8173_rt5650_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		/* pll from mclk 12.288M */
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, MCLK_FOR_CODECS,
+					  params_rate(params) * 512);
+		if (ret)
+			return ret;
+
+		/* sysclk from pll */
+		ret = snd_soc_dai_set_sysclk(codec_dai, 1,
+					     params_rate(params) * 512,
+					     SND_SOC_CLOCK_IN);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static struct snd_soc_ops mt8173_rt5650_ops = {
+	.hw_params = mt8173_rt5650_hw_params,
+};
+
+static struct snd_soc_jack mt8173_rt5650_jack;
+
+static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_codec *codec = runtime->codec_dais[0]->codec;
+	int ret;
+
+	rt5645_sel_asrc_clk_src(codec,
+				RT5645_DA_STEREO_FILTER |
+				RT5645_AD_STEREO_FILTER,
+				RT5645_CLK_SEL_I2S1_ASRC);
+	/* enable jack detection */
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &mt8173_rt5650_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
+		return ret;
+	}
+
+	return rt5645_set_jack_detect(codec,
+				      &mt8173_rt5650_jack,
+				      &mt8173_rt5650_jack,
+				      &mt8173_rt5650_jack);
+}
+
+static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
+	{
+		.dai_name = "rt5645-aif1",
+	},
+};
+
+enum {
+	DAI_LINK_PLAYBACK,
+	DAI_LINK_CAPTURE,
+	DAI_LINK_CODEC_I2S,
+};
+
+/* Digital audio interface glue - connects codec <---> CPU */
+static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
+	/* Front End DAI links */
+	[DAI_LINK_PLAYBACK] = {
+		.name = "rt5650 Playback",
+		.stream_name = "rt5650 Playback",
+		.cpu_dai_name = "DL1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
+	[DAI_LINK_CAPTURE] = {
+		.name = "rt5650 Capture",
+		.stream_name = "rt5650 Capture",
+		.cpu_dai_name = "VUL",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+	},
+	/* Back End DAI links */
+	[DAI_LINK_CODEC_I2S] = {
+		.name = "Codec",
+		.cpu_dai_name = "I2S",
+		.no_pcm = 1,
+		.codecs = mt8173_rt5650_codecs,
+		.num_codecs = 1,
+		.init = mt8173_rt5650_init,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
+		.ops = &mt8173_rt5650_ops,
+		.ignore_pmdown_time = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+};
+
+static struct snd_soc_card mt8173_rt5650_card = {
+	.name = "mtk-rt5650",
+	.owner = THIS_MODULE,
+	.dai_link = mt8173_rt5650_dais,
+	.num_links = ARRAY_SIZE(mt8173_rt5650_dais),
+	.controls = mt8173_rt5650_controls,
+	.num_controls = ARRAY_SIZE(mt8173_rt5650_controls),
+	.dapm_widgets = mt8173_rt5650_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8173_rt5650_widgets),
+	.dapm_routes = mt8173_rt5650_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8173_rt5650_routes),
+};
+
+static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt8173_rt5650_card;
+	struct device_node *platform_node;
+	int i, ret;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < card->num_links; i++) {
+		if (mt8173_rt5650_dais[i].platform_name)
+			continue;
+		mt8173_rt5650_dais[i].platform_of_node = platform_node;
+	}
+
+	mt8173_rt5650_codecs[0].of_node =
+		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 0);
+	if (!mt8173_rt5650_codecs[0].of_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+			__func__, ret);
+	return ret;
+}
+
+static const struct of_device_id mt8173_rt5650_dt_match[] = {
+	{ .compatible = "mediatek,mt8173-rt5650", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mt8173_rt5650_dt_match);
+
+static struct platform_driver mt8173_rt5650_driver = {
+	.driver = {
+		   .name = "mtk-rt5650",
+		   .of_match_table = mt8173_rt5650_dt_match,
+#ifdef CONFIG_PM
+		   .pm = &snd_soc_pm_ops,
+#endif
+	},
+	.probe = mt8173_rt5650_dev_probe,
+};
+
+module_platform_driver(mt8173_rt5650_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT8173 RT5650 SoC machine driver");
+MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mtk-rt5650");
+
-- 
1.7.9.5
