From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 10:15:22 +0800
Subject: [PATCH 4/6] ASoC: fsl: create fsl_utils to accommodate the
 common functions
In-Reply-To: <4F4BF770.3010205@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
 <4F4BF770.3010205@freescale.com>
Message-ID: <20120228021520.GC13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 03:36:48PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > There are some amount of code duplication between mpc8610_hpcd and
> 
> "There is"
> 
Ok.

> > ---
> > diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> > index 65087b1..46752af 100644
> > --- a/sound/soc/fsl/Makefile
> > +++ b/sound/soc/fsl/Makefile
> > @@ -8,8 +8,10 @@ obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o
> >  
> >  # Freescale PowerPC SSI/DMA Platform Support
> >  snd-soc-fsl-ssi-objs := fsl_ssi.o
> > +snd-soc-fsl-utils-objs := fsl_utils.o
> >  snd-soc-fsl-dma-objs := fsl_dma.o
> >  obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o
> > +obj-$(CONFIG_SND_SOC_FSL_UTILS) += snd-soc-fsl-utils.o
> >  obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o
> 
> I think it would be easier to do this:
> 
> obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o snd-soc-fsl-utils.o
> obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o snd-soc-fsl-utils.o
> 
Since fsl_utils.c is created to accommodate the common functions used
by mpc8610_hpcd.c and p1022_ds.c, I guess you actually meant something
like the following?

# MPC8610 HPCD Machine Support
snd-soc-mpc8610-hpcd-objs := mpc8610_hpcd.o fsl_utils.o
obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += snd-soc-mpc8610-hpcd.o

# P1022 DS Machine Support
snd-soc-p1022-ds-objs := p1022_ds.o fsl_utils.o
obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o

I actually started with doing so, but later changed to make fsl_utils
as a module.  It seems that mpc8610_hpcd and p1022_ds will not be
built in a single kernel image, but on ARM/IMX, it's very likely that
multiple machine drivers will be built in a single image, as the ARM
community is moving to support single image for multiple SoCs.  In
that case, fsl_utils can not be linked like that but has to be a module.

> Then you don't need to change the Kconfig.
> 
> > +static struct device_node *get_node_by_phandle_name(struct device_node *np,
> > +	const char *name, const char *compatible)
> 
> ...
> 
> > +static int get_parent_cell_index(struct device_node *np)
> 
> I think you should merge these two functions into their callers.  There's
> not much point in keeping them separate now.  That will also allow you to
> add dev_err() messages when returning error codes.
> 
Ok.

> > +/**
> > + * fsl_asoc_get_codec_dev_name - determine the dev_name for a codec node
> 
> Can you add kerneldoc descriptions of the parameters?
> 
Ok.

>  * @np: pointer to the I2C device tree node
> ...
> 
> > + *
> > + * This function determines the dev_name for an I2C node.  This is the name
> > + * that would be returned by dev_name() if this device_node were part of a
> > + * 'struct device'  It's ugly and hackish, but it works.
> > + *
> > + * The dev_name for such devices include the bus number and I2C address. For
> > + * example, "cs4270.0-004f".
> > + */
> > +int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len)
> > +{
> > +	const u32 *iprop;
> > +	int addr;
> 
> 'addr' should be a u32, actually.  I'm not sure why I made it a signed
> integer.
> 
Ok.

> > +
> > +int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
> > +			     const char *name,
> > +			     struct snd_soc_dai_link *dai,
> > +			     unsigned int *dma_channel_id,
> > +			     unsigned int *dma_id)
> > +{
> 
> Can you add kerneldoc comments to this function?
> 
Ok.

> > +MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
> > +MODULE_DESCRIPTION("Freescale ASoC utility code");
> > +MODULE_LICENSE("GPL v2");
> 
> Is this really a module?
> 
As I explained above, yes, it has to be a module.

> > diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
> > new file mode 100644
> > index 0000000..c928a15
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl_utils.h
> > @@ -0,0 +1,29 @@
> > +/**
> > + * Freescale ALSA SoC Machine driver utility
> > + *
> > + * Author: Timur Tabi <timur@freescale.com>
> > + *
> > + * Copyright 2010 Freescale Semiconductor, Inc.
> > + *
> > + * This file is licensed under the terms of the GNU General Public License
> > + * version 2.  This program is licensed "as is" without any warranty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#ifndef _FSL_UTILS_H
> > +#define _FSL_UTILS_H
> > +
> > +#define DAI_NAME_SIZE	32
> > +
> > +struct snd_soc_dai_link;
> > +struct device_node;
> > +
> > +extern int fsl_asoc_get_codec_dev_name(struct device_node *np,
> > +				       char *buf, size_t len);
> > +extern int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
> > +				    const char *name,
> > +				    struct snd_soc_dai_link *dai,
> > +				    unsigned int *dma_channel_id,
> > +				    unsigned int *dma_id);
> 
> No 'extern' for function prototypes, please.
> 
Ok.

-- 
Regards,
Shawn
