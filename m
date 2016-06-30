From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 13:00:07 -0700
Subject: [PATCH 10/10] clk: mvebu: Add the peripheral clock driver for
 Armada 3700
In-Reply-To: <1465565018-14172-11-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
 <1465565018-14172-11-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160630200007.GB1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10, Gregory CLEMENT wrote:
> These clocks are the ones which will be used as source for the
> peripherals of the Armada 3700 SoC. On this SoC there is two blocks of
> clocks: the North bridge one and the South bridge one.
> 
> Most of them are gatable. Most of the time their rate are their parent
> rated divided by a ratio depending of two registers. Their parent can be
> choose between the TBG clocks for most of them.
> 
> However, some of them can't choose their parent or directly depend of the
> xtal clocks. Other ones do not use exactly the same pattern to find the
> ratio between their parent rate and their rate.
> 
> For theses reason each clock is a composite clock and the operations they

s/theses/these/

> use are different depending of the clock.
> 
> According to the dataheet it would be possible to select the parent clock

s/dataheet/datasheet/

> and the ratio, however currently the driver does not support it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> new file mode 100644
> index 000000000000..cd5150035426
> --- /dev/null
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -0,0 +1,462 @@
> +/*
> + * Marvell Armada 37xx SoC Peripheral clocks
> + *
> + * Copyright (C) 2016 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * Most of the peripheral clocks can be modelled like this:
> + *             _____    _______    _______
> + * TBG-A-P  --|     |  |       |  |       |   ______
> + * TBG-B-P  --| Mux |--| /div1 |--| /div2 |--| Gate |--> perip_clk
> + * TBG-A-S  --|     |  |       |  |       |  |______|
> + * TBG-B-S  --|_____|  |_______|  |_______|
> + *
> + * However some clocks may use only one or two block or and use the
> + * xtal clock as parent.
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/log2.h>

Is this include used?

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>

Is this include used?

> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define PARENT_NUM	5
> +
> +#define TBG_SEL		0x0
> +#define DIV_SEL0	0x4
> +#define DIV_SEL1	0x8
> +#define DIV_SEL2	0xC
> +#define CLK_SEL		0x10
> +#define CLK_DIS		0x14
> +
> +
> +#define UNUSED	0xFFFF
> +#define XTAL_CHILD	0x1 /* Xtal is the only parent of the clock */
> +#define TBGA_S_CHILD	0x2 /* TBG A S is the only parent of the clock */
> +#define GBE_CORE_CHILD	0x3 /* GBE core is the only parent of the clock */
> +#define GBE_50_CHILD	0x4 /* GBE 50 is the only parent of the clock */
> +#define GBE_125_CHILD	0x5 /* GBE 125 is the only parent of the clock */
> +
> +struct clk_double_div {
> +	struct clk_hw hw;
> +	void __iomem *reg1;
> +	int shift1;
> +	void __iomem *reg2;
> +	int shift2;
> +};
> +
> +#define to_clk_double_div(_hw) container_of(_hw, struct clk_double_div, hw)
> +
> +struct clk_periph_data {
> +	char *name;
> +	int gate_shift;
> +	int mux_shift;
> +	u32 div_reg1;
> +	int div_shift1;
> +	u32 div_reg2;
> +	int div_shift2;
> +	struct clk_div_table *table;
> +	int flags;
> +};
> +
> +static struct clk_div_table clk_table6[] = {

const?

> +	{ .val = 1, .div = 1, },
> +	{ .val = 2, .div = 2, },
> +	{ .val = 3, .div = 3, },
> +	{ .val = 4, .div = 4, },
> +	{ .val = 5, .div = 5, },
> +	{ .val = 6, .div = 6, },
> +	{ .val = 0, .div = 0, }, /* laste entry */
> +};
> +
> +static struct clk_div_table clk_table1[] = {

const?

> +	{ .val = 0, .div = 1, },
> +	{ .val = 1, .div = 2, },
> +	{ .val = 0, .div = 0, }, /* laste entry */
> +};
> +
> +static struct clk_div_table clk_table2[] = {

const?

> +	{ .val = 0, .div = 2, },
> +	{ .val = 1, .div = 4, },
> +	{ .val = 0, .div = 0, }, /* laste entry */

s/laste/last/ 3 times

> +};
> +
> +struct clk_periph_data data_nb[] = {

const?

> +
> +struct clk_periph_data data_sb[] = {

const?

> +
> +const char *gbe_name[] = {

const char * const?

> +	"gbe-50", "gbe-core", "gbe-125",
> +};
> +
> +struct clk_periph_driver_data {
> +	struct clk_onecell_data clk_data;
> +	spinlock_t lock;
> +};
> +
> +static int get_div(void __iomem *reg, int shift)

Should this return unsigned instead?

> +{
> +	u32 val;
> +
> +	val = (readl(reg) >> shift) & 0x7;
> +	if (val > 6)
> +		return 0;
> +	return (unsigned int)val;

What is this cast for?

> +}
> +
> +static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_double_div *double_div = to_clk_double_div(hw);
> +	unsigned int div;
> +
> +	div = get_div(double_div->reg1, double_div->shift1);
> +	div *= get_div(double_div->reg2, double_div->shift2);
> +
> +	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +}
> +
> +const struct clk_ops clk_double_div_ops = {

static?

> +	.recalc_rate = clk_double_div_recalc_rate,
> +};
> +
> +static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
> +					 const char * const *parent_name,
> +					 void __iomem *reg, spinlock_t *lock,
> +					 struct device *dev, struct clk *clk)
> +{
> +	const struct clk_ops *mux_ops = NULL, *gate_ops = NULL,
> +		*div_ops = NULL;
> +	struct clk_hw *mux_hw = NULL, *gate_hw = NULL, *div_hw = NULL;
> +	const char * const *names;
> +	struct clk_mux *mux = NULL;
> +	struct clk_gate *gate = NULL;
> +	struct clk_divider *div = NULL;
> +	struct clk_double_div *double_div = NULL;
> +	int num_parent;
> +	int ret = 0;
> +
> +	if (data->gate_shift != UNUSED) {
> +		gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
> +
> +		if (!gate)
> +			return -ENOMEM;
> +
> +		gate->reg = reg + CLK_DIS;
> +		gate->bit_idx = data->gate_shift;
> +		gate->lock = lock;
> +		gate_ops = &clk_gate_ops;
> +		gate_hw = &gate->hw;
> +	}
> +
> +	if (data->mux_shift != UNUSED) {
> +		mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +
> +		if (!mux) {
> +			ret = -ENOMEM;
> +			goto free_gate;
> +		}
> +
> +		mux->reg = reg + TBG_SEL;
> +		mux->shift = data->mux_shift;
> +		mux->mask = 0x3;
> +		mux->lock = lock;
> +		mux_ops = &clk_mux_ro_ops;
> +		mux_hw = &mux->hw;
> +	}
> +
> +	if (data->div_reg1 != UNUSED) {
> +		if (data->div_reg2 == UNUSED) {
> +			const struct clk_div_table *clkt;
> +			int table_size = 0;
> +
> +			div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +			if (!div) {
> +				ret = -ENOMEM;
> +				goto free_mux;
> +			}
> +
> +			div->reg = reg + data->div_reg1;
> +			div->table = data->table;
> +			for (clkt = div->table; clkt->div; clkt++)
> +				table_size++;
> +			div->width = order_base_2(table_size);
> +			div->lock = lock;
> +			div_ops = &clk_divider_ro_ops;
> +			div_hw = &div->hw;
> +		} else {
> +			double_div = devm_kzalloc(dev, sizeof(*double_div),
> +						  GFP_KERNEL);
> +			if (!double_div) {
> +				ret = -ENOMEM;
> +				goto free_mux;
> +			}
> +
> +			double_div->reg1 = reg + data->div_reg1;
> +			double_div->shift1 = data->div_shift1;
> +			double_div->reg2 = reg + data->div_reg1;
> +			double_div->shift2 = data->div_shift2;
> +			div_ops = &clk_double_div_ops;
> +			div_hw = &double_div->hw;
> +		}
> +	}
> +
> +	switch (data->flags) {
> +	case XTAL_CHILD:
> +		/* the xtal clock is the 5th clock */
> +		names = &parent_name[4];
> +		num_parent = 1;
> +		break;
> +	case TBGA_S_CHILD:
> +		/* the TBG A S clock is the 3rd clock */
> +		names = &parent_name[2];
> +		num_parent = 1;
> +		break;
> +	case GBE_CORE_CHILD:
> +		names = &gbe_name[1];
> +		num_parent = 1;
> +		break;
> +	case  GBE_50_CHILD:
> +		names = &gbe_name[0];
> +		num_parent = 1;
> +		break;
> +	case  GBE_125_CHILD:
> +		names = &gbe_name[2];
> +		num_parent = 1;
> +		break;
> +	default:
> +		names = parent_name;
> +		num_parent = 4;
> +	}
> +	clk = clk_register_composite(NULL, data->name,

Please pass a dev here, it may be useful one day.

> +				     names, num_parent,
> +				     mux_hw, mux_ops,
> +				     div_hw, div_ops,
> +				     gate_hw, gate_ops,
> +				     CLK_IGNORE_UNUSED);
> +	if (IS_ERR(clk)) {
> +		ret = -EBUSY;

Why not ret = PTR_ERR(clk)?

> +		goto free_div;
> +	}
> +
> +	return 0;
> +free_div:
> +	devm_kfree(dev, div);
> +	devm_kfree(dev, double_div);
> +free_mux:
> +	devm_kfree(dev, mux);
> +free_gate:
> +	devm_kfree(dev, gate);
> +	return ret;
> +}
> +
> +static const struct of_device_id armada_3700_periph_clock_of_match[] = {
> +	{ .compatible = "marvell,armada-3700-periph-clock-nb",
> +	  .data = data_nb, },
> +	{ .compatible = "marvell,armada-3700-periph-clock-sb",
> +	  .data = data_sb, },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, armada_3700_periph_clock_of_match);
> +
> +static int armada_3700_periph_clock_probe(struct platform_device *pdev)
> +{
> +	struct clk_periph_driver_data *driver_data;
> +	struct device_node *np = pdev->dev.of_node;
> +	const char *parent_name[PARENT_NUM];
> +	const struct clk_periph_data *data;
> +	const struct of_device_id *device;
> +	struct device *dev = &pdev->dev;
> +	int num_periph = 0, i, ret;
> +	struct resource *res;
> +	void __iomem *reg;
> +
> +	device = of_match_device(armada_3700_periph_clock_of_match, dev);
> +	if (!device)
> +		return -ENODEV;
> +	data = device->data;

We have of_device_get_match_data() to simplify this.

> +
> +	while (data[num_periph].name)
> +		num_periph++;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg)) {
> +		dev_err(dev, "Could not map the periph clock registers\n");
> +		return PTR_ERR(reg);
> +	}
> +
> +	ret = of_clk_parent_fill(np, parent_name, PARENT_NUM);
> +	if (ret != PARENT_NUM) {
> +		dev_err(dev, "Could not retrieve the parents\n");
> +		return -EINVAL;
> +	}
> +
> +	driver_data = devm_kzalloc(dev, sizeof(struct clk_periph_driver_data),

sizeof(*driver_data) please

> +				   GFP_KERNEL);
> +	if (!driver_data)
> +		return -ENOMEM;
> +
> +	driver_data->clk_data.clk_num = num_periph;
> +	driver_data->clk_data.clks = devm_kcalloc(dev, num_periph,
> +				       sizeof(struct clk *), GFP_KERNEL);
> +	if (!driver_data->clk_data.clks)
> +		return -ENOMEM;

Again, move to clk_hw based registration.

> +
> +	spin_lock_init(&driver_data->lock);
> +
> +	for (i = 0; i < num_periph; i++) {
> +		struct clk *clk = driver_data->clk_data.clks[i];
> +
> +		if (armada_3700_add_composite_clk(&data[i], parent_name, reg,
> +						  &driver_data->lock, dev, clk))
> +			dev_err(dev, "Can't register periph clock %s\n",
> +			       data[i].name);
> +	}
> +
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
> +				  &driver_data->clk_data);
> +	if (ret) {
> +		for (i = 0; i < num_periph; i++)
> +			clk_unregister(driver_data->clk_data.clks[i]);

It would be nice if we had devm_* registration in composite
clks

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, driver_data);
> +	return 0;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
