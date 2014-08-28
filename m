From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Aug 2014 18:10:55 +0200
Subject: [PATCH v4 3/5] ARM: tegra: Initialize interrupt controller from DT
In-Reply-To: <1409239879-12376-3-git-send-email-thierry.reding@gmail.com>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <1409239879-12376-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <3056623.fB9uqpleQ5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 August 2014 17:31:17 Thierry Reding wrote:

>  void __init tegra_init_irq(void)
>  {
> -	int i;
> -	void __iomem *distbase;
> +	unsigned int max_ictlrs = ARRAY_SIZE(ictlr_regs), i;
> +	const struct of_device_id *match;
> +	struct device_node *np;
> +	struct resource res;
> +
> +	np = of_find_matching_node_and_match(NULL, ictlr_matches, &match);
> +	if (np) {
> +		const struct tegra_ictlr_soc *soc = match->data;
> +
> +		for (i = 0; i < soc->num_ictlrs; i++) {
> +			if (of_address_to_resource(np, i, &res) < 0)
> +				break;
> +
> +			ictlr_regs[i] = res;
> +		}
> +
> +		WARN(i != soc->num_ictlrs,
> +		     "Found %u interrupt controllers in DT; expected %u.\n",
> +		     i, soc->num_ictlrs);
> +
> +		max_ictlrs = soc->num_ictlrs;
> +		of_node_put(np);
> +	} else {
> +		/*
> +		 * If no matching device node was found, fall back to using
> +		 * the chip ID.
> +		 */
> +
> +		/* Tegra30 and later have five interrupt controllers, ... */
> +		max_ictlrs = ARRAY_SIZE(ictlr_regs);
> +
> +		/* ..., but Tegra20 only has four. */
> +		if (of_machine_is_compatible("nvidia,tegra20"))
> +			max_ictlrs--;
> +	}

How about moving the entire file to drivers/irqchip and using the
IRQCHIP_DECLARE() helper for the DT case?

For the fallback, you can have an entry into that file that just takes
the address and number, which you can call from platform code here.

	Arnd
