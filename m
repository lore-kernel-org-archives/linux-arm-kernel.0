From: horms@verge.net.au (Simon Horman)
Date: Thu, 16 May 2013 08:56:43 +0900
Subject: [PATCH v2 3/4] ARM: shmobile: marzen-reference: Initialise irqpin
In-Reply-To: <1482970.xQCySsLs8z@avalon>
References: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
 <1368586650-26263-4-git-send-email-horms+renesas@verge.net.au>
 <1482970.xQCySsLs8z@avalon>
Message-ID: <20130515235640.GA27876@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:28:15AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thanks for the patch.
> 
> On Wednesday 15 May 2013 11:57:29 Simon Horman wrote:
> > Empirically it appears to be necessary to call r8a7779_init_irq_extpin(1)
> > in order to initialise irqpin for use with IRQ1. This is already done in
> > the marzen board code. This adds the call to the marzen-reference board
> > code.
> > 
> > The motivation for this is to allow use of SMSC LAN, which uses IRQ1, with
> > marzen-reference.
> 
> This is an acceptable workaround for now, but in the not-so-long term we want 
> to move that code to the irqpin driver.

Yes, I agree that this not a long term solution.

> I've had a brief look at the irq-renesas-intc-irqpin driver, and it definitely 
> looks like some love is needed there. I don't have any free time for that at 
> the moment, but I could provide pointers if anyone wants to work on moving 
> irqpin-related arch code to the driver.
> 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/board-marzen-reference.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c
> > b/arch/arm/mach-shmobile/board-marzen-reference.c index 5332e89..f83b6d1
> > 100644
> > --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> > +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> > @@ -63,12 +63,18 @@ static const char *marzen_boards_compat_dt[] __initdata
> > = { NULL,
> >  };
> > 
> > +void __init marzen_init_irq(void)
> > +{
> > +	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
> > +	r8a7779_init_irq_dt();
> > +}
> > +
> >  DT_MACHINE_START(MARZEN, "marzen")
> >  	.smp		= smp_ops(r8a7779_smp_ops),
> >  	.map_io		= r8a7779_map_io,
> >  	.init_early	= r8a7779_init_delay,
> >  	.nr_irqs	= NR_IRQS_LEGACY,
> > -	.init_irq	= r8a7779_init_irq_dt,
> > +	.init_irq	= marzen_init_irq,
> >  	.init_machine	= marzen_init,
> >  	.init_time	= shmobile_timer_init,
> >  	.dt_compat	= marzen_boards_compat_dt,
> -- 
> Regards,
> 
> Laurent Pinchart
> 
