From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 22 May 2014 13:55:08 +0200
Subject: [PATCH 2/2] ASoC: samsung: Add machine driver for odroidx2
In-Reply-To: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
References: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1400759708-25831-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Zhen <zhen1.chen@samsung.com>

This machine driver primary defines the audio path, the supported
data formats and sample frequency.
The codec works in I2S master mode, in order to achieve required
exact audio sampling frequencies without a need to adjust the EPLL
frequency to each sample rate at runtime.

Signed-off-by: Chen Zhen <zhen1.chen@samsung.com>
[s.nawrocki at samsung.com: coding style changes, fixed of_match table name]
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
The only bits missing for v3.16 for audio on the Odroid X2/U3 to work
now seem to be only my clock defaults setting patches [1] and the related
dts updates.

[1] http://www.spinics.net/lists/devicetree/msg34718.html

 sound/soc/samsung/Kconfig             |    8 ++
 sound/soc/samsung/Makefile            |    2 +
 sound/soc/samsung/odroidx2_max98090.c |  150 +++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 sound/soc/samsung/odroidx2_max98090.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index f2e2891..aa5ce7c 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -231,3 +231,11 @@ config SND_SOC_LITTLEMILL
 	select SND_SAMSUNG_I2S
 	select MFD_WM8994
 	select SND_SOC_WM8994
+
+config SND_SOC_ODROIDX2
+	tristate "Audio support for Odroid-X2 and Odroid-U3"
+	depends on SND_SOC_SAMSUNG
+	select SND_SOC_MAX98090
+	select SND_SAMSUNG_I2S
+	help
+	  Say Y here to enable audio support for the Odroid-X2/U3.
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 86715d8..db89489 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -45,6 +45,7 @@ snd-soc-tobermory-objs := tobermory.o
 snd-soc-lowland-objs := lowland.o
 snd-soc-littlemill-objs := littlemill.o
 snd-soc-bells-objs := bells.o
+snd-soc-odroidx2-max98090-objs := odroidx2_max98090.o

 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -69,3 +70,4 @@ obj-$(CONFIG_SND_SOC_TOBERMORY) += snd-soc-tobermory.o
 obj-$(CONFIG_SND_SOC_LOWLAND) += snd-soc-lowland.o
 obj-$(CONFIG_SND_SOC_LITTLEMILL) += snd-soc-littlemill.o
 obj-$(CONFIG_SND_SOC_BELLS) += snd-soc-bells.o
+obj-$(CONFIG_SND_SOC_ODROIDX2) += snd-soc-odroidx2-max98090.o
diff --git a/sound/soc/samsung/odroidx2_max98090.c b/sound/soc/samsung/odroidx2_max98090.c
new file mode 100644
index 0000000..c3065a9
--- /dev/null
+++ b/sound/soc/samsung/odroidx2_max98090.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/of.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include "i2s.h"
+#include "i2s-regs.h"
+
+/* The I2S CDCLK output clock frequency to the MAX98090 codec. */
+#define MAX98090_MCLK_FREQ 19200000
+
+static int odroidx2_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+					| SND_SOC_DAIFMT_NB_NF
+					| SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+					| SND_SOC_DAIFMT_NB_NF
+					| SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 3, MAX98090_MCLK_FREQ,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev,
+			"Unable to switch to FLL1: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
+					0, MOD_OPCLK_PCLK);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev,
+			"Unable to set i2s opclk: 0x%x\n", ret);
+		return ret;
+	}
+
+	/* Set the cpu DAI configuration in order to use CDCLK */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
+					0, SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(codec_dai->dev,
+		"HiFi DAI %s params: channel %d, rate %d as I2S slave\n",
+		((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		 "playback" : "capture"),  params_channels(params),
+		params_rate(params));
+
+	return 0;
+}
+
+static struct snd_soc_ops odroidx2_ops = {
+	.hw_params	= odroidx2_hw_params,
+};
+
+static struct snd_soc_dai_link odroidx2_dai = {
+	.name		= "MAX98090",
+	.stream_name	= "MAX98090 PCM",
+	.codec_dai_name	= "HiFi",
+	.ops		= &odroidx2_ops,
+};
+
+static struct snd_soc_card odroidx2 = {
+	.name		= "odroidx2",
+	.owner		= THIS_MODULE,
+	.dai_link	= &odroidx2_dai,
+	.num_links	= 1,
+};
+
+static int odroidx2_audio_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_card *card = &odroidx2;
+
+	if (!np)
+		return -ENODEV;
+
+	card->dev = &pdev->dev;
+
+	odroidx2_dai.codec_name = NULL;
+	odroidx2_dai.codec_of_node = of_parse_phandle(np,
+						"samsung,audio-codec", 0);
+	if (!odroidx2_dai.codec_of_node) {
+		dev_err(&pdev->dev,
+			"missing or invalid samsung,audio-codec property\n");
+		return -EINVAL;
+	}
+
+	odroidx2_dai.cpu_name = NULL;
+	odroidx2_dai.cpu_of_node = of_parse_phandle(np,
+						"samsung,i2s-controller", 0);
+	if (!odroidx2_dai.cpu_of_node) {
+		dev_err(&pdev->dev,
+			"missing or invalid samsung,i2s-controller property\n");
+		return -EINVAL;
+	}
+
+	odroidx2_dai.platform_of_node = odroidx2_dai.cpu_of_node;
+
+	return snd_soc_register_card(card);
+}
+
+static int odroidx2_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static const struct of_device_id odroidx2_audio_of_match[] = {
+	{ .compatible = "samsung,odroidx2-audio" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, odroidx2_audio_of_match);
+
+static struct platform_driver odroidx2_audio_driver = {
+	.driver = {
+		.name		= "odroidx2-audio",
+		.owner		= THIS_MODULE,
+		.of_match_table	= odroidx2_audio_of_match,
+	},
+	.probe	= odroidx2_audio_probe,
+	.remove	= odroidx2_audio_remove,
+};
+module_platform_driver(odroidx2_audio_driver);
+
+MODULE_AUTHOR("zhen1.chen at samsung.com");
+MODULE_DESCRIPTION("ALSA SoC Odroidx2 Audio Support");
+MODULE_LICENSE("GPL v2");
--
1.7.9.5
