From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 26 Oct 2015 05:35:46 +0100
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU interrupts
 at resume time
In-Reply-To: <20151026011036.2cb5b7a8@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAPv3WKdZeCo-0xFC6EJcCeVQd7ef+SQz=MocR1nE5YdZAx3AJQ@mail.gmail.com>
 <20151026011036.2cb5b7a8@free-electrons.com>
Message-ID: <CAPv3WKc8bzCadNN=SRxQuJBxMiHTVKnmqaSkTehu=j6V4nF6Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

2015-10-26 1:10 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Marcin,
>
> On Sun, 25 Oct 2015 22:22:37 +0100, Marcin Wojtas wrote:
>
>> > @@ -550,16 +572,27 @@ static void armada_370_xp_mpic_resume(void)
>> >                 if (virq == 0)
>> >                         continue;
>> >
>> > -               if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
>> > +               data = irq_get_irq_data(virq);
>> > +
>> > +               if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
>> > +                       /* Non per-CPU interrupts */
>> >                         writel(irq, per_cpu_int_base +
>>
>> For "Non per-CPU interrupts" per_cpu_int_base is used - is it
>> intentional? In armada_370_xp_irq_mask/unmask the condition looks
>> exactly opposite...
>
> Yes, this is normal. Carefully read PATCH 5/5, which adds a big
> comment, which explains the logic of the HW and how the
> irq-armada-370-xp driver copes with it.
>
> Each interrupt can be masked at two levels. One level is enabled when
> the interrupted is mapped, the other upon ->mask()/->unmask(). So
> when we're resuming, we need to re-enable the interrupt at the level it
> was enabled in ->map(), and have ->mask()/->unmask() continue to
> mask/unmask the interrupt at the other level.
>
> For per-CPU interrupts, ->map() and ->resume() enable the interrupt at
> the global level, and leave ->mask()/->unmask() enable/disable at the
> per-CPU level.
>
> For global interrupts, ->map() and ->resume() enable the interrupt at
> the per-CPU level, and leave ->mask()/->unmask() enable/disable at the
> global level.
>
> Again, see PATCH 5/5, and let me know if there are still some unclear
> aspects.
>

Thanks for the explanation - now it's clear.

Btw, I checked the patches with mvneta in both 'standby' and 'mem'
modes on A38x (with not-yet-submitted support for PM in mvneta and
pinctrl) and everything works properly. Hence:

Tested-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin
