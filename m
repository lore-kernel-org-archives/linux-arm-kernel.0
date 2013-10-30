From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 30 Oct 2013 16:15:28 +0100 (CET)
Subject: [PATCH V2 1/7] DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable
 irqs
In-Reply-To: <1383145040-15852-2-git-send-email-r.sricharan@ti.com>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
 <1383145040-15852-2-git-send-email-r.sricharan@ti.com>
Message-ID: <alpine.DEB.2.02.1310301608380.24686@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Oct 2013, Sricharan R wrote:
> @@ -700,11 +709,22 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>  	*out_hwirq = intspec[1] + 16;
>  
>  	/* For SPIs, we need to add 16 more to get the GIC irq ID number */
> -	if (!intspec[0])
> +	if (!intspec[0]) {
>  		*out_hwirq += 16;

Minor nit. This should be in the default implementation. The crossbar
implementation will fill out_hwirq in its own way and is not
interested in the +16 operation at all.

> +		ret = gic_routable_irq_domain_ops->xlate(d, controller,
> +							 intspec,
> +							 intsize,
> +							 out_hwirq,
> +							 out_type);
> +

> +		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
> +					hwirq_base, &gic_irq_domain_ops, gic);
> +	} else {
> +		if (WARN_ON(!gic_routable_irq_domain_ops))
> +			return;

This warning is pointless, because you have default ops now.

> +
> +		gic->domain = irq_domain_add_linear(node, nr_routable_irqs,
> +						    &gic_irq_domain_ops,
> +						    gic);
>  	}

Thanks,

	tglx
