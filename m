From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 17:24:51 -0700
Subject: [PATCH 3/3 v6] clk: Add Gemini SoC clock controller
In-Reply-To: <20170618215550.29216-3-linus.walleij@linaro.org>
References: <20170618215550.29216-1-linus.walleij@linaro.org>
 <20170618215550.29216-3-linus.walleij@linaro.org>
Message-ID: <20170620002451.GV20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Linus Walleij wrote:
> The Cortina Systems Gemini (SL3516/CS3516) has an on-chip clock
> controller that derive all clocks from a single crystal, using some
> documented and some undocumented PLLs, half dividers, counters and
> gates. This is a best attempt to construct a clock driver for the
> clocks so at least we can gate off unused hardware and driver the
> PCI bus clock.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mike/Stephen: please merge this into the clk subsystem along
> with the <dt-bindings> patch once you're happy with it.

Looking good overall. Just the small things now.

> diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
> new file mode 100644
> index 000000000000..810c35008d6a
> --- /dev/null
> +++ b/drivers/clk/clk-gemini.c
> @@ -0,0 +1,455 @@
> +
> +static int gemini_clk_probe(struct platform_device *pdev)
> +{
> +	/* Gives the fracions 1x, 1.5x, 1.85x and 2x */
> +	unsigned int cpu_ahb_mult[4] = { 1, 3, 24, 2 };
> +	unsigned int cpu_ahb_div[4] = { 1, 2, 13, 1 };
> +	void __iomem *base;
> +	struct gemini_reset *gr;
> +	struct regmap *map;
> +	struct clk_hw *hw;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	unsigned int mult, div;
> +	u32 val;
> +	int ret;
> +	int i;
> +
> +	gr = devm_kzalloc(dev, sizeof(*gr), GFP_KERNEL);
> +	if (!gr)
> +		return -ENOMEM;
> +
> +	/* Remap the system controller for the exclusive register */
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		dev_err(dev, "no memory base\n");
> +		return -ENODEV;
> +	}

We can use normal platform device driver APIs now instead of
of_iomap()?

> +
> +	map = syscon_node_to_regmap(np);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "no syscon regmap\n");
> +		return PTR_ERR(map);
> +	}
> +
> +	gr->map = map;
> +	gr->rcdev.owner = THIS_MODULE;
[..]
> +
> +static void __init gemini_cc_init(struct device_node *np)
> +{
> +	struct regmap *map;
> +	struct clk_hw *hw;
> +	unsigned long freq;
> +	unsigned int mult, div;
> +	u32 val;
> +	int ret;
> +	int i;
> +
> +	gemini_clk_data = kzalloc(sizeof(*gemini_clk_data) +
> +			sizeof(*gemini_clk_data->hws) * GEMINI_NUM_CLKS,
> +			GFP_KERNEL);
> +	if (!gemini_clk_data) {
> +		pr_err("out of memory for clocks\n");

We don't need out of memory error messages.

> +		return;
> +	}
> +	/*
> +	 * This way all clock fetched before the platform device probes,
> +	 * except those we assign here for early use, will be deferred.
> +	 */
> +	for (i = 0; i < GEMINI_NUM_CLKS; i++)
> +		gemini_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +	map = syscon_node_to_regmap(np);
> +	if (IS_ERR(map)) {
> +		pr_err("no syscon regmap\n");
> +		return;
> +	}
> +	/*
> +	 * We check that the regmap works on this very first access,
> +	 * but as this is an MMIO-backed regmap, subsequent regmap
> +	 * access is not going to fail and we skip error checks from
> +	 * this point.
> +	 */
> +	ret = regmap_read(map, GEMINI_GLOBAL_STATUS, &val);
> +	if (ret) {
> +		pr_err("failed to read global status register\n");
> +		return;
> +	}
> +
> +	/*
> +	 * XTAL is the crystal oscillator, 60 or 30 MHz selected from
> +	 * strap pin E6
> +	 */
> +	if (val & PLL_OSC_SEL)
> +		freq = 30000000;
> +	else
> +		freq = 60000000;
> +	hw = clk_hw_register_fixed_rate(NULL, "xtal", NULL, 0, freq);
> +	pr_info("main crystal @%lu MHz\n", (freq / 1000000));

Debug printk? Also drop the parenthesis around that division
please.

> +
> +	/* VCO clock derived from the crystal */
> +	mult = 13 + ((val >> AHBSPEED_SHIFT) & AHBSPEED_MASK);
> +	div = 2;
> +	/* If we run on 30 MHz crystal we have to multiply with two */
> +	if (val & PLL_OSC_SEL)
> +		mult *= 2;
> +	hw = clk_hw_register_fixed_factor(NULL, "vco", "xtal", 0, mult, div);
> +
> +	/* The AHB clock is always 1/3 of the VCO */
> +	hw = clk_hw_register_fixed_factor(NULL, "ahb", "vco", 0, 1, 3);
> +	gemini_clk_data->hws[GEMINI_CLK_AHB] = hw;
> +
> +	/* The APB clock is always 1/6 of the AHB */
> +	hw = clk_hw_register_fixed_factor(NULL, "apb", "ahb", 0, 1, 6);
> +	gemini_clk_data->hws[GEMINI_CLK_APB] = hw;
> +
> +	/* Register the clocks to be accessed by the device tree */
> +	gemini_clk_data->num = GEMINI_NUM_CLKS;
> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, gemini_clk_data);
> +}
> +CLK_OF_DECLARE_DRIVER(gemini_cc, "cortina,gemini-syscon", gemini_cc_init);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
