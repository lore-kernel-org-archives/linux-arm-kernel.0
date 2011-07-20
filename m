From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 02:07:46 +0900
Subject: [PATCH] ARM: S5P64X0: External Interrupt Support
In-Reply-To: <CAAgF-BcBwcoibw8-0d+P=ShcQh2bC3sAyqxznRJN3Bip2PuAyg@mail.gmail.com>
References: <1310712094-19831-1-git-send-email-padma.v@samsung.com>
	<20110715090011.GN23270@n2100.arm.linux.org.uk>
	<CAAgF-Bcke26iFsgf0DA3LB5CLv=TkS6UG0y+SBLR=F6TzGYU+A@mail.gmail.com>
	<20110715123429.GP23270@n2100.arm.linux.org.uk>
	<CAAgF-BcBwcoibw8-0d+P=ShcQh2bC3sAyqxznRJN3Bip2PuAyg@mail.gmail.com>
Message-ID: <06cb01cc46ff$8dc9a8f0$a95cfad0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

padma venkat wrote:
> 
> Hi Russell,
> 
> On Fri, Jul 15, 2011 at 6:04 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jul 15, 2011 at 05:23:33PM +0530, padma venkat wrote:
> >> Hi Russell,
> >>
> >> On Fri, Jul 15, 2011 at 2:30 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Jul 15, 2011 at 12:11:34PM +0530, Padmavathi Venna wrote:
> >> >> +#define eint_offset(irq) ? ? ((irq) - IRQ_EINT(0))
> >> >> +#define eint_irq_to_bit(irq) ((u32)(1 << eint_offset(irq)))
> >> >> +
> >> >> +static inline void s5p64x0_irq_eint_mask(struct irq_data *data)
> >> >> +{
> >> >> + ? ? u32 mask;
> >> >> +
> >> >> + ? ? mask = __raw_readl(S5P64X0_EINT0MASK);
> >> >> + ? ? mask |= (u32)data->chip_data;
> >> >> + ? ? __raw_writel(mask, S5P64X0_EINT0MASK);
> >> >> +}
> >> >> +
> >> >> +static void s5p64x0_irq_eint_unmask(struct irq_data *data)
> >> >> +{
> >> >> + ? ? u32 mask;
> >> >> +
> >> >> + ? ? mask = __raw_readl(S5P64X0_EINT0MASK);
> >> >> + ? ? mask &= ~((u32)data->chip_data);
> >> >> + ? ? __raw_writel(mask, S5P64X0_EINT0MASK);
> >> >> +}
> >> >> +
> >> >> +static inline void s5p64x0_irq_eint_ack(struct irq_data *data)
> >> >> +{
> >> >> + ? ? __raw_writel((u32)data->chip_data, S5P64X0_EINT0PEND);
> >> >> +}
> >> >> +
> >> >> +static void s5p64x0_irq_eint_maskack(struct irq_data *data)
> >> >> +{
> >> >> + ? ? /* compiler should in-line these */
> >> >> + ? ? s5p64x0_irq_eint_mask(data);
> >> >> + ? ? s5p64x0_irq_eint_ack(data);
> >> >> +}
> >> >
> >> > Won't genirqchip support deal with all of the above for you?
> >> As per my understanding, to deal with low level interrupt hardware
access
> >> we need to use the accessor functions. Please suggest me if there is
> >> any better way of doing this.
> >
> > I'm not saying don't have these. ?I'm saying use the _generic_ irqchip
> > support which has the code implemented to set and clear bits in
registers.
> > Something like this:
> >
> > ? ? ? ?struct irq_chip_generic *gc;
> >
> > ? ? ? ?gc = irq_alloc_generic_chip(name, 1, first_irq,
base_of_controller,
> > ? ? ? ? ? ? ? ? ? ? ? ?handler);
> >
> > ? ? ? ?gc->chip_types->chip.irq_ack = irq_gc_ack;
> > ? ? ? ?gc->chip_types->chip.irq_mask = irq_gc_mask_set_bit;
> > ? ? ? ?gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
> >
> > ? ? ? ?/* replace the two below with the _real_ offset, rather than
these
> calculations */
> > ? ? ? ?gc->chip_types->reg.ack = S5P64X0_EINT0PEND - base_of_controller;
> > ? ? ? ?gc->chip_types->reg.mask = S5P64X0_EINT0MASK -
base_of_controller;
> >
> > ? ? ? ?irq_setup_generic_chip(gc, mask_of_irqs_to_setup,
> > ? ? ? ? ? ? ? ?IRQ_GC_INIT_MASK_CACHE, flags_to_clear, flags_to_set);
> >
> Thanks for your explanation.
> I will remake the patch based on generic_irq_chip support and resend the
same.
> 
Hmm...any updated patch on this?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
