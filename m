From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 22:32:42 +0000
Subject: [PATCH v2] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1363612826-15623-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.LFD.2.02.1303122150490.22263@ionos>
 <1363612826-15623-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201303282232.42955.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Uwe Kleine-K?nig wrote:

> +static int __init nvic_init_bases(struct device_node *node,
> +				  void __iomem *nvic_base)
> +{

There is probably no point to keep this function separate from
nvic_of_init any more, unless you plan to mke it globally
accessible and called from non-DT platforms. In that case
you would need an irq_base argument though.

> +	irq_base = irq_alloc_descs_from(16, irqs, numa_node_id());
> +	if (irq_base < 0) {
> +		pr_warn("Cannot allocate irq_descs\n");
> +		ret = irq_base;
> +		goto err_irq_alloc_descs;
> +	}
> +	if (irq_base != 16) {
> +		/*
> +		 * The entry code just passes the exception number (i.e. irq
> +		 * number + 16) to asm_do_IRQ, so the offset needs to be fixed
> +		 * here.
> +		 */
> +		pr_warn("Failed to allocate irq_descs at offset 16\n");
> +		goto err_wrong_irq_base;
> +	}
> +
> +	irq_domain = irq_domain_add_legacy(node, irqs, irq_base, 0,
> +					   &irq_domain_simple_ops, NULL);

Why do you use a legacy domain here, and hardcode the irq_base?
For a fully DT-enabled platform, the base should not matter and you
can use irq_domain_add_linear, while a legacy platform would likely
need a different base.

> +static int __init nvic_of_init(struct device_node *node,
> +			       struct device_node *parent)
> +{
> +	void __iomem *nvic_base;
> +
> +	if (!node)
> +		return -ENODEV;

As Thomas commented, the check for !node is pointless here.

	Arnd
