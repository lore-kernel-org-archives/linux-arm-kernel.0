From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 27 Feb 2014 12:28:47 +0100 (CET)
Subject: [patch 09/26] arm: mmp: Remove pointless fiddling with irq
 internals
In-Reply-To: <CAN1soZzipHL=0i4gH3B7PwHaOJh6=_uwv5u0e7W2MsvARp_jLA@mail.gmail.com>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.214342433@linutronix.de>
 <20140223231755.GA27579@pengutronix.de>
 <CADApbeiyGoSAF9n5-+Ys1H4VDgN+d727E6ARWFGj4EixqeP79w@mail.gmail.com>
 <CAN1soZy_TfzNigfn4y6kF2qe4K+AQsagd-1KWYrz1VEavMO4bA@mail.gmail.com>
 <alpine.DEB.2.02.1402241227400.21251@ionos.tec.linutronix.de>
 <CADApbeiJ2ESEuBxGNXLe+sbKEox02Vr0hhO-rW7dosc_4A+TEQ@mail.gmail.com>
 <CAN1soZzipHL=0i4gH3B7PwHaOJh6=_uwv5u0e7W2MsvARp_jLA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1402271211320.4174@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014, Haojian Zhuang wrote:
> Let me list the logic to make it easier to understand.
> 
> suspend_enter()
>   --> dpm_suspend_end()
>            --> dpm_suspend_noirq()
>                     --> suspend_device_irqs()
>                              --> __disable_irq()
>                                      --> set IRQS_SUSPENDED && call
> irq_disable() if necessary
>   --> syscore_suspend()
>           --> check_wakeup_irqs()
>                If there's no pending irq in suspend process &&
> IRQS_SUSPENDED is set,
>                then mask the irq.
> 
> Yes, we didn't implement disable_irq(). But we must implement mask_irq().
> 
> So system suspends. Then system will never be waken up by this irq any
> more since
> it's masked.

This is so wrong, it's not even funny anymore.

check_wakeup_irqs()
{
	for_each_irq_desc(irq, desc) {
                if (irqd_is_wakeup_set(&desc->irq_data)) {
                        if (desc->depth == 1 && desc->istate & IRQS_PENDING)
                                return -EBUSY;
                        continue;
                }

So all interrupt lines which have been marked as wakeup sources are
not masked. And we only mask the other lines if the irq chip has the
IRQCHIP_MASK_ON_SUSPEND flag set.

                if (desc->istate & IRQS_SUSPENDED &&
                    irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
                        mask_irq(desc);

}

The interrupts which can wake up your system fall into the
irqd_is_wakeup_set() clause. So nothing masks the interrupts at these
interrupt controller level. Your chip does not have the
IRQCHIP_MASK_ON_SUSPEND flag set either, so not a single interrupt
line gets masked.

The only thing you do with your hackery is to avoid that the interrupt
is marked disabled. And that means that you violate the rules of the
suspend logic.

We lazy disable the interrupts when we go into suspend in order to
abort the suspend when a wakeup interrupt happens between the
suspend_device_irqs() and check_wakeup_irqs(). Your hackery allows the
system to handle the interrupt, so we have no indication that the
suspend should be aborted.

You insist, that the interrupt line is masked at the irq chip level on
suspend, but you completely fail to explain how this should
happen. All you came up with so far is handwaving and a proper proof
of incompetence.

I'm really start to get grumpy about this utter waste of time.

Thanks,

	tglx
