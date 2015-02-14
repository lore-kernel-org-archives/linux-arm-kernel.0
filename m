From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 14 Feb 2015 18:02:11 +0100
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
Message-ID: <54DF7F93.3040009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2015 16:27, Russell King wrote:
> The PMU device contains an interrupt controller, power control and
> resets.  The interrupt controller is a little sub-standard in that
> there is no race free way to clear down pending interrupts, so we try
> to avoid problems by reducing the window as much as possible, and
> clearing as infrequently as possible.
>
> The interrupt support is implemented using an IRQ domain, and the
> parent interrupt referenced in the standard DT way.
>
> The power domains and reset support is closely related - there is a
> defined sequence for powering down a domain which is tightly coupled
> with asserting the reset.  Hence, it makes sense to group these two
> together.
>
> This patch adds the core PMU driver: power domains must be defined in
> the DT file in order to make use of them.  The reset controller can
> be referenced in the standard way for reset controllers.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
[...]
> diff --git a/arch/arm/mach-dove/pmu.c b/arch/arm/mach-dove/pmu.c
> new file mode 100644
> index 000000000000..2d1325995a68
> --- /dev/null
> +++ b/arch/arm/mach-dove/pmu.c
> @@ -0,0 +1,410 @@
> +/*
> + * Marvell Dove PMU support
> + */
[...]
> +/*
> + * pmu {
> + *	compatible = "marvell,pmu";

Russell,

Should we be more precise and call it "marvell,dove-pmu" ?

Also, can we have an additional "syscon" compatible for that node?

That will allow us to get rid of the messy iomem stuff current
pinctrl-dove is doing to get access to the pmu pinctrl registers.

> + *	reg = <0xd0000 0x8000> <0xd8000 0x8000>;
> + *	interrupts = <33>;
> + *	#reset-cells = 1;
> + *	#power-domain-cells = <0>;
> + *	vpu_domain: vpu-domain {
> + *		marvell,pmu_pwr_mask = <0x00000008>;
> + *		marvell,pmu_iso_mask = <0x00000001>;
> + *		resets = <&pmu 16>;
> + *	};
> + *	gpu_domain: gpu-domain {
> + *		marvell,pmu_pwr_mask = <0x00000004>;
> + *		marvell,pmu_iso_mask = <0x00000002>;
> + *		resets = <&pmu 18>;
> + *	};
> + * };
> + */
> +int __init dove_init_pmu(void)
> +{

How about we copy the clk subsystem way of installing early probed
pm for DT here?

For example:

#define PM_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)

and

static int __init dove_pmu_init(struct device_node *np) { ... }
PM_OF_DECLARE(dove_pmu, "marvell,dove-pmu", dove_init_pmu);

Sebastian

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
> +	pmu_reset_init(pmu);
> +
> +	for_each_available_child_of_node(pmu->of_node, np) {
> +		struct of_phandle_args args;
> +		struct pmu_domain *domain;
> +
> +		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +		if (!domain)
> +			break;
> +
> +		domain->pmu = pmu;
> +		domain->base.name = kstrdup(np->name, GFP_KERNEL);
> +		if (!domain->base.name) {
> +			kfree(domain);
> +			break;
> +		}
> +
> +		of_property_read_u32(np, "marvell,pmu_pwr_mask",
> +				     &domain->pwr_mask);
> +		of_property_read_u32(np, "marvell,pmu_iso_mask",
> +				     &domain->iso_mask);
> +
> +		ret = of_parse_phandle_with_args(np, "resets", "#reset-cells",
> +						 0, &args);
> +		if (ret == 0) {
> +			if (args.np == pmu->of_node)
> +				domain->rst_mask = BIT(args.args[0]);
> +			of_node_put(args.np);
> +		}
> +
> +		__pmu_domain_register(domain, np);
> +	}
> +	pm_genpd_poweroff_unused();
> +
> +	ret = dove_init_pmu_irq(pmu, parent_irq);
> +	if (ret)
> +		pr_err("dove_init_pmu_irq() failed: %d\n", ret);
> +
> +	return 0;
> +}
>
