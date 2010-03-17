From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 17:31:04 -0400
Subject: [PATCH] ASoC: support codec via ssp interface in aspenite
Message-ID: <mailman.243.1268879511.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support WM8753 codec in aspenite via ssp interface.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig      |   15 ++-
 sound/soc/pxa/Makefile     |    4 +
 sound/soc/pxa/aspenite.c   |  200 +++++++++++++++++++++++
 sound/soc/pxa/pxa168-ssp.c |  383 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa168-ssp.h |   42 +++++
 5 files changed, 643 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/pxa/aspenite.c
 create mode 100644 sound/soc/pxa/pxa168-ssp.c
 create mode 100644 sound/soc/pxa/pxa168-ssp.h

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 7be1d5f..0f10ee2 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,6 +1,6 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || ARCH_MMP
 	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -25,6 +25,10 @@ config SND_PXA2XX_SOC_SSP
 	tristate
 	select PXA_SSP

+config SND_PXA168_SOC_SSP
+	tristate
+	select PXA_SSP
+
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
 	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx
@@ -109,6 +113,15 @@ config SND_PXA2XX_SOC_PALM27X
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
index 33c1579..74054aa 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -3,13 +3,16 @@ snd-soc-pxa2xx-objs := pxa2xx-pcm.o
 snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
 snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
 snd-soc-pxa2xx-ssp-objs := pxa-ssp.o pxa2xx-ssp.o
+snd-soc-pxa168-ssp-objs := pxa-ssp.o pxa168-ssp.o

 obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
 obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
 obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SSP) += snd-soc-pxa2xx-ssp.o
+obj-$(CONFIG_SND_PXA168_SOC_SSP) += snd-soc-pxa168-ssp.o

 # PXA Machine Support
+snd-soc-aspenite-objs := aspenite.o
 snd-soc-corgi-objs := corgi.o
 snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
@@ -36,6 +39,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
 obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
+obj-$(CONFIG_SND_SOC_ASPENITE) += snd-soc-aspenite.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/aspenite.c b/sound/soc/pxa/aspenite.c
new file mode 100644
index 0000000..344c043
--- /dev/null
+++ b/sound/soc/pxa/aspenite.c
@@ -0,0 +1,200 @@
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
+	SND_SOC_DAPM_SPK("Headset Speaker", NULL),
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
+	{"Headset Speaker", NULL, "LOUT2"},
+	{"Headset Speaker", NULL, "OUT4"},
+	{"Headset Speaker", NULL, "OUT3"},
+	{"Headset Speaker", NULL, "ROUT2"},
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
+	SOC_DAPM_PIN_SWITCH("Headset Speaker"),
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
+	ret = seek_mclk_conf(rate, width, channel);
+	if (ret < 0)
+		return ret;
+	index = ret;
+	mclk = get_mclk(ret);
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
+static int aspenite_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static struct snd_soc_ops aspenite_hifi_ops = {
+	.hw_params	= aspenite_hifi_hw_params,
+	.hw_free	= aspenite_hifi_hw_free,
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
diff --git a/sound/soc/pxa/pxa168-ssp.c b/sound/soc/pxa/pxa168-ssp.c
new file mode 100644
index 0000000..1a3b15e
--- /dev/null
+++ b/sound/soc/pxa/pxa168-ssp.c
@@ -0,0 +1,383 @@
+/*
+ * pxa168-ssp.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2009-2010 Marvell International Ltd.
+ * Author:
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/pxa2xx-lib.h>
+
+#include <mach/hardware.h>
+#include <mach/dma.h>
+#include <mach/regs-apbc.h>
+#include <mach/regs-apmu.h>
+#include <mach/regs-mpmu.h>
+#include <plat/ssp.h>
+
+#include "pxa2xx-pcm.h"
+#include "pxa168-ssp.h"
+#include "pxa-ssp.h"
+
+struct ssp_mclk {
+	unsigned int	rate;
+	unsigned int	format;
+	unsigned int	channel;
+	unsigned int	mclk;
+	unsigned int	mclk_denom;
+	unsigned int	mclk_num;
+	unsigned int	bclk;
+	unsigned int	bclk_denom;
+	unsigned int	bclk_num;
+};
+
+/*
+ * This table is used while CPU is clock master.
+ * MCLK = 312MHz * (ASYSCLK_DENOM + 1) / ASYSCLK_NUM
+ * BCLK = 2 * MCLK * (SSPSCLK_DENOM + 1) / SSPSCLK_NUM
+ */
+static const struct ssp_mclk mclk_conf[] = {
+	/* rate, fmt, chn, mclk,   den, num, bclk, den, num */
+	{96000, 16, 2, 12288000,  63, 1625, 3072000,  1,  2},
+	{96000, 16, 1, 12288000,  63, 1625, 3072000,  1,  8},
+	{88200, 16, 2, 11289600, 293, 8125, 2822400,  1,  2},
+	{88200, 16, 1, 11289600, 293, 8125, 2822400,  1,  8},
+	{48000, 16, 2, 12288000,  63, 1625, 1536000,  1,  4},
+	{48000, 16, 1, 12288000,  63, 1625, 1536000,  1, 16},
+	{44100, 16, 2, 11289600, 293, 8125, 1411200,  1,  4},
+	{44100, 16, 1, 11289600, 293, 8125, 1411200,  1, 16},
+	{32000, 16, 2, 12288000,  63, 1625, 1024000,  1,  6},
+	{32000, 16, 1, 12288000,  63, 1625, 1024000,  1, 24},
+	{22050, 16, 2, 11289600, 293, 8125,  705600,  1,  8},
+	{22050, 16, 1, 11289600, 293, 8125,  705600,  1, 32},
+	{16000, 16, 2, 12288000,  63, 1625,  512000,  1, 12},
+	{16000, 16, 1, 12288000,  63, 1625,  512000,  1, 48},
+	{11025, 16, 2, 11289600, 293, 8125,  352800,  1, 16},
+	{11025, 16, 1, 11289600, 293, 8125,  352800,  1, 64},
+	{ 8000, 16, 2, 12288000,  63, 1625,  256000,  1, 24},
+	{ 8000, 16, 1, 12288000,  63, 1625,  256000,  1, 96},
+};
+
+/* Seek the index of MCLK configuration table */
+int seek_mclk_conf(int rate, int format, int channel)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mclk_conf); i++) {
+		if ((mclk_conf[i].rate == rate)
+			&& (mclk_conf[i].format == format)
+			&& (mclk_conf[i].channel == channel))
+			return i;
+	}
+	return -EINVAL;
+}
+
+/* Get the MCLK frequency */
+int get_mclk(int i)
+{
+	if ((i < 0) || (i >= ARRAY_SIZE(mclk_conf)))
+		return -EINVAL;
+	return mclk_conf[i].mclk;
+}
+
+/* Get the BCLK frequency */
+int get_bclk(int i)
+{
+	if ((i < 0) || (i >= ARRAY_SIZE(mclk_conf)))
+		return -EINVAL;
+	return mclk_conf[i].bclk;
+}
+
+static void dump_registers(struct ssp_device *ssp)
+{
+	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
+		ssp_read_reg(ssp, SSCR0), ssp_read_reg(ssp, SSCR1),
+		ssp_read_reg(ssp, SSTO));
+
+	dev_dbg(&ssp->pdev->dev, "SSPSP 0x%08x SSSR 0x%08x\n",
+		ssp_read_reg(ssp, SSPSP), ssp_read_reg(ssp, SSSR));
+}
+
+/*
+ * Set the SSP ports SYSCLK only from Audio SYSCLK.
+ */
+static int pxa168_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
+				     unsigned int freq, int dir)
+{
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
+	unsigned int sscr0, data, asysdr, asspdr;
+
+	dev_dbg(&ssp->pdev->dev, "%s id: %d, clk_id %d, freq %u\n",
+		__func__, cpu_dai->id, clk_id, freq);
+
+	switch (clk_id) {
+	case PXA168_ASYSCLK_MASTER:
+	case PXA168_ASYSCLK_SLAVE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* freq is the index of mclk_conf table */
+	if ((freq < 0) || (freq >= ARRAY_SIZE(mclk_conf))) {
+		dev_warn(&ssp->pdev->dev, "Wrong frequency index:%d\n", freq);
+		return -EINVAL;
+	}
+	asysdr = (mclk_conf[freq].mclk_num << 16)
+		| mclk_conf[freq].mclk_denom;
+	asspdr = 0;
+	if (clk_id == PXA168_ASYSCLK_MASTER)
+		asspdr = (mclk_conf[freq].bclk_num << 16)
+			| mclk_conf[freq].bclk_denom;
+
+	ssp_disable(ssp);
+	clk_disable(ssp->clk);			/* SSP port internal clock */
+
+	/* clear ECS, NCS, MOD, ACS */
+	sscr0 = ssp_read_reg(ssp, SSCR0);
+	data = sscr0 & ~(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+	if (sscr0 != data)
+		ssp_write_reg(ssp, SSCR0, data);
+
+	/* update divider register in MPMU */
+	__raw_writel(asysdr, MPMU_ASYSDR);
+	__raw_writel(asspdr, MPMU_ASSPDR);
+
+	clk_enable(ssp->clk);			/* SSP port internal clock */
+	ssp_enable(ssp);
+	return 0;
+}
+
+/*
+ * Set up the SSP DAI format.
+ * The SSP Port must be inactive before calling this function as the
+ * physical interface format is changed.
+ */
+static int pxa168_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
+	u32 sscr0;
+	u32 sscr1;
+	u32 sspsp;
+
+	/* check if we need to change anything at all */
+	if (priv->dai_fmt == fmt)
+		return 0;
+
+	ssp_disable(ssp);
+
+	sscr0 = ssp_read_reg(ssp, SSCR0);
+	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
+	sspsp = 0;
+
+	/* we can only change the settings if the port is not in use */
+	if (sscr0 & SSCR0_SSE) {
+		dev_err(&ssp->pdev->dev,
+			"can't change hardware dai format: stream is in use");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		sscr1 |= SSCR1_SCLKDIR;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		sspsp |= SSPSP_SFRMP;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		sspsp |= SSPSP_SCMODE(2);
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		sspsp |= SSPSP_SCMODE(2) | SSPSP_SFRMP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		sscr0 |= SSCR0_PSP;
+		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
+		/* See hw_params() */
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ssp_write_reg(ssp, SSCR0, sscr0);
+	ssp_write_reg(ssp, SSCR1, sscr1);
+	ssp_write_reg(ssp, SSPSP, sspsp);
+	ssp_enable(ssp);
+
+	/* Since we are configuring the timings for the format by hand
+	 * we have to defer some things until hw_params() where we
+	 * know parameters like the sample size.
+	 */
+	priv->dai_fmt = fmt;
+
+	dump_registers(ssp);
+
+	return 0;
+}
+
+static int pxa168_ssp_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
+	int width = snd_pcm_format_physical_width(params_format(params));
+	int channels = params_channels(params);
+	int dma_16b = 0, stream_out, data_size;
+	u32 sscr0, sspsp;
+
+	/* generate correct DMA params */
+	if (cpu_dai->dma_data)
+		kfree(cpu_dai->dma_data);
+
+	if ((width == 16) && (params_channels(params) == 1))
+		dma_16b = 1;
+	stream_out = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ? 1 : 0;
+	cpu_dai->dma_data = pxa_ssp_get_dma_params(ssp, dma_16b, stream_out);
+
+	/* clear selected SSP bits */
+	sscr0 = ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
+
+	/* data_size should only be 16-bit or 32-bit because of DMA */
+	data_size = width * channels;
+	switch (data_size) {
+	case 16:
+		sscr0 |= SSCR0_DataSize(16);
+		break;
+	case 32:
+		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
+		break;
+	}
+
+	ssp_disable(ssp);
+	sspsp = ssp_read_reg(ssp, SSPSP);
+	sspsp &= ~SSPSP_TIMING_MASK;
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		/* The polarity of frame sync should be inverted at here. */
+		sspsp |= SSPSP_SFRMWDTH(width);
+		if (channels == 1) {
+			sspsp |= SSPSP_DMYSTRT(1);
+			sspsp |= SSPSP_DMYSTOP((width - 1) & 0x3);
+			sspsp |= SSPSP_EDMYSTOP(((width - 1) >> 2) & 0x7);
+		} else if (channels == 2) {
+			if (width == 32) {
+				dev_err(&ssp->pdev->dev, "can't support %d-"
+					"data with %-channels in I2S mode\n",
+					width, channels);
+				return -EINVAL;
+			}
+			sspsp |= SSPSP_FSRT;
+		}
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		/* Right Justified mode doesn't support 32-bit data */
+		if (params_format(params) == SNDRV_PCM_FORMAT_S32_LE)
+			return -EINVAL;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		sspsp |= SSPSP_SFRMWDTH(width);
+		break;
+	}
+
+	/* update SSP register at the same time */
+	ssp_write_reg(ssp, SSCR0, sscr0);
+	ssp_write_reg(ssp, SSPSP, sspsp);
+	ssp_enable(ssp);
+
+	dump_registers(ssp);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops pxa168_ssp_dai_ops = {
+	.hw_params	= pxa168_ssp_hw_params,
+	.set_sysclk	= pxa168_ssp_set_dai_sysclk,
+	.set_fmt	= pxa168_ssp_set_dai_fmt,
+};
+
+struct snd_soc_dai pxa168_ssp_dai[PXA168_DAI_SSP_MAX];
+EXPORT_SYMBOL(pxa168_ssp_dai);
+
+static int __init pxa168_ssp_init(void)
+{
+	struct snd_soc_dai *dai;
+	int i, ret;
+
+	for (i = 0; i < PXA168_DAI_SSP_MAX; i++) {
+		dai = &pxa168_ssp_dai[i];
+		dai->name = "pxa168-ssp";
+		dai->id = i;
+		dai->playback.channels_min = 1;
+		dai->playback.channels_max = 2;
+		dai->playback.rates = PXA168_SSP_RATES;
+		dai->playback.formats = PXA168_SSP_FORMATS;
+		dai->capture.channels_min = 1;
+		dai->capture.channels_max = 2;
+		dai->capture.rates = PXA168_SSP_RATES;
+		dai->capture.formats = PXA168_SSP_FORMATS;
+		dai->ops = &pxa168_ssp_dai_ops;
+		ret = pxa_ssp_register_dai(dai);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+module_init(pxa168_ssp_init);
+
+static void __exit pxa168_ssp_exit(void)
+{
+	struct snd_soc_dai *dai = NULL;
+	int i;
+
+	for (i = 0; i < PXA168_DAI_SSP_MAX; i++) {
+		dai = &pxa168_ssp_dai[dai->id];
+		snd_soc_unregister_dai(dai);
+	}
+}
+module_exit(pxa168_ssp_exit);
+
+/* Module information */
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("PXA168 SSP SoC Interface");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/pxa/pxa168-ssp.h b/sound/soc/pxa/pxa168-ssp.h
new file mode 100644
index 0000000..141a784
--- /dev/null
+++ b/sound/soc/pxa/pxa168-ssp.h
@@ -0,0 +1,42 @@
+/*
+ * ASoC PXA168 SSP port support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _PXA168_SSP_H
+#define _PXA168_SSP_H
+
+#define PXA168_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
+			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
+			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |	\
+			SNDRV_PCM_RATE_96000)
+
+#define PXA168_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE 			\
+			| SNDRV_PCM_FMTBIT_S24_LE			\
+			| SNDRV_PCM_FMTBIT_S32_LE)
+
+/* pxa DAI SSP IDs */
+enum {
+	PXA168_DAI_SSP1,
+	PXA168_DAI_SSP2,
+	PXA168_DAI_SSP3,
+	PXA168_DAI_SSP4,
+	PXA168_DAI_SSP5,
+	PXA168_DAI_SSP_MAX,
+};
+
+/* PXA168 SSP SYSCLK source */
+#define PXA168_ASYSCLK_MASTER		0
+#define PXA168_ASYSCLK_SLAVE		1
+
+extern struct snd_soc_dai pxa168_ssp_dai[5];
+
+extern int seek_mclk_conf(int rate, int format, int channel);
+extern int get_mclk(int i);
+extern int get_bclk(int i);
+
+#endif
-- 
1.5.6.5
