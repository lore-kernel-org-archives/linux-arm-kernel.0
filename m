From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Dec 2014 10:39:00 +0100
Subject: [PATCH 04/12] irqchip: nvic: support routable irq domain ops
In-Reply-To: <1417565531-4507-5-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-5-git-send-email-stefan@agner.ch>
Message-ID: <20141203093900.GL2129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On Wed, Dec 03, 2014 at 01:12:03AM +0100, Stefan Agner wrote:
> Add support for routable irq domain ops like the GIC interrupt
> controller provides. This is useful for asymmetrical multi-
> processor SoCs, such as Freescale Vybrid (VF6xx) which have
> a Cortex-M4 alongside a Cortex-A5 and a interrupt router to
> route the peripheral interrupts between them.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/irqchip/irq-nvic.c       | 70 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/irqchip/arm-nvic.h | 25 ++++++++++++++
>  2 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/irqchip/arm-nvic.h
> 
> diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
> index 4ff0805..dbfb5be 100644
> --- a/drivers/irqchip/irq-nvic.c
> +++ b/drivers/irqchip/irq-nvic.c
> @@ -40,6 +40,7 @@
>  #define NVIC_MAX_IRQ		((NVIC_MAX_BANKS - 1) * 32 + 16)
>  
>  static struct irq_domain *nvic_irq_domain;
> +const struct irq_domain_ops *nvic_routable_irq_domain_ops;
Can you reshuffle the order of functions to make this forward
declaration unnecessary?
  
>  asmlinkage void __exception_irq_entry
>  nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> @@ -49,6 +50,73 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>  	handle_IRQ(irq, regs);
>  }
>  
> +static int nvic_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +				irq_hw_number_t hw)
> +{
> +	int ret;
> +
> +	ret = irq_map_generic_chip(d, irq, hw);
> +
> +	if (IS_ERR_VALUE(ret))
if (ret < 0)

> +		return ret;
> +
> +	return nvic_routable_irq_domain_ops->map(d, irq, hw);
You could save the default implementations if you do:

	if (nvic_routable_irq_domain_ops)
		return nvic_routable_irq_domain_ops->map(d, irq, hw);

(maybe also check for map?)

> +}
> +
> +static void nvic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
> +{
> +	nvic_routable_irq_domain_ops->unmap(d, irq);
> +}
> +
> +static int nvic_irq_domain_xlate(struct irq_domain *d,
> +				 struct device_node *controller,
> +				 const u32 *intspec, unsigned int intsize,
> +				 unsigned long *out_hwirq,
> +				 unsigned int *out_type)
> +{
> +	*out_hwirq = intspec[0];
> +	*out_type = IRQ_TYPE_NONE;
If you demand from the callback to set this, you can just do

	nvic_irq_domain_ops.xlate = new_callback;

not sure this is sensible though. Up to you.

> +	return nvic_routable_irq_domain_ops->xlate(d, controller, intspec,
> +						  intsize, out_hwirq, out_type);
> +}
> +
> +struct irq_domain_ops nvic_irq_domain_ops = {
> +	.map	= nvic_irq_domain_map,
> +	.unmap	= nvic_irq_domain_unmap,
> +	.xlate	= nvic_irq_domain_xlate,
> +};
> +
> +/* Default functions for routable irq domain */
> +static int nvic_routable_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +			      irq_hw_number_t hw)
> +{
> +	return 0;
> +}
> +
> +static void nvic_routable_irq_domain_unmap(struct irq_domain *d,
> +					  unsigned int irq)
> +{
> +}
> +
> +static int nvic_routable_irq_domain_xlate(struct irq_domain *d,
> +				struct device_node *controller,
> +				const u32 *intspec, unsigned int intsize,
> +				unsigned long *out_hwirq,
> +				unsigned int *out_type)
> +{
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops nvic_default_routable_irq_domain_ops = {
> +	.map = nvic_routable_irq_domain_map,
> +	.unmap = nvic_routable_irq_domain_unmap,
> +	.xlate = nvic_routable_irq_domain_xlate,
> +};
> +
> +const struct irq_domain_ops *nvic_routable_irq_domain_ops =
> +					&nvic_default_routable_irq_domain_ops;
> +
>  static int __init nvic_of_init(struct device_node *node,
>  			       struct device_node *parent)
>  {
> @@ -70,7 +138,7 @@ static int __init nvic_of_init(struct device_node *node,
>  		irqs = NVIC_MAX_IRQ;
>  
>  	nvic_irq_domain =
> -		irq_domain_add_linear(node, irqs, &irq_generic_chip_ops, NULL);
> +		irq_domain_add_linear(node, irqs, &nvic_irq_domain_ops, NULL);
>  	if (!nvic_irq_domain) {
>  		pr_warn("Failed to allocate irq domain\n");
>  		return -ENOMEM;
> diff --git a/include/linux/irqchip/arm-nvic.h b/include/linux/irqchip/arm-nvic.h
> new file mode 100644
> index 0000000..0e92a14
> --- /dev/null
> +++ b/include/linux/irqchip/arm-nvic.h
> @@ -0,0 +1,25 @@
> +/*
> + *  include/linux/irqchip/arm-nvic.h
Don't add the filename to a comment. There are more reliable means to
find it out than looking for that comment.

> + *
> + *  Copyright (C) 2014 Stefan Agner
Is this indented differently to the paragraph below on purpose?

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __LINUX_IRQCHIP_ARM_NVIC_H
> +#define __LINUX_IRQCHIP_ARM_NVIC_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#ifdef CONFIG_ARM_NVIC
> +extern const struct irq_domain_ops *nvic_routable_irq_domain_ops;
> +static inline void __init register_routable_domain_ops
> +					(const struct irq_domain_ops *ops)
> +{
> +		nvic_routable_irq_domain_ops = ops;
> +}
> +#endif /* CONFIG_ARM_NVIC */
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* __LINUX_IRQCHIP_ARM_NVIC_H */

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
