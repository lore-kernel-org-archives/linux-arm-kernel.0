From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 17 Aug 2010 13:24:35 +0800
Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
Message-ID: <mailman.195.1282139384.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x codec is used in Marvell tavorevb3 development board. 88PM860x
codec is used as master mode of SSP communication. Only I2S format is
supported.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig      |    9 +
 sound/soc/pxa/Makefile     |    2 +
 sound/soc/pxa/pxa2xx-ssp.c |  532 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa2xx-ssp.h |   59 +++++
 sound/soc/pxa/ssp.c        |  298 +++++++++++++++++++++++++
 sound/soc/pxa/ssp.h        |   42 ++++
 sound/soc/pxa/tavorevb3.c  |  193 ++++++++++++++++
 7 files changed, 1135 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/pxa2xx-ssp.c
 create mode 100644 sound/soc/pxa/pxa2xx-ssp.h
 create mode 100644 sound/soc/pxa/ssp.c
 create mode 100644 sound/soc/pxa/ssp.h
 create mode 100644 sound/soc/pxa/tavorevb3.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index e30c832..04ddc7b 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -117,6 +117,15 @@ config SND_PXA2XX_SOC_PALM27X
 	  Say Y if you want to add support for SoC audio on
 	  Palm T|X, T5, E2 or LifeDrive handheld computer.

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
index caa03d8..315941f 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -19,6 +19,7 @@ snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
 snd-soc-palm27x-objs := palm27x.o
+snd-soc-tavorevb3-objs := tavorevb3.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
@@ -38,6 +39,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_PXA2XX_SOC_Z2) += snd-soc-z2.o
+obj-$(CONFIG_SND_SOC_TAVOREVB3) += snd-soc-tavorevb3.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/pxa2xx-ssp.c b/sound/soc/pxa/pxa2xx-ssp.c
new file mode 100644
index 0000000..5eab055
--- /dev/null
+++ b/sound/soc/pxa/pxa2xx-ssp.c
@@ -0,0 +1,532 @@
+/*
+ * pxa2xx-ssp.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2005,2008 Wolfson Microelectronics PLC.
+ * Author: Liam Girdwood
+ *         Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * Copyright 2009-2010 Marvell International Ltd.
+ * Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * TODO:
+ *  o Test network mode for > 16bit sample size
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
+
+#include <mach/hardware.h>
+#include <mach/dma.h>
+#include <mach/regs-ssp.h>
+#include <mach/audio.h>
+#include <plat/ssp.h>
+
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ssp.h"
+#include "ssp.h"
+
+static void dump_registers(struct ssp_device *ssp)
+{
+	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
+		 ssp_read_reg(ssp, SSCR0), ssp_read_reg(ssp, SSCR1),
+		 ssp_read_reg(ssp, SSTO));
+
+	dev_dbg(&ssp->pdev->dev, "SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x\n",
+		 ssp_read_reg(ssp, SSPSP), ssp_read_reg(ssp, SSSR),
+		 ssp_read_reg(ssp, SSACD));
+}
+
+/**
+ * ssp_set_clkdiv - set SSP clock divider
+ * @div: serial clock rate divider
+ */
+static void ssp_set_scr(struct ssp_device *ssp, u32 div)
+{
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+
+	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
+		sscr0 &= ~0x0000ff00;
+		sscr0 |= ((div - 2)/2) << 8; /* 2..512 */
+	} else {
+		sscr0 &= ~0x000fff00;
+		sscr0 |= (div - 1) << 8;     /* 1..4096 */
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+}
+
+/**
+ * ssp_get_clkdiv - get SSP clock divider
+ */
+static u32 ssp_get_scr(struct ssp_device *ssp)
+{
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+	u32 div;
+
+	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
+		div = ((sscr0 >> 8) & 0xff) * 2 + 2;
+	else
+		div = ((sscr0 >> 8) & 0xfff) + 1;
+	return div;
+}
+
+/*
+ * Set the SSP ports SYSCLK.
+ */
+static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
+				     unsigned int freq, int dir)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	int val;
+
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0) &
+		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+
+	dev_dbg(&ssp->pdev->dev,
+		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
+		cpu_dai->id, clk_id, freq);
+
+	switch (clk_id) {
+	case PXA2XX_SSP_CLK_NET_PLL:
+		sscr0 |= SSCR0_MOD;
+		break;
+	case PXA2XX_SSP_CLK_PLL:
+		/* Internal PLL is fixed */
+		if (cpu_is_pxa25x())
+			info->sysclk = 1843200;
+		else
+			info->sysclk = 13000000;
+		break;
+	case PXA2XX_SSP_CLK_EXT:
+		info->sysclk = freq;
+		sscr0 |= SSCR0_ECS;
+		break;
+	case PXA2XX_SSP_CLK_NET:
+		info->sysclk = freq;
+		sscr0 |= SSCR0_NCS | SSCR0_MOD;
+		break;
+	case PXA2XX_SSP_CLK_AUDIO:
+		info->sysclk = 0;
+		ssp_set_scr(ssp, 1);
+		sscr0 |= SSCR0_ACS;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	/* The SSP clock must be disabled when changing SSP clock mode
+	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
+	if (!cpu_is_pxa3xx())
+		clk_disable(info->dev.ssp->clk);
+	val = ssp_read_reg(ssp, SSCR0) | sscr0;
+	ssp_write_reg(ssp, SSCR0, val);
+	if (!cpu_is_pxa3xx())
+		clk_enable(info->dev.ssp->clk);
+
+	return 0;
+}
+
+/*
+ * Set the SSP clock dividers.
+ */
+static int pxa2xx_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
+				     int div_id, int div)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	int val;
+
+	switch (div_id) {
+	case PXA2XX_SSP_AUDIO_DIV_ACDS:
+		val = (ssp_read_reg(ssp, SSACD) & ~0x7) | SSACD_ACDS(div);
+		ssp_write_reg(ssp, SSACD, val);
+		break;
+	case PXA2XX_SSP_AUDIO_DIV_SCDB:
+		val = ssp_read_reg(ssp, SSACD);
+		val &= ~SSACD_SCDB;
+		if (cpu_is_pxa3xx())
+			val &= ~SSACD_SCDX8;
+		switch (div) {
+		case PXA2XX_SSP_CLK_SCDB_1:
+			val |= SSACD_SCDB;
+			break;
+		case PXA2XX_SSP_CLK_SCDB_4:
+			break;
+		case PXA2XX_SSP_CLK_SCDB_8:
+			if (cpu_is_pxa3xx())
+				val |= SSACD_SCDX8;
+			else
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ssp_write_reg(ssp, SSACD, val);
+		break;
+	case PXA2XX_SSP_DIV_SCR:
+		ssp_set_scr(ssp, div);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * Configure the PLL frequency pxa27x and (afaik - pxa320 only)
+ */
+static int pxa2xx_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
+				  int source, unsigned int freq_in,
+				  unsigned int freq_out)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;
+
+	if (cpu_is_pxa3xx())
+		ssp_write_reg(ssp, SSACDD, 0);
+
+	switch (freq_out) {
+	case 5622000:
+		break;
+	case 11345000:
+		ssacd |= (0x1 << 4);
+		break;
+	case 12235000:
+		ssacd |= (0x2 << 4);
+		break;
+	case 14857000:
+		ssacd |= (0x3 << 4);
+		break;
+	case 32842000:
+		ssacd |= (0x4 << 4);
+		break;
+	case 48000000:
+		ssacd |= (0x5 << 4);
+		break;
+	case 0:
+		/* Disable */
+		break;
+
+	default:
+		/* PXA3xx has a clock ditherer which can be used to generate
+		 * a wider range of frequencies - calculate a value for it.
+		 */
+		if (cpu_is_pxa3xx()) {
+			u32 val;
+			u64 tmp = 19968;
+			tmp *= 1000000;
+			do_div(tmp, freq_out);
+			val = tmp;
+
+			val = (val << 16) | 64;
+			ssp_write_reg(ssp, SSACDD, val);
+
+			ssacd |= (0x6 << 4);
+
+			dev_dbg(&ssp->pdev->dev,
+				"Using SSACDD %x to supply %uHz\n",
+				val, freq_out);
+			break;
+		}
+
+		return -EINVAL;
+	}
+
+	ssp_write_reg(ssp, SSACD, ssacd);
+
+	return 0;
+}
+
+/*
+ * Set up the SSP DAI format.
+ * The SSP Port must be inactive before calling this function as the
+ * physical interface format is changed.
+ */
+static int pxa2xx_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+				  unsigned int fmt)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	u32 sscr0;
+	u32 sscr1;
+	u32 sspsp;
+
+	/* check if we need to change anything at all */
+	if (info->dai_fmt == fmt)
+		return 0;
+
+	/* we can only change the settings if the port is not in use */
+	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
+		dev_err(&ssp->pdev->dev,
+			"can't change hardware dai format: stream is in use");
+		return -EINVAL;
+	}
+
+	/* reset port settings */
+	sscr0 = ssp_read_reg(ssp, SSCR0) &
+		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
+	sspsp = 0;
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
+	case SND_SOC_DAIFMT_DSP_A:
+		sspsp |= SSPSP_FSRT;
+	case SND_SOC_DAIFMT_DSP_B:
+		sscr0 |= SSCR0_MOD | SSCR0_PSP;
+		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ssp_write_reg(ssp, SSCR0, sscr0);
+	ssp_write_reg(ssp, SSCR1, sscr1);
+	ssp_write_reg(ssp, SSPSP, sspsp);
+
+	dump_registers(ssp);
+
+	/* Since we are configuring the timings for the format by hand
+	 * we have to defer some things until hw_params() where we
+	 * know parameters like the sample size.
+	 */
+	info->dai_fmt = fmt;
+
+	return 0;
+}
+
+/*
+ * Set the SSP audio DMA parameters and sample size.
+ * Can be called multiple times by oss emulation.
+ */
+static int pxa2xx_ssp_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	int chn = params_channels(params);
+	u32 sscr0;
+	u32 sspsp;
+	int width = snd_pcm_format_physical_width(params_format(params));
+	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
+
+	/* generate correct DMA params */
+	if (cpu_dai->dma_data)
+		kfree(cpu_dai->dma_data);
+
+	/* Network mode with one active slot (ttsa == 1) can be used
+	 * to force 16-bit frame width on the wire (for S16_LE), even
+	 * with two channels. Use 16-bit DMA transfers for this case.
+	 */
+	cpu_dai->dma_data = pxa_ssp_get_dma_params(ssp,
+			((chn == 2) && (ttsa != 1)) || (width == 32),
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	/* we can only change the settings if the port is not in use */
+	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
+		return 0;
+
+	/* clear selected SSP bits */
+	sscr0 = ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
+	ssp_write_reg(ssp, SSCR0, sscr0);
+
+	/* bit size */
+	sscr0 = ssp_read_reg(ssp, SSCR0);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		if (cpu_is_pxa3xx())
+			sscr0 |= SSCR0_FPCKE;
+		sscr0 |= SSCR0_DataSize(16);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
+		break;
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+
+	switch (info->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	       sspsp = ssp_read_reg(ssp, SSPSP);
+
+		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {
+			/* This is a special case where the bitclk is 64fs
+			* and we're not dealing with 2*32 bits of audio
+			* samples.
+			*
+			* The SSP values used for that are all found out by
+			* trying and failing a lot; some of the registers
+			* needed for that mode are only available on PXA3xx.
+			*/
+
+			if (!cpu_is_pxa3xx())
+				return -EINVAL;
+
+			sspsp |= SSPSP_SFRMWDTH(width * 2);
+			sspsp |= SSPSP_SFRMDLY(width * 4);
+			sspsp |= SSPSP_EDMYSTOP(3);
+			sspsp |= SSPSP_DMYSTOP(3);
+			sspsp |= SSPSP_DMYSTRT(1);
+		} else {
+			/* The frame width is the width the LRCLK is
+			 * asserted for; the delay is expressed in
+			 * half cycle units.  We need the extra cycle
+			 * because the data starts clocking out one BCLK
+			 * after LRCLK changes polarity.
+			 */
+			sspsp |= SSPSP_SFRMWDTH(width + 1);
+			sspsp |= SSPSP_SFRMDLY((width + 1) * 2);
+			sspsp |= SSPSP_DMYSTRT(1);
+		}
+
+		ssp_write_reg(ssp, SSPSP, sspsp);
+		break;
+	default:
+		break;
+	}
+
+	/* When we use a network mode, we always require TDM slots
+	 * - complain loudly and fail if they've not been set up yet.
+	 */
+	if ((sscr0 & SSCR0_MOD) && !ttsa) {
+		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
+		return -EINVAL;
+	}
+
+	dump_registers(ssp);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops pxa2xx_ssp_dai_ops = {
+	.hw_params	= pxa2xx_ssp_hw_params,
+	.set_sysclk	= pxa2xx_ssp_set_dai_sysclk,
+	.set_clkdiv	= pxa2xx_ssp_set_dai_clkdiv,
+	.set_pll	= pxa2xx_ssp_set_dai_pll,
+	.set_fmt	= pxa2xx_ssp_set_dai_fmt,
+};
+
+struct snd_soc_dai pxa2xx_ssp_dai[PXA2XX_DAI_SSP_MAX];
+EXPORT_SYMBOL(pxa2xx_ssp_dai);
+
+static int __devinit pxa2xx_ssp_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai *dai;
+	int ret;
+
+	if (pdev->id >= PXA2XX_DAI_SSP_MAX) {
+		dev_err(&pdev->dev, "id %d is out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	dai = &pxa2xx_ssp_dai[pdev->id];
+	dai->dev = &pdev->dev;
+	dai->name = "pxa2xx-ssp";
+	dai->id = pdev->id;
+	dai->playback.channels_min = 1;
+	dai->playback.channels_max = 8;
+	dai->playback.rates = PXA2XX_SSP_RATES;
+	dai->playback.formats = PXA2XX_SSP_FORMATS;
+	dai->capture.channels_min = 1;
+	dai->capture.channels_max = 8;
+	dai->capture.rates = PXA2XX_SSP_RATES;
+	dai->capture.formats = PXA2XX_SSP_FORMATS;
+	dai->ops = &pxa2xx_ssp_dai_ops;
+
+	ret = pxa_ssp_register_dai(dai);
+	return ret;
+}
+
+static int __devexit pxa2xx_ssp_dev_remove(struct platform_device *pdev)
+{
+	struct snd_soc_dai *dai;
+
+	dai = &pxa2xx_ssp_dai[pdev->id];
+	snd_soc_unregister_dai(dai);
+	return 0;
+}
+
+static struct platform_driver pxa2xx_ssp_driver = {
+	.probe	= pxa2xx_ssp_dev_probe,
+	.remove	= __devexit_p(pxa2xx_ssp_dev_remove),
+	.driver	= {
+		.name	= "pxa2xx-ssp",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init pxa2xx_ssp_init(void)
+{
+	return platform_driver_register(&pxa2xx_ssp_driver);
+}
+module_init(pxa2xx_ssp_init);
+
+static void __exit pxa2xx_ssp_exit(void)
+{
+	platform_driver_unregister(&pxa2xx_ssp_driver);
+}
+module_exit(pxa2xx_ssp_exit);
+
+/* Module information */
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_DESCRIPTION("PXA SSP/PCM SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa2xx-ssp.h b/sound/soc/pxa/pxa2xx-ssp.h
new file mode 100644
index 0000000..2455bf4
--- /dev/null
+++ b/sound/soc/pxa/pxa2xx-ssp.h
@@ -0,0 +1,59 @@
+/*
+ * ASoC PXA SSP port support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PXA2XX_SOC_SSP_H
+#define __PXA2XX_SOC_SSP_H
+
+#define PXA2XX_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+			  SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
+			  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |	\
+			  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define PXA2XX_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			    SNDRV_PCM_FMTBIT_S24_LE |	\
+			    SNDRV_PCM_FMTBIT_S32_LE)
+
+/* pxa DAI SSP IDs */
+enum {
+	PXA2XX_DAI_SSP1,
+	PXA2XX_DAI_SSP2,
+	PXA2XX_DAI_SSP3,
+	PXA2XX_DAI_SSP4,
+	PXA2XX_DAI_SSP_MAX,
+};
+
+/* SSP clock sources */
+#define PXA2XX_SSP_CLK_PLL			0
+#define PXA2XX_SSP_CLK_EXT			1
+#define PXA2XX_SSP_CLK_NET			2
+#define PXA2XX_SSP_CLK_AUDIO			3
+#define PXA2XX_SSP_CLK_NET_PLL			4
+
+/* SSP audio dividers */
+#define PXA2XX_SSP_AUDIO_DIV_ACDS		0
+#define PXA2XX_SSP_AUDIO_DIV_SCDB		1
+#define PXA2XX_SSP_DIV_SCR			2
+
+/* SSP ACDS audio dividers values */
+#define PXA2XX_SSP_CLK_AUDIO_DIV_1		0
+#define PXA2XX_SSP_CLK_AUDIO_DIV_2		1
+#define PXA2XX_SSP_CLK_AUDIO_DIV_4		2
+#define PXA2XX_SSP_CLK_AUDIO_DIV_8		3
+#define PXA2XX_SSP_CLK_AUDIO_DIV_16		4
+#define PXA2XX_SSP_CLK_AUDIO_DIV_32		5
+
+/* SSP divider bypass */
+#define PXA2XX_SSP_CLK_SCDB_4			0
+#define PXA2XX_SSP_CLK_SCDB_1			1
+#define PXA2XX_SSP_CLK_SCDB_8			2
+
+#define PXA2XX_SSP_PLL_OUT  			0
+
+extern struct snd_soc_dai pxa2xx_ssp_dai[PXA2XX_DAI_SSP_MAX];
+
+#endif	/* __PXA2XX_SOC_SSP_H */
diff --git a/sound/soc/pxa/ssp.c b/sound/soc/pxa/ssp.c
new file mode 100644
index 0000000..444b643
--- /dev/null
+++ b/sound/soc/pxa/ssp.c
@@ -0,0 +1,298 @@
+/*
+ * ssp.c  --  ALSA Soc Audio Layer
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
+#include <linux/clk.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/pxa2xx-lib.h>
+
+#include <mach/hardware.h>
+#include <mach/dma.h>
+#include <mach/regs-ssp.h>
+
+#include <plat/ssp.h>
+
+#include "ssp.h"
+
+struct pxa2xx_pcm_dma_data {
+	struct pxa2xx_pcm_dma_params params;
+	char name[20];
+};
+
+struct pxa2xx_pcm_dma_params *
+pxa_ssp_get_dma_params(struct ssp_device *ssp, int width4, int out)
+{
+	struct pxa2xx_pcm_dma_data *dma;
+
+	dma = kzalloc(sizeof(struct pxa2xx_pcm_dma_data), GFP_KERNEL);
+	if (dma == NULL)
+		return NULL;
+
+	snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
+			width4 ? "32-bit" : "16-bit", out ? "out" : "in");
+
+	dma->params.name = dma->name;
+	dma->params.drcmr = &DRCMR(out ? ssp->drcmr_tx : ssp->drcmr_rx);
+	dma->params.dcmd = (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG) :
+				  (DCMD_INCTRGADDR | DCMD_FLOWSRC)) |
+			(width4 ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
+	dma->params.dev_addr = ssp->phys_base + SSDR;
+
+	return &dma->params;
+}
+EXPORT_SYMBOL(pxa_ssp_get_dma_params);
+
+static int pxa_ssp_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ssp_info *info = cpu_dai->private_data;
+	int ret = 0;
+
+	if (!cpu_dai->active) {
+		info->dev.port = cpu_dai->id + 1;
+		info->dev.irq = NO_IRQ;
+		clk_enable(info->dev.ssp->clk);
+		ssp_disable(&info->dev);
+	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
+	return ret;
+}
+
+static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ssp_info *info = cpu_dai->private_data;
+
+	if (!cpu_dai->active) {
+		ssp_disable(&info->dev);
+		clk_disable(info->dev.ssp->clk);
+	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
+}
+
+#ifdef CONFIG_PM
+
+static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+
+	if (!cpu_dai->active)
+		clk_enable(info->dev.ssp->clk);
+
+	ssp_save_state(&info->dev, &info->state);
+	clk_disable(info->dev.ssp->clk);
+
+	return 0;
+}
+
+static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+
+	clk_enable(info->dev.ssp->clk);
+	ssp_restore_state(&info->dev, &info->state);
+
+	if (cpu_dai->active)
+		ssp_enable(&info->dev);
+	else
+		clk_disable(info->dev.ssp->clk);
+
+	return 0;
+}
+
+#else
+#define pxa_ssp_suspend	NULL
+#define pxa_ssp_resume	NULL
+#endif
+
+/*
+ * Set the active slots in TDM/Network mode
+ */
+static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	u32 sscr0;
+
+	sscr0 = ssp_read_reg(ssp, SSCR0);
+	sscr0 &= ~(SSCR0_MOD | SSCR0_SlotsPerFrm(8) | SSCR0_EDSS | SSCR0_DSS);
+
+	/* set slot width */
+	if (slot_width > 16)
+		sscr0 |= SSCR0_EDSS | SSCR0_DataSize(slot_width - 16);
+	else
+		sscr0 |= SSCR0_DataSize(slot_width);
+
+	if (slots > 1) {
+		/* enable network mode */
+		sscr0 |= SSCR0_MOD;
+
+		/* set number of active slots */
+		sscr0 |= SSCR0_SlotsPerFrm(slots);
+
+		/* set active slot mask */
+		ssp_write_reg(ssp, SSTSA, tx_mask);
+		ssp_write_reg(ssp, SSRSA, rx_mask);
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+
+	return 0;
+}
+
+/*
+ * Tristate the SSP DAI lines
+ */
+static int pxa_ssp_set_dai_tristate(struct snd_soc_dai *cpu_dai,
+	int tristate)
+{
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	u32 sscr1;
+
+	sscr1 = ssp_read_reg(ssp, SSCR1);
+	if (tristate)
+		sscr1 &= ~SSCR1_TTE;
+	else
+		sscr1 |= SSCR1_TTE;
+	ssp_write_reg(ssp, SSCR1, sscr1);
+
+	return 0;
+}
+
+static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret = 0;
+	struct ssp_info *info = cpu_dai->private_data;
+	struct ssp_device *ssp = info->dev.ssp;
+	int val;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ssp_enable(&info->dev);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		val = ssp_read_reg(ssp, SSCR1);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			val |= SSCR1_TSRE;
+		else
+			val |= SSCR1_RSRE;
+		ssp_write_reg(ssp, SSCR1, val);
+		val = ssp_read_reg(ssp, SSSR);
+		ssp_write_reg(ssp, SSSR, val);
+		break;
+	case SNDRV_PCM_TRIGGER_START:
+		val = ssp_read_reg(ssp, SSCR1);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			val |= SSCR1_TSRE;
+		else
+			val |= SSCR1_RSRE;
+		ssp_write_reg(ssp, SSCR1, val);
+		ssp_enable(&info->dev);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		val = ssp_read_reg(ssp, SSCR1);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			val &= ~SSCR1_TSRE;
+		else
+			val &= ~SSCR1_RSRE;
+		ssp_write_reg(ssp, SSCR1, val);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ssp_disable(&info->dev);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		val = ssp_read_reg(ssp, SSCR1);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			val &= ~SSCR1_TSRE;
+		else
+			val &= ~SSCR1_RSRE;
+		ssp_write_reg(ssp, SSCR1, val);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int pxa_ssp_probe(struct platform_device *pdev,
+			    struct snd_soc_dai *dai)
+{
+	struct ssp_info *info;
+	int ret;
+
+	info = kzalloc(sizeof(struct ssp_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
+	if (info->dev.ssp == NULL) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	info->dai_fmt = (unsigned int) -1;
+	dai->private_data = info;
+
+	return 0;
+
+err:
+	kfree(info);
+	return ret;
+}
+
+static void pxa_ssp_remove(struct platform_device *pdev,
+			      struct snd_soc_dai *dai)
+{
+	struct ssp_info *info = dai->private_data;
+	ssp_free(info->dev.ssp);
+}
+
+int pxa_ssp_register_dai(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dai_ops *ops = dai->ops;
+
+	ops->startup = pxa_ssp_startup;
+	ops->shutdown = pxa_ssp_shutdown;
+	ops->trigger = pxa_ssp_trigger;
+	ops->set_tdm_slot = pxa_ssp_set_dai_tdm_slot;
+	ops->set_tristate = pxa_ssp_set_dai_tristate;
+
+	dai->probe = pxa_ssp_probe;
+	dai->remove = pxa_ssp_remove;
+	dai->suspend = pxa_ssp_suspend;
+	dai->resume = pxa_ssp_resume;
+
+	return snd_soc_register_dai(dai);
+}
+EXPORT_SYMBOL(pxa_ssp_register_dai);
diff --git a/sound/soc/pxa/ssp.h b/sound/soc/pxa/ssp.h
new file mode 100644
index 0000000..314c06d
--- /dev/null
+++ b/sound/soc/pxa/ssp.h
@@ -0,0 +1,42 @@
+/*
+ * ssp.h  --  ALSA Soc Audio Layer Head file
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
+#ifndef __PXA_SSP_H
+#define __PXA_SSP_H
+
+/*
+ * SSP audio data
+ */
+struct ssp_info {
+	struct ssp_dev		dev;
+	unsigned int		sysclk;
+	int			dai_fmt;
+#ifdef CONFIG_PM
+	struct ssp_state	state;
+#endif
+};
+
+struct dai_ssp {
+	unsigned int		sysclk;
+	int			dai_fmt;
+#ifdef CONFIG_PM
+	struct ssp_state	state;
+#endif
+};
+
+extern struct pxa2xx_pcm_dma_params *
+pxa_ssp_get_dma_params(struct ssp_device *ssp, int width4, int out);
+extern int pxa_ssp_register_dai(struct snd_soc_dai *dai);
+
+#endif	/* __PXA_SSP_H */
diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
new file mode 100644
index 0000000..3ee39d4
--- /dev/null
+++ b/sound/soc/pxa/tavorevb3.c
@@ -0,0 +1,193 @@
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
+#include "pxa-ssp.h"
+
+static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd);
+
+static struct platform_device *evb3_snd_device;
+
+static struct snd_soc_jack hs_jack;
+
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{ .pin = "Headset Stereophone",	.mask = SND_JACK_HEADPHONE, },
+	{ .pin = "Headset Mic 2",	.mask = SND_JACK_MICROPHONE, },
+};
+
+/* tavorevb3 machine dapm widgets */
+static const struct snd_soc_dapm_widget evb3_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 1", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 2", NULL),
+	SND_SOC_DAPM_SPK("Ext Speaker", NULL),
+	SND_SOC_DAPM_MIC("Ext Mic 1", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic 2", NULL),
+	SND_SOC_DAPM_MIC("Ext Mic 3", NULL),
+};
+
+/* tavorevb3 machine audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headset Stereophone", NULL, "HS1"},
+	{"Headset Stereophone", NULL, "HS2"},
+
+	{"Ext Speaker", NULL, "LSP"},
+	{"Ext Speaker", NULL, "LSN"},
+
+	{"Lineout Out 1", NULL, "LINEOUT1"},
+	{"Lineout Out 2", NULL, "LINEOUT2"},
+
+	{"MIC1P", NULL, "Mic1 Bias"},
+	{"MIC1N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Ext Mic 1"},
+
+	{"MIC2P", NULL, "Mic1 Bias"},
+	{"MIC2N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Headset Mic 2"},
+
+	{"MIC3P", NULL, "Mic3 Bias"},
+	{"MIC3N", NULL, "Mic3 Bias"},
+	{"Mic3 Bias", NULL, "Ext Mic 3"},
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
+	snd_soc_dapm_new_controls(codec, evb3_dapm_widgets,
+				  ARRAY_SIZE(evb3_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	/* connected pins */
+	snd_soc_dapm_enable_pin(codec, "Ext Speaker");
+	snd_soc_dapm_enable_pin(codec, "Ext Mic 1");
+	snd_soc_dapm_enable_pin(codec, "Ext Mic 3");
+	snd_soc_dapm_disable_pin(codec, "Headset Mic 2");
+	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
+
+	ret = snd_soc_dapm_sync(codec);
+	if (ret)
+		return ret;
+
+	/* Headset jack detection */
+	snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET
+			| SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
+			&hs_jack);
+	snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+			      hs_jack_pins);
+	/* headphone, microphone detection & headset short detection */
+	pm860x_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET,
+			      SND_JACK_BTN_0);
+	pm860x_hook_detect(codec, &hs_jack, SND_JACK_BTN_1, SND_JACK_BTN_2);
+	return 0;
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
+MODULE_DESCRIPTION("ALSA SoC 88PM860x Tavor EVB3");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5
