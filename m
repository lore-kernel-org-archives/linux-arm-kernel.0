From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 14 Feb 2015 18:09:39 +0100
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
Message-ID: <20150214170939.GG3213@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

> +static struct reset_control_ops pmu_reset_ops = {
> +	.reset = pmu_reset_reset,
> +	.assert = pmu_reset_assert,
> +	.deassert = pmu_reset_deassert,
> +};
> +
> +static struct reset_controller_dev pmu_reset __initdata = {
> +	.ops = &pmu_reset_ops,
> +	.owner = THIS_MODULE,

Dumb question: Is this still needed? There have been a lot of patches
from Wolfram Sang removing similar THIS_MODULE statements.

> + * pmu {
> + *	compatible = "marvell,pmu";

Is this maybe too generic? I'm sure Marvell has more than one pmu.
Maybe "marvell,dove-pmu"

> +int __init dove_init_pmu(void)
> +{
> +	struct device_node *np_pmu, *np;
> +	struct pmu_data *pmu;
> +	int ret, parent_irq;
> +
> +	/* Lookup the PMU node */
> +	np_pmu = of_find_compatible_node(NULL, NULL, "marvell,pmu");
> +	if (!np_pmu)
> +		return 0;
> +
> +	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&pmu->lock);
> +	pmu->of_node = np_pmu;
> +	pmu->pmc_base = of_iomap(pmu->of_node, 0);
> +	pmu->pmu_base = of_iomap(pmu->of_node, 1);
> +	if (!pmu->pmc_base || !pmu->pmu_base) {
> +		pr_err("%s: failed to map PMU\n", np_pmu->name);
> +		iounmap(pmu->pmu_base);
> +		iounmap(pmu->pmc_base);
> +		kfree(pmu);
> +		return -ENOMEM;
> +	}
> +
> +	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
> +	if (!parent_irq)
> +		pr_err("%s: no interrupt specified\n", np_pmu->name);
> +

Is it not fatal to be missing the interrupt? Seems like return -EINVAL
would be a good idea?

      Andrew
