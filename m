From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 22 Sep 2015 13:55:58 +0200
Subject: [PATCH 1/3] irqchip: atmel-aic5: fix bug with mask/unmask
In-Reply-To: <alpine.DEB.2.11.1509221226090.5606@nanos>
References: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
 <alpine.DEB.2.11.1509221226090.5606@nanos>
Message-ID: <20150922135558.7be8ac1c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, 22 Sep 2015 12:27:08 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 21 Sep 2015, Ludovic Desroches wrote:
> > diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> > index 9da9942..6c5fd25 100644
> > --- a/drivers/irqchip/irq-atmel-aic5.c
> > +++ b/drivers/irqchip/irq-atmel-aic5.c
> > @@ -88,28 +88,30 @@ static void aic5_mask(struct irq_data *d)
> >  {
> >  	struct irq_domain *domain = d->domain;
> >  	struct irq_domain_chip_generic *dgc = domain->gc;
> > -	struct irq_chip_generic *gc = dgc->gc[0];
> > +	struct irq_chip_generic *bgc = dgc->gc[0];
> > +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> >  
> >  	/* Disable interrupt on AIC5 */
> > -	irq_gc_lock(gc);
> > +	irq_gc_lock(bgc);
> 
> Why is this locking dgc->gc[0] and fiddling with some other generic
> chip?

Actually, we always access the same set of registers for all irqs of the
domain, and thus need to take the same lock (I chose the one contained
in the first generic irqchip, but I guess it could work with the others
too, as long as we always take the same one) before accessing them
because the configuration is done in two steps:

1/ specify the irq line you want to configure
2/ set the new configuration

Regarding register accesses, all generic chips are configured to
point to the same registers, so accessing them from the 'base' generic
chip or from the generic chip attached to the irq_data struct is the
same, though I agree that using bgc would add some consistency to the
implementation.

This leaves the mask_cache value, which should be updated on the generic
chip attached to the irq_data (but since the lock is global to the
whole domain, it should work fine).

Please let us know if you see other problems, or have a better
solution to fix the bug.

Best Regards,

Boris

> 
> >  	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
> >  	irq_reg_writel(gc, 1, AT91_AIC5_IDCR);
> 
> Thanks,
> 
> 	tglx



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
