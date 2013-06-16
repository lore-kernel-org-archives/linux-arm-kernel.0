From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 16 Jun 2013 11:21:52 +0200
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <20130615004149.D85B13E0A2E@localhost>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130615004149.D85B13E0A2E@localhost>
Message-ID: <20130616092152.GH11232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 01:41:49AM +0100, Grant Likely wrote:
> On Wed, 12 Jun 2013 23:50:35 +0200, Uwe Kleine-K?nig  <u.kleine-koenig@pengutronix.de> wrote:
> > This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
> > 
> > Support for this controller appeared in Catalin's Cortex tree based on
> > 2.6.33 but was nearly completely rewritten.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > 
> > Notes:
> >     Changes since v3, sent with
> >     Message-Id: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>:
> >     
> >      - use generic chip
> >      - rename nvic_do_IRQ to nvic_handle_irq
> >     
> >     This depends on the stuff currently in tip/irq/for-arm
> 
> Minor comments below, but it looks good to me. Nice and small.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> > +asmlinkage void __exception_irq_entry
> > +nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> > +{
> > +	unsigned int irq = irq_linear_revmap(nvic_irq_domain, hwirq);
> > +
> > +	handle_IRQ(irq, regs);
> 
> Or simply:
> 	handle_IRQ(irq_linear_revmap(nvic_irq_domain, hwirq), regs);
I think my version is more readable, so I tend to keep it the way I
suggested.

> > +static int __init nvic_of_init(struct device_node *node,
> > +			       struct device_node *parent)
> > +{
> > +	void __iomem *nvic_base;
> > +	unsigned int irqs, i, ret;
> > +	unsigned numbanks = (readl_relaxed(V7M_SCS_ICTR) &
> > +			     V7M_SCS_ICTR_INTLINESNUM_MASK) + 1;
> > +	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> > +
> > +	nvic_base = of_iomap(node, 0);
> > +	if (!nvic_base) {
> > +		pr_warn("unable to map nvic registers\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	irqs = numbanks * 32;
> > +	if (irqs > NVIC_MAX_IRQ)
> > +		irqs = NVIC_MAX_IRQ;
> 
> I would display some kind of message here.
That's not an error case. The documentation about INTLINESNUM reads:

	The total number of interrupt lines supported by an
	implementation, defined in groups of 32. That is, the total number of
	interrupt lines is up to (32*(INTLINESNUM+1)). However, the absolute
	maximum number of interrupts is 496, corresponding to the INTLINESNUM
	value 0b1111.

And the documentation for e.g. NVIC_ISER0 - NVIC_ISER15 reads:

	Usage constraints NVIC_ISERn[31:0] are the set-enable bits for
	interrupts (31+(32*n)) - (32*n).
	When n=15, bits [31:16] are reserved.

So it's just an implementation detail that the last bank can only
contain 16 interrupts. There is a comment describing that fact at the
definition of NVIC_MAX_IRQ.

So I think this case is important enough to clutter the kernel log.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
