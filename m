From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 10:45:30 -0400
Subject: [PATCH] ASoC: split pxa ssp for reusing code
Message-ID: <mailman.247.1269013925.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since basic SSP features are shared between PXA2xx and PXA168, the difference
is focused on clock generating. Now split ssp code into two parts. One is for
general ssp feature. The other is for pxa2xx parts.

hw_params() isn't put in common ssp files since cpu_is_pxa3xx() is used. The
cpu_is_pxa3xx() macro is only valid in ARCH_PXA and it's used to distinguish
pxa2xx and pxa3xx. This macro is meaning less in other architectures. So keep
this function in device specific driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig      |    8 +-
 sound/soc/pxa/Makefile     |    4 +-
 sound/soc/pxa/magician.c   |   38 ++--
 sound/soc/pxa/pxa-ssp.c    |  680 +++++++------------------------------------
 sound/soc/pxa/pxa-ssp.h    |   51 ++--
 sound/soc/pxa/pxa2xx-ssp.c |  431 ++++++++++++++++++++++++++++
 sound/soc/pxa/pxa2xx-ssp.h |   51 ++++
 sound/soc/pxa/raumfeld.c   |   14 +-
 sound/soc/pxa/zylonite.c   |    6 +-
 9 files changed, 647 insertions(+), 636 deletions(-)
 create mode 100644 sound/soc/pxa/pxa2xx-ssp.c
 create mode 100644 sound/soc/pxa/pxa2xx-ssp.h

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 78e6121..7be1d5f 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -21,7 +21,7 @@ config SND_PXA2XX_SOC_AC97
 config SND_PXA2XX_SOC_I2S
 	tristate

-config SND_PXA_SOC_SSP
+config SND_PXA2XX_SOC_SSP
 	tristate
 	select PXA_SSP

@@ -113,7 +113,7 @@ config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
 	select SND_PXA2XX_SOC_AC97
-	select SND_PXA_SOC_SSP
+	select SND_PXA2XX_SOC_SSP
 	select SND_SOC_WM9713
 	help
 	  Say Y if you want to add support for SoC audio on the
@@ -122,7 +122,7 @@ config SND_SOC_ZYLONITE
 config SND_SOC_RAUMFELD
 	tristate "SoC Audio support Raumfeld audio adapter"
 	depends on SND_PXA2XX_SOC && (MACH_RAUMFELD_SPEAKER ||
MACH_RAUMFELD_CONNECTOR)
-	select SND_PXA_SOC_SSP
+	select SND_PXA2XX_SOC_SSP
 	select SND_SOC_CS4270
 	select SND_SOC_AK4104
 	help
@@ -132,7 +132,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 	tristate "SoC Audio support for HTC Magician"
 	depends on SND_PXA2XX_SOC && MACH_MAGICIAN
 	select SND_PXA2XX_SOC_I2S
-	select SND_PXA_SOC_SSP
+	select SND_PXA2XX_SOC_SSP
 	select SND_SOC_UDA1380
 	help
 	  Say Y if you want to add support for SoC audio on the
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index f3e08fd..33c1579 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -2,12 +2,12 @@
 snd-soc-pxa2xx-objs := pxa2xx-pcm.o
 snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
 snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
-snd-soc-pxa-ssp-objs := pxa-ssp.o
+snd-soc-pxa2xx-ssp-objs := pxa-ssp.o pxa2xx-ssp.o

 obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
 obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
 obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
-obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
+obj-$(CONFIG_SND_PXA2XX_SOC_SSP) += snd-soc-pxa2xx-ssp.o

 # PXA Machine Support
 snd-soc-corgi-objs := corgi.o
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 4c8d99a..da6ff83 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -34,7 +34,7 @@
 #include "../codecs/uda1380.h"
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-i2s.h"
-#include "pxa-ssp.h"
+#include "pxa2xx-ssp.h"

 #define MAGICIAN_MIC       0
 #define MAGICIAN_MIC_EXT   1
@@ -89,7 +89,7 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	unsigned int acps, acds, width, rate;
-	unsigned int div4 = PXA_SSP_CLK_SCDB_4;
+	unsigned int div4 = PXA2XX_SSP_CLK_SCDB_4;
 	int ret = 0;

 	rate = params_rate(params);
@@ -106,11 +106,11 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		switch (width) {
 		case 16:
 			/* 513156 Hz ~= _2_ * 8000 Hz * 32 (+0.23%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_16;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_16;
 			break;
 		default: /* 32 */
 			/* 1026312 Hz ~= _2_ * 8000 Hz * 64 (+0.23%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_8;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_8;
 		}
 		break;
 	case 11025:
@@ -118,11 +118,11 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		switch (width) {
 		case 16:
 			/* 351375 Hz ~= 11025 Hz * 32 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_4;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_4;
 			break;
 		default: /* 32 */
 			/* 702750 Hz ~= 11025 Hz * 64 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_2;
 		}
 		break;
 	case 22050:
@@ -130,11 +130,11 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		switch (width) {
 		case 16:
 			/* 702750 Hz ~= 22050 Hz * 32 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_2;
 			break;
 		default: /* 32 */
 			/* 1405500 Hz ~= 22050 Hz * 64 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_1;
 		}
 		break;
 	case 44100:
@@ -142,11 +142,11 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		switch (width) {
 		case 16:
 			/* 1405500 Hz ~= 44100 Hz * 32 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_2;
 			break;
 		default: /* 32 */
 			/* 2811000 Hz ~= 44100 Hz * 64 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_1;
 		}
 		break;
 	case 48000:
@@ -154,11 +154,11 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		switch (width) {
 		case 16:
 			/* 1529375 Hz ~= 48000 Hz * 32 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_2;
 			break;
 		default: /* 32 */
 			/* 3058750 Hz ~= 48000 Hz * 64 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_1;
 		}
 		break;
 	case 96000:
@@ -167,12 +167,12 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		switch (width) {
 		case 16:
 			/* 3058750 Hz ~= 96000 Hz * 32 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_1;
 			break;
 		default: /* 32 */
 			/* 6117500 Hz ~= 96000 Hz * 64 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
-			div4 = PXA_SSP_CLK_SCDB_1;
+			acds = PXA2XX_SSP_CLK_AUDIO_DIV_2;
+			div4 = PXA2XX_SSP_CLK_SCDB_1;
 			break;
 		}
 		break;
@@ -195,20 +195,20 @@ static int magician_playback_hw_params(struct
snd_pcm_substream *substream,
 		return ret;

 	/* set audio clock as clock source */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0,
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_SSP_CLK_AUDIO, 0,
 			SND_SOC_CLOCK_OUT);
 	if (ret < 0)
 		return ret;

 	/* set the SSP audio system clock ACDS divider */
 	ret = snd_soc_dai_set_clkdiv(cpu_dai,
-			PXA_SSP_AUDIO_DIV_ACDS, acds);
+			PXA2XX_SSP_AUDIO_DIV_ACDS, acds);
 	if (ret < 0)
 		return ret;

 	/* set the SSP audio system clock SCDB divider4 */
 	ret = snd_soc_dai_set_clkdiv(cpu_dai,
-			PXA_SSP_AUDIO_DIV_SCDB, div4);
+			PXA2XX_SSP_AUDIO_DIV_SCDB, div4);
 	if (ret < 0)
 		return ret;

@@ -427,7 +427,7 @@ static struct snd_soc_dai_link magician_dai[] = {
 {
 	.name = "uda1380",
 	.stream_name = "UDA1380 Playback",
-	.cpu_dai = &pxa_ssp_dai[PXA_DAI_SSP1],
+	.cpu_dai = &pxa2xx_ssp_dai[PXA2XX_DAI_SSP1],
 	.codec_dai = &uda1380_dai[UDA1380_DAI_PLAYBACK],
 	.init = magician_uda1380_init,
 	.ops = &magician_playback_ops,
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4ca9245..4ba1ede 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -5,53 +5,29 @@
  * Author: Liam Girdwood
  *         Mark Brown <broonie@opensource.wolfsonmicro.com>
  *
+ * Copyright 2010 Marvell International Ltd.
+ * Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
- *
- * TODO:
- *  o Test network mode for > 16bit sample size
  */

-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/io.h>
-
-#include <asm/irq.h>
-
 #include <sound/core.h>
+#include <sound/soc.h>
 #include <sound/pcm.h>
-#include <sound/initval.h>
 #include <sound/pcm_params.h>
-#include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>

 #include <mach/hardware.h>
 #include <mach/dma.h>
-#include <mach/audio.h>
 #include <plat/ssp.h>

 #include "pxa2xx-pcm.h"
 #include "pxa-ssp.h"

-/*
- * SSP audio private data
- */
-struct ssp_priv {
-	struct ssp_device *ssp;
-	unsigned int sysclk;
-	int dai_fmt;
-#ifdef CONFIG_PM
-	uint32_t	cr0;
-	uint32_t	cr1;
-	uint32_t	to;
-	uint32_t	psp;
-#endif
-};
-
 static void dump_registers(struct ssp_device *ssp)
 {
 	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
@@ -63,7 +39,7 @@ static void dump_registers(struct ssp_device *ssp)
 		 ssp_read_reg(ssp, SSACD));
 }

-static void ssp_enable(struct ssp_device *ssp)
+void ssp_enable(struct ssp_device *ssp)
 {
 	uint32_t sscr0;

@@ -71,7 +47,7 @@ static void ssp_enable(struct ssp_device *ssp)
 	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
 }

-static void ssp_disable(struct ssp_device *ssp)
+void ssp_disable(struct ssp_device *ssp)
 {
 	uint32_t sscr0;

@@ -84,7 +60,7 @@ struct pxa2xx_pcm_dma_data {
 	char name[20];
 };

-static struct pxa2xx_pcm_dma_params *
+struct pxa2xx_pcm_dma_params *
 ssp_get_dma_params(struct ssp_device *ssp, int width4, int out)
 {
 	struct pxa2xx_pcm_dma_data *dma;
@@ -105,6 +81,96 @@ ssp_get_dma_params(struct ssp_device *ssp, int
width4, int out)

 	return &dma->params;
 }
+EXPORT_SYMBOL_GPL(ssp_get_dma_params);
+
+/*
+ * Set up the SSP DAI format.
+ * The SSP Port must be inactive before calling this function as the
+ * physical interface format is changed.
+ */
+static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+				unsigned int fmt)
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

 static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
@@ -193,216 +259,6 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 #define pxa_ssp_resume	NULL
 #endif

-/**
- * ssp_set_clkdiv - set SSP clock divider
- * @div: serial clock rate divider
- */
-static void ssp_set_scr(struct ssp_device *ssp, u32 div)
-{
-	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
-
-	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
-		sscr0 &= ~0x0000ff00;
-		sscr0 |= ((div - 2)/2) << 8; /* 2..512 */
-	} else {
-		sscr0 &= ~0x000fff00;
-		sscr0 |= (div - 1) << 8;     /* 1..4096 */
-	}
-	ssp_write_reg(ssp, SSCR0, sscr0);
-}
-
-/**
- * ssp_get_clkdiv - get SSP clock divider
- */
-static u32 ssp_get_scr(struct ssp_device *ssp)
-{
-	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
-	u32 div;
-
-	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
-		div = ((sscr0 >> 8) & 0xff) * 2 + 2;
-	else
-		div = ((sscr0 >> 8) & 0xfff) + 1;
-	return div;
-}
-
-/*
- * Set the SSP ports SYSCLK.
- */
-static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-	int clk_id, unsigned int freq, int dir)
-{
-	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->ssp;
-	int val;
-
-	u32 sscr0 = ssp_read_reg(ssp, SSCR0) &
-		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
-
-	dev_dbg(&ssp->pdev->dev,
-		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
-		cpu_dai->id, clk_id, freq);
-
-	switch (clk_id) {
-	case PXA_SSP_CLK_NET_PLL:
-		sscr0 |= SSCR0_MOD;
-		break;
-	case PXA_SSP_CLK_PLL:
-		/* Internal PLL is fixed */
-		if (cpu_is_pxa25x())
-			priv->sysclk = 1843200;
-		else
-			priv->sysclk = 13000000;
-		break;
-	case PXA_SSP_CLK_EXT:
-		priv->sysclk = freq;
-		sscr0 |= SSCR0_ECS;
-		break;
-	case PXA_SSP_CLK_NET:
-		priv->sysclk = freq;
-		sscr0 |= SSCR0_NCS | SSCR0_MOD;
-		break;
-	case PXA_SSP_CLK_AUDIO:
-		priv->sysclk = 0;
-		ssp_set_scr(ssp, 1);
-		sscr0 |= SSCR0_ACS;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	/* The SSP clock must be disabled when changing SSP clock mode
-	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
-	if (!cpu_is_pxa3xx())
-		clk_disable(ssp->clk);
-	val = ssp_read_reg(ssp, SSCR0) | sscr0;
-	ssp_write_reg(ssp, SSCR0, val);
-	if (!cpu_is_pxa3xx())
-		clk_enable(ssp->clk);
-
-	return 0;
-}
-
-/*
- * Set the SSP clock dividers.
- */
-static int pxa_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
-	int div_id, int div)
-{
-	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->ssp;
-	int val;
-
-	switch (div_id) {
-	case PXA_SSP_AUDIO_DIV_ACDS:
-		val = (ssp_read_reg(ssp, SSACD) & ~0x7) | SSACD_ACDS(div);
-		ssp_write_reg(ssp, SSACD, val);
-		break;
-	case PXA_SSP_AUDIO_DIV_SCDB:
-		val = ssp_read_reg(ssp, SSACD);
-		val &= ~SSACD_SCDB;
-#if defined(CONFIG_PXA3xx)
-		if (cpu_is_pxa3xx())
-			val &= ~SSACD_SCDX8;
-#endif
-		switch (div) {
-		case PXA_SSP_CLK_SCDB_1:
-			val |= SSACD_SCDB;
-			break;
-		case PXA_SSP_CLK_SCDB_4:
-			break;
-#if defined(CONFIG_PXA3xx)
-		case PXA_SSP_CLK_SCDB_8:
-			if (cpu_is_pxa3xx())
-				val |= SSACD_SCDX8;
-			else
-				return -EINVAL;
-			break;
-#endif
-		default:
-			return -EINVAL;
-		}
-		ssp_write_reg(ssp, SSACD, val);
-		break;
-	case PXA_SSP_DIV_SCR:
-		ssp_set_scr(ssp, div);
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-/*
- * Configure the PLL frequency pxa27x and (afaik - pxa320 only)
- */
-static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
-	int source, unsigned int freq_in, unsigned int freq_out)
-{
-	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->ssp;
-	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;
-
-#if defined(CONFIG_PXA3xx)
-	if (cpu_is_pxa3xx())
-		ssp_write_reg(ssp, SSACDD, 0);
-#endif
-
-	switch (freq_out) {
-	case 5622000:
-		break;
-	case 11345000:
-		ssacd |= (0x1 << 4);
-		break;
-	case 12235000:
-		ssacd |= (0x2 << 4);
-		break;
-	case 14857000:
-		ssacd |= (0x3 << 4);
-		break;
-	case 32842000:
-		ssacd |= (0x4 << 4);
-		break;
-	case 48000000:
-		ssacd |= (0x5 << 4);
-		break;
-	case 0:
-		/* Disable */
-		break;
-
-	default:
-#ifdef CONFIG_PXA3xx
-		/* PXA3xx has a clock ditherer which can be used to generate
-		 * a wider range of frequencies - calculate a value for it.
-		 */
-		if (cpu_is_pxa3xx()) {
-			u32 val;
-			u64 tmp = 19968;
-			tmp *= 1000000;
-			do_div(tmp, freq_out);
-			val = tmp;
-
-			val = (val << 16) | 64;
-			ssp_write_reg(ssp, SSACDD, val);
-
-			ssacd |= (0x6 << 4);
-
-			dev_dbg(&ssp->pdev->dev,
-				"Using SSACDD %x to supply %uHz\n",
-				val, freq_out);
-			break;
-		}
-#endif
-
-		return -EINVAL;
-	}
-
-	ssp_write_reg(ssp, SSACD, ssacd);
-
-	return 0;
-}
-
 /*
  * Set the active slots in TDM/Network mode
  */
@@ -458,213 +314,6 @@ static int pxa_ssp_set_dai_tristate(struct
snd_soc_dai *cpu_dai,
 	return 0;
 }

-/*
- * Set up the SSP DAI format.
- * The SSP Port must be inactive before calling this function as the
- * physical interface format is changed.
- */
-static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-		unsigned int fmt)
-{
-	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->ssp;
-	u32 sscr0;
-	u32 sscr1;
-	u32 sspsp;
-
-	/* check if we need to change anything at all */
-	if (priv->dai_fmt == fmt)
-		return 0;
-
-	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
-		dev_err(&ssp->pdev->dev,
-			"can't change hardware dai format: stream is in use");
-		return -EINVAL;
-	}
-
-	/* reset port settings */
-	sscr0 = ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
-	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
-	sspsp = 0;
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR;
-		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
-		sscr1 |= SSCR1_SCLKDIR;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		sspsp |= SSPSP_SFRMP;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		sspsp |= SSPSP_SCMODE(2);
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		sspsp |= SSPSP_SCMODE(2) | SSPSP_SFRMP;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		sscr0 |= SSCR0_PSP;
-		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
-		/* See hw_params() */
-		break;
-
-	case SND_SOC_DAIFMT_DSP_A:
-		sspsp |= SSPSP_FSRT;
-	case SND_SOC_DAIFMT_DSP_B:
-		sscr0 |= SSCR0_MOD | SSCR0_PSP;
-		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	ssp_write_reg(ssp, SSCR0, sscr0);
-	ssp_write_reg(ssp, SSCR1, sscr1);
-	ssp_write_reg(ssp, SSPSP, sspsp);
-
-	dump_registers(ssp);
-
-	/* Since we are configuring the timings for the format by hand
-	 * we have to defer some things until hw_params() where we
-	 * know parameters like the sample size.
-	 */
-	priv->dai_fmt = fmt;
-
-	return 0;
-}
-
-/*
- * Set the SSP audio DMA parameters and sample size.
- * Can be called multiple times by oss emulation.
- */
-static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params,
-				struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->ssp;
-	int chn = params_channels(params);
-	u32 sscr0;
-	u32 sspsp;
-	int width = snd_pcm_format_physical_width(params_format(params));
-	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
-
-	/* generate correct DMA params */
-	if (cpu_dai->dma_data)
-		kfree(cpu_dai->dma_data);
-
-	/* Network mode with one active slot (ttsa == 1) can be used
-	 * to force 16-bit frame width on the wire (for S16_LE), even
-	 * with two channels. Use 16-bit DMA transfers for this case.
-	 */
-	cpu_dai->dma_data = ssp_get_dma_params(ssp,
-			((chn == 2) && (ttsa != 1)) || (width == 32),
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
-
-	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
-		return 0;
-
-	/* clear selected SSP bits */
-	sscr0 = ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	ssp_write_reg(ssp, SSCR0, sscr0);
-
-	/* bit size */
-	sscr0 = ssp_read_reg(ssp, SSCR0);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-#ifdef CONFIG_PXA3xx
-		if (cpu_is_pxa3xx())
-			sscr0 |= SSCR0_FPCKE;
-#endif
-		sscr0 |= SSCR0_DataSize(16);
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
-		break;
-	}
-	ssp_write_reg(ssp, SSCR0, sscr0);
-
-	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-	       sspsp = ssp_read_reg(ssp, SSPSP);
-
-		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {
-			/* This is a special case where the bitclk is 64fs
-			* and we're not dealing with 2*32 bits of audio
-			* samples.
-			*
-			* The SSP values used for that are all found out by
-			* trying and failing a lot; some of the registers
-			* needed for that mode are only available on PXA3xx.
-			*/
-
-#ifdef CONFIG_PXA3xx
-			if (!cpu_is_pxa3xx())
-				return -EINVAL;
-
-			sspsp |= SSPSP_SFRMWDTH(width * 2);
-			sspsp |= SSPSP_SFRMDLY(width * 4);
-			sspsp |= SSPSP_EDMYSTOP(3);
-			sspsp |= SSPSP_DMYSTOP(3);
-			sspsp |= SSPSP_DMYSTRT(1);
-#else
-			return -EINVAL;
-#endif
-		} else {
-			/* The frame width is the width the LRCLK is
-			 * asserted for; the delay is expressed in
-			 * half cycle units.  We need the extra cycle
-			 * because the data starts clocking out one BCLK
-			 * after LRCLK changes polarity.
-			 */
-			sspsp |= SSPSP_SFRMWDTH(width + 1);
-			sspsp |= SSPSP_SFRMDLY((width + 1) * 2);
-			sspsp |= SSPSP_DMYSTRT(1);
-		}
-
-		ssp_write_reg(ssp, SSPSP, sspsp);
-		break;
-	default:
-		break;
-	}
-
-	/* When we use a network mode, we always require TDM slots
-	 * - complain loudly and fail if they've not been set up yet.
-	 */
-	if ((sscr0 & SSCR0_MOD) && !ttsa) {
-		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
-		return -EINVAL;
-	}
-
-	dump_registers(ssp);
-
-	return 0;
-}
-
 static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai)
 {
@@ -760,128 +409,21 @@ static void pxa_ssp_remove(struct platform_device *pdev,
 	ssp_free(priv->ssp);
 }

-#define PXA_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-			  SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
-			  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |	\
-			  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-#define PXA_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
-			    SNDRV_PCM_FMTBIT_S24_LE |	\
-			    SNDRV_PCM_FMTBIT_S32_LE)
-
-static struct snd_soc_dai_ops pxa_ssp_dai_ops = {
-	.startup	= pxa_ssp_startup,
-	.shutdown	= pxa_ssp_shutdown,
-	.trigger	= pxa_ssp_trigger,
-	.hw_params	= pxa_ssp_hw_params,
-	.set_sysclk	= pxa_ssp_set_dai_sysclk,
-	.set_clkdiv	= pxa_ssp_set_dai_clkdiv,
-	.set_pll	= pxa_ssp_set_dai_pll,
-	.set_fmt	= pxa_ssp_set_dai_fmt,
-	.set_tdm_slot	= pxa_ssp_set_dai_tdm_slot,
-	.set_tristate	= pxa_ssp_set_dai_tristate,
-};
+int ssp_register_dai(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dai_ops *ops = dai->ops;

-struct snd_soc_dai pxa_ssp_dai[] = {
-	{
-		.name = "pxa2xx-ssp1",
-		.id = 0,
-		.probe = pxa_ssp_probe,
-		.remove = pxa_ssp_remove,
-		.suspend = pxa_ssp_suspend,
-		.resume = pxa_ssp_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		},
-		.capture = {
-			 .channels_min = 1,
-			 .channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		 },
-		.ops = &pxa_ssp_dai_ops,
-	},
-	{	.name = "pxa2xx-ssp2",
-		.id = 1,
-		.probe = pxa_ssp_probe,
-		.remove = pxa_ssp_remove,
-		.suspend = pxa_ssp_suspend,
-		.resume = pxa_ssp_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		 },
-		.ops = &pxa_ssp_dai_ops,
-	},
-	{
-		.name = "pxa2xx-ssp3",
-		.id = 2,
-		.probe = pxa_ssp_probe,
-		.remove = pxa_ssp_remove,
-		.suspend = pxa_ssp_suspend,
-		.resume = pxa_ssp_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		 },
-		.ops = &pxa_ssp_dai_ops,
-	},
-	{
-		.name = "pxa2xx-ssp4",
-		.id = 3,
-		.probe = pxa_ssp_probe,
-		.remove = pxa_ssp_remove,
-		.suspend = pxa_ssp_suspend,
-		.resume = pxa_ssp_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 8,
-			.rates = PXA_SSP_RATES,
-			.formats = PXA_SSP_FORMATS,
-		 },
-		.ops = &pxa_ssp_dai_ops,
-	},
-};
-EXPORT_SYMBOL_GPL(pxa_ssp_dai);
+	ops->startup = pxa_ssp_startup;
+	ops->shutdown = pxa_ssp_shutdown;
+	ops->trigger = pxa_ssp_trigger;
+	ops->set_fmt = pxa_ssp_set_dai_fmt;
+	ops->set_tdm_slot = pxa_ssp_set_dai_tdm_slot;
+	ops->set_tristate = pxa_ssp_set_dai_tristate;

-static int __init pxa_ssp_init(void)
-{
-	return snd_soc_register_dais(pxa_ssp_dai, ARRAY_SIZE(pxa_ssp_dai));
-}
-module_init(pxa_ssp_init);
+	dai->probe = pxa_ssp_probe;
+	dai->remove = pxa_ssp_remove;
+	dai->suspend = pxa_ssp_suspend;
+	dai->resume = pxa_ssp_resume;

-static void __exit pxa_ssp_exit(void)
-{
-	snd_soc_unregister_dais(pxa_ssp_dai, ARRAY_SIZE(pxa_ssp_dai));
+	return snd_soc_register_dai(dai);
 }
-module_exit(pxa_ssp_exit);
-
-/* Module information */
-MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-MODULE_DESCRIPTION("PXA SSP/PCM SoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa-ssp.h b/sound/soc/pxa/pxa-ssp.h
index 91deadd..ea9c4a0 100644
--- a/sound/soc/pxa/pxa-ssp.h
+++ b/sound/soc/pxa/pxa-ssp.h
@@ -9,39 +9,26 @@
 #ifndef _PXA_SSP_H
 #define _PXA_SSP_H

-/* pxa DAI SSP IDs */
-#define PXA_DAI_SSP1			0
-#define PXA_DAI_SSP2			1
-#define PXA_DAI_SSP3			2
-#define PXA_DAI_SSP4			3

-/* SSP clock sources */
-#define PXA_SSP_CLK_PLL	0
-#define PXA_SSP_CLK_EXT	1
-#define PXA_SSP_CLK_NET	2
-#define PXA_SSP_CLK_AUDIO	3
-#define PXA_SSP_CLK_NET_PLL	4
-
-/* SSP audio dividers */
-#define PXA_SSP_AUDIO_DIV_ACDS		0
-#define PXA_SSP_AUDIO_DIV_SCDB		1
-#define PXA_SSP_DIV_SCR				2
-
-/* SSP ACDS audio dividers values */
-#define PXA_SSP_CLK_AUDIO_DIV_1		0
-#define PXA_SSP_CLK_AUDIO_DIV_2		1
-#define PXA_SSP_CLK_AUDIO_DIV_4		2
-#define PXA_SSP_CLK_AUDIO_DIV_8		3
-#define PXA_SSP_CLK_AUDIO_DIV_16	4
-#define PXA_SSP_CLK_AUDIO_DIV_32	5
-
-/* SSP divider bypass */
-#define PXA_SSP_CLK_SCDB_4		0
-#define PXA_SSP_CLK_SCDB_1		1
-#define PXA_SSP_CLK_SCDB_8		2
-
-#define PXA_SSP_PLL_OUT  0
+/*
+ * SSP audio data
+ */
+struct ssp_priv {
+	struct ssp_device	*ssp;
+	unsigned int		sysclk;
+	int			dai_fmt;
+#ifdef CONFIG_PM
+	uint32_t		cr0;
+	uint32_t		cr1;
+	uint32_t		to;
+	uint32_t		psp;
+#endif
+};

-extern struct snd_soc_dai pxa_ssp_dai[4];
+extern void ssp_enable(struct ssp_device *ssp);
+extern void ssp_disable(struct ssp_device *ssp);
+extern struct pxa2xx_pcm_dma_params *
+ssp_get_dma_params(struct ssp_device *ssp, int width4, int out);
+extern int ssp_register_dai(struct snd_soc_dai *dai);

 #endif
diff --git a/sound/soc/pxa/pxa2xx-ssp.c b/sound/soc/pxa/pxa2xx-ssp.c
new file mode 100644
index 0000000..b2ac121
--- /dev/null
+++ b/sound/soc/pxa/pxa2xx-ssp.c
@@ -0,0 +1,431 @@
+/*
+ * pxa2xx-ssp.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2005,2008 Wolfson Microelectronics PLC.
+ * Author: Liam Girdwood
+ *         Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * Copyright 2010 Marvell International Ltd.
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
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
+
+#include <mach/hardware.h>
+#include <mach/dma.h>
+#include <plat/ssp.h>
+
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ssp.h"
+#include "pxa-ssp.h"
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
+static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
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
+			priv->sysclk = 1843200;
+		else
+			priv->sysclk = 13000000;
+		break;
+	case PXA2XX_SSP_CLK_EXT:
+		priv->sysclk = freq;
+		sscr0 |= SSCR0_ECS;
+		break;
+	case PXA2XX_SSP_CLK_NET:
+		priv->sysclk = freq;
+		sscr0 |= SSCR0_NCS | SSCR0_MOD;
+		break;
+	case PXA2XX_SSP_CLK_AUDIO:
+		priv->sysclk = 0;
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
+		clk_disable(ssp->clk);
+	val = ssp_read_reg(ssp, SSCR0) | sscr0;
+	ssp_write_reg(ssp, SSCR0, val);
+	if (!cpu_is_pxa3xx())
+		clk_enable(ssp->clk);
+
+	return 0;
+}
+
+/*
+ * Set the SSP clock dividers.
+ */
+static int pxa2xx_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
+				int div_id, int div)
+{
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
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
+#if defined(CONFIG_PXA3xx)
+		if (cpu_is_pxa3xx())
+			val &= ~SSACD_SCDX8;
+#endif
+		switch (div) {
+		case PXA2XX_SSP_CLK_SCDB_1:
+			val |= SSACD_SCDB;
+			break;
+		case PXA2XX_SSP_CLK_SCDB_4:
+			break;
+#if defined(CONFIG_PXA3xx)
+		case PXA2XX_SSP_CLK_SCDB_8:
+			if (cpu_is_pxa3xx())
+				val |= SSACD_SCDX8;
+			else
+				return -EINVAL;
+			break;
+#endif
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
+				int source, unsigned int freq_in,
+				unsigned int freq_out)
+{
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
+	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;
+
+#if defined(CONFIG_PXA3xx)
+	if (cpu_is_pxa3xx())
+		ssp_write_reg(ssp, SSACDD, 0);
+#endif
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
+#ifdef CONFIG_PXA3xx
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
+#endif
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
+ * Set the SSP audio DMA parameters and sample size.
+ * Can be called multiple times by oss emulation.
+ */
+static int pxa2xx_ssp_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ssp_priv *priv = cpu_dai->private_data;
+	struct ssp_device *ssp = priv->ssp;
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
+	cpu_dai->dma_data = ssp_get_dma_params(ssp,
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
+#ifdef CONFIG_PXA3xx
+		if (cpu_is_pxa3xx())
+			sscr0 |= SSCR0_FPCKE;
+#endif
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
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
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
+#ifdef CONFIG_PXA3xx
+			if (!cpu_is_pxa3xx())
+				return -EINVAL;
+
+			sspsp |= SSPSP_SFRMWDTH(width * 2);
+			sspsp |= SSPSP_SFRMDLY(width * 4);
+			sspsp |= SSPSP_EDMYSTOP(3);
+			sspsp |= SSPSP_DMYSTOP(3);
+			sspsp |= SSPSP_DMYSTRT(1);
+#else
+			return -EINVAL;
+#endif
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
+	return 0;
+}
+
+static struct snd_soc_dai_ops pxa2xx_ssp_dai_ops = {
+	.hw_params	= pxa2xx_ssp_hw_params,
+	.set_sysclk	= pxa2xx_ssp_set_dai_sysclk,
+	.set_clkdiv	= pxa2xx_ssp_set_dai_clkdiv,
+	.set_pll	= pxa2xx_ssp_set_dai_pll,
+};
+
+#define PXA2XX_SSP_RATES	SNDRV_PCM_RATE_8000_96000
+#define PXA2XX_SSP_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |	\
+				SNDRV_PCM_FMTBIT_S24_LE |	\
+				SNDRV_PCM_FMTBIT_S32_LE)
+
+#define PXA2XX_SSP_DAI(_id)					\
+{								\
+	.name	= "pxa2xx-ssp",					\
+	.id	= _id,						\
+	.playback = {						\
+		.channels_min = 1,				\
+		.channels_max = 8,				\
+		.rates = PXA2XX_SSP_RATES,			\
+		.formats = PXA2XX_SSP_FORMATS,			\
+	},							\
+	.capture = {						\
+		.channels_min = 1,				\
+		.channels_max = 8,				\
+		.rates = PXA2XX_SSP_RATES,			\
+		.formats = PXA2XX_SSP_FORMATS,			\
+	},							\
+	.ops = &pxa2xx_ssp_dai_ops,				\
+}
+
+struct snd_soc_dai pxa2xx_ssp_dai[] = {
+	PXA2XX_SSP_DAI(PXA2XX_DAI_SSP1),
+	PXA2XX_SSP_DAI(PXA2XX_DAI_SSP2),
+	PXA2XX_SSP_DAI(PXA2XX_DAI_SSP3),
+	PXA2XX_SSP_DAI(PXA2XX_DAI_SSP4),
+};
+EXPORT_SYMBOL_GPL(pxa2xx_ssp_dai);
+
+static int __init pxa2xx_ssp_init(void)
+{
+	struct snd_soc_dai *dai;
+	int i, ret;
+
+	for (i = 0; i < PXA2XX_DAI_SSP_MAX; i++) {
+		dai = &pxa2xx_ssp_dai[i];
+		ret = ssp_register_dai(dai);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+module_init(pxa2xx_ssp_init);
+
+static void __exit pxa2xx_ssp_exit(void)
+{
+	struct snd_soc_dai *dai = NULL;
+	int i;
+
+	for (i = 0; i < PXA2XX_DAI_SSP_MAX; i++) {
+		dai = &pxa2xx_ssp_dai[i];
+		snd_soc_unregister_dai(dai);
+	}
+}
+module_exit(pxa2xx_ssp_exit);
+
+/* Module information */
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_DESCRIPTION("PXA2xx SSP/PCM SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa2xx-ssp.h b/sound/soc/pxa/pxa2xx-ssp.h
new file mode 100644
index 0000000..cb75985
--- /dev/null
+++ b/sound/soc/pxa/pxa2xx-ssp.h
@@ -0,0 +1,51 @@
+
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
+#endif		/* __PXA2XX_SOC_SSP_H */
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 7e3f416..e66dc12 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -29,7 +29,7 @@
 #include "../codecs/cs4270.h"
 #include "../codecs/ak4104.h"
 #include "pxa2xx-pcm.h"
-#include "pxa-ssp.h"
+#include "pxa2xx-ssp.h"

 #define GPIO_SPDIF_RESET	(38)
 #define GPIO_MCLK_RESET		(111)
@@ -138,11 +138,11 @@ static int raumfeld_cs4270_hw_params(struct
snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;

-	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA2XX_SSP_DIV_SCR, 4);
 	if (ret < 0)
 		return ret;

-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 1);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_SSP_CLK_EXT, clk, 1);
 	if (ret < 0)
 		return ret;

@@ -170,7 +170,7 @@ static int raumfeld_line_resume(struct
platform_device *pdev)
 static struct snd_soc_dai_link raumfeld_line_dai = {
 	.name		= "CS4270",
 	.stream_name	= "CS4270",
-	.cpu_dai	= &pxa_ssp_dai[PXA_DAI_SSP1],
+	.cpu_dai	= &pxa2xx_ssp_dai[PXA2XX_DAI_SSP1],
 	.codec_dai	= &cs4270_dai,
 	.ops		= &raumfeld_cs4270_ops,
 };
@@ -232,11 +232,11 @@ static int raumfeld_ak4104_hw_params(struct
snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;

-	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA2XX_SSP_DIV_SCR, 4);
 	if (ret < 0)
 		return ret;

-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 1);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_SSP_CLK_EXT, clk, 1);
 	if (ret < 0)
 		return ret;

@@ -250,7 +250,7 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 static struct snd_soc_dai_link raumfeld_spdif_dai = {
 	.name		= "ak4104",
 	.stream_name	= "Playback",
-	.cpu_dai	= &pxa_ssp_dai[PXA_DAI_SSP2],
+	.cpu_dai	= &pxa2xx_ssp_dai[PXA2XX_DAI_SSP2],
 	.codec_dai	= &ak4104_dai,
 	.ops		= &raumfeld_ak4104_ops,
 };
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index dd678ae..c65e0db 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -25,7 +25,7 @@
 #include "../codecs/wm9713.h"
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
-#include "pxa-ssp.h"
+#include "pxa2xx-ssp.h"

 /*
  * There is a physical switch SW15 on the board which changes the MCLK
@@ -125,7 +125,7 @@ static int zylonite_voice_hw_params(struct
snd_pcm_substream *substream,
 	/* Add 1 to the width for the leading clock cycle */
 	pll_out = rate * (width + 1) * 8;

-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0, 1);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_SSP_CLK_AUDIO, 0, 1);
 	if (ret < 0)
 		return ret;

@@ -176,7 +176,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 {
 	.name = "WM9713 Voice",
 	.stream_name = "WM9713 Voice",
-	.cpu_dai = &pxa_ssp_dai[PXA_DAI_SSP3],
+	.cpu_dai = &pxa2xx_ssp_dai[PXA2XX_DAI_SSP3],
 	.codec_dai = &wm9713_dai[WM9713_DAI_PCM_VOICE],
 	.ops = &zylonite_voice_ops,
 },
-- 
1.5.6.5
