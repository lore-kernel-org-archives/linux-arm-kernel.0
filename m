From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 14:24:09 -0700
Subject: [PATCH v3 6/6] clk: mvebu: Add the peripheral clock driver for
 Armada 3700
In-Reply-To: <1468935742-11218-7-git-send-email-gregory.clement@free-electrons.com>
References: <1468935742-11218-1-git-send-email-gregory.clement@free-electrons.com>
 <1468935742-11218-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160815212409.GD361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19, Gregory CLEMENT wrote:
> +
> +static const struct clk_ops clk_double_div_ops = {
> +	.recalc_rate = clk_double_div_recalc_rate,
> +};
> +
> +static const struct of_device_id armada_3700_periph_clock_of_match[] = {
> +	{ .compatible = "marvell,armada-3700-periph-clock-nb",
> +	  .data = data_nb, },
> +	{ .compatible = "marvell,armada-3700-periph-clock-sb",
> +	.data = data_sb, },
> +	{ }
> +};
> +static int armada_3700_add_composite_clk(const struct clk_periph_data *data,

Put a newline between the function and array please.

> +					 void __iomem *reg, spinlock_t *lock,
> +					 struct device *dev, struct clk_hw *hw)
> +{
> +	const struct clk_ops *mux_ops = NULL, *gate_ops = NULL,
> +		*rate_ops = NULL;
> +	struct clk_hw *mux_hw = NULL, *gate_hw = NULL, *rate_hw = NULL;
> +
> +	if (data->mux_hw) {
> +		struct clk_mux *mux;
> +
> +		mux_hw = data->mux_hw;
> +		mux = to_clk_mux(mux_hw);
> +		mux->lock = lock;
> +		mux_ops = mux_hw->init->ops;
> +		mux->reg = reg + (u64)mux->reg;

This file spews a ton of sparse errors because of address space
assignment violations due to the reuse of the reg property as a
pointer to iomem and an offset. This style never makes me feel
great because the code may run multiple times if we have
something like probe defer happening and then we're modifying
what is essentially static data (the offset) many times.

Would it be hard to rework this to be more of a descriptor style
that allocates the clk_hw and wrapping structures on the heap
instead? That would avoid these types of problems from cropping
up in the future.

> +	}
> +
> +	if (data->gate_hw) {
> +		struct clk_gate *gate;
> +
> +		gate_hw = data->gate_hw;
> +		gate = to_clk_gate(gate_hw);
> +		gate->lock = lock;
> +		gate_ops = gate_hw->init->ops;
> +		gate->reg = reg + (u64)gate->reg;
> +	}
> +
> +	if (data->rate_hw) {
> +		rate_hw = data->rate_hw;
> +		rate_ops = rate_hw->init->ops;
> +		if (data->is_double_div) {
> +			struct clk_double_div *rate;
> +
> +			rate =  to_clk_double_div(rate_hw);
> +			rate->reg1 = reg + (u64)rate->reg1;
> +			rate->reg2 = reg + (u64)rate->reg2;
> +		} else {
> +			struct clk_divider *rate = to_clk_divider(rate_hw);
> +			const struct clk_div_table *clkt;
> +			int table_size = 0;
> +
> +			rate->reg = reg + (u64)rate->reg;
> +			for (clkt = rate->table; clkt->div; clkt++)
> +				table_size++;
> +			rate->width = order_base_2(table_size);
> +			rate->lock = lock;
> +		}
> +	}
> +
> +	hw = clk_hw_register_composite(dev, data->name, data->parent_names,
> +				       data->num_parents, mux_hw,
> +				       mux_ops, rate_hw, rate_ops,
> +				       gate_hw, gate_ops, CLK_IGNORE_UNUSED);
> +
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	return 0;

This can be return PTR_ERR_OR_ZERO();

> +}
> +
> +static int armada_3700_periph_clock_probe(struct platform_device *pdev)
> +{
> +	struct clk_periph_driver_data *driver_data;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct clk_periph_data *data;
> +	struct device *dev = &pdev->dev;
> +	int num_periph = 0, i, ret;
> +	struct resource *res;
> +	void __iomem *reg;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	while (data[num_periph].name)
> +		num_periph++;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg)) {
> +		dev_err(dev, "Could not map the periph clock registers\n");

devm_ioremap_resource() should already spit out an error.

> +		return PTR_ERR(reg);
> +	}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
