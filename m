From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 13:07:06 +0100
Subject: [PATCH 5/9] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <E1YW7t5-0003mI-Sk@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7t5-0003mI-Sk@rmk-PC.arm.linux.org.uk>
Message-ID: <89767639.F6rHWX5yIj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 18:31:15 Russell King wrote:
> +int __init dove_init_pmu(void)
> +{
> +       struct device_node *np_pmu, *np;
> +       struct pmu_data *pmu;
> +       int ret, parent_irq;
> +
> +       /* Lookup the PMU node */
> +       np_pmu = of_find_compatible_node(NULL, NULL, "marvell,dove-pmu");
> +       if (!np_pmu)
> +               return 0;

What is the reason that this is not a platform_driver? I think you
should try to make it one, or explain in the changelog the reason
for not making it one. This obviously ties in with the question I
asked about who calls dove_init_pmu().

> +               ret = of_parse_phandle_with_args(np, "resets", "#reset-cells",
> +                                                0, &args);
> +               if (ret == 0) {
> +                       if (args.np == pmu->of_node)
> +                               domain->rst_mask = BIT(args.args[0]);
> +                       of_node_put(args.np);
> +               }

In particular, manually parsing the "resets" property is something
we should try to avoid. With a platform driver, this could become
devm_reset_control_get(), otherwise I think of_reset_control_get()
would also do the right thing here.

	Arnd
