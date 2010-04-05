From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  5 Apr 2010 06:13:38 +0200
Subject: [PATCH 3/3] Zipit Z2 WM8750 aSoC driver
In-Reply-To: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1270440818-25790-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for sound through the WM8750 codec on Zipit Z2.
Also, this patch incorporates support for detecting headset jack
insertion through the jack detection API.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 sound/soc/pxa/Kconfig  |    8 ++
 sound/soc/pxa/Makefile |    2 +
 sound/soc/pxa/z2.c     |  246 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/z2.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 376e14a..495a36f 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -42,6 +42,14 @@ config SND_PXA2XX_SOC_SPITZ
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-Cxx00 models (Spitz, Borzoi and Akita).
 
+config SND_PXA2XX_SOC_Z2
+	tristate "SoC Audio support for Zipit Z2"
+	depends on SND_PXA2XX_SOC && MACH_ZIPIT2
+	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8750
+	help
+	  Say Y if you want to add support for SoC audio on Zipit Z2.
+
 config SND_PXA2XX_SOC_POODLE
 	tristate "SoC Audio support for Poodle"
 	depends on SND_PXA2XX_SOC && MACH_POODLE
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index f3e08fd..caa03d8 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -22,6 +22,7 @@ snd-soc-palm27x-objs := palm27x.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
+snd-soc-z2-objs := z2.o
 snd-soc-imote2-objs := imote2.o
 snd-soc-raumfeld-objs := raumfeld.o
 
@@ -36,6 +37,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
 obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
+obj-$(CONFIG_SND_PXA2XX_SOC_Z2) += snd-soc-z2.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
new file mode 100644
index 0000000..4e4d2fa
--- /dev/null
+++ b/sound/soc/pxa/z2.c
@@ -0,0 +1,246 @@
+/*
+ * linux/sound/soc/pxa/z2.c
+ *
+ * SoC Audio driver for Aeronix Zipit Z2
+ *
+ * Copyright (C) 2009 Ken McGuire <kenm@desertweyr.com>
+ * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/audio.h>
+#include <mach/z2.h>
+
+#include "../codecs/wm8750.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-i2s.h"
+
+static struct snd_soc_card snd_soc_z2;
+
+static int z2_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		clk = 11289600;
+		break;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set the I2S system clock as input (unused) */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_jack hs_jack;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin	= "Mic Jack",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+	{
+		.pin	= "Headphone Jack",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+};
+
+/* Headset jack detection gpios */
+static struct snd_soc_jack_gpio hs_jack_gpios[] = {
+	{
+		.gpio		= GPIO37_ZIPITZ2_HEADSET_DETECT,
+		.name		= "hsdet-gpio",
+		.report		= SND_JACK_HEADSET,
+		.debounce_time	= 200,
+	},
+};
+
+/* z2 machine dapm widgets */
+static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+
+	/* headset is a mic and mono headphone */
+	SND_SOC_DAPM_HP("Headset Jack", NULL),
+};
+
+/* Z2 machine audio_map */
+static const struct snd_soc_dapm_route audio_map[] = {
+
+	/* headphone connected to LOUT1, ROUT1 */
+	{"Headphone Jack", NULL, "LOUT1"},
+	{"Headphone Jack", NULL, "ROUT1"},
+
+	/* ext speaker connected to LOUT2, ROUT2  */
+	{"Ext Spk", NULL , "ROUT2"},
+	{"Ext Spk", NULL , "LOUT2"},
+
+	/* mic is connected to R input 2 - with bias */
+	{"RINPUT2", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Mic Jack"},
+};
+
+/*
+ * Logic for a wm8750 as connected on a Z2 Device
+ */
+static int z2_wm8750_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* NC codec pins */
+	snd_soc_dapm_disable_pin(codec, "LINPUT3");
+	snd_soc_dapm_disable_pin(codec, "RINPUT3");
+	snd_soc_dapm_disable_pin(codec, "OUT3");
+	snd_soc_dapm_disable_pin(codec, "MONO");
+
+	/* Add z2 specific widgets */
+	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+				 ARRAY_SIZE(wm8750_dapm_widgets));
+
+	/* Set up z2 specific audio paths */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	ret = snd_soc_dapm_sync(codec);
+	if (ret)
+		goto err;
+
+	/* Jack detection API stuff */
+	ret = snd_soc_jack_new(&snd_soc_z2, "Headset Jack", SND_JACK_HEADSET,
+				&hs_jack);
+	if (ret)
+		goto err;
+
+	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+	if (ret)
+		goto err;
+
+	ret = snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
+				hs_jack_gpios);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static struct snd_soc_ops z2_ops = {
+	.hw_params = z2_hw_params,
+};
+
+/* z2 digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link z2_dai = {
+	.name		= "wm8750",
+	.stream_name	= "WM8750",
+	.cpu_dai	= &pxa_i2s_dai,
+	.codec_dai	= &wm8750_dai,
+	.init		= z2_wm8750_init,
+	.ops		= &z2_ops,
+};
+
+/* z2 audio machine driver */
+static struct snd_soc_card snd_soc_z2 = {
+	.name		= "Z2",
+	.platform	= &pxa2xx_soc_platform,
+	.dai_link	= &z2_dai,
+	.num_links	= 1,
+};
+
+/* z2 audio subsystem */
+static struct snd_soc_device z2_snd_devdata = {
+	.card		= &snd_soc_z2,
+	.codec_dev	= &soc_codec_dev_wm8750,
+};
+
+static struct platform_device *z2_snd_device;
+
+static int __init z2_init(void)
+{
+	int ret;
+
+	if (!machine_is_zipit2())
+		return -ENODEV;
+
+	z2_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!z2_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(z2_snd_device, &z2_snd_devdata);
+	z2_snd_devdata.dev = &z2_snd_device->dev;
+	ret = platform_device_add(z2_snd_device);
+
+	if (ret)
+		platform_device_put(z2_snd_device);
+
+	return ret;
+}
+
+static void __exit z2_exit(void)
+{
+	platform_device_unregister(z2_snd_device);
+}
+
+module_init(z2_init);
+module_exit(z2_exit);
+
+MODULE_AUTHOR("Ken McGuire <kenm@desertweyr.com>, "
+		"Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("ALSA SoC ZipitZ2");
+MODULE_LICENSE("GPL");
-- 
1.7.0
