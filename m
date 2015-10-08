From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Oct 2015 17:55:32 -0700
Subject: [PATCH v5] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <1444181140-3570-1-git-send-email-eric@anholt.net>
References: <1444181140-3570-1-git-send-email-eric@anholt.net>
Message-ID: <20151008005532.GB26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06, Eric Anholt wrote:
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index dd295e4..b4d4421 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -17,10 +17,273 @@
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
>  #include <linux/clk/bcm2835.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/bcm2835.h>

Please include slab.h for the kzalloc usage

> +
> +
> +static struct clk *bcm2835_register_pll(struct bcm2835_cprman *cprman,
> +					const struct bcm2835_pll_data *data)
> +{
> +	struct bcm2835_pll *pll;
> +	struct clk_init_data init;
> +
> +	memset(&init, 0, sizeof(init));
> +
> +	/* All of the PLLs derive from the external oscillator. */
> +	init.parent_names = &cprman->osc_name;
> +	init.num_parents = 1;
> +	init.name = data->name;
> +	init.ops = &bcm2835_pll_clk_ops;
> +	init.flags = CLK_IGNORE_UNUSED;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return NULL;
> +
> +	pll->cprman = cprman;
> +	pll->data = data;
> +	pll->hw.init = &init;
> +
> +	return clk_register(cprman->dev, &pll->hw);

devm_clk_register?

> +}
> +
> +static struct clk *
> +bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
> +			     const struct bcm2835_pll_divider_data *data)
> +{
> +	struct bcm2835_pll_divider *divider;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	const char *divider_name;
> +
> +	if (data->fixed_divider != 1) {
> +		divider_name = devm_kasprintf(cprman->dev, GFP_KERNEL,
> +					      "%s_prediv", data->name);
> +		if (!divider_name)
> +			return NULL;
> +	} else {
> +		divider_name = data->name;
> +	}
> +
> +	memset(&init, 0, sizeof(init));
> +
> +	init.parent_names = &data->source_pll->name;
> +	init.num_parents = 1;
> +	init.name = divider_name;
> +	init.ops = &bcm2835_pll_divider_clk_ops;
> +	init.flags = (CLK_SET_RATE_PARENT |
> +		      CLK_IGNORE_UNUSED);

Drop () and put on one line.

> +
> +	divider = kzalloc(sizeof(*divider), GFP_KERNEL);

Use devm_kzalloc() to auto free on errors?

> +	if (!divider)
> +		return NULL;
> +
> +	divider->div.reg = cprman->regs + data->a2w_reg;
> +	divider->div.shift = A2W_PLL_DIV_SHIFT;
> +	divider->div.width = A2W_PLL_DIV_BITS;
> +	divider->div.flags = 0;
> +	divider->div.lock = &cprman->regs_lock;
> +	divider->div.hw.init = &init;
> +	divider->div.table = NULL;
> +
> +	divider->cprman = cprman;
> +	divider->data = data;
> +
> +	clk = clk_register(cprman->dev, &divider->div.hw);

devm_clk_register?

> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	/*
> +	 * PLLH's channels have a fixed divide by 10 afterwards, which
> +	 * is what our consumers are actually using.
> +	 */
> +	if (data->fixed_divider != 1) {
> +		return clk_register_fixed_factor(cprman->dev, data->name,
> +						 divider_name,
> +						 CLK_SET_RATE_PARENT,
> +						 1,
> +						 data->fixed_divider);
> +	}
> +
> +	return clk;
> +}
> +
> +static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
> +					  const struct bcm2835_clock_data *data)
> +{
[..]
> +
> +	memset(&init, 0, sizeof(init));
> +	init.parent_names = &parent;
> +	init.num_parents = 1;
> +	init.name = data->name;
> +	init.flags = CLK_IGNORE_UNUSED;
> +
> +	if (data->is_vpu_clock) {
> +		init.ops = &bcm2835_vpu_clock_clk_ops;
> +	} else {
> +		init.ops = &bcm2835_clock_clk_ops;
> +		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
> +	}
> +
> +	clock = kzalloc(sizeof(*clock), GFP_KERNEL);

devm_kzalloc()?

> +	if (!clock)
> +		return NULL;
> +
> +	clock->cprman = cprman;
> +	clock->data = data;
> +	clock->hw.init = &init;
> +
> +	return clk_register(cprman->dev, &clock->hw);

devm_clk_register()?

> +}
> +
> +static int bcm2835_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk **clks;
> +	struct bcm2835_cprman *cprman;
> +
> +	cprman = devm_kzalloc(dev, sizeof(*cprman), GFP_KERNEL);
> +	if (!cprman)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&cprman->regs_lock);
> +	cprman->dev = &pdev->dev;

Just use dev?

> +	cprman->regs = of_iomap(dev->of_node, 0);

Please use platform driver APIs:

	platform_get_resource()
	devm_ioremap_resource()

> +	if (!cprman->regs)
> +		return -ENODEV;
> +
> +	cprman->osc_name = of_clk_get_parent_name(dev->of_node, 0);
> +	if (!cprman->osc_name) {
> +		iounmap(cprman->regs);
> +		return -ENODEV;
> +	}
[...]
> +
> +	/*
> +	 * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
> +	 * you have the debug bit set in the power manager, which we
> +	 * don't bother exposing) are individual gates off of the
> +	 * non-stop vpu clock.
> +	 */
> +	clks[BCM2835_CLOCK_PERI_IMAGE] =
> +		clk_register_gate(dev, "peri_image", "vpu",
> +				  CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
> +				  cprman->regs + CM_PERIICTL, CM_GATE_BIT,
> +				  0, &cprman->regs_lock);
> +
> +	return of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,

Just use dev?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
