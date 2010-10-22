From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 22 Oct 2010 19:57:03 +0200
Subject: [PATCH 1/3] imx: make IMX_IO_ADDRESS assembly compatible
In-Reply-To: <20100316103052.GB29005@pengutronix.de>
References: <cover.1268721010.git.baruch@tkos.co.il>
	<f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
	<20100316085212.GA29005@pengutronix.de>
	<20100316094154.GA3642@jasper.tkos.co.il>
	<20100316103052.GB29005@pengutronix.de>
Message-ID: <20101022175702.GI19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 16, 2010 at 11:30:52AM +0100, Uwe Kleine-K?nig wrote:
> > > > -#define IMX_IO_ADDRESS(addr, module)					\
> > > > -	((void __force __iomem *)					\
> > > > -	 (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
> > > > -	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
> > > > +#ifdef __ASSEMBLER__
> > > > +#define IOMEM(addr,base,size,virt)	((addr) - (base) + (virt))
> > > > +#else
> > > > +#define IOMEM(addr,base,size,virt)			\
> > > > +	((void __force __iomem *)			\
> > > > +	((unsigned long) ((addr) - (base)) < size) ?	\
> > > > +	(addr) - (base) + (virt) : 0)
> > > > +#endif
> > > > +
> > > > +#define IMX_IO_ADDRESS(addr, module)				\
> > > > +	IOMEM(addr, module ## _BASE_ADDR, module ## _SIZE,	\
> > > > +	module ## _BASE_ADDR_VIRT)
> > > hmmm, the construct used to define MX27_IO_ADDRESS et al. does only work
> > > without __ASSEMBLER__ anyhow, still I think it might be at least
> > > surprising that e.g.
> > > 
> > > 	IOMEM(MX27_WDOG_BASE_ADDR, MX27_SAHB1_BASE_ADDR, MX27_SAHB1_SIZE, MX27_SAHB1_BASE_ADDR_VIRT)
> > > 
> > > evaluates to 0x84102000 if __ASSEMBLER__ is defined but 0 if not.
> > > 
> > > I tend to think we should use a different solution.
> > > 
> > > IMHO it would be great to have a macro that maps physical to virtual
> > > addresses for both assembler and C.  E.g. ns9xxx has something like
> > > that[1], other probably, too, but for imx it would be harder as the used
> > > addresses differ and are spread over the whole address space.  Some time
> > > ago I found a function that would do the task, but Sascha didn't agree
> > > to use it because it involved too much magic.
> > 
> > So, what you actually suggest is to use the simple arithmetic IOMEM version 
> > which is assembly compatible, and remove the C only ?: error checking, as is 
> > being done in ns9xxx, right? Or are you suggesting to change the P2V mapping 
> > of the entire i.MX platform so that this error checking is not needed?
> We currently need the ?: construct for the definition of
> MX.._IO_ADDRESS.   Maybe using it would work for assembler, too, as
> there are only constants involved?
> 
> For reference:  The function I found back then is:
> 
> 	#define io_p2v(x)	(0xf4000000 + \
> 				(((x) & 0x50000000) >> 8) + \
> 				(((x) & 0x02000000) >> 4) + \
> 				(((x) & 0x000fffff)))
> 
> This would introduce an injective mapping of the io space to
> [0xf4000000;0xf47fffff] for mx1, mx21, mx25, mx27, mx31 and mx35.
> (Skipping the chip select mappings that are (AFAIK unnecessarily)
> currently used on some socs.):
> 
>         mx1:            0x00200000 -> 0xf4000000
>         mx2[17]:        0x10000000 -> 0xf4100000
>                         0x80000000 -> 0xf4000000
>         mx21:           0xdf000000 -> 0xf4700000
>         mx27:           0xd8000000 -> 0xf4500000
>         mx3[15]:        0xb8000000 -> 0xf4100000
>         mx{25,31,35}:   0x68000000 -> 0xf4400000
>                         0x43f00000 -> 0xf4600000
>                         0x53f00000 -> 0xf4700000
> 
> The upside of this approach is that it just works in C and Assembler,
> but it's ugly and the mapped sections are spread over
> [0xf4000000;0xf47fffff] instead of being one after another as they are
> now.  For mx51 this might need further adaption.
> 
> So in my order of preference the possibilities are:
> 
>  1) IOMEM with ?: for Assembler, too
>  2) "my" io_p2v as above
>  3) IOMEM as you suggested
> 
> The nice thing about 1) (and 2)) is that we could just use
> MX.._IO_ADDRESS in debug-macro.h.
While trying to get rid of IMX_NEEDS_DEPRECATED_SYMBOLS I tried 1), but
it seems it doesn't work (using a gcc 4.3.2 + binutils 2.19 toolchain). :-(

So I tried if my function works for mx51, and it does.  Unfortunately it
fails for mxc91231.  But I already have a different function that works
on all mxc-SoCs.

I will create an RFC patch that introduces my suggestion in reply to
this mail.  Would be nice to hear (or better read) your thoughts on
that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
