From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 8 Oct 2015 18:52:11 +0800
Subject: [PATCH 1/5] clk: berlin: add common pll driver
In-Reply-To: <20151001223220.GQ19319@codeaurora.org>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
 <1442931156-5877-2-git-send-email-jszhang@marvell.com>
 <20151001223220.GQ19319@codeaurora.org>
Message-ID: <20151008185211.65089e99@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, 1 Oct 2015 15:32:20 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 09/22, Jisheng Zhang wrote:
> > diff --git a/drivers/clk/berlin/pll.c b/drivers/clk/berlin/pll.c
> > new file mode 100644
> > index 0000000..9aad0b6
> > --- /dev/null
> > +++ b/drivers/clk/berlin/pll.c
> > @@ -0,0 +1,119 @@
> > +
> > +#define to_berlin_pll(hw)       container_of(hw, struct berlin_pll, hw)
> > +
> > +static u8 vcodiv_berlin[] = {1, 2, 4, 8, 16, 32, 64, 128};
> 
> This is an array of 1 << index position...

oops, yes! I didn't realize this before! Accept all the comments below, will
update in v2.

Thanks a lot for review,
Jisheng

> 
> > +
> > +static unsigned long berlin_pll_recalc_rate(struct clk_hw *hw,
> > +					    unsigned long parent_rate)
> > +{
> > +	u32 val, fbdiv, rfdiv, vcodivsel, bypass;
> > +	struct berlin_pll *pll = to_berlin_pll(hw);
> > +
> > +	bypass = readl_relaxed(pll->bypass);
> > +	if (bypass & (1 << pll->bypass_shift))
> > +		return parent_rate;
> > +
> > +	val = readl_relaxed(pll->ctrl + PLL_CTRL0);
> > +	fbdiv = (val >> 12) & 0x1FF;
> > +	rfdiv = (val >> 3) & 0x1FF;
> > +	val = readl_relaxed(pll->ctrl + PLL_CTRL1);
> > +	vcodivsel = (val >> 9) & 0x7;
> > +	return parent_rate * fbdiv * 4 / rfdiv /
> > +		vcodiv_berlin[vcodivsel];
> 
> so we can replace this with 1 << vcodivsel?
> 
> > +}
> > +
> > +static u8 berlin_pll_get_parent(struct clk_hw *hw)
> > +{
> > +	struct berlin_pll *pll = to_berlin_pll(hw);
> > +	u32 bypass = readl_relaxed(pll->bypass);
> > +
> > +	if (bypass & (1 << pll->bypass_shift))
> > +		return 1;
> > +	else
> > +		return 0;
> 
> Simplify this to 
> 
> 	if (bypass & (1 << pll->bypass_shift))
> 		return 1;
> 	return 0;
> 
> or
> 
> 	return !!(bypass & (1 << pll->bypass_shift)) 
> 
> > +}
> > +
> > +static const struct clk_ops berlin_pll_ops = {
> > +	.recalc_rate	= berlin_pll_recalc_rate,
> > +	.get_parent	= berlin_pll_get_parent,
> > +};
> > +
> > +void __init berlin_pll_setup(struct device_node *np)
> 
> static?
> 
> > +{
> > +	struct clk_init_data init;
> > +	struct berlin_pll *pll;
> > +	const char *parent_names[PLL_SOURCE_MAX];
> > +	struct clk *clk;
> > +	int ret, num_parents;
> > +
> > +	num_parents = of_clk_get_parent_count(np);
> > +	if (num_parents <= 0 || num_parents > PLL_SOURCE_MAX)
> > +		return;
> > +
> > +	of_clk_parent_fill(np, parent_names, num_parents);
> > +
> > +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> > +	if (WARN_ON(!pll))
> 
> We already print a big warning on allocation failures, so drop
> the WARN_ON please.
> 
> > +		return;
> > +
> > +	pll->ctrl = of_iomap(np, 0);
> > +	pll->bypass = of_iomap(np, 1);
> > +	ret = of_property_read_u8(np, "bypass-shift", &pll->bypass_shift);
> > +	if (WARN_ON(!pll->ctrl || !pll->bypass || ret))
> > +		return;
> > +
> > +	init.name = np->name;
> > +	init.ops = &berlin_pll_ops;
> > +	init.parent_names = parent_names;
> > +	init.num_parents = num_parents;
> 
> init.flags is not initialized. Please initialize the init struct
> on the stack to 0 to avoid future problems.
> 
> > +
> > +	pll->hw.init = &init;
> > +
> > +	clk = clk_register(NULL, &pll->hw);
> > +	if (WARN_ON(IS_ERR(clk)))
> > +		return;
> > +
> > +	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> > +	if (WARN_ON(ret))
> > +		return;
> 
> This return is useless.
> 
> > +}
> 
