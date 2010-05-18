From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 18 May 2010 12:54:53 -0500
Subject: [RFC PATCH 1/3] ep93xx i2s driver
In-Reply-To: <4BF21D48.3020005@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
	<4BF21D48.3020005@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B0270842697636F14EB75@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 17, 2010 9:53 PM, Ryan Mallon wrote:
> Add ep93xx i2s audio driver
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index b1749bc..f7cb451 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -28,6 +28,7 @@ source "sound/soc/atmel/Kconfig"
>  source "sound/soc/au1x/Kconfig"
>  source "sound/soc/blackfin/Kconfig"
>  source "sound/soc/davinci/Kconfig"
> +source "sound/soc/ep93xx/Kconfig"
>  source "sound/soc/fsl/Kconfig"
>  source "sound/soc/imx/Kconfig"
>  source "sound/soc/omap/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 1470141..55b711a 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SND_SOC) += atmel/
>  obj-$(CONFIG_SND_SOC)        += au1x/
>  obj-$(CONFIG_SND_SOC)        += blackfin/
>  obj-$(CONFIG_SND_SOC)        += davinci/
> +obj-$(CONFIG_SND_SOC)        += ep93xx/
>  obj-$(CONFIG_SND_SOC)        += fsl/
>  obj-$(CONFIG_SND_SOC)   += imx/
>  obj-$(CONFIG_SND_SOC)        += omap/
> diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
> new file mode 100644
> index 0000000..6af5dd8
> --- /dev/null
> +++ b/sound/soc/ep93xx/Kconfig
> @@ -0,0 +1,15 @@
> +config SND_EP93XX_SOC
> +     tristate "SoC Audio support for the Cirrus Logic EP93xx series"
> +     depends on ARCH_EP93XX && SND_SOC
> +     help
> +       Say Y or M if you want to add support for codecs attached to
> +       the EP93xx I2S interface.
> +
> +config SND_EP93XX_SOC_I2S
> +     tristate
> +
> +config SND_EP93XX_SOC_SNAPPERCL15
> +        tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
> +        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15
> +        select SND_EP93XX_SOC_I2S
> +        select SND_SOC_TLV320AIC23

Missing help text?

> diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
> new file mode 100644
> index 0000000..272e60f
> --- /dev/null
> +++ b/sound/soc/ep93xx/Makefile
> @@ -0,0 +1,11 @@
> +# EP93xx Platform Support
> +snd-soc-ep93xx-objs                          := ep93xx-pcm.o
> +snd-soc-ep93xx-i2s-objs                              := ep93xx-i2s.o
> +
> +obj-$(CONFIG_SND_EP93XX_SOC)                 += snd-soc-ep93xx.o
> +obj-$(CONFIG_SND_EP93XX_SOC_I2S)             += snd-soc-ep93xx-i2s.o
> +
> +# EP93XX Machine Support
> +snd-soc-snappercl15-objs                     := snappercl15.o
> +
> +obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)     += snd-soc-snappercl15.o
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
> new file mode 100644
> index 0000000..a81a18d
> --- /dev/null
> +++ b/sound/soc/ep93xx/ep93xx-i2s.c
> @@ -0,0 +1,497 @@
> +/*
> + * linux/sound/soc/ep93xx-i2s.c
> + * EP93xx I2S driver
> + *
> + * Copyright (C) 2008 Ryan Mallon <ryan@bluewatersys.com>
> + *
> + * Based on the original driver by:
> + *   Copyright (C) 2007 Chase Douglas <chasedouglas@gmail>
> + *   Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/ep93xx-regs.h>
> +#include <mach/dma.h>
> +
> +#include "ep93xx-pcm.h"
> +#include "ep93xx-i2s.h"
> +
> +#define EP93XX_I2S_TXCLKCFG          0x00
> +#define EP93XX_I2S_RXCLKCFG          0x04
> +#define EP93XX_I2S_GLSTS             0x08
> +#define EP93XX_I2S_GLCTRL            0x0C
> +
> +#define EP93XX_I2S_TX0LFT            0x10
> +#define EP93XX_I2S_TX0RT             0x14
> +#define EP93XX_I2S_TX1LFT            0x18
> +#define EP93XX_I2S_TX1RT             0x1C
> +#define EP93XX_I2S_TX2LFT            0x20
> +#define EP93XX_I2S_TX2RT             0x24
> +#define EP93XX_I2S_TXLINCTRLDATA     0x28
> +#define EP93XX_I2S_TXCTRL            0x2C
> +#define EP93XX_I2S_TXWRDLEN          0x30
> +#define EP93XX_I2S_TX0EN             0x34
> +#define EP93XX_I2S_TX1EN             0x38
> +#define EP93XX_I2S_TX2EN             0x3C
> +
> +#define EP93XX_I2S_RX0LFT            0x40
> +#define EP93XX_I2S_RX0RT             0x44
> +#define EP93XX_I2S_RX1LFT            0x48
> +#define EP93XX_I2S_RX1RT             0x4C
> +#define EP93XX_I2S_RX2LFT            0x50
> +#define EP93XX_I2S_RX2RT             0x54
> +
> +#define EP93XX_I2S_RXLINCTRLDATA     0x58
> +#define EP93XX_I2S_RXCTRL            0x5C
> +#define EP93XX_I2S_RXWRDLEN          0x60
> +#define EP93XX_I2S_RX0EN             0x64
> +#define EP93XX_I2S_RX1EN             0x68
> +#define EP93XX_I2S_RX2EN             0x6C
> +
> +#define EP93XX_I2S_WRDLEN_16         (0 << 0)
> +#define EP93XX_I2S_WRDLEN_24         (1 << 0)
> +#define EP93XX_I2S_WRDLEN_32         (2 << 0)
> +
> +#define EP93XX_I2S_LINCTRLDATA_R_JUST        (1 << 2) /* Right justify */
> +
> +#define EP93XX_I2S_CLKCFG_LRS                (1 << 0) /* lrclk polarity */
> +#define EP93XX_I2S_CLKCFG_CKP                (1 << 1) /* Bit clock polarity */
> +#define EP93XX_I2S_CLKCFG_REL                (1 << 2) /*  */
> +#define EP93XX_I2S_CLKCFG_MASTER     (1 << 3) /* Master mode */
> +#define EP93XX_I2S_CLKCFG_NBCG               (1 << 4) /* Not bit clock gating */
> +
> +struct ep93xx_i2s_info {
> +     struct clk                      *i2s_clk;

Comment about the clocks below.

> +     struct ep93xx_pcm_dma_params    *dma_params[2];
> +     struct resource                 *mem;
> +     void __iomem                    *regs;
> +};

Also, I saw Chase Douglas' comment on this struct and the defines.

If they are "only" used in this source file please leave them here.  If there
is not a reason to expose the information globally, keep it private to the
driver.

As far as the name of the struct, I really don't care.

> +
> +static struct ep93xx_pcm_dma_params ep93xx_i2s_pcm_out = {
> +     .name           = "i2s-pcm-out",
> +     .dma_port       = EP93XX_DMA_M2P_PORT_I2S1,
> +};
> +
> +static struct ep93xx_pcm_dma_params ep93xx_i2s_pcm_in = {
> +     .name           = "i2s-pcm-in",
> +     .dma_port       = EP93XX_DMA_M2P_PORT_I2S1,
> +};
> +
> +static inline void ep93xx_i2s_write_reg(struct ep93xx_i2s_info *info,
> +                                     unsigned reg, unsigned val)
> +{
> +     __raw_writel(val, info->regs + reg);
> +}
> +
> +static inline unsigned ep93xx_i2s_read_reg(struct ep93xx_i2s_info *info,
> +                                        unsigned reg)
> +{
> +     return __raw_readl(info->regs + reg);
> +}
> +
> +static inline void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int enable)
> +{
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, enable);
> +}
> +
> +static inline void ep93xx_i2s_enable_fifos(struct ep93xx_i2s_info *info,
> +                                        int enable)

Not sure if this should be 'inline'

> +{
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_RX0EN, enable);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_RX1EN, enable);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_RX2EN, enable);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN, enable);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_TX1EN, enable);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_TX2EN, enable);
> +}
> +
> +static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
> +                           struct snd_soc_dai *dai)
> +{
> +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +     struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +     struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
> +
> +     clk_enable(info->i2s_clk);

Comment about this below.

> +     cpu_dai->dma_data = info->dma_params[substream->stream];
> +     return 0;
> +}
> +
> +static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
> +                             struct snd_soc_dai *dai)
> +{
> +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +     struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
> +
> +     clk_disable(info->i2s_clk);

Again, comment about this below.

> +}
> +
> +static int ep93xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> +                           struct snd_soc_dai *dai)
> +{
> +     return 0;
> +}
> +
> +static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
> +                               unsigned int fmt)
> +{
> +     struct ep93xx_i2s_info *info = cpu_dai->private_data;
> +     unsigned int clk_cfg, lin_ctrl;
> +
> +     clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
> +     lin_ctrl = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXLINCTRLDATA);
> +
> +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +     case SND_SOC_DAIFMT_I2S:
> +             clk_cfg |= EP93XX_I2S_CLKCFG_REL;
> +             lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
> +             break;
> +
> +     case SND_SOC_DAIFMT_LEFT_J:
> +             clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
> +             lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
> +             break;
> +
> +     case SND_SOC_DAIFMT_RIGHT_J:
> +             clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
> +             lin_ctrl |= EP93XX_I2S_LINCTRLDATA_R_JUST;
> +             break;
> +
> +     default:
> +             return -EINVAL;
> +     }
> +
> +     switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +     case SND_SOC_DAIFMT_CBS_CFS:
> +             /* CPU is master */
> +             clk_cfg |= EP93XX_I2S_CLKCFG_MASTER;
> +             break;
> +
> +     case SND_SOC_DAIFMT_CBM_CFM:
> +             /* Codec is master */
> +             clk_cfg &= ~EP93XX_I2S_CLKCFG_MASTER;
> +             break;
> +
> +     default:
> +             return -EINVAL;
> +     }
> +
> +     switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +     case SND_SOC_DAIFMT_NB_NF:
> +             /* Negative bit clock, lrclk low on left word */
> +             clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL);
> +             break;
> +
> +     case SND_SOC_DAIFMT_NB_IF:
> +             /* Negative bit clock, lrclk low on right word */
> +             clk_cfg &= ~EP93XX_I2S_CLKCFG_CKP;
> +             clk_cfg |= EP93XX_I2S_CLKCFG_REL;
> +             break;
> +
> +     case SND_SOC_DAIFMT_IB_NF:
> +             /* Positive bit clock, lrclk low on left word */
> +             clk_cfg |= EP93XX_I2S_CLKCFG_CKP;
> +             clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
> +             break;
> +
> +     case SND_SOC_DAIFMT_IB_IF:
> +             /* Positive bit clock, lrclk low on right word */
> +             clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL;
> +             break;
> +     }
> +
> +     /* Write new register values */
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_RXCLKCFG, clk_cfg);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCLKCFG, clk_cfg);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, lin_ctrl);
> +     ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, lin_ctrl);
> +     return 0;
> +}
> +
> +static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
> +                             struct snd_pcm_hw_params *params,
> +                             struct snd_soc_dai *dai)
> +{
> +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +     struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +     struct ep93xx_i2s_info *info = cpu_dai->private_data;
> +     unsigned word_len;
> +
> +     switch (params_format(params)) {
> +     case SNDRV_PCM_FORMAT_S16_LE:
> +             word_len = EP93XX_I2S_WRDLEN_16;
> +             break;
> +
> +     case SNDRV_PCM_FORMAT_S24_LE:
> +             word_len = EP93XX_I2S_WRDLEN_24;
> +             break;
> +
> +     case SNDRV_PCM_FORMAT_S32_LE:
> +             word_len = EP93XX_I2S_WRDLEN_32;
> +             break;
> +
> +     default:
> +             return -EINVAL;
> +     }
> +
> +     if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +             ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);
> +     else
> +             ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);
> +     return 0;
> +}
> +
> +static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
> +                              unsigned int freq, int dir)
> +{
> +     struct ep93xx_i2s_info *info = cpu_dai->private_data;
> +
> +     if (dir == SND_SOC_CLOCK_IN || clk_id != 0)
> +             return -EINVAL;
> +
> +     return clk_set_rate(info->i2s_clk, freq);
> +}
> +
> +static int ep93xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai, int div_id,
> +                              int div)
> +{
> +     unsigned val;
> +
> +     /*
> +      * The LRDIV (frame clock) and SDIV (bit clock) controls are in the
> +      * EP93XX_SYSCON_I2SCLKDIV register, which is also used by clock.c
> +      * to set the I2S master clock.
> +      *
> +      * FIXME - This functions is potentially racy with the clock api for
> +      * the I2S master clock. Its also ugly modifying the syscon registers
> +      * here.
> +      */
> +     val = __raw_readl( EP93XX_SYSCON_I2SCLKDIV);
> +
> +     switch (div_id) {
> +     case EP93XX_I2S_SDIV:
> +             /* SCLK = MCLK / div */
> +             switch (div) {
> +             case 2:
> +                     val &= ~(0x1 << EP93XX_I2S_SDIV);
> +                     break;
> +
> +             case 4:
> +                     val |= 0x1 << EP93XX_I2S_SDIV;
> +                     break;
> +
> +             default:
> +                     return -EINVAL;
> +             }
> +             break;
> +
> +     case EP93XX_I2S_LRDIV:
> +             /* LRCLK = SCLK / div */
> +             switch (div) {
> +             case 32:
> +                     val &= ~(0x3 << EP93XX_I2S_LRDIV);
> +                     break;
> +
> +             case 64:
> +                     val &= ~(0x3 << EP93XX_I2S_LRDIV);
> +                     val |= 0x1 << EP93XX_I2S_LRDIV;
> +                     break;
> +
> +             case 128:
> +                     val &= ~(0x3 << EP93XX_I2S_LRDIV);
> +                     val |= 0x2 << EP93XX_I2S_LRDIV;
> +                     break;
> +
> +             default:
> +                     return -EINVAL;
> +             }
> +             break;
> +
> +     default:
> +             return -EINVAL;
> +     }
> +
> +     ep93xx_syscon_swlocked_write(val, EP93XX_SYSCON_I2SCLKDIV);
> +     return 0;
> +}

As you noted, this is a bit ugly.

If you create two pseudo clocks in clock.c for the sclk and lrclk this can
all be changed to:

static int ep93xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai, int div_id,
                                 int div)
{
        struct ep93xx_i2s_info *info = dai->private_data;
        unsigned long rate;

        switch (div_id) {
        case EP93XX_I2S_SDIV:
                /* SCLK = MCLK / div */
                rate = clk_get_rate(info->i2s_clk) / div;
                return clk_set_rate(info->sclk, rate);

        case EP93XX_I2S_LRDIV:
                /* LRCLK = SCLK / div */
                rate = clk_get_rate(info->sclk) / div;
                return clk_set_rate(info->lrclk, rate);

        default:
                return -EINVAL;
        }
}

If the "parents" of the clocks are set so i2s_clk is the parent of sclk which
is the parent of lrclk then you just need to enable/disable the lrclk to get
the others enabled/disabled.

These pseudo clocks will also have to be part of your struct ep93xx_i2s_info and
will need to the appropriate clk_get's in the probe and clk_put's as needed.

The only tricky part about the pseudo clocks are the set_rate routines so that
changing the MCLK (i2s_clk) propagates the correct "rate" down to the children.
Technically it's not even a big deal since you never really query those rates,
internally the rates will be "correct" based on the new MCLK rate.

I'll propose a patch for clock.c in PATCH 2/3.

> +
> +#ifdef CONFIG_PM
> +static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
> +{
> +     struct ep93xx_i2s_info *info = dai->private_data;
> +
> +     if (!dai->active)
> +             return;
> +
> +     ep93xx_i2s_enable(info, 0);
> +}
> +
> +static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
> +{
> +     struct ep93xx_i2s_info *info = dai->private_data;
> +
> +     if (!dai->active)
> +             return;
> +
> +     ep93xx_i2s_enable(info, 1);
> +}
> +#else
> +#define ep93xx_i2s_suspend   NULL
> +#define ep93xx_i2s_resume    NULL
> +#endif
> +
> +#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
> +                         SNDRV_PCM_FMTBIT_S24_LE | \
> +                         SNDRV_PCM_FMTBIT_S32_LE)
> +
> +static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
> +     .startup        = ep93xx_i2s_startup,
> +     .shutdown       = ep93xx_i2s_shutdown,
> +     .trigger        = ep93xx_i2s_trigger,
> +     .hw_params      = ep93xx_i2s_hw_params,
> +     .set_sysclk     = ep93xx_i2s_set_sysclk,
> +     .set_clkdiv     = ep93xx_i2s_set_clkdiv,
> +     .set_fmt        = ep93xx_i2s_set_dai_fmt,
> +};
> +
> +struct snd_soc_dai ep93xx_i2s_dai = {
> +     .name           = "ep93xx-i2s",
> +     .id             = 0,
> +     .suspend        = ep93xx_i2s_suspend,
> +     .resume         = ep93xx_i2s_resume,
> +     .playback       = {
> +             .channels_min   = 2,
> +             .channels_max   = 2,
> +             .rates          = SNDRV_PCM_RATE_8000_48000,
> +             .formats        = EP93XX_I2S_FORMATS,
> +     },
> +     .capture        = {
> +              .channels_min  = 2,
> +              .channels_max  = 2,
> +              .rates         = SNDRV_PCM_RATE_8000_48000,
> +              .formats       = EP93XX_I2S_FORMATS,
> +     },
> +     .ops            = &ep93xx_i2s_dai_ops,
> +};
> +EXPORT_SYMBOL_GPL(ep93xx_i2s_dai);
> +
> +static int ep93xx_i2s_probe(struct platform_device *pdev)
> +{
> +     struct ep93xx_i2s_info *info;
> +     struct resource *res;
> +     int err;
> +
> +     info = kzalloc(sizeof(struct ep93xx_i2s_info), GFP_KERNEL);
> +     if (!info) {
> +             err = -ENOMEM;
> +             goto fail;
> +     }
> +
> +     ep93xx_i2s_dai.dev = &pdev->dev;
> +     ep93xx_i2s_dai.private_data = info;
> +
> +     info->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &ep93xx_i2s_pcm_out;
> +     info->dma_params[SNDRV_PCM_STREAM_CAPTURE]  = &ep93xx_i2s_pcm_in;
> +
> +     err = snd_soc_register_dai(&ep93xx_i2s_dai);
> +     if (err)
> +             goto fail_free_info;
> +
> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +     if (!res) {
> +             err = -ENODEV;
> +             goto fail_unregister_dai;
> +     }
> +
> +     info->mem = request_mem_region(res->start, resource_size(res),
> +                                    pdev->name);
> +     if (!info->mem) {
> +             err = -EBUSY;
> +             goto fail_free_info;
> +     }
> +
> +     info->regs = ioremap(info->mem->start, resource_size(info->mem));
> +     if (!info->regs) {
> +             err = -ENXIO;
> +             goto fail_release_mem;
> +     }
> +
> +     info->i2s_clk = clk_get(&pdev->dev, NULL);
> +     if (IS_ERR(info->i2s_clk)) {
> +             err = PTR_ERR(info->i2s_clk);
> +             goto fail_unmap_mem;
> +     }

See comment above.

> +
> +     ep93xx_i2s_enable_fifos(info, 1);
> +     ep93xx_i2s_enable(info, 1);
> +     return 0;
> +
> +fail_unmap_mem:
> +     iounmap(info->regs);
> +fail_release_mem:
> +     release_mem_region(info->mem->start, resource_size(info->mem));
> +fail_unregister_dai:
> +     snd_soc_unregister_dai(&ep93xx_i2s_dai);
> +fail_free_info:
> +     kfree(info);
> +fail:
> +     return err;
> +}
> +
> +static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
> +{
> +     struct ep93xx_i2s_info *info = ep93xx_i2s_dai.private_data;
> +
> +     ep93xx_i2s_enable_fifos(info, 0);
> +     ep93xx_i2s_enable(info, 0);
> +
> +     clk_put(info->i2s_clk);

See comment above.

> +     iounmap(info->regs);
> +     release_mem_region(info->mem->start, resource_size(info->mem));
> +     snd_soc_unregister_dai(&ep93xx_i2s_dai);
> +     kfree(info);
> +     return 0;
> +}
> +
> +static struct platform_driver ep93xx_i2s_driver = {
> +     .probe  = ep93xx_i2s_probe,
> +     .remove = __devexit_p(ep93xx_i2s_remove),
> +     .driver = {
> +             .name   = "ep93xx-i2s",
> +             .owner  = THIS_MODULE,
> +     },
> +};
> +
> +static int __init ep93xx_i2s_init(void)
> +{
> +     return platform_driver_register(&ep93xx_i2s_driver);
> +}
> +
> +static void __exit ep93xx_i2s_exit(void)
> +{
> +     platform_driver_unregister(&ep93xx_i2s_driver);
> +}
> +
> +module_init(ep93xx_i2s_init);
> +module_exit(ep93xx_i2s_exit);
> +
> +MODULE_ALIAS("platform:ep93xx-i2s");
> +MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com>");
> +MODULE_DESCRIPTION("EP93XX I2S driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.h b/sound/soc/ep93xx/ep93xx-i2s.h
> new file mode 100644
> index 0000000..37e6370
> --- /dev/null
> +++ b/sound/soc/ep93xx/ep93xx-i2s.h
> @@ -0,0 +1,13 @@
> +#ifndef _EP93XX_SND_SOC_I2S_H
> +#define _EP93XX_SND_SOC_I2S_H
> +
> +/*
> + * These are the offsets for the LRDIV and SDIV fields in the syscon i2sclkdiv
> + * register.
> + */
> +#define EP93XX_I2S_LRDIV     17
> +#define EP93XX_I2S_SDIV              16

Using the pseudo clocks, these defines can go away.

But, since they are also used as the "div_id" in ep93xx_i2s_set_clkdiv they should
be changed to something more logical (i.e. 0, 1 not 16, 17).

> +
> +extern struct snd_soc_dai ep93xx_i2s_dai;
> +
> +#endif /* _EP93XX_SND_SOC_I2S_H */
> diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
> new file mode 100644
> index 0000000..c071b5c
> --- /dev/null
> +++ b/sound/soc/ep93xx/ep93xx-pcm.c

Is this pcm driver generic enough to work with an AC97 driver?  Looking at
some of the other soc drivers it appears there are different pcm drivers for
different codec interfaces.  If it's not completely generic please rename this
file as appropriate.

> @@ -0,0 +1,321 @@
> +/*
> + * linux/sound/arm/ep93xx-pcm.c - EP93xx ALSA PCM interface
> + *
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2006 Applied Data Systems
> + *
> + * Rewritten for the SoC audio subsystem (Based on PXA2xx code):
> + *   Copyright (c) 2008 Ryan Mallon <ryan@bluewatersys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <mach/dma.h>
> +#include <mach/hardware.h>
> +#include <mach/ep93xx-regs.h>
> +
> +#include "ep93xx-pcm.h"
> +
> +static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
> +     .info                   = (SNDRV_PCM_INFO_MMAP          |
> +                                SNDRV_PCM_INFO_MMAP_VALID    |
> +                                SNDRV_PCM_INFO_INTERLEAVED   |
> +                                SNDRV_PCM_INFO_BLOCK_TRANSFER),
> +
> +     .rates                  = SNDRV_PCM_RATE_8000_48000,
> +     .rate_min               = SNDRV_PCM_RATE_8000,
> +     .rate_max               = SNDRV_PCM_RATE_48000,
> +
> +     .formats                = (SNDRV_PCM_FMTBIT_S16_LE |
> +                                SNDRV_PCM_FMTBIT_S24_LE |
> +                                SNDRV_PCM_FMTBIT_S32_LE),
> +
> +     .buffer_bytes_max       = 131072,
> +     .period_bytes_min       = 32,
> +     .period_bytes_max       = 32768,
> +     .periods_min            = 1,
> +     .periods_max            = 32,
> +     .fifo_size              = 32,
> +};
> +
> +struct ep93xx_runtime_data
> +{
> +     struct ep93xx_dma_m2p_client    cl;
> +     struct ep93xx_pcm_dma_params    *params;
> +     int                             pointer_bytes;
> +     struct tasklet_struct           period_tasklet;
> +     int                             periods;
> +     struct ep93xx_dma_buffer        buf[32];
> +};
> +
> +static void ep93xx_pcm_period_elapsed(unsigned long data)
> +{
> +     struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
> +     snd_pcm_period_elapsed(substream);
> +}
> +
> +static void ep93xx_pcm_buffer_started(void *cookie,
> +                                   struct ep93xx_dma_buffer *buf)
> +{
> +}
> +
> +static void ep93xx_pcm_buffer_finished(void *cookie,
> +                                    struct ep93xx_dma_buffer *buf,
> +                                    int bytes, int error)
> +{
> +     struct snd_pcm_substream *substream = cookie;
> +     struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
> +
> +     if (buf == rtd->buf + rtd->periods - 1)
> +             rtd->pointer_bytes = 0;
> +     else
> +             rtd->pointer_bytes += buf->size;
> +
> +     if (!error) {
> +             ep93xx_dma_m2p_submit_recursive(&rtd->cl, buf);
> +             tasklet_schedule(&rtd->period_tasklet);
> +     } else {
> +             snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +     }
> +}
> +
> +static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
> +{
> +     struct snd_soc_pcm_runtime *soc_rtd = substream->private_data;
> +     struct ep93xx_pcm_dma_params *dma_params = soc_rtd->dai->cpu_dai->dma_data;
> +     struct ep93xx_runtime_data *rtd;
> +     int ret;
> +
> +     snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
> +
> +     rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
> +     if (!rtd)
> +             return -ENOMEM;
> +
> +     memset(&rtd->period_tasklet, 0, sizeof(rtd->period_tasklet));
> +     rtd->period_tasklet.func = ep93xx_pcm_period_elapsed;
> +     rtd->period_tasklet.data = (unsigned long)substream;
> +
> +     rtd->cl.name = dma_params->name;
> +     rtd->cl.flags = dma_params->dma_port | EP93XX_DMA_M2P_IGNORE_ERROR |
> +             ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> +              EP93XX_DMA_M2P_TX : EP93XX_DMA_M2P_RX);
> +     rtd->cl.cookie = substream;
> +     rtd->cl.buffer_started = ep93xx_pcm_buffer_started;
> +     rtd->cl.buffer_finished = ep93xx_pcm_buffer_finished;
> +     ret = ep93xx_dma_m2p_client_register(&rtd->cl);
> +     if (ret < 0) {
> +             kfree(rtd);
> +             return ret;
> +     }
> +
> +     substream->runtime->private_data = rtd;
> +     return 0;
> +}
> +
> +static int ep93xx_pcm_close(struct snd_pcm_substream *substream)
> +{
> +     struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
> +
> +     ep93xx_dma_m2p_client_unregister(&rtd->cl);
> +     kfree(rtd);
> +     return 0;
> +}
> +
> +static int ep93xx_pcm_hw_params(struct snd_pcm_substream *substream,
> +                             struct snd_pcm_hw_params *params)
> +{
> +     struct snd_pcm_runtime *runtime = substream->runtime;
> +     struct ep93xx_runtime_data *rtd = runtime->private_data;
> +     size_t totsize = params_buffer_bytes(params);
> +     size_t period = params_period_bytes(params);
> +     int i;
> +
> +     snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +     runtime->dma_bytes = totsize;
> +
> +     rtd->periods = (totsize + period - 1) / period;
> +     for (i = 0; i < rtd->periods; i++) {
> +             rtd->buf[i].bus_addr = runtime->dma_addr + (i * period);
> +             rtd->buf[i].size = period;
> +             if ((i + 1) * period > totsize)
> +                     rtd->buf[i].size = totsize - (i * period);
> +     }
> +
> +     return 0;
> +}
> +
> +static int ep93xx_pcm_hw_free(struct snd_pcm_substream *substream)
> +{
> +     snd_pcm_set_runtime_buffer(substream, NULL);
> +     return 0;
> +}
> +
> +static int ep93xx_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +     return 0;
> +}
> +
> +static int ep93xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +     struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
> +     int ret;
> +     int i;
> +
> +     ret = 0;
> +     switch (cmd) {
> +     case SNDRV_PCM_TRIGGER_START:
> +     case SNDRV_PCM_TRIGGER_RESUME:
> +     case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +             rtd->pointer_bytes = 0;
> +             for (i = 0; i < rtd->periods; i++)
> +                     ep93xx_dma_m2p_submit(&rtd->cl, rtd->buf + i);
> +             break;
> +
> +     case SNDRV_PCM_TRIGGER_STOP:
> +     case SNDRV_PCM_TRIGGER_SUSPEND:
> +     case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +             ep93xx_dma_m2p_flush(&rtd->cl);
> +             break;
> +
> +     default:
> +             ret = -EINVAL;
> +             break;
> +     }
> +
> +     return ret;
> +}
> +
> +static snd_pcm_uframes_t ep93xx_pcm_pointer(struct snd_pcm_substream *substream)
> +{
> +     struct snd_pcm_runtime *runtime = substream->runtime;
> +     struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
> +
> +     /* FIXME: implement this with sub-period granularity */
> +     return bytes_to_frames(runtime, rtd->pointer_bytes);
> +}
> +
> +static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
> +                        struct vm_area_struct *vma)
> +{
> +     struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +     return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +                                  runtime->dma_area,
> +                                  runtime->dma_addr,
> +                                  runtime->dma_bytes);
> +}
> +
> +static struct snd_pcm_ops ep93xx_pcm_ops = {
> +     .open           = ep93xx_pcm_open,
> +     .close          = ep93xx_pcm_close,
> +     .ioctl          = snd_pcm_lib_ioctl,
> +     .hw_params      = ep93xx_pcm_hw_params,
> +     .hw_free        = ep93xx_pcm_hw_free,
> +     .prepare        = ep93xx_pcm_prepare,
> +     .trigger        = ep93xx_pcm_trigger,
> +     .pointer        = ep93xx_pcm_pointer,
> +     .mmap           = ep93xx_pcm_mmap,
> +};
> +
> +static int ep93xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
> +{
> +     struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +     struct snd_dma_buffer *buf = &substream->dma_buffer;
> +     size_t size = ep93xx_pcm_hardware.buffer_bytes_max;
> +
> +     buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +     buf->dev.dev = pcm->card->dev;
> +     buf->private_data = NULL;
> +     buf->area = dma_alloc_writecombine(pcm->card->dev, size,
> +                                        &buf->addr, GFP_KERNEL);
> +     buf->bytes = size;
> +
> +     return (buf->area == NULL) ? -ENOMEM : 0;
> +}
> +
> +static void ep93xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +     struct snd_pcm_substream *substream;
> +     struct snd_dma_buffer *buf;
> +     int stream;
> +
> +     for (stream = 0; stream < 2; stream++) {
> +             substream = pcm->streams[stream].substream;
> +             if (!substream)
> +                     continue;
> +
> +             buf = &substream->dma_buffer;
> +             if (!buf->area)
> +                     continue;
> +
> +             dma_free_writecombine(pcm->card->dev, buf->bytes, buf->area,
> +                                   buf->addr);
> +             buf->area = NULL;
> +     }
> +}
> +
> +static u64 ep93xx_pcm_dmamask = 0xffffffff;
> +
> +static int ep93xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
> +                       struct snd_pcm *pcm)
> +{
> +     int ret = 0;
> +
> +     if (!card->dev->dma_mask)
> +             card->dev->dma_mask = &ep93xx_pcm_dmamask;
> +     if (!card->dev->coherent_dma_mask)
> +             card->dev->coherent_dma_mask = 0xffffffff;
> +
> +     if (dai->playback.channels_min) {
> +             ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
> +                                     SNDRV_PCM_STREAM_PLAYBACK);
> +             if (ret)
> +                     return ret;
> +
> +             ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
> +                                     SNDRV_PCM_STREAM_CAPTURE);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     return 0;
> +}
> +
> +struct snd_soc_platform ep93xx_soc_platform = {
> +     .name           = "ep93xx-audio",
> +     .pcm_ops        = &ep93xx_pcm_ops,
> +     .pcm_new        = &ep93xx_pcm_new,
> +     .pcm_free       = &ep93xx_pcm_free_dma_buffers,
> +};
> +EXPORT_SYMBOL_GPL(ep93xx_soc_platform);
> +
> +static int __init ep93xx_soc_platform_init(void)
> +{
> +     return snd_soc_register_platform(&ep93xx_soc_platform);
> +}
> +
> +static void __exit ep93xx_soc_platform_exit(void)
> +{
> +     snd_soc_unregister_platform(&ep93xx_soc_platform);
> +}
> +
> +module_init(ep93xx_soc_platform_init);
> +module_exit(ep93xx_soc_platform_exit);
> +
> +MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
> +MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/ep93xx/ep93xx-pcm.h b/sound/soc/ep93xx/ep93xx-pcm.h
> new file mode 100644
> index 0000000..4ffdd3f
> --- /dev/null
> +++ b/sound/soc/ep93xx/ep93xx-pcm.h
> @@ -0,0 +1,22 @@
> +/*
> + * sound/soc/ep93xx/ep93xx-pcm.h - EP93xx ALSA PCM interface
> + *
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2006 Applied Data Systems
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _EP93XX_SND_SOC_PCM_H
> +#define _EP93XX_SND_SOC_PCM_H
> +
> +struct ep93xx_pcm_dma_params {
> +     char    *name;
> +     int     dma_port;
> +};
> +
> +extern struct snd_soc_platform ep93xx_soc_platform;
> +
> +#endif /* _EP93XX_SND_SOC_PCM_H */


Ugh... Sound drivers make my head hurt...

Regards,
Hartley
