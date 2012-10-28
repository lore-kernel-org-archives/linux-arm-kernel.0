From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 28 Oct 2012 19:46:12 +0100 (CET)
Subject: irq_set_chained_handler() called too early for hwirq to be
 initialized
In-Reply-To: <508D7B33.80902@antcom.de>
References: <508D55C9.3030702@antcom.de>
 <alpine.LFD.2.02.1210281810390.2756@ionos> <508D7B33.80902@antcom.de>
Message-ID: <alpine.LFD.2.02.1210281941570.2756@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2012, Roland Stigge wrote:
> On 28/10/12 18:34, Thomas Gleixner wrote:
> > On Sun, 28 Oct 2012, Roland Stigge wrote:
> >> consider arch/arm/mach-lpc32xx/irq.c: irq_set_chained_handler() is
> >> called at a point where it accesses
> >> irq_to_desc(IRQ_LPC32XX_SUB2IRQ)->irq_data.hwirq but which is not yet
> >> initialized.
> > 
> > None of the functions which are called inside of
> > irq_set_chained_handler() touches desc->irq_data.hwirq.
> > 
> > So what are you talking about?
> 
> Via the call trace:
> 
> irq_set_chained_handler()
> -> __irq_set_handler()
> -> irq_startup()
> -> irq_enable()
> -> desc->irq_data.chip->irq_unmask()

That's right. Though your description was so vague that I really could
not figure that out.
 
> Still, my question remains if I can move the irq_set_chained_handler()
> calls to after of_irq_init() and irq_domain_add_legacy() since only the
> latter initializes hwirq.

That's not a question. You MUST do that. And there is no reason why
you can't.

> > If those interrupts would not be preallocated, then the code would
> > fail to initialize any interrupt at all. And of course nothing would
> > notice as all function calls to set_irq_* do not check the return
> > value.
> 
> Do you mean mach-lpc32xx/irq.c's calls to set_irq_* not checking the
> return values? Maybe because those are declared "void"?
> 
> static inline void
> irq_set_chained_handler(unsigned int irq, irq_flow_handler_t handle);
> void set_irq_flags(unsigned int irq, unsigned int iflags);
> static inline void irq_set_chip_and_handler(unsigned int irq,
>                                             struct irq_chip *chip,
>                                             irq_flow_handler_t handle);

Bah. Yes. We should change that or at least put a warning into the
core code.

Thanks,

	tglx
