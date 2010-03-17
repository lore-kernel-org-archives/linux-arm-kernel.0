From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 17:31:04 -0400
Subject: [PATCH] ASoC: support pxa168 ssp in ASoC
Message-ID: <mailman.250.1269014049.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support pxa168 ssp in ASoC. The clock configuration and hw_params()
is different from pxa2xx ssp. Others are shared with pxa2xx ssp.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig      |    6 +-
 sound/soc/pxa/Makefile     |    2 +
 sound/soc/pxa/pxa168-ssp.c |  318 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa168-ssp.h |   31 +++++
 4 files changed, 356 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/pxa/pxa168-ssp.c
 create mode 100644 sound/soc/pxa/pxa168-ssp.h

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 7be1d5f..286d52a 100644
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
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 33c1579..a74e6c9 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -3,11 +3,13 @@ snd-soc-pxa2xx-objs := pxa2xx-pcm.o
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
 snd-soc-corgi-objs := corgi.o
diff --git a/sound/soc/pxa/pxa168-ssp.c b/sound/soc/pxa/pxa168-ssp.c
new file mode 100644
index 0000000..2164359
--- /dev/null
+++ b/sound/soc/pxa/pxa168-ssp.c
@@ -0,0 +1,318 @@
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
+int pxa168_seek_mclk_conf(int rate, int format, int channel)
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
+EXPORT_SYMBOL_GPL(pxa168_seek_mclk_conf);
+
+/* Get the MCLK frequency */
+int pxa168_get_mclk(int i)
+{
+	if ((i < 0) || (i >= ARRAY_SIZE(mclk_conf)))
+		return -EINVAL;
+	return mclk_conf[i].mclk;
+}
+EXPORT_SYMBOL_GPL(pxa168_get_mclk);
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
+	if ((clk_id != PXA168_ASYSCLK_MASTER)
+		&& (clk_id != PXA168_ASYSCLK_SLAVE)) {
+		dev_warn(&ssp->pdev->dev, "Wrong clk_id(%d) is specified\n",
+			clk_id);
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
+	/* If ASYSCLK is supplied by pxa168, ASSPDR should be configured. */
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
+	cpu_dai->dma_data = ssp_get_dma_params(ssp, dma_16b, stream_out);
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
+		/*
+		 * The polarity of frame sync should be inverted at here.
+		 *
+		 * In I2S format, frame sync is always inactive while
+		 * transfering data of left channel. So some additional
+		 * parameters like frame width, frame delay should be
+		 * configured. And more bit clocks in one frame cycle should
+		 * be reserved to meet the clock delay formula.
+		 *
+		 * If frame sync signal is inverted, frame width & frame
+		 * delay needn't be configured at here.
+		 */
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
+};
+
+#define PXA168_SSP_RATES	SNDRV_PCM_RATE_8000_96000
+#define PXA168_SSP_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |	\
+				SNDRV_PCM_FMTBIT_S24_LE |	\
+				SNDRV_PCM_FMTBIT_S32_LE)
+
+#define PXA168_SSP_DAI(_id)					\
+{								\
+	.name	= "pxa168-ssp",					\
+	.id	= _id,						\
+	.playback = {						\
+		.channels_min = 1,				\
+		.channels_max = 2,				\
+		.rates = PXA168_SSP_RATES,			\
+		.formats = PXA168_SSP_FORMATS,			\
+	},							\
+	.capture = {						\
+		.channels_min = 1,				\
+		.channels_max = 2,				\
+		.rates = PXA168_SSP_RATES,			\
+		.formats = PXA168_SSP_FORMATS,			\
+	},							\
+	.ops = &pxa168_ssp_dai_ops,				\
+}
+
+struct snd_soc_dai pxa168_ssp_dai[] = {
+	PXA168_SSP_DAI(PXA168_DAI_SSP1),
+	PXA168_SSP_DAI(PXA168_DAI_SSP2),
+	PXA168_SSP_DAI(PXA168_DAI_SSP3),
+	PXA168_SSP_DAI(PXA168_DAI_SSP4),
+	PXA168_SSP_DAI(PXA168_DAI_SSP5),
+};
+EXPORT_SYMBOL_GPL(pxa168_ssp_dai);
+
+static int __init pxa168_ssp_init(void)
+{
+	struct snd_soc_dai *dai;
+	int i, ret;
+
+	for (i = 0; i < PXA168_DAI_SSP_MAX; i++) {
+		dai = &pxa168_ssp_dai[i];
+		ret = ssp_register_dai(dai);
+		if (ret)
+			return ret;
+	}
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
+		dai = &pxa168_ssp_dai[i];
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
index 0000000..59b3cb9
--- /dev/null
+++ b/sound/soc/pxa/pxa168-ssp.h
@@ -0,0 +1,31 @@
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
+#define PXA168_ASYSCLK_MASTER		0	/* ASYSCLK master -- pxa168 */
+#define PXA168_ASYSCLK_SLAVE		1	/* ASYSCLK slave -- pxa168 */
+
+extern struct snd_soc_dai pxa168_ssp_dai[PXA168_DAI_SSP_MAX];
+
+extern int pxa168_seek_mclk_conf(int rate, int format, int channel);
+extern int pxa168_get_mclk(int i);
+
+#endif
-- 
1.5.6.5
