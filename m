From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Oct 2012 11:30:29 +0200
Subject: [PATCH 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <50865F59.8000507@free-electrons.com>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
 <1350925368-24243-6-git-send-email-gregory.clement@free-electrons.com>
 <20121022184537.GN21046@lunn.ch>
 <50865F59.8000507@free-electrons.com>
Message-ID: <20121023093029.GY11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 11:11:53AM +0200, Gregory CLEMENT wrote:
> On 10/22/2012 08:45 PM, Andrew Lunn wrote:
> > Hi Gregory
> > 
> >> +void __init set_secondary_cpus_clock(void)
> >> +{
> >> +	int cpu;
> >> +	unsigned long rate;
> >> +	struct clk *cpu_clk = NULL;
> >> +	struct device_node *np = NULL;
> >> +
> >> +	cpu = smp_processor_id();
> >> +	np = of_find_node_by_type(np, "cpu");
> >> +	np = NULL;
> >> +	while ((np = of_find_node_by_type(np, "cpu"))) {
> >> +		const u32 *reg;
> >> +		int len;
> >> +		reg = of_get_property(np, "reg", &len);
> >> +		if (!reg || len != 4) {
> >> +			pr_err("%s missing reg property\n", np->full_name);
> >> +			continue;
> >> +		}
> >> +		if (be32_to_cpup(reg) == cpu) {
> >> +			cpu_clk = of_clk_get(np, 0);
> >> +			break;
> >> +		}
> >> +	}
> >> +	WARN_ON(IS_ERR(cpu_clk));
> >> +	rate = clk_get_rate(cpu_clk);
> >> +
> >> +	/* set all the other CPU clk to the same rate than the boot CPU */
> >> +	np = NULL;
> >> +	while ((np = of_find_node_by_type(np, "cpu"))) {
> >> +		const u32 *reg;
> >> +		int len;
> >> +		reg = of_get_property(np, "reg", &len);
> >> +		if (!reg || len != 4) {
> >> +			pr_err("%s missing reg property\n", np->full_name);
> >> +			continue;
> >> +		}
> >> +		if (be32_to_cpup(reg) != cpu) {
> >> +			cpu_clk = of_clk_get(np, 0);
> >> +			clk_set_rate(cpu_clk, rate);
> >> +		}
> > 
> > Maybe its hiding somewhere, but where is the clk_prepare_enable() for
> > this cpu_clk clock?
> > 
> 
> Well the clocks are always enable. In the clock framework, the cpu clocks
> don't provide an enable function.

Is it possible in the hardware to disable them? Turning them off might
save some power. If these chips end up in some data center server, it
might be that CPU hotplugging is used.

> But maybe it is cleaner to call clk_prepare_enable() even if it does
> nothing except update the usage count.

You also have to watch out for the late_initcall which will disable
all clocks which are running but nobody has claimed. This will become
an issue if you do have enable/disable function in later versions of
the clock functions.

	Andrew
