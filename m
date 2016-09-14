From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 14 Sep 2016 11:19:02 +0200 (CEST)
Subject: [PATCH v5 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <6941f61d-0b33-4108-0135-b11887cd0488@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609131713490.6233@nanos>
 <6941f61d-0b33-4108-0135-b11887cd0488@st.com>
Message-ID: <alpine.DEB.2.20.1609141103420.6233@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Sep 2016, Alexandre Torgue wrote:
> On 09/13/2016 05:21 PM, Thomas Gleixner wrote:
> > On Fri, 9 Sep 2016, Alexandre TORGUE wrote:
> > > +static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
> > > +			    unsigned int nr_irqs)
> > > +{
> > > +	struct irq_data *data = irq_get_irq_data(virq);
> > > +
> > > +	irq_gc_mask_clr_bit(data->parent_data);
> > 
> > I have a hard time to understand this. The irq domain is not hierarchical.
> 
> Actually, I wanted to test ".free" callback function of gpio_irq_domain in
> STM32 pinctrl driver. To do that I modified gpio driver: just after getting
> virq through gpio_to_irq, I called "irq_dispose_mapping(virq)".
> I know it is dirty but I thought it was the only way to test.
> 
> Doing that, I see that ".free" callback of gpio domain is called but as it is
> hirerchical ".free" callback for parent domain (exti one) is also called. I
> observed that virq was well unmapped, but not masked at exti level. It is for
> this reason than I added "irq_gc_mask_clr_bit(data->parent_data);" which mask
> interrupt at exti level.

Aargh. I really misread the patch, but this is entirely non obvious and you
should do:

       struct irq_data *data = irq_domain_get_irq_data(d, virq);

       irq_gc_mask_clr_bit(d);

Then it is entirely clear that you mask the interrupt of _this_ (the exti)
domain.

Now what really bugs me is that you do that at all. An interrupt which is
freed must be masked already. Why is it unmasked in the first place?

Thanks,

	tglx
