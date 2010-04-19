From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 19 Apr 2010 12:35:19 +0100
Subject: [alsa-devel] [PATCH 3/4] ASoC: support pxa168 ssp in ASoC
In-Reply-To: <w2t771cded01004162236m32c46db0t14ad4d17fc5faa68@mail.gmail.com>
References: <w2t771cded01004162236m32c46db0t14ad4d17fc5faa68@mail.gmail.com>
Message-ID: <1271676919.3208.61.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-04-17 at 13:36 +0800, Haojian Zhuang wrote:
> >From 0539606a09ecc94f45dcf4c793ba46c1f10738b1 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 17 Mar 2010 17:31:04 -0400
> Subject: [PATCH] ASoC: support pxa168 ssp in ASoC
> 
> Support pxa168 ssp in ASoC. The SSP bit clock mechanism is totally different
> from pxa2xx series.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/mach-mmp/include/mach/regs-mpmu.h |   48 ++++++
>  sound/soc/pxa/Kconfig                      |    6 +-
>  sound/soc/pxa/Makefile                     |    2 +
>  sound/soc/pxa/pxa-ssp.h                    |    1 +
>  sound/soc/pxa/pxa168-ssp.c                 |  233 ++++++++++++++++++++++++++++
>  sound/soc/pxa/pxa168-ssp.h                 |   27 ++++
>  6 files changed, 316 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mmp/include/mach/regs-mpmu.h
>  create mode 100644 sound/soc/pxa/pxa168-ssp.c
>  create mode 100644 sound/soc/pxa/pxa168-ssp.h
> 
> diff --git a/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> new file mode 100644
> index 0000000..0d57236
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> @@ -0,0 +1,48 @@
> +/*
> + * linux/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> + *
> + *   Main Power Management Unit
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MACH_REGS_MPMU_H
> +#define __ASM_MACH_REGS_MPMU_H
> +
> +#include <mach/addr-map.h>
> +
> +#define MPMU_VIRT_BASE	(APB_VIRT_BASE + 0x50000)
> +#define MPMU_REG(off)	(MPMU_VIRT_BASE + (off))
> +
> +#define MPMU_CPCR	MPMU_REG(0x0000)
> +#define MPMU_FCCR	MPMU_REG(0x0008)
> +#define MPMU_POCR	MPMU_REG(0x000c)
> +#define MPMU_POSR	MPMU_REG(0x0010)
> +#define MPMU_SUCCR	MPMU_REG(0x0014)
> +#define MPMU_VRCR	MPMU_REG(0x0018)
> +#define MPMU_OHCR	MPMU_REG(0x001c)
> +#define MPMU_GPCR	MPMU_REG(0x0030)
> +#define MPMU_PLL2CR	MPMU_REG(0x0034)
> +#define MPMU_SCCR	MPMU_REG(0x0038)
> +#define MPMU_CWUCRM	MPMU_REG(0x004c)
> +#define MPMU_PLL1_REG1	MPMU_REG(0x0050)
> +#define MPMU_PLL1_REG2	MPMU_REG(0x0054)
> +#define MPMU_PLL1_SSC	MPMU_REG(0x0058)
> +#define MPMU_PLL2_REG1	MPMU_REG(0x0060)
> +#define MPMU_PLL2_REG2	MPMU_REG(0x0064)
> +#define MPMU_PLL2_SSC	MPMU_REG(0x0068)
> +#define MPMU_TS		MPMU_REG(0x0080)
> +#define MPMU_WDTPCR	MPMU_REG(0x0200)
> +#define MPMU_APCR	MPMU_REG(0x1000)
> +#define MPMU_APSR	MPMU_REG(0x1004)
> +#define MPMU_APRR	MPMU_REG(0x1020)
> +#define MPMU_ACGR	MPMU_REG(0x1024)
> +#define MPMU_ARSR	MPMU_REG(0x1028)
> +#define MPMU_AWUCRS	MPMU_REG(0x1048)
> +#define MPMU_AWUCRM	MPMU_REG(0x104c)
> +#define MPMU_ASYSDR	MPMU_REG(0x1050)
> +#define MPMU_ASSPDR	MPMU_REG(0x1054)
> +
> +#endif /* __ASM_MACH_REGS_APMU_H */
> diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
> index 7be1d5f..286d52a 100644
> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -1,6 +1,6 @@
>  config SND_PXA2XX_SOC
>  	tristate "SoC Audio for the Intel PXA2xx chip"
> -	depends on ARCH_PXA
> +	depends on ARCH_PXA || ARCH_MMP
>  	select SND_PXA2XX_LIB
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
> @@ -25,6 +25,10 @@ config SND_PXA2XX_SOC_SSP
>  	tristate
>  	select PXA_SSP
> 
> +config SND_PXA168_SOC_SSP
> +	tristate
> +	select PXA_SSP
> +
>  config SND_PXA2XX_SOC_CORGI
>  	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
>  	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx
> diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
> index 33c1579..a74e6c9 100644
> --- a/sound/soc/pxa/Makefile
> +++ b/sound/soc/pxa/Makefile
> @@ -3,11 +3,13 @@ snd-soc-pxa2xx-objs := pxa2xx-pcm.o
>  snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
>  snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
>  snd-soc-pxa2xx-ssp-objs := pxa-ssp.o pxa2xx-ssp.o
> +snd-soc-pxa168-ssp-objs := pxa-ssp.o pxa168-ssp.o
> 
>  obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
>  obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
>  obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
>  obj-$(CONFIG_SND_PXA2XX_SOC_SSP) += snd-soc-pxa2xx-ssp.o
> +obj-$(CONFIG_SND_PXA168_SOC_SSP) += snd-soc-pxa168-ssp.o
> 
>  # PXA Machine Support
>  snd-soc-corgi-objs := corgi.o
> diff --git a/sound/soc/pxa/pxa-ssp.h b/sound/soc/pxa/pxa-ssp.h
> index af4a09b..852660a 100644
> --- a/sound/soc/pxa/pxa-ssp.h
> +++ b/sound/soc/pxa/pxa-ssp.h
> @@ -15,6 +15,7 @@
>  struct ssp_priv {
>  	struct ssp_device	*ssp;
>  	unsigned int		sysclk;
> +	unsigned int		sysclk_idx;
>  	int			dai_fmt;
>  #ifdef CONFIG_PM
>  	uint32_t		cr0;
> diff --git a/sound/soc/pxa/pxa168-ssp.c b/sound/soc/pxa/pxa168-ssp.c
> new file mode 100644
> index 0000000..487e899
> --- /dev/null
> +++ b/sound/soc/pxa/pxa168-ssp.c
> @@ -0,0 +1,233 @@
> +/*
> + * pxa168-ssp.c  --  ALSA Soc Audio Layer
> + *
> + * Copyright 2009-2010 Marvell International Ltd.
> + *	Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + * TODO:
> + *  o Test network mode
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/pxa2xx-lib.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/dma.h>
> +#include <mach/regs-apbc.h>
> +#include <mach/regs-apmu.h>
> +#include <mach/regs-mpmu.h>
> +#include <plat/ssp.h>
> +
> +#include "pxa2xx-pcm.h"
> +#include "pxa168-ssp.h"
> +#include "pxa-ssp.h"
> +
> +struct pxa168_ssp_mclk {
> +	unsigned int	rate;
> +	unsigned int	format;
> +	unsigned int	channel;
> +	unsigned int	mclk;
> +	unsigned int	mclk_denom;
> +	unsigned int	mclk_num;
> +	unsigned int	bclk;
> +	unsigned int	bclk_denom;
> +	unsigned int	bclk_num;
> +};
> +
> +/*
> + * This table is used while CPU is clock master.
> + * MCLK = 312MHz * ASYSCLK_DENOM / ASYSCLK_NUM
> + * BCLK = MCLK * SSPSCLK_DENOM / SSPSCLK_NUM
> + */
> +static const struct pxa168_ssp_mclk mclk_conf[] = {
> +	/* rate, fmt, chn, mclk,   den, num, bclk, den, num */
> +	{96000, 16, 2, 12288000,  64, 1625, 6144000,  1,  2},
> +	{96000, 16, 1, 12288000,  64, 1625, 1536000,  1,  8},
> +	{88200, 16, 2, 11289600, 294, 8125, 5644800,  1,  2},
> +	{88200, 16, 1, 11289600, 294, 8125, 1411200,  1,  8},
> +	{48000, 16, 2, 12288000,  64, 1625, 3072000,  1,  4},
> +	{48000, 16, 1, 12288000,  64, 1625,  768000,  1, 16},
> +	{44100, 16, 2, 11289600, 294, 8125, 2822400,  1,  4},
> +	{44100, 16, 1, 11289600, 294, 8125,  705600,  1, 16},
> +	{32000, 16, 2, 12288000,  64, 1625, 2048000,  1,  6},
> +	{32000, 16, 1, 12288000,  64, 1625,  512000,  1, 24},
> +	{22050, 16, 2, 11289600, 294, 8125, 1411200,  1,  8},
> +	{22050, 16, 1, 11289600, 294, 8125,  352800,  1, 32},
> +	{16000, 16, 2, 12288000,  64, 1625, 1024000,  1, 12},
> +	{16000, 16, 1, 12288000,  64, 1625,  256000,  1, 48},
> +	{11025, 16, 2, 11289600, 294, 8125,  705600,  1, 16},
> +	{11025, 16, 1, 11289600, 294, 8125,  176400,  1, 64},
> +	{ 8000, 16, 2, 12288000,  64, 1625,  512000,  1, 24},
> +	{ 8000, 16, 1, 12288000,  64, 1625,  128000,  1, 96},
> +};
> +
> +int pxa168_query_mclk(struct snd_pcm_substream *substream,
> +		      struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct ssp_priv *priv = cpu_dai->private_data;
> +	unsigned int rate, width, channel;
> +	int i, ret = -EINVAL;
> +
> +	rate =  params_rate(params);
> +	width = snd_pcm_format_physical_width(params_format(params));
> +	channel = params_channels(params);
> +
> +	for (i = 0; i < ARRAY_SIZE(mclk_conf); i++) {
> +		if ((mclk_conf[i].rate == rate)
> +			&& (mclk_conf[i].format == width)
> +			&& (mclk_conf[i].channel == channel)) {
> +			/* save both mclk and mclk index into ssp_priv */
> +			priv->sysclk = mclk_conf[i].mclk;
> +			priv->sysclk_idx = i;
> +			ret = priv->sysclk;
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pxa168_query_mclk);
> +
> +/*
> + * Set the SSP ports SYSCLK only from Audio SYSCLK.
> + */
> +static int pxa168_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
> +				     unsigned int freq, int dir)
> +{
> +	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> +	unsigned int sscr0, data, asysdr, asspdr;
> +
> +	dev_dbg(&ssp->pdev->dev, "%s id: %d, clk_id %d, freq %u\n",
> +		__func__, cpu_dai->id, clk_id, freq);
> +
> +	/* freq is the index of mclk_conf table */
> +	if ((freq < 0) || (priv->sysclk_idx >= ARRAY_SIZE(mclk_conf))) {
> +		dev_warn(&ssp->pdev->dev, "Wrong frequency on SYSCLK\n");
> +		return -EINVAL;
> +	}
> +	asysdr = (mclk_conf[priv->sysclk_idx].mclk_num << 16)
> +		| mclk_conf[priv->sysclk_idx].mclk_denom;
> +	asspdr = 0;
> +	/* If ASYSCLK is supplied by pxa168, ASSPDR should be configured. */
> +	if (dir == SND_SOC_CLOCK_OUT)
> +		asspdr = (mclk_conf[priv->sysclk_idx].bclk_num << 16)
> +			| mclk_conf[priv->sysclk_idx].bclk_denom;
> +
> +	pxa_ssp_disable(ssp);
> +	clk_disable(ssp->clk);			/* SSP port internal clock */

Again, we should not disable when the SSP is active.

Thanks

Liam


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
