From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 20 Nov 2015 21:54:01 +0100
Subject: [PATCH v2 2/6] clk: berlin: add common clk driver for newer SoCs
In-Reply-To: <1448008952-1787-3-git-send-email-jszhang@marvell.com>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-3-git-send-email-jszhang@marvell.com>
Message-ID: <564F8869.6040307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2015 09:42, Jisheng Zhang wrote:
> Add common clk driver for Marvell SoCs newer than BG2, BG2CD, BG2Q.
> berlin_clk_setup() is provided to setup and register such kind of clks.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/clk/berlin/Makefile |   2 +-
>  drivers/clk/berlin/clk.c    | 203 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/berlin/clk.h    |  33 +++++++
>  3 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/berlin/clk.c
>  create mode 100644 drivers/clk/berlin/clk.h
> 
> diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
> index eee42b0..ee2e09d 100644
> --- a/drivers/clk/berlin/Makefile
> +++ b/drivers/clk/berlin/Makefile
> @@ -1,5 +1,5 @@
>  obj-y += berlin2-avpll.o berlin2-pll.o berlin2-div.o
> -obj-y += pll.o
> +obj-y += pll.o clk.o

Same comment about the naming convention.

>  obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
>  obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
>  obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
> diff --git a/drivers/clk/berlin/clk.c b/drivers/clk/berlin/clk.c
> new file mode 100644
> index 0000000..70f2b9d
> --- /dev/null
> +++ b/drivers/clk/berlin/clk.c
> @@ -0,0 +1,203 @@
> +/*
> + * Copyright (c) 2015 Marvell Technology Group Ltd.
> + *
> + * Author: Jisheng Zhang <jszhang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define CLKEN		(1 << 0)

#define CLKEN	BIT(0)

> +#define CLKPLLSEL_MASK	7

Please use hex numbers for the mask.

> +#define CLKPLLSEL_SHIFT	1
> +#define CLKPLLSWITCH	(1 << 4)
> +#define CLKSWITCH	(1 << 5)
> +#define CLKD3SWITCH	(1 << 6)

BIT() again.

> +#define CLKSEL_MASK	7

Hex again.

> +#define CLKSEL_SHIFT	7
> +
> +#define CLK_SOURCE_MAX	5
> +
> +struct berlin_clk {
> +	struct clk_hw hw;
> +	void __iomem *base;
> +};
> +
> +#define to_berlin_clk(hw)	container_of(hw, struct berlin_clk, hw)
> +
> +static u8 clk_div[] = {1, 2, 4, 6, 8, 12, 1, 1};

Hmm, this pretty much looks like berlin2-div dividers...

> +static unsigned long berlin_clk_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	u32 val, divider;
> +	struct berlin_clk *clk = to_berlin_clk(hw);
> +
> +	val = readl_relaxed(clk->base);
> +	if (val & CLKD3SWITCH)
> +		divider = 3;

and this looks like berlin2-div structure, doesn't it?

Again, please reuse what is already available.

Sebastian

> +	else {
> +		if (val & CLKSWITCH) {
> +			val >>= CLKSEL_SHIFT;
> +			val &= CLKSEL_MASK;
> +			divider = clk_div[val];
> +		} else
> +			divider = 1;
> +	}
> +
> +	return parent_rate / divider;
> +}
> +
> +static u8 berlin_clk_get_parent(struct clk_hw *hw)
> +{
> +	u32 val;
> +	struct berlin_clk *clk = to_berlin_clk(hw);
> +
> +	val = readl_relaxed(clk->base);
> +	if (val & CLKPLLSWITCH) {
> +		val >>= CLKPLLSEL_SHIFT;
> +		val &= CLKPLLSEL_MASK;
> +		return val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int berlin_clk_enable(struct clk_hw *hw)
> +{
> +	u32 val;
> +	struct berlin_clk *clk = to_berlin_clk(hw);
> +
> +	val = readl_relaxed(clk->base);
> +	val |= CLKEN;
> +	writel_relaxed(val, clk->base);
> +
> +	return 0;
> +}
> +
> +static void berlin_clk_disable(struct clk_hw *hw)
> +{
> +	u32 val;
> +	struct berlin_clk *clk = to_berlin_clk(hw);
> +
> +	val = readl_relaxed(clk->base);
> +	val &= ~CLKEN;
> +	writel_relaxed(val, clk->base);
> +}
> +
> +static int berlin_clk_is_enabled(struct clk_hw *hw)
> +{
> +	u32 val;
> +	struct berlin_clk *clk = to_berlin_clk(hw);
> +
> +	val = readl_relaxed(clk->base);
> +	val &= CLKEN;
> +
> +	return val ? 1 : 0;
> +}
> +
> +static const struct clk_ops berlin_clk_ops = {
> +	.recalc_rate	= berlin_clk_recalc_rate,
> +	.get_parent	= berlin_clk_get_parent,
> +	.enable		= berlin_clk_enable,
> +	.disable	= berlin_clk_disable,
> +	.is_enabled	= berlin_clk_is_enabled,
> +};
> +
> +static struct clk * __init
> +berlin_clk_register(const char *name, int num_parents,
> +		    const char **parent_names, unsigned long flags,
> +		    void __iomem *base)
> +{
> +	struct clk *clk;
> +	struct berlin_clk *bclk;
> +	struct clk_init_data init;
> +
> +	bclk = kzalloc(sizeof(*bclk), GFP_KERNEL);
> +	if (!bclk)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &berlin_clk_ops;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +	init.flags = flags;
> +
> +	bclk->base = base;
> +	bclk->hw.init = &init;
> +
> +	clk = clk_register(NULL, &bclk->hw);
> +	if (IS_ERR(clk))
> +		kfree(bclk);
> +
> +	return clk;
> +}
> +
> +void __init berlin_clk_setup(struct device_node *np,
> +			     const struct clk_desc *descs,
> +			     struct clk_onecell_data *clk_data,
> +			     int n)
> +{
> +	int i, ret, num_parents;
> +	void __iomem *base;
> +	struct clk **clks;
> +	const char *parent_names[CLK_SOURCE_MAX];
> +
> +	num_parents = of_clk_get_parent_count(np);
> +	if (num_parents <= 0 || num_parents > CLK_SOURCE_MAX)
> +		return;
> +
> +	of_clk_parent_fill(np, parent_names, num_parents);
> +
> +	clks = kcalloc(n, sizeof(struct clk *), GFP_KERNEL);
> +	if (!clks)
> +		return;
> +
> +	base = of_iomap(np, 0);
> +	if (WARN_ON(!base))
> +		goto err_iomap;
> +
> +	for (i = 0; i < n; i++) {
> +		struct clk *clk;
> +
> +		clk = berlin_clk_register(descs[i].name,
> +				num_parents, parent_names,
> +				descs[i].flags,
> +				base + descs[i].offset);
> +		if (WARN_ON(IS_ERR(clks[i])))
> +			goto err_clk_register;
> +		clks[i] = clk;
> +	}
> +
> +	clk_data->clks = clks;
> +	clk_data->clk_num = i;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
> +	if (WARN_ON(ret))
> +		goto err_clk_register;
> +	return;
> +
> +err_clk_register:
> +	for (i = 0; i < n; i++)
> +		clk_unregister(clks[i]);
> +	iounmap(base);
> +err_iomap:
> +	kfree(clks);
> +}
> diff --git a/drivers/clk/berlin/clk.h b/drivers/clk/berlin/clk.h
> new file mode 100644
> index 0000000..5e5680e
> --- /dev/null
> +++ b/drivers/clk/berlin/clk.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (c) 2015 Marvell Technology Group Ltd.
> + *
> + * Author: Jisheng Zhang <jszhang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __BERLIN_CLK_H
> +#define __BERLIN_CLK_H
> +
> +struct clk_desc {
> +	const char	*name;
> +	u32		offset;
> +	unsigned long	flags;
> +};
> +
> +void __init berlin_clk_setup(struct device_node *np,
> +			     const struct clk_desc *desc,
> +			     struct clk_onecell_data *clk_data,
> +			     int n);
> +
> +#endif
> 
