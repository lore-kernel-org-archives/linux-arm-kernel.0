From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Jun 2015 12:13:30 -0500
Subject: [PATCH 07/15] irqchip: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-8-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-8-git-send-email-robh@kernel.org>
Message-ID: <CAL_JsqL+3uSBZ5yjb60xL4xt_b3xnpZvLpnKHBuCdc0Fs2udAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 1:26 PM, Rob Herring <robh@kernel.org> wrote:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
>
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.

[...]

> diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
> index 33127f1..e3609ae 100644
> --- a/drivers/irqchip/irq-clps711x.c
> +++ b/drivers/irqchip/irq-clps711x.c
> @@ -133,14 +133,14 @@ static int __init clps711x_intc_irq_map(struct irq_domain *h, unsigned int virq,
>                                         irq_hw_number_t hw)
>  {
>         irq_flow_handler_t handler = handle_level_irq;
> -       unsigned int flags = IRQF_VALID | IRQF_PROBE;
> +       unsigned int flags = 0;
>
>         if (!clps711x_irqs[hw].flags)
>                 return 0;
>
>         if (clps711x_irqs[hw].flags & CLPS711X_FLAG_FIQ) {
>                 handler = handle_bad_irq;
> -               flags |= IRQF_NOAUTOEN;
> +               flags |= IRQ_NOAUTOEN;
>         } else if (clps711x_irqs[hw].eoi) {
>                 handler = handle_fasteoi_irq;
>         }
> @@ -150,7 +150,7 @@ static int __init clps711x_intc_irq_map(struct irq_domain *h, unsigned int virq,
>                 writel_relaxed(0, clps711x_intc->base + clps711x_irqs[hw].eoi);
>
>         irq_set_chip_and_handler(virq, &clps711x_intc_chip, handler);
> -       set_irq_flags(virq, flags);
> +       irq_modify_status_flags(irq, IRQ_NOPROBE, flags);

One fix needed here:

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index e3609ae..2e74e81 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -150,7 +150,7 @@ static int __init clps711x_intc_irq_map(struct
irq_domain *h, unsigned int virq,
                writel_relaxed(0, clps711x_intc->base + clps711x_irqs[hw].eoi);

        irq_set_chip_and_handler(virq, &clps711x_intc_chip, handler);
-       irq_modify_status_flags(irq, IRQ_NOPROBE, flags);
+       irq_modify_status(virq, IRQ_NOPROBE, flags);

        return 0;
 }
