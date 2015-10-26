From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Oct 2015 01:10:36 +0100
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU
 interrupts at resume time
In-Reply-To: <CAPv3WKdZeCo-0xFC6EJcCeVQd7ef+SQz=MocR1nE5YdZAx3AJQ@mail.gmail.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAPv3WKdZeCo-0xFC6EJcCeVQd7ef+SQz=MocR1nE5YdZAx3AJQ@mail.gmail.com>
Message-ID: <20151026011036.2cb5b7a8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcin,

On Sun, 25 Oct 2015 22:22:37 +0100, Marcin Wojtas wrote:

> > @@ -550,16 +572,27 @@ static void armada_370_xp_mpic_resume(void)
> >                 if (virq == 0)
> >                         continue;
> >
> > -               if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> > +               data = irq_get_irq_data(virq);
> > +
> > +               if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
> > +                       /* Non per-CPU interrupts */
> >                         writel(irq, per_cpu_int_base +
> 
> For "Non per-CPU interrupts" per_cpu_int_base is used - is it
> intentional? In armada_370_xp_irq_mask/unmask the condition looks
> exactly opposite...

Yes, this is normal. Carefully read PATCH 5/5, which adds a big
comment, which explains the logic of the HW and how the
irq-armada-370-xp driver copes with it.

Each interrupt can be masked at two levels. One level is enabled when
the interrupted is mapped, the other upon ->mask()/->unmask(). So
when we're resuming, we need to re-enable the interrupt at the level it
was enabled in ->map(), and have ->mask()/->unmask() continue to
mask/unmask the interrupt at the other level.

For per-CPU interrupts, ->map() and ->resume() enable the interrupt at
the global level, and leave ->mask()/->unmask() enable/disable at the
per-CPU level.

For global interrupts, ->map() and ->resume() enable the interrupt at
the per-CPU level, and leave ->mask()/->unmask() enable/disable at the
global level.

Again, see PATCH 5/5, and let me know if there are still some unclear
aspects.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
