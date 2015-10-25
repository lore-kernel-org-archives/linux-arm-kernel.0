From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 25 Oct 2015 22:22:37 +0100
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU interrupts
 at resume time
In-Reply-To: <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAPv3WKdZeCo-0xFC6EJcCeVQd7ef+SQz=MocR1nE5YdZAx3AJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


>
> @@ -550,16 +572,27 @@ static void armada_370_xp_mpic_resume(void)
>                 if (virq == 0)
>                         continue;
>
> -               if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> +               data = irq_get_irq_data(virq);
> +
> +               if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
> +                       /* Non per-CPU interrupts */
>                         writel(irq, per_cpu_int_base +

For "Non per-CPU interrupts" per_cpu_int_base is used - is it
intentional? In armada_370_xp_irq_mask/unmask the condition looks
exactly opposite...

>                                ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> -               else
> +                       if (!irqd_irq_disabled(data))
> +                               armada_370_xp_irq_unmask(data);
> +               } else {
> +                       /* Per-CPU interrupts */
>                         writel(irq, main_int_base +
>                                ARMADA_370_XP_INT_SET_ENABLE_OFFS);
>

Best regards,
Marcin
