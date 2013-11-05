From: B47053@freescale.com (Li Xiubo)
Date: Tue, 5 Nov 2013 03:50:07 +0000
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <20131101102805.GG28401@MrMyself>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82875503@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolin,


> > This is the SGTL5000 codec based audio driver supported with both
> > playback and capture dai link implemention.
> >
> > This implementation is only compatible with device tree definition.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> >
> > Conflicts:
> > 	sound/soc/fsl/Makefile
> > ---
> >  sound/soc/fsl/Kconfig              |  10 ++
> >  sound/soc/fsl/Makefile             |   2 +
> 
> >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208
> > +++++++++++++++++++++++++++++++++++++
> 
> I just doubt if this file naming is appropriate. Even if we might not
> have rigor rule for the file names, according to existing ones, they are
> all in a same pattern: [SoC name]-[codec name].c
> 
> "imx-sgtl5000.c" for example
> 
> I think it would make user less confused about what this file exactly is
> if this machine driver also follow the pattern: vf610-sgtl5000.c
> 

Yes, it looks nicer.

> 
> @Shawn
> 
> What do you think about the file name?
> 
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 sound/soc/fsl/fsl-sgtl5000-vf610.c
> >
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig index
> > 9a8851e..1b835ba 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -228,4 +228,14 @@ config SND_SOC_FSL_SAI
> >  	tristate
> >  	select SND_SOC_GENERIC_DMAENGINE_PCM
> >
> > +config SND_SOC_FSL_SGTL5000_VF610
> 
> Same problem with the this define.
> 
> > +	tristate "SoC Audio support for FSL boards with sgtl5000"
> 
> And 'FSL' here confuses me a lot. Because those boards based on i.MX
> series also could be called FSL boards.
> 

Yes, this should be VF610.

> > +	depends on OF && I2C
> > +	select SND_SOC_FSL_SAI
> > +	select SND_SOC_FSL_PCM
> > +	select SND_SOC_SGTL5000
> > +	help
> > +	  Say Y if you want to add support for SoC audio on an FSL board
> with
> > +	  a sgtl5000 codec.
> > +
> >  endif # SND_FSL_SOC
> > diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile index
> > e5acc03..26fc551 100644
> > --- a/sound/soc/fsl/Makefile
> > +++ b/sound/soc/fsl/Makefile
> > @@ -59,5 +59,7 @@ obj-$(CONFIG_SND_SOC_IMX_MC13783) +=
> > snd-soc-imx-mc13783.o
> >
> >  # FSL ARM SAI/SGT15000 Platform Support  snd-soc-fsl-sai-objs :=
> > fsl-sai.o
> > +snd-soc-fsl-sgtl5000-vf610-objs := fsl-sgtl5000-vf610.o
> >
> >  obj-$(CONFIG_SND_SOC_FSL_SAI) += snd-soc-fsl-sai.o
> > +obj-$(CONFIG_SND_SOC_FSL_SGTL5000_VF610) +=
> > +snd-soc-fsl-sgtl5000-vf610.o
> > diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > new file mode 100644
> > index 0000000..f535b42
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > @@ -0,0 +1,208 @@
> > +/*
> > + * Freeacale ALSA SoC Audio using SGT1500 as codec.
> > + *
> > + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/i2c.h>
> > +#include <linux/clk.h>
> > +
> > +#include "../codecs/sgtl5000.h"
> > +#include "fsl-sai.h"
> > +
> > +static unsigned int sysclk_rate;
> > +
> > +static int fsl_sgtl5000_dai_init(struct snd_soc_pcm_runtime *rtd)
> 
> Naming issue here again.
> 
> At least from my point of view, if you actually merged imx-sgtl5000 with
> vf610-sgtl5000 and made it also compatible to other freescale SoCs, you
> could then fairly call it fsl_sgtl5000_xxxx.
> 
> Well, I might be a little picky here because it's a static function and
> won't conflict others. Just the name here doesn't look so explicit to me.
> 
> Please reconsider about this whole file's naming.
> 

Yes, I still not very sure the names of the functions and files, from your replies,
I have got many information about the rules and others, I'll think it over and do some
research, Please see the next version.



Best regards,
Xiubo
