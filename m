From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Apr 2011 10:12:05 +0100
Subject: [RFC PATCH 01/12] ARM: gic: add per-cpu interrupt multiplexer
In-Reply-To: <4DB64361.4050904@codeaurora.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-2-git-send-email-marc.zyngier@arm.com>
	<4DB64361.4050904@codeaurora.org>
Message-ID: <20110426101205.6696a6ea@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr 2011 21:00:33 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> Just minor comments. I'm not a GIC or IRQ expert (yet).
> 
> On 4/20/2011 12:08 PM, Marc Zyngier wrote:
> > @@ -312,17 +414,39 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
> >  	 * Limit number of interrupts registered to the platform maximum
> >  	 */
> >  	irq_limit = gic->irq_offset + gic_irqs;
> > -	if (WARN_ON(irq_limit > NR_IRQS))
> > +	if (WARN_ON((irq_limit) > NR_IRQS))
> 
> () are RFC leftovers?

Just a fossil dating back from an early version of the patch. Will fix.

> >  		irq_limit = NR_IRQS;
> >  
> >  	/*
> >  	 * Setup the Linux IRQ subsystem.
> >  	 */
> >  	for (i = irq_start; i < irq_limit; i++) {
> > -		irq_set_chip_and_handler(i, &gic_chip, handle_fasteoi_irq);
> > +#ifdef CONFIG_ARM_GIC_VPPI
> > +		if (nrvppis && gic_irq_is_ppi(gic, i))
> > +			irq_set_chip_and_handler(i, &gic_chip, gic_handle_ppi);
> > +		else
> > +#endif
> > +		{
> > +			irq_set_chip_and_handler(i, &gic_chip,
> > +						 handle_fasteoi_irq);
> > +			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> > +		}
> > +		irq_set_chip_data(i, gic);
> > +	}
> > +
> > +#ifdef CONFIG_ARM_GIC_VPPI
> > +	if (!nrvppis)
> > +		goto out;
> > +	gic->vppi_base = irq_alloc_descs(-1, 0, nrvppis, 0);
> > +	if (unlikely(WARN_ON(gic->vppi_base < 0)))
> 
> WARN_ON should already have an unlikely in it.

Good point. Will fix as well.

Thanks for reviewing,

	M.
-- 
I'm the slime oozin' out from your TV set...
