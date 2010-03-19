From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 19 Mar 2010 18:13:32 -0400
Subject: [PATCH] ASoC: enable wm8753 in aspenite
Message-ID: <mailman.251.1269014088.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wm8753 codec in aspenite via ssp interface.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig    |    9 ++
 sound/soc/pxa/Makefile   |    2 +
 sound/soc/pxa/aspenite.c |  196 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/aspenite.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 286d52a..0f10ee2 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -113,6 +113,15 @@ config SND_PXA2XX_SOC_PALM27X
 	  Say Y if you want to add support for SoC audio on
 	  Palm T|X, T5, E2 or LifeDrive handheld computer.

+config SND_SOC_ASPENITE
+	tristate "SoC Audio support for Marvell Aspenite"
+	depends on SND_PXA2XX_SOC && MACH_ASPENITE
+	select SND_PXA168_SOC_SSP
+	select SND_SOC_WM8753
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Marvell Aspenite reference platform.
+
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index a74e6c9..74054aa 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_SSP) += snd-soc-pxa2xx-ssp.o
 obj-$(CONFIG_SND_PXA168_SOC_SSP) += snd-soc-pxa168-ssp.o

 # PXA Machine Support
+snd-soc-aspenite-objs := aspenite.o
 snd-soc-corgi-objs := corgi.o
 snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
@@ -38,6 +39,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
 obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
+obj-$(CONFIG_SND_SOC_ASPENITE) += snd-soc-aspenite.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/aspenite.c b/sound/soc/pxa/aspenite.c
new file mode 100644
index 0000000..41d24c8
--- /dev/null
+++ b/sound/soc/pxa/aspenite.c
@@ -0,0 +1,196 @@
+/*
+ * aspenite.c -- SoC audio for Aspenite
+ *
+ * Copyright (C) 2009-2010 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/ssp.h>
+
+#include "../codecs/wm8753.h"
+#include "pxa2xx-pcm.h"
+#include "pxa168-ssp.h"
+
+static struct snd_soc_card aspenite;
+
+/* aspenite machine dapm widgets */
+static const struct snd_soc_dapm_widget aspenite_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Headset Speaker L", NULL),
+	SND_SOC_DAPM_SPK("Headset Speaker R", NULL),
+	SND_SOC_DAPM_LINE("Line LIN", NULL),
+	SND_SOC_DAPM_LINE("Line RIN", NULL),
+};
+
+/* aspenite machine audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Headphone connected to LOUT1/ROUT1 */
+	{"Headphone", NULL, "LOUT1"},
+	{"Headphone", NULL, "ROUT1"},
+
+	/* Speaker connected to LOUT2/OUT4 & OUT3/ROUT2 */
+	{"Headset Speaker L", NULL, "LOUT2"},
+	{"Headset Speaker L", NULL, "OUT4"},
+	{"Headset Speaker R", NULL, "OUT3"},
+	{"Headset Speaker R", NULL, "ROUT2"},
+
+	/* Line connected to LINE1/LINE2 */
+	{"Line LIN", NULL, "LINE1"},
+	{"Line RIN", NULL, "LINE2"},
+
+	/* Mic */
+	{"MIC1", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Headset Mic"},
+
+	/* Connect the ALC pins */
+	{"ACIN", NULL, "ACOP"},
+};
+
+static const struct snd_kcontrol_new wm8753_aspenite_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headset Speaker L"),
+	SOC_DAPM_PIN_SWITCH("Headset Speaker R"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Line LIN"),
+	SOC_DAPM_PIN_SWITCH("Line RIN"),
+};
+
+static int aspenite_hifi_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int rate, width, channel;
+	int index, mclk, ret;
+
+	rate =  params_rate(params);
+	width = snd_pcm_format_physical_width(params_format(params));
+	channel = params_channels(params);
+	ret = pxa168_seek_mclk_conf(rate, width, channel);
+	if (ret < 0)
+		return ret;
+	index = ret;
+	mclk = pxa168_get_mclk(ret);
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+				  | SND_SOC_DAIFMT_NB_IF
+				  | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+				  | SND_SOC_DAIFMT_NB_IF
+				  | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, mclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu system clock */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA168_ASYSCLK_MASTER, index,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops aspenite_hifi_ops = {
+	.hw_params	= aspenite_hifi_hw_params,
+};
+
+static int aspenite_wm8753_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* set up NC codec pins */
+	snd_soc_dapm_nc_pin(codec, "MONO1");
+	snd_soc_dapm_nc_pin(codec, "MONO2");
+	snd_soc_dapm_nc_pin(codec, "RXP");
+	snd_soc_dapm_nc_pin(codec, "RXN");
+
+	snd_soc_dapm_new_controls(codec, aspenite_dapm_widgets,
+				  ARRAY_SIZE(aspenite_dapm_widgets));
+	ret = snd_soc_add_controls(codec, wm8753_aspenite_controls,
+				   ARRAY_SIZE(wm8753_aspenite_controls));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	return 0;
+}
+
+static struct snd_soc_dai_link aspenite_dai[] = {
+	{
+		.name		= "WM8753 HiFi",
+		.stream_name	= "WM8753 HiFi",
+		.cpu_dai	= &pxa168_ssp_dai[PXA168_DAI_SSP1],
+		.codec_dai	= &wm8753_dai[0],
+		.init		= aspenite_wm8753_init,
+		.ops		= &aspenite_hifi_ops,
+	},
+};
+
+static struct snd_soc_card aspenite = {
+	.name		= "Aspenite",
+	.platform	= &pxa2xx_soc_platform,
+	.dai_link	= aspenite_dai,
+	.num_links	= ARRAY_SIZE(aspenite_dai),
+};
+
+static struct snd_soc_device aspenite_snd_devdata = {
+	.card		= &aspenite,
+	.codec_dev	= &soc_codec_dev_wm8753,
+};
+
+static struct platform_device *aspenite_snd_device;
+
+static int __init aspenite_init(void)
+{
+	int ret;
+
+	aspenite_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!aspenite_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(aspenite_snd_device, &aspenite_snd_devdata);
+	aspenite_snd_devdata.dev = &aspenite_snd_device->dev;
+
+	ret = platform_device_add(aspenite_snd_device);
+	if (ret)
+		platform_device_put(aspenite_snd_device);
+	return ret;
+}
+module_init(aspenite_init);
+
+static void __exit aspenite_exit(void)
+{
+	platform_device_unregister(aspenite_snd_device);
+}
+module_exit(aspenite_exit);
+
+MODULE_DESCRIPTION("ALSA SoC WM8753 Aspenite");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
