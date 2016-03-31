From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 16:07:25 +0800
Subject: [PATCH 01/18] irqchip: vf610-gpc: add Vybrid GPC IRQ controller
In-Reply-To: <1457576219-7971-2-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-2-git-send-email-stefan@agner.ch>
Message-ID: <20160331080725.GU28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:16:42PM -0800, Stefan Agner wrote:
> +static int __init vf610_gpc_of_init(struct device_node *node,
> +			       struct device_node *parent)
> +{
> +	struct irq_domain *domain, *domain_parent;
> +	int i;
> +
> +	domain_parent = irq_find_host(parent);
> +	if (!domain_parent) {
> +		pr_err("vf610_gpc: interrupt-parent not found\n");
> +		return -EINVAL;
> +	}
> +
> +	gpc_base = of_io_request_and_map(node, 0, "gpc");
> +	if (WARN_ON(!gpc_base))

of_io_request_and_map() doesn't return NULL for error but an error code
encoded by ERR_PTR().  That said, you should use IS_ERR(gpc_base) rather
than !gpc_base for error check.

Shawn

> +		return PTR_ERR(gpc_base);
> +
> +	domain = irq_domain_add_hierarchy(domain_parent, 0, VF610_GPC_MAX_IRQS,
> +					  node, &gpc_irq_domain_ops, NULL);
> +	if (!domain) {
> +		iounmap(gpc_base);
> +		return -ENOMEM;
> +	}
> +
> +	/* Initially mask all interrupts for wakeup */
> +	for (i = 0; i < IMR_NUM; i++)
> +		writel_relaxed(~0, gpc_base + VF610_GPC_IMR1 + i * 4);
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(vf610_gpc, "fsl,vf610-gpc", vf610_gpc_of_init);
> -- 
> 2.7.2
> 
> 
