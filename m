From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 May 2015 11:19:02 +0200
Subject: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
In-Reply-To: <1432713024.27695.235.camel@x220>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
 <1432713024.27695.235.camel@x220>
Message-ID: <20150527091902.GN3199@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/2015 at 09:50:24 +0200, Paul Bolle wrote :
> Now that this patch is already applied my remarks can only be addressed
> in a follow up patch. (Perhaps such a patch is already queued.)
> 
> On Tue, 2015-05-26 at 00:04 +0200, Alexandre Belloni wrote:
> > --- a/sound/soc/atmel/Kconfig
> > +++ b/sound/soc/atmel/Kconfig
>  
> >  config SND_ATMEL_SOC_PDC
> > -	tristate
> > +	bool
> >  
> >  config SND_ATMEL_SOC_DMA
> > -	tristate
> > +	bool
> >  	select SND_SOC_GENERIC_DMAENGINE_PCM
> 
> > --- a/sound/soc/atmel/Makefile
> > +++ b/sound/soc/atmel/Makefile
> 
> > -snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
> > -snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
> > -snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
> > +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) := atmel-pcm-pdc.o
> > +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o
> > +snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)
> >  
> > -obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
> > -obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
> >  obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
> 
> The code in atmel-pcm-pdc.c and atmel-pcm-dma.c will now either be part
> of the snd-soc-atmel_ssc_dai.ko or be built-in. That means, I think,
> that:
> - the (in total) four uses of EXPORT_SYMBOL() in these two files can be
>   dropped;
> - MODULE_AUTHOR() and friends, and probably also the include of
>   linux/module.h, can be dropped from these two files.
> 

Yeah, I as not sure how to merge those MODULE_AUTHOR but I checked and
the information is correctly included.

> Furthermore, the references to CONFIG_SND_ATMEL_SOC_PDC_MODULE and
> CONFIG_SND_ATMEL_SOC_DMA_MODULE in atmel-pcm.h can be removed now.
> 

Indeed.

However, the Kconfig maintainer found a way to do the right thing so we
may as well drop that patch and keep those as modules.

Nicolas, what do you think?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
