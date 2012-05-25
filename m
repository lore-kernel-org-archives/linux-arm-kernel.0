From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 25 May 2012 15:11:03 +0800
Subject: [PATCH 4/4] ASoC: add mmp brownstone support
In-Reply-To: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1337929863-31885-5-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds Alsa audio platform driver for mmp brownstone machine

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Leo Yan <leoy@marvell.com>
---
 sound/soc/pxa/Kconfig      |    9 ++
 sound/soc/pxa/Makefile     |    2 +
 sound/soc/pxa/brownstone.c |  303 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/brownstone.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 39461ba..b5fa91f 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -205,3 +205,12 @@ config SND_PXA2XX_SOC_IMOTE2
        help
          Say Y if you want to add support for SoC audio on the
 	 IMote 2.
+
+config SND_MMP_SOC_BROWNSTONE
+	tristate "SoC Audio support for Marvell Brownstone"
+	depends on SND_MMP_SOC && MACH_BROWNSTONE
+	select SND_MMP_SOC_SSPA
+	select SND_SOC_WM8994
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Marvell Brownstone reference platform.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 07b8417..c12aa2a 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -32,6 +32,7 @@ snd-soc-mioa701-objs := mioa701_wm9713.o
 snd-soc-z2-objs := z2.o
 snd-soc-imote2-objs := imote2.o
 snd-soc-raumfeld-objs := raumfeld.o
+snd-soc-brownstone-objs := brownstone.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -51,3 +52,4 @@ obj-$(CONFIG_SND_SOC_TAVOREVB3) += snd-soc-tavorevb3.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
+obj-$(CONFIG_SND_MMP_SOC_BROWNSTONE) += snd-soc-brownstone.o
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
new file mode 100644
index 0000000..b024e58
--- /dev/null
+++ b/sound/soc/pxa/brownstone.c
@@ -0,0 +1,303 @@
+/*
+ * linux/sound/soc/pxa/brownstone.c
+ *
+ * Copyright (C) 2011 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <linux/suspend.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/mfd/wm8994/registers.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-types.h>
+
+#include "../codecs/wm8994.h"
+#include "mmp-sspa.h"
+
+#define BROWNSTONE_HP        0
+#define BROWNSTONE_MIC       1
+#define BROWNSTONE_HEADSET   2
+#define BROWNSTONE_HP_OFF    3
+#define BROWNSTONE_SPK_ON    0
+#define BROWNSTONE_SPK_OFF   1
+
+static struct snd_soc_card brownstone;
+static int brownstone_jack_func;
+static int brownstone_spk_func;
+
+static void brownstone_ext_control(struct snd_soc_dapm_context *dapm)
+{
+	if (brownstone_spk_func == BROWNSTONE_SPK_ON) {
+		snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
+		snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
+	} else {
+		snd_soc_dapm_disable_pin(dapm, "Ext Left Spk");
+		snd_soc_dapm_disable_pin(dapm, "Ext Right Spk");
+	}
+
+	/* set up jack connection */
+	switch (brownstone_jack_func) {
+	case BROWNSTONE_HP:
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_enable_pin(dapm, "Main Mic");
+		snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
+		break;
+	case BROWNSTONE_MIC:
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_enable_pin(dapm, "Main Mic");
+		snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
+		break;
+	case BROWNSTONE_HEADSET:
+		snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Main Mic");
+		snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
+		break;
+	case BROWNSTONE_HP_OFF:
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Main Mic");
+		snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
+		break;
+	}
+	snd_soc_dapm_sync(dapm);
+	return;
+}
+
+static int brownstone_get_jack(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = brownstone_jack_func;
+	return 0;
+}
+
+static int brownstone_set_jack(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
+
+	if (brownstone_jack_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	brownstone_jack_func = ucontrol->value.integer.value[0];
+	brownstone_ext_control(&card->dapm);
+	return 1;
+}
+
+static int brownstone_get_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = brownstone_spk_func;
+	return 0;
+}
+
+static int brownstone_set_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
+
+	if (brownstone_spk_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	brownstone_spk_func = ucontrol->value.integer.value[0];
+	brownstone_ext_control(&card->dapm);
+	return 1;
+}
+
+static const struct snd_soc_dapm_widget brownstone_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Ext Right Spk", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Main Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route brownstone_audio_map[] = {
+	{"Ext Left Spk", NULL, "SPKOUTLP"},
+	{"Ext Left Spk", NULL, "SPKOUTLN"},
+
+	{"Ext Right Spk", NULL, "SPKOUTRP"},
+	{"Ext Right Spk", NULL, "SPKOUTRN"},
+
+	{"Headset Stereophone", NULL, "HPOUT1L"},
+	{"Headset Stereophone", NULL, "HPOUT1R"},
+
+	{"IN1RN", NULL, "Headset Mic"},
+
+	{"DMIC1DAT", NULL, "MICBIAS1"},
+	{"MICBIAS1", NULL, "Main Mic"},
+};
+
+static const char *jack_function[] = {"Headphone", "Mic", "Headset", "Off"};
+static const char *spk_function[]  = {"On", "Off"};
+static const struct soc_enum brownstone_enum[] = {
+	SOC_ENUM_SINGLE_EXT(4, jack_function),
+	SOC_ENUM_SINGLE_EXT(2, spk_function),
+};
+
+static const struct snd_kcontrol_new brownstone_wm8994_controls[] = {
+	SOC_ENUM_EXT("Jack Function", brownstone_enum[0],
+		     brownstone_get_jack, brownstone_set_jack),
+	SOC_ENUM_EXT("Speaker Function", brownstone_enum[1],
+		     brownstone_get_spk, brownstone_set_spk),
+};
+
+static int brownstone_wm8994_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	brownstone_jack_func = BROWNSTONE_MIC;
+	brownstone_spk_func  = BROWNSTONE_SPK_ON;
+
+	snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
+	snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
+	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_enable_pin(dapm, "Main Mic");
+
+	/* set endpoints to not connected */
+	snd_soc_dapm_nc_pin(dapm, "HPOUT2P");
+	snd_soc_dapm_nc_pin(dapm, "HPOUT2N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1P");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2P");
+	snd_soc_dapm_nc_pin(dapm, "IN1LN");
+	snd_soc_dapm_nc_pin(dapm, "IN1LP");
+	snd_soc_dapm_nc_pin(dapm, "IN1RP");
+	snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
+	snd_soc_dapm_nc_pin(dapm, "IN2RN");
+	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
+	snd_soc_dapm_nc_pin(dapm, "IN2LN");
+
+	snd_soc_dapm_sync(dapm);
+
+	/* turn on micbias 1/2 always */
+	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+			    WM8994_MICB1_ENA_MASK |
+			    WM8994_MICB2_ENA_MASK,
+			    WM8994_MICB1_ENA |
+			    WM8994_MICB2_ENA);
+	return 0;
+}
+
+static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
+				       struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int freq_out, sspa_mclk, sysclk;
+	int sspa_div;
+
+	if (params_rate(params) > 11025) {
+		freq_out  = params_rate(params) * 512;
+		sysclk    = params_rate(params) * 256;
+		sspa_mclk = params_rate(params) * 64;
+	} else {
+		freq_out  = params_rate(params) * 1024;
+		sysclk    = params_rate(params) * 512;
+		sspa_mclk = params_rate(params) * 64;
+	}
+	sspa_div = freq_out;
+	do_div(sspa_div, sspa_mclk);
+
+	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
+	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
+	snd_soc_dai_set_pll(cpu_dai, MMP_SSPA_CLK, 0, freq_out, sspa_mclk);
+
+	/* set wm8994 sysclk */
+	snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_MCLK1, sysclk, 0);
+
+	snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+
+	snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+
+	return 0;
+}
+
+/* machine stream operations */
+static struct snd_soc_ops brownstone_ops = {
+	.hw_params = brownstone_wm8994_hw_params,
+};
+
+static struct snd_soc_dai_link brownstone_wm8994_dai[] = {
+{
+	.name		= "WM8994",
+	.stream_name	= "WM8994 HiFi",
+	.cpu_dai_name	= "mmp-sspa-dai.0",
+	.codec_dai_name	= "wm8994-aif1",
+	.platform_name	= "mmp-pcm-audio",
+	.codec_name	= "wm8994-codec",
+	.ops		= &brownstone_ops,
+	.init		= brownstone_wm8994_init,
+},
+};
+
+/* audio machine driver */
+static struct snd_soc_card brownstone = {
+	.name         = "brownstone",
+	.dai_link     = brownstone_wm8994_dai,
+	.num_links    = ARRAY_SIZE(brownstone_wm8994_dai),
+
+	.controls = brownstone_wm8994_controls,
+	.num_controls = ARRAY_SIZE(brownstone_wm8994_controls),
+	.dapm_widgets = brownstone_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(brownstone_dapm_widgets),
+	.dapm_routes = brownstone_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(brownstone_audio_map),
+};
+
+static int __devinit brownstone_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	brownstone.dev = &pdev->dev;
+	ret = snd_soc_register_card(&brownstone);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+				ret);
+	return ret;
+}
+
+static int __devexit brownstone_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&brownstone);
+	return 0;
+}
+
+static struct platform_driver mmp_driver = {
+	.driver		= {
+		.name	= "mmp-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= brownstone_probe,
+	.remove		= __devexit_p(brownstone_remove),
+};
+
+module_platform_driver(mmp_driver);
+
+MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
+MODULE_DESCRIPTION("ALSA SoC Brownstone");
+MODULE_LICENSE("GPL");
-- 
1.7.1
