From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Feb 2014 11:51:21 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <20140206114559.GK29446@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-3-git-send-email-will.deacon@arm.com>
 <20140206114559.GK29446@arm.com>
Message-ID: <20140206115121.GN26035@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:45:59AM +0000, Catalin Marinas wrote:
> On Thu, Feb 06, 2014 at 11:30:50AM +0000, Will Deacon wrote:
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index 341c6016812d..03fe5ef3f2fe 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -662,11 +662,10 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >  	/*
> >  	 * Ensure that stores to Normal memory are visible to the
> >  	 * other CPUs before issuing the IPI.
> > +	 *
> > +	 * This always happens on GIC0.
> >  	 */
> > -	dsb();
> > -
> > -	/* this always happens on GIC0 */
> > -	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> > +	writel(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> 
> That's heavier than a dsb() since with outer caches on ARM we also get
> an outer_sync() call.

Yes, which I think we actually need in this case, since we're trying to make
normal writes visible to a CPU before a device write hits the GIC.

I can update the commit message if you like?

Will
