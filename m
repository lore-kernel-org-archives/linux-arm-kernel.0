From: krishna.md@samsung.com (Krishna Mohan Dani)
Date: Mon, 27 Oct 2014 11:41:09 +0530
Subject: [PATCH 2/4] Sound: Samsung: Add sound card machine driver for Arndale
 Board
In-Reply-To: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
References: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
Message-ID: <1414390271-25040-3-git-send-email-krishna.md@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding machine driver to instantiate I2S based realtek's ALC5631
sound card on Arndale board.

There are other variants of Audio Daughter Cards for Arndale
Board for which support already exists but there is no support for
Realtek's alc5631 codec hence support for ALC5631 based machine
driver is being added.

Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
---
 sound/soc/samsung/Kconfig          |    6 ++
 sound/soc/samsung/Makefile         |    2 +
 sound/soc/samsung/arndale_rt5631.c |  167 ++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 sound/soc/samsung/arndale_rt5631.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 55a3869..b6134aa 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -239,3 +239,9 @@ config SND_SOC_ODROIDX2
 	select SND_SAMSUNG_I2S
 	help
 	  Say Y here to enable audio support for the Odroid-X2/U3.
+
+config SND_SOC_ARNDALE_RT5631
+        tristate "Audio support for RT5631(ALC5631) on Arndale Board"
+        depends on SND_SOC_SAMSUNG
+        select SND_SAMSUNG_I2S
+        select SND_SOC_RT5631
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 91505dd..656e64d 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -45,6 +45,7 @@ snd-soc-lowland-objs := lowland.o
 snd-soc-littlemill-objs := littlemill.o
 snd-soc-bells-objs := bells.o
 snd-soc-odroidx2-max98090-objs := odroidx2_max98090.o
+snd-soc-arndale-rt5631-objs := arndale_rt5631.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -71,3 +72,4 @@ obj-$(CONFIG_SND_SOC_LOWLAND) += snd-soc-lowland.o
 obj-$(CONFIG_SND_SOC_LITTLEMILL) += snd-soc-littlemill.o
 obj-$(CONFIG_SND_SOC_BELLS) += snd-soc-bells.o
 obj-$(CONFIG_SND_SOC_ODROIDX2) += snd-soc-odroidx2-max98090.o
+obj-$(CONFIG_SND_SOC_ARNDALE_RT5631) += snd-soc-arndale-rt5631.o
diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
new file mode 100644
index 0000000..2697af7
--- /dev/null
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -0,0 +1,167 @@
+/*
+ *  arndale_rt5631.c
+ *
+ *  Copyright (c) 2014, Insignal Co., Ltd.
+ *
+ *  Author: Claude <claude@insginal.co.kr>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "i2s.h"
+
+static int arndale_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int bfs, psr, rfs, ret;
+	unsigned long rclk;
+
+	bfs = 32;
+
+	rfs = 256;
+
+	rclk = params_rate(params) * rfs;
+
+	psr = 4;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
+					0, SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_RCLKSRC_0,
+					0, SND_SOC_CLOCK_OUT);
+
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, rclk, SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops arndale_ops = {
+	.hw_params = arndale_hw_params,
+};
+
+static int arndale_alc5631_init_paiftx(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link arndale_dai[] = {
+	{
+		.name = "RT5631 HiFi",
+		.stream_name = "Primary",
+		.codec_dai_name = "rt5631-hifi",
+		.init = arndale_alc5631_init_paiftx,
+		.dai_fmt = SND_SOC_DAIFMT_I2S
+			| SND_SOC_DAIFMT_NB_NF
+			| SND_SOC_DAIFMT_CBS_CFS,
+		.ops = &arndale_ops,
+	},
+};
+
+static struct snd_soc_card arndale = {
+	.name = "Arndale-I2S",
+	.dai_link = arndale_dai,
+	.num_links = ARRAY_SIZE(arndale_dai),
+};
+
+static int arndale_audio_probe(struct platform_device *pdev)
+{
+	int n, ret;
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_card *card = &arndale;
+
+	card->dev = &pdev->dev;
+
+	for (n = 0; np && n < ARRAY_SIZE(arndale_dai); n++) {
+		if (!arndale_dai[n].cpu_dai_name) {
+			arndale_dai[n].cpu_of_node = of_parse_phandle(np,
+					"samsung,audio-cpu", n);
+
+			if (!arndale_dai[n].cpu_of_node) {
+				dev_err(&pdev->dev,
+				"Property 'samsung,audio-cpu' missing or invalid\n");
+				ret = -EINVAL;
+			}
+		}
+		if (!arndale_dai[n].platform_name)
+			arndale_dai[n].platform_of_node =
+						arndale_dai[n].cpu_of_node;
+
+		arndale_dai[n].codec_name = NULL;
+		arndale_dai[n].codec_of_node = of_parse_phandle(np,
+					"samsung,audio-codec", n);
+		if (!arndale_dai[0].codec_of_node) {
+			dev_err(&pdev->dev,
+			"Property 'samsung,audio-codec' missing or invalid\n");
+			ret = -EINVAL;
+		}
+	}
+
+	ret = snd_soc_register_card(card);
+
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed:%d\n", ret);
+
+	return ret;
+}
+
+static int arndale_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id samsung_arndale_rt5631_of_match[] = {
+	{ .compatible = "samsung,arndale-rt5631", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, samsung_arndale_rt5631_of_match);
+#endif /* CONFIG_OF */
+
+static struct platform_driver arndale_audio_driver = {
+	.driver = {
+		.name   = "arndale-audio",
+		.owner  = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = of_match_ptr(samsung_arndale_rt5631_of_match),
+	},
+	.probe = arndale_audio_probe,
+	.remove = arndale_audio_remove,
+};
+
+module_platform_driver(arndale_audio_driver);
+
+MODULE_AUTHOR("Claude <claude@insignal.co.kr>");
+MODULE_DESCRIPTION("ALSA SoC Driver for Arndale Board");
+MODULE_LICENSE("GPL");
+
-- 
1.7.9.5
