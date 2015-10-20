From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 15:50:35 +0200
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU
 interrupts at resume time
In-Reply-To: <87vba1ejqf.fsf@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <87vba1ejqf.fsf@free-electrons.com>
Message-ID: <20151020155035.0ba62be9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 20 Oct 2015 15:46:00 +0200, Gregory CLEMENT wrote:

> > +	/* Re-enable per-CPU interrupts that were enabled before suspend */
> > +	nirqs = (readl(main_int_base + ARMADA_370_XP_INT_CONTROL) >> 2) & 0x3ff;
> > +	for (irq = 0; irq < nirqs; irq++) {
> 
> Actually we could reduce this loop by using
> ARMADA_370_XP_MAX_PER_CPU_IRQS, as we know that we can't have more per
> cpu irq. 

Indeed. I can fix that up in the next version.

> > +		struct irq_data *data;
> > +		int virq;
> > +
> > +		virq = irq_linear_revmap(armada_370_xp_mpic_domain, irq);
> > +		if (virq == 0)
> > +			continue;
> > +
> > +		data = irq_get_irq_data(virq);
> > +
> > +		if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> > +			continue;
> 
> So eventually you only manage the timer IRQs?
> 
> If it is intentional you could it differently, but I wonder why you don't
> enable again the other percpu IRQ.

The idea is to have the same condition at the one used in the
->resume() hook.

In the end, it should be using the is_percpu_irq() function as is done
in linux-next in the ->resume() function. But since this patch is
(hopefully) aimed at 4.3, I've for now kept the same logic as the
current ->resume() function.

> The following chunk will conflict with "irqchip: armada-370-xp: Rework
> per-cpu interrupts handling" which is in Linux next. But as this patch
> is for 4.3, you can't do anything...

Indeed. I intentionally based this series on 4.3-rc, because it's
fixing a regression introduced between 4.2 and 4.3-rc, and therefore as
such should be fixed before 4.3 is released if possible (though I
understand it's already -rc6 time so maybe a bit late).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
