From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 12 Aug 2010 12:04:23 +0800
Subject: [PATCH 5/5] ASoc: add machine driver for 88pm860x
Message-ID: <mailman.170.1281707756.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x codec is used in Marvell development board (Saarb and tavorevb3).
Codec is used as master mode in both of these two boards.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig     |   18 ++++
 sound/soc/pxa/Makefile    |    4 +
 sound/soc/pxa/saarb.c     |  208 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/tavorevb3.c |  209 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 439 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/saarb.c
 create mode 100644 sound/soc/pxa/tavorevb3.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index e30c832..37f191b 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -117,6 +117,24 @@ config SND_PXA2XX_SOC_PALM27X
 	  Say Y if you want to add support for SoC audio on
 	  Palm T|X, T5, E2 or LifeDrive handheld computer.

+config SND_SOC_SAARB
+	tristate "SoC Audio support for Marvell Saarb"
+	depends on SND_PXA2XX_SOC && MACH_SAARB
+	select SND_PXA_SOC_SSP
+	select SND_SOC_88PM860X
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Marvell Saarb reference platform.
+
+config SND_SOC_TAVOREVB3
+	tristate "SoC Audio support for Marvell Tavor EVB3"
+	depends on SND_PXA2XX_SOC && MACH_TAVOREVB3
+	select SND_PXA_SOC_SSP
+	select SND_SOC_88PM860X
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Marvell Saarb reference platform.
+
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index caa03d8..0766016 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -19,6 +19,8 @@ snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
 snd-soc-palm27x-objs := palm27x.o
+snd-soc-saarb-objs := saarb.o
+snd-soc-tavorevb3-objs := tavorevb3.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
@@ -38,6 +40,8 @@ obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_PXA2XX_SOC_Z2) += snd-soc-z2.o
+obj-$(CONFIG_SND_SOC_SAARB) += snd-soc-saarb.o
+obj-$(CONFIG_SND_SOC_TAVOREVB3) += snd-soc-tavorevb3.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
new file mode 100644
index 0000000..4220c28
--- /dev/null
+++ b/sound/soc/pxa/saarb.c
@@ -0,0 +1,208 @@
+/*
+ * saarb.c -- SoC audio for saarb
+ *
+ * Copyright (C) 2010 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/88pm860x-codec.h"
+#include "../../arm/pxa2xx-pcm.h"
+#include "pxa-ssp.h"
+
+static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd);
+
+static struct platform_device *saarb_snd_device;
+static struct snd_soc_jack hs_jack;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin	= "Mic Jack",
+		.mask	= SND_JACK_MICROPHONE,
+	}, {
+		.pin	= "Headphone Jack",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+};
+
+/* saarb machine dapm widgets */
+static const struct snd_soc_dapm_widget saarb_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 1", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 2", NULL),
+	SND_SOC_DAPM_SPK("Board Speaker", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 1", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 3", NULL),
+};
+
+/* saarb machine audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "HS1"},
+	{"Headphone Jack", NULL, "HS2"},
+
+	{"Board Speaker", NULL, "LSP"},
+	{"Board Speaker", NULL, "LSN"},
+
+	{"Lineout Out 1", NULL, "LINEOUT1"},
+	{"Lineout Out 2", NULL, "LINEOUT2"},
+
+	{"MIC1P", NULL, "Mic1 Bias"},
+	{"MIC1N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Board Mic 1"},
+
+	{"MIC2P", NULL, "Mic1 Bias"},
+	{"MIC2N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Mic Jack"},
+
+	{"MIC3P", NULL, "Mic3 Bias"},
+	{"MIC3N", NULL, "Mic3 Bias"},
+	{"Mic3 Bias", NULL, "Board Mic 3"},
+};
+
+static const struct snd_kcontrol_new pm860x_saarb_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Board Speaker"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 1"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 3"),
+};
+
+static int saarb_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int width = snd_pcm_format_physical_width(params_format(params));
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_NET_PLL, 0,
+				     PM860X_CLK_DIR_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 0, PM860X_CLK_DIR_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
+
+	return ret;
+}
+
+static struct snd_soc_ops saarb_i2s_ops = {
+	.hw_params	= saarb_i2s_hw_params,
+};
+
+static struct snd_soc_dai_link saarb_dai[] = {
+	{
+		.name		= "88PM860x I2S",
+		.stream_name	= "I2S Audio",
+		.cpu_dai_name	= "pxa-ssp-dai.1",
+		.codec_dai_name	= "88pm860x-i2s",
+		.platform_name	= "pxa-pcm-audio",
+		.codec_name	= "88pm860x-codec",
+		.init		= saarb_pm860x_init,
+		.ops		= &saarb_i2s_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_card_saarb = {
+	.name = "Saarb",
+	.dai_link = saarb_dai,
+	.num_links = ARRAY_SIZE(saarb_dai),
+};
+
+static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	ret = snd_soc_add_controls(codec, pm860x_saarb_controls,
+				   ARRAY_SIZE(pm860x_saarb_controls));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_new_controls(codec, saarb_dapm_widgets,
+				  ARRAY_SIZE(saarb_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_disable_pin(codec, "Board Speaker");
+	snd_soc_dapm_disable_pin(codec, "Board Mic 1");
+	snd_soc_dapm_disable_pin(codec, "Board Mic 3");
+
+	ret = snd_soc_dapm_sync(codec);
+	if (ret < 0)
+		return ret;
+
+	/* Jack detection */
+	ret = snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET
+				| SND_JACK_LINEOUT | SND_JACK_BTN_0, &hs_jack);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+	if (ret < 0)
+		return ret;
+
+	ret = pm860x_hs_detect(codec, &hs_jack, PM860X_DET_MASK);
+	return ret;
+}
+
+static int __init saarb_init(void)
+{
+	int ret;
+
+	if (!machine_is_saarb())
+		return -ENODEV;
+	saarb_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!saarb_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(saarb_snd_device, &snd_soc_card_saarb);
+
+	ret = platform_device_add(saarb_snd_device);
+	if (ret)
+		platform_device_put(saarb_snd_device);
+
+	return ret;
+}
+
+static void __exit saarb_exit(void)
+{
+	platform_device_unregister(saarb_snd_device);
+}
+
+module_init(saarb_init);
+module_exit(saarb_exit);
+
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("ALSA SoC 88PM860x Saarb");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
new file mode 100644
index 0000000..d5f8ac9
--- /dev/null
+++ b/sound/soc/pxa/tavorevb3.c
@@ -0,0 +1,209 @@
+/*
+ * tavorevb3.c -- SoC audio for Tavor EVB3
+ *
+ * Copyright (C) 2010 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/88pm860x-codec.h"
+#include "../../arm/pxa2xx-pcm.h"
+#include "pxa-ssp.h"
+
+static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd);
+
+static struct platform_device *evb3_snd_device;
+static struct snd_soc_jack hs_jack;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin	= "Mic Jack",
+		.mask	= SND_JACK_MICROPHONE,
+	}, {
+		.pin	= "Headphone Jack",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+};
+
+/* tavorevb3 machine dapm widgets */
+static const struct snd_soc_dapm_widget evb3_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 1", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 2", NULL),
+	SND_SOC_DAPM_SPK("Board Speaker", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 1", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 3", NULL),
+};
+
+/* tavorevb3 machine audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "HS1"},
+	{"Headphone Jack", NULL, "HS2"},
+
+	{"Board Speaker", NULL, "LSP"},
+	{"Board Speaker", NULL, "LSN"},
+
+	{"Lineout Out 1", NULL, "LINEOUT1"},
+	{"Lineout Out 2", NULL, "LINEOUT2"},
+
+	{"MIC1P", NULL, "Mic1 Bias"},
+	{"MIC1N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Board Mic 1"},
+
+	{"MIC2P", NULL, "Mic1 Bias"},
+	{"MIC2N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Mic Jack"},
+
+	{"MIC3P", NULL, "Mic3 Bias"},
+	{"MIC3N", NULL, "Mic3 Bias"},
+	{"Mic3 Bias", NULL, "Board Mic 3"},
+};
+
+static const struct snd_kcontrol_new pm860x_evb3_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Board Speaker"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 1"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 3"),
+};
+
+static int evb3_i2s_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int width = snd_pcm_format_physical_width(params_format(params));
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_NET_PLL, 0,
+				     PM860X_CLK_DIR_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 0, PM860X_CLK_DIR_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
+	return ret;
+}
+
+static struct snd_soc_ops evb3_i2s_ops = {
+	.hw_params	= evb3_i2s_hw_params,
+};
+
+static struct snd_soc_dai_link evb3_dai[] = {
+	{
+		.name		= "88PM860x I2S",
+		.stream_name	= "I2S Audio",
+		.cpu_dai_name	= "pxa-ssp-dai.1",
+		.codec_dai_name	= "88pm860x-i2s",
+		.platform_name	= "pxa-pcm-audio",
+		.codec_name	= "88pm860x-codec",
+		.init		= evb3_pm860x_init,
+		.ops		= &evb3_i2s_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_card_evb3 = {
+	.name = "Tavor EVB3",
+	.dai_link = evb3_dai,
+	.num_links = ARRAY_SIZE(evb3_dai),
+};
+
+static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	ret = snd_soc_add_controls(codec, pm860x_evb3_controls,
+				   ARRAY_SIZE(pm860x_evb3_controls));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_new_controls(codec, evb3_dapm_widgets,
+				  ARRAY_SIZE(evb3_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_disable_pin(codec, "Board Speaker");
+	snd_soc_dapm_disable_pin(codec, "Board Mic 1");
+	snd_soc_dapm_disable_pin(codec, "Board Mic 3");
+
+	ret = snd_soc_dapm_sync(codec);
+	if (ret < 0)
+		return ret;
+
+	/* Jack detection */
+	ret = snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET
+				| SND_JACK_LINEOUT | SND_JACK_BTN_0, &hs_jack);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+	if (ret < 0)
+		return ret;
+
+	ret = pm860x_hs_detect(codec, &hs_jack, PM860X_DET_MASK);
+	return ret;
+}
+
+static int __init tavorevb3_init(void)
+{
+	int ret;
+
+	if (!machine_is_tavorevb3())
+		return -ENODEV;
+	evb3_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!evb3_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(evb3_snd_device, &snd_soc_card_evb3);
+
+	ret = platform_device_add(evb3_snd_device);
+	if (ret)
+		platform_device_put(evb3_snd_device);
+
+	return ret;
+}
+
+static void __exit tavorevb3_exit(void)
+{
+	platform_device_unregister(evb3_snd_device);
+}
+
+module_init(tavorevb3_init);
+module_exit(tavorevb3_exit);
+
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("ALSA SoC 88PM860x Saarb");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5
