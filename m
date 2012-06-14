From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jun 2012 08:12:34 +0000
Subject: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for
 DT boards
In-Reply-To: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
Message-ID: <201206140812.34399.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 June 2012, Andrew Lunn wrote:
> +static int __init kirkwood_add_irq_domain(struct device_node *np,
> +                                         struct device_node *interrupt_parent)
> +{
> +       kirkwood_init_irq();
> +       irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
> +       return 0;
> +}
> +
> +static const struct of_device_id kirkwood_irq_match[] = {
> +       { .compatible = "marvell,orion-intc",
> +         .data = kirkwood_add_irq_domain, },
> +       {},
> +};
> +
> +static void __init kirkwood_dt_init_irq(void)
> +{
> +       of_irq_init(kirkwood_irq_match);
> +}
> +

I think if you compute the number of interrupts in the domain from the number of
registers that are described in the device tree, call orion_irq_init()
based on those registers, and use irq domains for the gpio stuff as Rob suggested,
this init_irq function can become completely generic to all orion platforms.

That is what I tried to do with an earlier patch, which was flawed for other reasons.

	Arnd
