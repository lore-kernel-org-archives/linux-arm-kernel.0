From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Nov 2010 19:32:03 +0530
Subject: [PATCH v3 02/13] OMAP: DMA: Introduce errata handling feature
In-Reply-To: <87sjzakuxp.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-3-git-send-email-manjugk@ti.com>
	<87sjzakuxp.fsf@deeprootsystems.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 3:43 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Peter Ujfalusi; 
> Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v3 02/13] OMAP: DMA: Introduce errata 
> handling feature
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Implement errata handling to use flags instead of cpu_is_*
> > and cpu_class_* in the code.
> >
> > The errata flags are initialized at init time and during runtime
> > we are using the errata variable (via the IS_DMA_ERRATA macro)
> > to execute the required errata workaround.
> >
> > Reused errata handling patch from Peter Ujfalusi 
> <peter.ujfalusi@nokia.com>
> > https://patchwork.kernel.org/patch/231191/
> 
> When starting from someone else's work, would be very helpful to
> reviewers (and original authors) if you summarized what you
> changed/fixed/updated etc.

ok. I will update patch summary.

> 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/plat-omap/dma.c              |  134 
> ++++++++++++++++++++++----------
[...]
> > +	if (omap_type() == OMAP3430_REV_ES1_0)
> > +		SET_DMA_ERRATA(DMA_ERRATA_i88);
> > +
> > +	/*
> > +	 * Errata 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
> 
> This doesn't look like a unique errata identifier.  Chapter 3 
> is usually
> the 'Cautions' section, and I don't listed in either the 34xx (v5.9),
> 36xx (v1.3) or 44xx (v1.3) errata docs under this number, and 
> don't see
> that number in either of the 24xx errata docs either.   
> Please clarify.

Even I tried to find this info from errata docs prior to migrating
all errata's to generic errata handling. This code was exising earlier,
hence I retained it "as is", no documentation exists for this errata.

> 
> > +	 * read before the DMA controller finished disabling 
> the channel.
> > +	 */
> > +	if (!cpu_is_omap15xx())
> > +		SET_DMA_ERRATA(DMA_ERRATA_3_3);
> > +}
> > +
> >  
> /*------------------------------------------------------------
> ----------------*/
> >  
> >  static int __init omap_init_dma(void)
> > @@ -2481,6 +2528,9 @@ static int __init omap_init_dma(void)
> >  		}
> >  	}
> >  
> > +	/* Configure errata handling for all omap's */
> > +	configure_dma_errata();
> > +
> >  	return 0;
> >  
> >  out_free:
> > diff --git a/arch/arm/plat-omap/include/plat/dma.h 
> b/arch/arm/plat-omap/include/plat/dma.h
> > index 27578f3..5e28d26 100644
> > --- a/arch/arm/plat-omap/include/plat/dma.h
> > +++ b/arch/arm/plat-omap/include/plat/dma.h
> > @@ -285,6 +285,17 @@
> >  #define DMA_CH_PRIO_HIGH		0x1
> >  #define DMA_CH_PRIO_LOW			0x0 /* Def */
> >  
> > +/* Errata handling */
> > +#define IS_DMA_ERRATA(id)		(errata &= (id))
> 
> Why the '&=' here?  I guess it should just be a '&'  The '=' 
> was not in
> Peter's original.

correct. There was bug in peter's original patch for SET_DMA_ERRATA(id)
it was | instead |=, while fixing set_dma_errata, accidentally, I have
changed is_dma_errata also. Will fix it.

> 
> > +#define SET_DMA_ERRATA(id)		(errata |= (id))
> > +
> > +#define DMA_ERRATA_IFRAME_BUFFERING	(1 << 0)
> > +#define DMA_ERRATA_PARALLEL_CHANNELS	(1 << 1)
> > +#define DMA_ERRATA_i378			(1 << 2)
> > +#define DMA_ERRATA_i541			(1 << 3)
> > +#define DMA_ERRATA_i88			(1 << 4)
> > +#define DMA_ERRATA_3_3			(1 << 5)
> 
> Please use BIT()
ok.

-Manjunath
