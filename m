From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 16 May 2012 15:56:26 +0900
Subject: [PATCH 01/08] mach-shmobile: Emma Mobile EV2 SoC base support V3
In-Reply-To: <20120516064458.32286.37948.sendpatchset@w520>
References: <20120516064449.32286.77941.sendpatchset@w520>
 <20120516064458.32286.37948.sendpatchset@w520>
Message-ID: <20120516065625.GM7988@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 03:44:58PM +0900, Magnus Damm wrote:
> +static int emev2_gclk_enable(struct clk *clk)
> +{
> +	iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
> +		  clk->mapped_reg);
> +	return 0;
> +}
> +
> +static void emev2_gclk_disable(struct clk *clk)
> +{
> +	iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
> +		  clk->mapped_reg);
> +}
> +
> +static struct sh_clk_ops emev2_gclk_clk_ops = {
> +	.enable		= emev2_gclk_enable,
> +	.disable	= emev2_gclk_disable,
> +	.recalc		= followparent_recalc,
> +};
> +
> +static int __init emev2_gclk_register(struct clk *clks, int nr)
> +{
> +	struct clk *clkp;
> +	int ret = 0;
> +	int k;
> +
> +	for (k = 0; !ret && (k < nr); k++) {
> +		clkp = clks + k;
> +		clkp->ops = &emev2_gclk_clk_ops;
> +		ret |= clk_register(clkp);
> +	}
> +
> +	return ret;
> +}
> +
This all looks like a pointless abstraction. This is basically a verbatim
copy of the sh_clk_mstp32 routines.

I suppose this is a case where you want to use the mstp32 routines but
don't specifically have div4/div6 clocks to manage so you aren't setting
SH_CLK_CPG. Perhaps we should just move the sh_clk_mstp32 stuff out so
it's provided regardless of the CPG setting and rename it to drop the
mstp32 connotations. It's really only the div4/div6 stuff that has any
CPG-specific behaviour at this point anyways.
