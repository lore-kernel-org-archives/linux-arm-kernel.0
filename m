From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Oct 2014 17:59:56 +0100
Subject: [PATCH v3 3/7] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <1412864980-20273-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
 <1412864980-20273-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <5436BF0C.1030508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/14 15:29, Joe.C wrote:
> From: "Joe.C" <yingjoe.chen@mediatek.com>
> 
> Add support to use gic as a parent for stacked irq domain.
> 
> Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> ---
>  drivers/irqchip/irq-gic.c | 56 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index dda6dbc..17f5aa6 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -767,19 +767,17 @@ void __init gic_init_physaddr(struct device_node *node)
>  static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  				irq_hw_number_t hw)
>  {
> +	irq_domain_set_hwirq_and_chip(d, irq, hw, &gic_chip, d->host_data);
>  	if (hw < 32) {
>  		irq_set_percpu_devid(irq);
> -		irq_set_chip_and_handler(irq, &gic_chip,
> -					 handle_percpu_devid_irq);
> +		irq_set_handler(irq, handle_percpu_devid_irq);
>  		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
>  	} else {
> -		irq_set_chip_and_handler(irq, &gic_chip,
> -					 handle_fasteoi_irq);
> +		irq_set_handler(irq, handle_fasteoi_irq);
>  		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>  
>  		gic_routable_irq_domain_ops->map(d, irq, hw);
>  	}
> -	irq_set_chip_data(irq, d->host_data);
>  	return 0;
>  }
>  
> @@ -795,8 +793,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>  {
>  	unsigned long ret = 0;
>  
> -	if (d->of_node != controller)
> -		return -EINVAL;
>  	if (intsize < 3)
>  		return -EINVAL;
>  
> @@ -839,6 +835,46 @@ static struct notifier_block gic_cpu_notifier = {
>  };
>  #endif
>  
> +
> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> +static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				unsigned int nr_irqs, void *arg)
> +{
> +	int i, ret;
> +	irq_hw_number_t hwirq;
> +	unsigned int type = IRQ_TYPE_NONE;
> +	struct of_phandle_args *irq_data = arg;
> +
> +	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
> +				   irq_data->args_count, &hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++)
> +		gic_irq_domain_map(domain, virq+i, hwirq+i);
> +
> +	return 0;
> +}
> +
> +static void gic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +				unsigned int nr_irqs)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_set_handler(virq + i, NULL);
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, 0, NULL, NULL);
> +	}
> +}
> +
> +static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
> +	.alloc = gic_irq_domain_alloc,
> +	.free = gic_irq_domain_free,
> +};
> +#else
> +#define gic_irq_domain_hierarchy_ops 0
> +#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
> +
>  static const struct irq_domain_ops gic_irq_domain_ops = {
>  	.map = gic_irq_domain_map,
>  	.unmap = gic_irq_domain_unmap,
> @@ -952,7 +988,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  
>  	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
>  
> -	if (of_property_read_u32(node, "arm,routable-irqs",
> +	if (IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) &&
> +		of_find_property(node, "arm,irq-domain-hierarchy", NULL))
> +		gic->domain = irq_domain_add_linear(node, gic_irqs,
> +					&gic_irq_domain_hierarchy_ops, gic);

I really think that looking for a property is the wrong thing to do. If
"node" is non-NULL, then we're pretty sure that we're initializing from
DT, and that a pure linear domain should be the right thing, leaving the
legacy stuff for the few non-DT platforms that are still around.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
