From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Mon, 2 Aug 2010 19:09:58 +0530
Subject: [PATCH v3 1/4] omap3: nand: prefetch in irq mode support
In-Reply-To: <20100802130306.GL12293@atomide.com>
References: <1278996337-25172-1-git-send-email-s-ghorai@ti.com>
	<1278996337-25172-2-git-send-email-s-ghorai@ti.com>
	<20100802130306.GL12293@atomide.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E54E6BD@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Monday, August 02, 2010 6:33 PM
> To: Ghorai, Sukumar
> Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
> kernel at lists.infradead.org; Vimal Singh
> Subject: Re: [PATCH v3 1/4] omap3: nand: prefetch in irq mode support
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100713 07:39]:
> > This patch enable prefetch-irq mode for NAND.
> 
> <snip>
> 
> > --- a/arch/arm/mach-omap2/board-flash.c
> > +++ b/arch/arm/mach-omap2/board-flash.c
> > @@ -133,6 +133,7 @@ static struct omap_nand_platform_data
> board_nand_data = {
> >  	.nand_setup	= NULL,
> >  	.gpmc_t		= &nand_timings,
> >  	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
> > +	.gpmc_irq	= GPMC_IRQ_NUMBER,
> >  	.dev_ready	= NULL,
> >  	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
> >  };
> > --- a/arch/arm/mach-omap2/include/mach/board-flash.h
> > +++ b/arch/arm/mach-omap2/include/mach/board-flash.h
> > @@ -19,6 +19,9 @@
> >  #define PDC_ONENAND	3
> >  #define DBG_MPDB	4
> >
> > +/* Interrupt number to the MPU Subsystem for GPMC */
> > +#define GPMC_IRQ_NUMBER	20
> > +
> 
> This does not look right for the IRQ. Please add it to the irqs.h and 34xx,
> then set it dynamically during the init just like we handle the other
> interrupt numbers.
> 
> This is because the irq numbers can change between omaps, like irqs-44xx.h
> already has
> 
> #define OMAP44XX_IRQ_GPMC                       (20 +
> OMAP44XX_IRQ_GIC_START)
> 
> > @@ -130,6 +141,13 @@ struct omap_nand_info {
> >  	unsigned long			phys_base;
> >  	struct completion		comp;
> >  	int				dma_ch;
> > +	int				gpmc_irq;
> > +	enum {
> > +		NAND_IO_READ = 0,	/* read */
> > +		NAND_IO_WRITE,		/* write */
> > +	} iomode;
> > +	u_char				*buf;
> > +	int					buf_len;
> >  };
> 
> These should probably be OMAP_NAND_IO_READ and OMAP_NAND_IO_WRITE?
[Ghorai] Thanks. I understand all your comments. I will rework and submit again. 

Regards,
Ghorai

> 
> Regards,
> 
> Tony
