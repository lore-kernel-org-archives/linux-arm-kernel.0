From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 18 Jun 2015 17:25:34 +0200
Subject: [PATCH] clk: at91: add generated clock driver
In-Reply-To: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>
References: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150618172534.57b09c0b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

I haven't run checkpatch on your patch, but there seems to be a few
things to fix ;-).

On Wed, 17 Jun 2015 15:23:29 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:




> +
> +static long clk_generated_determine_rate(struct clk_hw *hw,
> +					 unsigned long rate,
> +					 unsigned long *best_parent_rate,
> +					 struct clk_hw **best_parent_hw)

The ->determine_rate() prototype has changed (see [1]).


> +/* No modification of hardware as we have the flag CLK_SET_RATE_GATE set */
> +static int clk_generated_set_rate(struct clk_hw *hw,
> +				    unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct clk_generated *gck = to_clk_generated(hw);
> +	u32 div;
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	if (gck->id < PERIPHERAL_ID_MIN || !gck->range.max) {
> +		if (parent_rate == rate) {
> +			gck->gckdiv = 0;
> +			return 0;
> +		} else {
> +			return -EINVAL;
> +		}
> +	}

Do you really need the above check ?
AFAICT, periph ids inferior to 2 are invalid ids, so they should be
detected at probe time.
The !gck->range.max will be caught by the rate > gck->range.max test.
And finally, the case parent_rate == rate will just give you a div of 1,
which in turns give a gckdiv of 0.

> +
> +	if (rate > gck->range.max)
> +		return -EINVAL;
> +
> +	div = DIV_ROUND_CLOSEST(parent_rate, rate);
> +	if (div > GENERATED_MAX_DIV + 1 || !div)
> +		return -EINVAL;
> +
> +	gck->gckdiv = div - 1;
> +	return 0;
> +}
> +
> +static const struct clk_ops generated_ops = {
> +	.enable = clk_generated_enable,
> +	.disable = clk_generated_disable,
> +	.is_enabled = clk_generated_is_enabled,
> +	.recalc_rate = clk_generated_recalc_rate,
> +	.determine_rate = clk_generated_determine_rate,
> +	.get_parent = clk_generated_get_parent,
> +	.set_parent = clk_generated_set_parent,
> +	.set_rate = clk_generated_set_rate,
> +};
> +
> +/**
> + * clk_generated_startup - Initialize a given clock to its default parent and
> + * divisor parameter.
> + *
> + * @gck:	Generated clock to set the startup parameters for.
> + *
> + * Take parameters from the hardware and update local clock configuration
> + * accordingly.
> + */
> +static void clk_generated_startup(struct clk_generated *gck)
> +{
> +	struct at91_pmc *pmc = gck->pmc;
> +	u32 tmp;
> +
> +	pmc_lock(pmc);
> +	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
> +	tmp = pmc_read(pmc, AT91_PMC_PCR);
> +	pmc_unlock(pmc);
> +
> +	gck->parent_id = (tmp & AT91_PMC_PCR_GCKCSS_MASK) >> AT91_PMC_PCR_GCKCSS_OFFSET;
> +	gck->gckdiv = (tmp & AT91_PMC_PCR_GCKDIV_MASK) >> AT91_PMC_PCR_GCKDIV_OFFSET;
> +}
> +
> +static struct clk * __init
> +at91_clk_register_generated(struct at91_pmc *pmc, const char *name,
> +			    const char **parent_names, u8 num_parents,
> +			    u8 id, const struct clk_range *range)
> +{
> +	struct clk_generated *gck;
> +	struct clk *clk = NULL;
> +	struct clk_init_data init;
> +
> +	gck = kzalloc(sizeof(*gck), GFP_KERNEL);
> +	if (!gck)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &generated_ops;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
> +
> +	gck->id = id;
> +	gck->hw.init = &init;
> +	gck->pmc = pmc;
> +	gck->range = *range;
> +
> +	clk = clk_register(NULL, &gck->hw);
> +	if (IS_ERR(clk))
> +		kfree(gck);
> +	else
> +		clk_generated_startup(gck);
> +
> +	return clk;
> +}
> +
> +void __init of_sama5d2_clk_generated_setup(struct device_node *np,
> +					   struct at91_pmc *pmc)
> +{
> +	int i;
> +	int num;
> +	u32 id;
> +	const char *name;
> +	struct clk *clk;
> +	int num_parents;
> +	const char *parent_names[GENERATED_SOURCE_MAX];
> +	struct device_node *gcknp;
> +	struct clk_range range = CLK_RANGE(0, 0);
> +
> +	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");

Use the of_clk_get_parent_count() [2].

That's all I got for now.

Thanks,

Boris


[1]http://lxr.free-electrons.com/source/include/linux/clk-provider.h#L178
[2]http://lxr.free-electrons.com/source/include/linux/clk-provider.h#L626

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
