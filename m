From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Nov 2009 12:10:48 -0800
Subject: [RFC] [PATCH v2] OMAP: DMA: Fix omapfb/lcdc on Amstrad Delta
	broken when PM set
In-Reply-To: <200911032104.33049.jkrzyszt@tis.icnet.pl>
References: <200911032024.47741.jkrzyszt@tis.icnet.pl>
	<200911032104.33049.jkrzyszt@tis.icnet.pl>
Message-ID: <20091103201048.GP8981@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091103 12:05]:
> Tuesday 03 November 2009 20:24:38 Janusz Krzysztofik napisa?(a):
> > If there are still no comments, especially on the bug possible impact on
> > other OMAP1510 boards (or even OMAP1610 with internal LCD controller), then
> > Tony, please apply it as is. Until it is accepted, I am stuck with new
> > ams_delta_defconfig.
> 
> Tony,
> Sorry, I've not checked for new mail before posting this one and missed your 
> acceptance for my idea of fixing all omap1510, not only ams_delta. If there 
> are no more comments, I'll submit v3 with cpu_is_omap1510() replacing 
> machine_is_ams_delta().

Sounds good to me.

Tony
 
> Thanks,
> Janusz
> 
> > --- linux-2.6.32-rc5/arch/arm/plat-omap/dma.c.orig	2009-10-16
> > 02:41:50.000000000 +0200 +++
> > linux-2.6.32-rc5/arch/arm/plat-omap/dma.c	2009-11-03 20:15:35.000000000
> > +0100 @@ -30,6 +30,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/io.h>
> >
> > +#include <asm/mach-types.h>
> >  #include <asm/system.h>
> >  #include <mach/hardware.h>
> >  #include <mach/dma.h>
> > @@ -1110,6 +1111,14 @@ int omap_dma_running(void)
> >  {
> >  	int lch;
> >
> > +	/*
> > +	 * On Amstrad Delta, the OMAP internal LCD controller will start the
> > +	 * transfer when it gets enabled, so assume DMA running if LCD enabled.
> > +	 */
> > +	if (machine_is_ams_delta())
> > +		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > +			return 1;
> > +
> >  	/* Check if LCD DMA is running */
> >  	if (cpu_is_omap16xx())
> >  		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
> 
> 
