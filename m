From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 8 Jun 2015 12:59:57 +0200
Subject: EDMA oftree entry for AM335x
In-Reply-To: <20150506143951.GG21061@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com>
 <20150505145828.GB21061@atomide.com> <5549F95B.8090905@ti.com>
 <20150506143951.GG21061@atomide.com>
Message-ID: <20150608105957.GT26523@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 07:39:52AM -0700, Tony Lindgren wrote:
> > In different SoC we can have different number of CCs (OMAP-L138 has two) and
> > each CC can have different number of TCs associated with. In AM335x we have
> > one CC with 3 TC, in OMAP-L138 we have two CC, CC0 has 2 TC, CC1 has 1 TC. The
> > TCs are used to set priorities, you can assign the priorities to the TCs and
> > you can choose to assign the transfer (channel) to a give TC.
> 
> OK
>  
> > >> And yes, both TC and CCs can generate interrupts.
> > > 
> > > Do the TCs have a shared interrupt that could be handled by
> > > each TC instance?
> > 
> > Separate IRQ lines to the ARM core, but we do not handle them right now.
> 
> OK
>  
> > >> So it is not straight forward to separate the TC from the CC driver (edma3).
> > > 
> > > It seems pm runtime for these four separate modules needs to be
> > > done at the CC driver level if it can't be done separately for
> > > each instance.
> > 
> > The current eDMA stack is not really flexible on this IMHO.
> > I think the way forward would be something like this in DT:
> > 
> > edma_cc: edma_cc at 49000000 {
> > 	compatible = "ti,edma3-cc";
> > 	ti,hwmods = "tpcc"
> > 	reg =	<0x49000000 0x10000>,
> > 		<0x44e10f90 0x40>;
> > 	interrupts = <12 13 14>;
> > 	#dma-cells = <1>;
> > 
> > 	edma3_tc0: edma3_tc0 at 49800000 {
> > 		compatible = "ti,edma3-tc";
> > 		ti,hwmods = "tptc0"
> > 	};
> > 
> > 	edma3_tc1: edma3_tc1 at 49900000 {
> > 		compatible = "ti,edma3-tc";
> > 		ti,hwmods = "tptc1"
> > 	};
> > 
> > 	edma3_tc2: edma3_tc2 at 49a00000 {
> > 		compatible = "ti,edma3-tc";
> > 		ti,hwmods = "tptc2"
> > 	};
> > };
> 
> Yeah that would be an improvment and remove the blockers for further
> hwmod work. It would still be better to have the TC probe separately
> and register with CC rather than combining separate elements in DT
> in a way that does not represent the hardare. There's a 7MB reserved
> block inbetween there..
>  
> > The driver for ti,edma3-tc would be pretty minimal, doing only pm_runtime only
> > and from the CC driver we could just set the runtime status for the the TC
> > which we are about to submit work and decrement the runtime when the work is
> > done. If not work is needed for the TC it can be shot down.
> 
> OK
>  
> > But this would need significant amount of work which can be done when we get
> > rid of the legacy (arch/arm/common/edma.c) and move to dmaengine only mode.
> 
> That may never happen considering that davinci is using it too.. It's
> best to not count on that happening anytime soon at least.

So my current understanding is that we have the situation that the
kernel warns about the oftree being wrong, but isn't able to handle an
oftree that would be right.

Shouldn't the warning being added when the kernel driver supports that
new mechanism?

I had a warning free mainline kernel without patches on my customer
hardware before, so this smells a bit like a regression ... :-/

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
