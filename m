From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:21 +0100
Subject: [PATCH 07/12] add phycore sound support
In-Reply-To: <1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/phycore.c |  181 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/imx/phycore.c

diff --git a/sound/soc/imx/phycore.c b/sound/soc/imx/phycore.c
new file mode 100644
index 0000000..35e5875
--- /dev/null
+++ b/sound/soc/imx/phycore.c
@@ -0,0 +1,181 @@
+/*
+ * phycore.c  --  SoC audio for imx_phycore
+ *
+ * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-types.h>
+
+#include "../codecs/mc13783.h"
+#include "../codecs/wm9712.h"
+#include "imx-ssi.h"
+
+static struct snd_soc_card imx_phycore;
+
+static int imx_phycore_hifi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret = 0;
+
+	/* set cpu DAI configuration */
+	if (machine_is_pcm038() || machine_is_pcm037()) {
+		snd_soc_dai_set_fmt(cpu_dai,
+				SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			snd_soc_dai_set_fmt(codec_dai,
+				SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM);
+		} else {
+			snd_soc_dai_set_fmt(codec_dai,
+				SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM);
+			snd_soc_dai_set_tdm_slot(codec_dai, 0, 0, 4, 0);
+		}
+		snd_soc_dai_set_sysclk(codec_dai, MC13783_CLK_CLIA, 26000000, 0);
+
+		/* Put DC field of STCCR to 1 (not zero) */
+		ret = cpu_dai->ops->set_tdm_slot(cpu_dai, 0x0, 0xfffffffc, 4, 0);
+	}
+	if (ret < 0) {
+		printk(KERN_ERR "Error from cpu DAI configuration\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int imx_phycore_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static struct snd_soc_ops imx_phycore_hifi_ops = {
+	.hw_params = imx_phycore_hifi_hw_params,
+	.hw_free = imx_phycore_hifi_hw_free,
+};
+
+static int imx_phycore_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int imx_phycore_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_SND_SOC_MC13783
+static struct snd_soc_dai_link imx_phycore_dai_mc13783[] = {
+	{
+		.name = "MC13783 Playback",
+		.stream_name	= "Playback",
+		.codec_dai	= &mc13783_dai[0],
+		.ops		= &imx_phycore_hifi_ops,
+	}, {
+		.name = "MC13783 Capture",
+		.stream_name	= "Capture",
+		.codec_dai	= &mc13783_dai[1],
+		.ops		= &imx_phycore_hifi_ops,
+	},
+};
+#endif
+
+#ifdef CONFIG_SND_SOC_WM9712
+static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
+	{
+		.name		= "HiFi",
+		.stream_name	= "HiFi",
+		.codec_dai	= &wm9712_dai[WM9712_DAI_AC97_HIFI],
+		.ops		= &imx_phycore_hifi_ops,
+	},
+};
+#endif
+
+static struct snd_soc_card imx_phycore = {
+	.name		= "PhyCORE-audio",
+	.platform	= &imx_soc_platform,
+	.probe		= imx_phycore_probe,
+	.remove		= imx_phycore_remove,
+	.dai_link	= NULL, /* runtime */
+	.num_links	= 0, /* runtime */
+};
+
+static struct snd_soc_device imx_phycore_snd_devdata = {
+	.card		= &imx_phycore,
+	.codec_dev	= NULL, /* runtime */
+};
+
+static struct platform_device *imx_phycore_snd_device;
+
+static int __init imx_phycore_init(void)
+{
+	int ret;
+
+	if (machine_is_pcm038() || machine_is_pcm037()) {
+#ifdef CONFIG_SND_SOC_MC13783
+		imx_phycore_snd_devdata.codec_dev = &soc_codec_dev_mc13783;
+		imx_phycore.dai_link = imx_phycore_dai_mc13783;
+		imx_phycore.num_links = ARRAY_SIZE(imx_phycore_dai_mc13783);
+#endif
+	} else if (machine_is_pcm043() || machine_is_pca100()) {
+#ifdef CONFIG_SND_SOC_WM9712
+		imx_phycore_snd_devdata.codec_dev = &soc_codec_dev_wm9712;
+		imx_phycore.dai_link = imx_phycore_dai_ac97;
+		imx_phycore.num_links = ARRAY_SIZE(imx_phycore_dai_ac97);
+#endif
+	} else
+		/* return happy. We might run on a totally different machine */
+		return 0;
+
+	imx_phycore_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!imx_phycore_snd_device)
+		return -ENOMEM;
+
+#ifdef CONFIG_SND_SOC_MC13783
+	imx_phycore_dai_mc13783[0].cpu_dai = imx_ssi_pcm_dai[0];
+	imx_phycore_dai_mc13783[1].cpu_dai = imx_ssi_pcm_dai[0];
+#endif
+#ifdef CONFIG_SND_SOC_WM9712
+	imx_phycore_dai_ac97[0].cpu_dai = imx_ssi_pcm_dai[0];
+#endif
+	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore_snd_devdata);
+	imx_phycore_snd_devdata.dev = &imx_phycore_snd_device->dev;
+	ret = platform_device_add(imx_phycore_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(imx_phycore_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit imx_phycore_exit(void)
+{
+	platform_device_unregister(imx_phycore_snd_device);
+}
+
+late_initcall(imx_phycore_init);
+module_exit(imx_phycore_exit);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
1.6.5.2
