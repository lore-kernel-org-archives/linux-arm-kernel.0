From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 2 May 2013 12:53:22 -0600
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130502185322.GA29333@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:25:04PM +0200, Sebastian Hesselbarth wrote:
> +
> +static void __iomem *orion_irq_base[ORION_MAX_IRQREG];
> +static unsigned int orion_irq_regs;
> +static struct irq_domain *orion_irq_domain;
> +
> +asmlinkage void __exception_irq_entry orion_handle_irq(struct
> pt_regs *regs)

This can be static?

> +static int __init orion_of_init(struct device_node *np,
> +				struct device_node *parent)
> +{
> +	int n;
> +
> +	for (n = 0; n < ORION_MAX_IRQREG; n++) {
> +		orion_irq_base[n] = of_iomap(np, n);

Is it possible to also reserve the resources for these registers at
this point in the boot sequence?

> +static struct of_device_id orion_irq_dt_ids[] __initconst = {
> +	{ .compatible = "marvell,orion-mpic", .data = orion_of_init },
> +	{ }

Is there a strong reason to change the compatible string? Looks to me
like either the new driver or the old driver will bind depending on
what is in the machine description. No need for a new string?

> +};
> +
> +void __init orion_init_irq(void)
> +{
> +	of_irq_init(orion_irq_dt_ids);
> +}

Shouldn't this use the new IRQCHIP_DECLARE mechanism?

> diff --git a/include/linux/irqchip/orion.h b/include/linux/irqchip/orion.h

> +extern void orion_init_irq(void);

.. which lets this go away, use the generic irqchip_init instead of
orion_init_irq.

Regards,
Jason
