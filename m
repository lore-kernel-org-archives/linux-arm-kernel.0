From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 13 Mar 2015 18:35:26 +0100
Subject: [PATCH v3 02/12] irqchip: nvic: support hierarchy irq domain
In-Reply-To: <1426203380-7155-3-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
 <1426203380-7155-3-git-send-email-stefan@agner.ch>
Message-ID: <CALszF6Di4kngd1Rzp9G=xwWPc4FqOPpA+5s+jrRSUGjs8OiCLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-13 0:36 GMT+01:00 Stefan Agner <stefan@agner.ch>:
> Add support for hierarchy irq domain. Use to support the interrupt
> router found in Vybrid SoC, which is between the NVIC and the
> peripherals.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/irqchip/irq-nvic.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
> index 4ff0805..5fac910 100644
> --- a/drivers/irqchip/irq-nvic.c
> +++ b/drivers/irqchip/irq-nvic.c
> @@ -49,6 +49,31 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>         handle_IRQ(irq, regs);
>  }
>
> +static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +                               unsigned int nr_irqs, void *arg)
> +{
> +       int i, ret;
> +       irq_hw_number_t hwirq;
> +       unsigned int type = IRQ_TYPE_NONE;
> +       struct of_phandle_args *irq_data = arg;
> +
> +       ret = irq_domain_xlate_onecell(domain, irq_data->np, irq_data->args,
> +                                  irq_data->args_count, &hwirq, &type);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < nr_irqs; i++)
> +               irq_map_generic_chip(domain, virq + i, hwirq + i);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops nvic_irq_domain_ops = {
> +       .xlate = irq_domain_xlate_onecell,
> +       .alloc = nvic_irq_domain_alloc,

.alloc is only available with CONFIG_IRQ_DOMAIN_HIERARCHY=y, and it is
not selected by in the config ARM_NVIC entry.
It breaks the build with my STM32 series.

Once selected, the build is fine, and the board boots successfully.


Best regards,
Maxime
