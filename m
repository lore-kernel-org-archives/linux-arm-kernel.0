From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Oct 2012 20:45:37 +0200
Subject: [PATCH 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <1350925368-24243-6-git-send-email-gregory.clement@free-electrons.com>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
 <1350925368-24243-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121022184537.GN21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory

> +void __init set_secondary_cpus_clock(void)
> +{
> +	int cpu;
> +	unsigned long rate;
> +	struct clk *cpu_clk = NULL;
> +	struct device_node *np = NULL;
> +
> +	cpu = smp_processor_id();
> +	np = of_find_node_by_type(np, "cpu");
> +	np = NULL;
> +	while ((np = of_find_node_by_type(np, "cpu"))) {
> +		const u32 *reg;
> +		int len;
> +		reg = of_get_property(np, "reg", &len);
> +		if (!reg || len != 4) {
> +			pr_err("%s missing reg property\n", np->full_name);
> +			continue;
> +		}
> +		if (be32_to_cpup(reg) == cpu) {
> +			cpu_clk = of_clk_get(np, 0);
> +			break;
> +		}
> +	}
> +	WARN_ON(IS_ERR(cpu_clk));
> +	rate = clk_get_rate(cpu_clk);
> +
> +	/* set all the other CPU clk to the same rate than the boot CPU */
> +	np = NULL;
> +	while ((np = of_find_node_by_type(np, "cpu"))) {
> +		const u32 *reg;
> +		int len;
> +		reg = of_get_property(np, "reg", &len);
> +		if (!reg || len != 4) {
> +			pr_err("%s missing reg property\n", np->full_name);
> +			continue;
> +		}
> +		if (be32_to_cpup(reg) != cpu) {
> +			cpu_clk = of_clk_get(np, 0);
> +			clk_set_rate(cpu_clk, rate);
> +		}

Maybe its hiding somewhere, but where is the clk_prepare_enable() for
this cpu_clk clock?

     Andrew
