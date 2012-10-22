From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 22 Oct 2012 17:55:23 +0200
Subject: [PATCH v2 1/5] clk: samsung: add common clock framework support
 for Samsung platforms
In-Reply-To: <1349629855-4962-2-git-send-email-thomas.abraham@linaro.org>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
 <1349629855-4962-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <50856C6B.3090001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 10/07/2012 07:10 PM, Thomas Abraham wrote:
> All Samsung platforms include several types of clocks including fixed-rate,
> mux, divider and gate clock types. There are typically hundreds of such clocks
> on each of the Samsung platforms. To enable Samsung platforms to register these
> clocks using the common clock framework, a bunch of utility functions are
> introduced here which simplify the clock registration process.
> 
> In addition to the basic types of clock supported by common clock framework,
> a Samsung specific representation of the PLL clocks is also introduced.
> 
> Both legacy and device tree based Samsung platforms are supported. On legacy
> platforms, the clocks are statically instantiated and registered with common
> clock framework. On device tree enabled platforms, the device tree is
> searched and all clock nodes found are registered. It is also possible to
> register statically instantiated clocks on device tree enabled platforms.
> 
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Thanks for the patch. I'm trying to use this series on an Exynos4412 
SoC based board. I think it wasn't tested with Exynos4x12 (with FDT
support), was it ?

I have a few comments, please see below.

> ---
>  drivers/clk/Makefile         |    1 +
>  drivers/clk/samsung/Makefile |    5 +
>  drivers/clk/samsung/clk.c    |  414 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk.h    |  212 +++++++++++++++++++++
>  4 files changed, 632 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/samsung/Makefile
>  create mode 100644 drivers/clk/samsung/clk.c
>  create mode 100644 drivers/clk/samsung/clk.h
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 71a25b9..95644e3 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -19,6 +19,7 @@ endif
>  obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
> +obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
>  
>  # Chip specific
>  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> new file mode 100644
> index 0000000..3f926b0
> --- /dev/null
> +++ b/drivers/clk/samsung/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Samsung Clock specific Makefile
> +#
> +
> +obj-$(CONFIG_PLAT_SAMSUNG)	+= clk.o
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> new file mode 100644
> index 0000000..f5e269a
> --- /dev/null
> +++ b/drivers/clk/samsung/clk.c
> @@ -0,0 +1,414 @@
> +/*
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2012 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This file includes utility functions to register clocks to common
> + * clock framework for Samsung platforms. This includes an implementation
> + * of Samsung 'pll type' clock to represent the implementation of the
> + * pll found on Samsung platforms. In addition to that, utility functions
> + * to register mux, div, gate and fixed rate types of clocks are included.
> +*/
> +
> +#include <linux/of.h>
> +#include "clk.h"
> +
> +#define MAX_PARENT_CLKS		16
> +#define to_clk_pll(_hw) container_of(_hw, struct samsung_pll_clock, hw)
> +
> +static DEFINE_SPINLOCK(lock);
> +static void __iomem *reg_base;
> +static void __iomem *reg_fin_pll;
> +
> +void __init samsung_clk_set_ctrl_base(void __iomem *base)
> +{
> +	reg_base = base;
> +}
> +
> +void __init samsung_clk_set_finpll_reg(void __iomem *reg)
> +{
> +	reg_fin_pll = reg;
> +}
> +
> +/* determine the output clock speed of the pll */
> +static unsigned long samsung_pll_clock_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct samsung_pll_clock *clk_pll = to_clk_pll(hw);
> +
> +	if (clk_pll->get_rate)
> +		return to_clk_pll(hw)->get_rate(parent_rate);
> +
> +	return 0;
> +}
> +
> +/* round operation not supported */
> +static long samsung_pll_clock_round_rate(struct clk_hw *hw, unsigned long drate,
> +				unsigned long *prate)
> +{
> +	return samsung_pll_clock_recalc_rate(hw, *prate);
> +}
> +
> +/* set the clock output rate of the pll */
> +static int samsung_pll_clock_set_rate(struct clk_hw *hw, unsigned long drate,
> +				unsigned long prate)
> +{
> +	struct samsung_pll_clock *clk_pll = to_clk_pll(hw);
> +
> +	if (clk_pll->set_rate)
> +		return to_clk_pll(hw)->set_rate(drate);
> +
> +	return 0;
> +}
> +
> +/* clock operations for samsung pll clock type */
> +static const struct clk_ops samsung_pll_clock_ops = {
> +	.recalc_rate = samsung_pll_clock_recalc_rate,
> +	.round_rate = samsung_pll_clock_round_rate,
> +	.set_rate = samsung_pll_clock_set_rate,
> +};
> +
> +/* register a samsung pll type clock */
> +void __init samsung_clk_register_pll(const char *name, const char **pnames,
> +				struct device_node *np,
> +				int (*set_rate)(unsigned long rate),
> +				unsigned long (*get_rate)(unsigned long rate))
> +{
> +	struct samsung_pll_clock *clk_pll;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	clk_pll = kzalloc(sizeof(*clk_pll), GFP_KERNEL);
> +	if (!clk_pll) {
> +		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
> +		return;
> +	}
> +
> +	init.name = name;
> +	init.ops = &samsung_pll_clock_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE;
> +	init.parent_names = pnames;
> +	init.num_parents = 1;
> +
> +	clk_pll->set_rate = set_rate;
> +	clk_pll->get_rate = get_rate;
> +	clk_pll->hw.init = &init;
> +
> +	/* register the clock */
> +	clk = clk_register(NULL, &clk_pll->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register pll clock %s\n", __func__,
> +				name);
> +		kfree(clk_pll);
> +		return;
> +	}
> +
> +#ifdef CONFIG_OF
> +	if (np)
> +		of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +#endif

Is it really required to do clk_register() and of_clk_add_provider() for 
each single clock ? This seems more heavy than it could be. Looking at
drivers/clk/mxs/clk-imx28.c, it registers only single clock provider for
whole group of clocks. Also, couldn't we statically define most of the 
clocks and still register them so they can be used with platforms using 
FDT ? Something along the lines of imx28 implementation (arch/arm/boot/dts
/imx28.dtsi), where a clock is specified at consumer device node by
a phandle to the clock controller node and a clock index ?

Besides that, what bothers me with in the current approach is the 
clock consumers being defined through one big data structure together 
with the actual clocks. Not all clock objects are going to have 
consumers, some resources are waisted by using flat tables of those 
big data structure objects. Perhaps we could use two tables, one for the
platform clocks and one for the consumers ? These common clock driver
is intended to cover all Samsung SoC, I would expect all samsung 
sub-archs getting converted to use it eventually, with as many of them 
as possible then reworked to support device tree. It's a lot of work 
and is going to take some time, but it would be good to have it planned 
in advance. That said I'm not sure the common samsung clock driver in 
non-dt variant would be really a temporary thing.

> +	/*
> +	 * Register a clock lookup for the pll-type clock even if this
> +	 * has been instantiated from device tree. This helps to do
> +	 * clk_get() lookup on this clock for pruposes of displaying its
> +	 * clock speed at boot time.
> +	 */
> +	ret = clk_register_clkdev(clk, name, NULL);
> +	if (ret)
> +		pr_err("%s: failed to register clock lookup for %s", __func__,
> +				name);
> +}
> +
> +#ifdef CONFIG_OF
> +/* register a samsung pll type clock instantiated from device tree */
> +void __init samsung_of_clk_register_pll(struct device_node *np)
> +{
> +	const char *clk_name = np->name;
> +	const char *parent_name;
> +
> +	of_property_read_string(np, "clock-output-names", &clk_name);
> +	parent_name = of_clk_get_parent_name(np, 0);
> +	samsung_clk_register_pll(clk_name, &parent_name, np, NULL, NULL);
> +}
> +#endif
> +
> +/*
> + * Allow platform specific implementations to attach set_rate and get_rate
> + * callbacks for the pll type clock. Typical calling sequence..
> + *
> + * struct clk *clk = clk_get(NULL, "pll-clk-name");
> + * samsung_pll_clk_set_cb(clk, pll_set_rate, pll_get_rate);
> + */
> +void __init samsung_pll_clk_set_cb(struct clk *clk,
> +			int (*set_rate)(unsigned long rate),
> +			unsigned long (*get_rate)(unsigned long rate))
> +{
> +	struct samsung_pll_clock *clk_pll;
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +
> +	clk_pll = to_clk_pll(hw);
> +	clk_pll->set_rate = set_rate;
> +	clk_pll->get_rate = get_rate;
> +}
> +
> +/* register a list of fixed clocks (used only for non-dt platforms) */
> +void __init samsung_clk_register_fixed_rate(
> +		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk)
> +{
> +	struct clk *clk;
> +	unsigned int idx, ret;
> +
> +	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
> +		clk = clk_register_fixed_rate(NULL, clk_list->name, NULL,
> +				clk_list->flags, clk_list->fixed_rate);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: failed to register clock %s\n", __func__,
> +				clk_list->name);
> +			continue;
> +		}
> +
> +		/*
> +		 * Register a lookup which will help in clk_get() and
> +		 * printing the clock rate during clock initialization.
> +		 */
> +		ret = clk_register_clkdev(clk, clk_list->name,
> +						clk_list->dev_name);
> +		if (ret)
> +			pr_err("clock: failed to register clock lookup for %s",
> +				clk_list->name);
> +	}
> +}
> +
> +/* register a list of mux clocks */
> +void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
> +						unsigned int nr_clk)
> +{
> +	struct clk *clk;
> +	unsigned int idx, ret;
> +
> +	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
> +		clk = clk_register_mux(NULL, clk_list->name,
> +			clk_list->parent_names, clk_list->num_parents,
> +			clk_list->flags, clk_list->reg, clk_list->shift,
> +			clk_list->width, clk_list->mux_flags, &lock);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: failed to register clock %s\n", __func__,
> +				clk_list->name);
> +			continue;
> +		}
> +
> +#ifdef CONFIG_OF
> +		if (clk_list->np)
> +			of_clk_add_provider(clk_list->np, of_clk_src_simple_get,
> +							clk);
> +#endif
> +
> +		ret = clk_register_clkdev(clk, clk_list->name,
> +						clk_list->dev_name);
> +		if (ret)
> +			pr_err("%s: failed to register clock lookup for %s",
> +					__func__, clk_list->name);
> +
> +		if (clk_list->alias) {
> +			ret = clk_register_clkdev(clk, clk_list->alias,
> +						clk_list->dev_name);
> +			if (ret)
> +				pr_err("%s: failed to register lookup %s\n",
> +					__func__, clk_list->alias);
> +		}
> +	}
> +}
> +
> +#ifdef CONFIG_OF
> +/* register a samsung mux type clock instantiated from device tree */
> +void __init samsung_of_clk_register_mux(struct device_node *np)
> +{
> +	struct samsung_mux_clock mux_clk;
> +	const char *clk_name = np->name;
> +	const char *parent_names[MAX_PARENT_CLKS];
> +	u32 reg_info[3];
> +	int idx = 0;
> +
> +	of_property_read_string(np, "clock-output-names", &clk_name);
> +	do {
> +		/* get names of all parent clocks */
> +		parent_names[idx] = of_clk_get_parent_name(np, idx);
> +		idx++;
> +	} while (parent_names[idx-1]);
> +
> +	if (of_property_read_u32_array(np, "reg-info", reg_info, 3))
> +		pr_err("%s: invalid register info in node\n", __func__);
> +
> +	mux_clk.name = clk_name;
> +	mux_clk.parent_names = parent_names;
> +	mux_clk.num_parents = idx - 1;
> +	mux_clk.reg = (void __iomem *)(reg_base + reg_info[0]);
> +	mux_clk.shift = reg_info[1];
> +	mux_clk.width = reg_info[2];
> +	mux_clk.dev_name = NULL;
> +	mux_clk.flags = 0;
> +	mux_clk.mux_flags = 0;
> +	mux_clk.alias = NULL;
> +	mux_clk.np = np;
> +
> +	if (!strcmp(mux_clk.name, "fin_pll"))
> +		mux_clk.reg = reg_fin_pll;
> +
> +	samsung_clk_register_mux(&mux_clk, 1);
> +}
> +#endif
> +
> +/* register a list of div clocks */
> +void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
> +						unsigned int nr_clk)
> +{
> +	struct clk *clk;
> +	unsigned int idx, ret;
> +
> +	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
> +		clk = clk_register_divider(NULL, clk_list->name,
> +			clk_list->parent_name, clk_list->flags, clk_list->reg,
> +			clk_list->shift, clk_list->width, clk_list->div_flags,
> +			&lock);
> +		if (IS_ERR(clk)) {
> +			pr_err("clock: failed to register clock %s\n",
> +				clk_list->name);
> +			continue;
> +		}
> +
> +#ifdef CONFIG_OF
> +		if (clk_list->np)
> +			of_clk_add_provider(clk_list->np, of_clk_src_simple_get,
> +							clk);
> +#endif
> +
> +		ret = clk_register_clkdev(clk, clk_list->name,
> +						clk_list->dev_name);
> +		if (ret)
> +			pr_err("%s: failed to register clock lookup for %s",
> +					__func__, clk_list->name);
> +
> +		if (clk_list->alias) {
> +			ret = clk_register_clkdev(clk, clk_list->alias,
> +						clk_list->dev_name);
> +			if (ret)
> +				pr_err("%s: failed to register lookup %s\n",
> +					__func__, clk_list->alias);
> +		}
> +	}
> +}
> +
> +#ifdef CONFIG_OF
> +/* register a samsung div type clock instantiated from device tree */
> +void __init samsung_of_clk_register_div(struct device_node *np)
> +{
> +	struct samsung_div_clock clk_div;
> +	const char *clk_name = np->name;
> +	const char *parent_name;
> +	u32 reg_info[3];
> +
> +	of_property_read_string(np, "clock-output-names", &clk_name);
> +	parent_name = of_clk_get_parent_name(np, 0);
> +	if (of_property_read_u32_array(np, "reg-info", reg_info, 3))
> +		pr_err("%s: invalid register info in node\n", __func__);
> +
> +	clk_div.name = clk_name;
> +	clk_div.parent_name = parent_name;
> +	clk_div.reg = (void __iomem *)(reg_base + reg_info[0]);
> +	clk_div.shift = reg_info[1];
> +	clk_div.width = reg_info[2];
> +	clk_div.dev_name = NULL;
> +	clk_div.flags = 0;
> +	clk_div.div_flags = 0;
> +	clk_div.alias = NULL;
> +	clk_div.np = np;
> +
> +	samsung_clk_register_div(&clk_div, 1);
> +}
> +#endif
> +
> +/* register a list of gate clocks */
> +void __init samsung_clk_register_gate(struct samsung_gate_clock *clk_list,
> +						unsigned int nr_clk)
> +{
> +	struct clk *clk;
> +	unsigned int idx, ret;
> +
> +	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
> +		clk = clk_register_gate(NULL, clk_list->name,
> +			clk_list->parent_name, clk_list->flags, clk_list->reg,
> +			clk_list->bit_idx, clk_list->gate_flags, &lock);
> +		if (IS_ERR(clk)) {
> +			pr_err("clock: failed to register clock %s\n",
> +				clk_list->name);
> +			continue;
> +		}
> +
> +#ifdef CONFIG_OF
> +		if (clk_list->np)
> +			of_clk_add_provider(clk_list->np, of_clk_src_simple_get,
> +							clk);
> +#endif
> +
> +		ret = clk_register_clkdev(clk, clk_list->name,
> +						clk_list->dev_name);
> +		if (ret)
> +			pr_err("%s: failed to register clock lookup for %s",
> +					__func__, clk_list->name);
> +
> +		if (clk_list->alias) {
> +			ret = clk_register_clkdev(clk, clk_list->alias,
> +						clk_list->dev_name);
> +			if (ret)
> +				pr_err("%s: failed to register lookup %s\n",
> +					__func__, clk_list->alias);
> +		}
> +	}
> +}
> +
> +#ifdef CONFIG_OF
> +/* register a samsung gate type clock instantiated from device tree */
> +void __init samsung_of_clk_register_gate(struct device_node *np)
> +{
> +	struct samsung_gate_clock clk_gate;
> +	const char *clk_name = np->name;
> +	const char *parent_name;
> +	u32 reg_info[2];
> +
> +	of_property_read_string(np, "clock-output-names", &clk_name);
> +	parent_name = of_clk_get_parent_name(np, 0);
> +	if (of_property_read_u32_array(np, "reg-info", reg_info, 2))
> +		pr_err("%s: invalid register info in node\n", __func__);
> +
> +	clk_gate.name = clk_name;
> +	clk_gate.parent_name = parent_name;
> +	clk_gate.reg = (void __iomem *)(reg_base + reg_info[0]);
> +	clk_gate.bit_idx = reg_info[1];
> +	clk_gate.dev_name = NULL;
> +	clk_gate.flags = 0;
> +	clk_gate.gate_flags = 0;

Some clocks need CLK_SET_RATE_PARENT for the drivers to work
as before. So far it is not set for any mux, div nor gate clock.

> +	clk_gate.alias = NULL;
> +	clk_gate.np = np;
> +
> +	samsung_clk_register_gate(&clk_gate, 1);
> +}
> +#endif
> +

--

Thanks,
Sylwester
