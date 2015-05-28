From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 14:55:34 -0700
Subject: [PATCH v2 1/3] clk: meson: Add support for Meson clock controller
In-Reply-To: <1431773333-23567-2-git-send-email-carlo@caione.org>
References: <1431773333-23567-1-git-send-email-carlo@caione.org>
 <1431773333-23567-2-git-send-email-carlo@caione.org>
Message-ID: <20150528215534.GC24204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16, Carlo Caione wrote:
> diff --git a/drivers/clk/meson/clk-cpu.c b/drivers/clk/meson/clk-cpu.c
> new file mode 100644
> index 0000000..88f4606
> --- /dev/null
> +++ b/drivers/clk/meson/clk-cpu.c
> @@ -0,0 +1,291 @@
> +/*
> + * Copyright (c) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
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
> +/*
> + * CPU clock path:
> + *
> + *                           +-[/N]-----|3|
> + *             MUX2  +--[/2]-+----------|2| MUX1
> + * [sys_pll]---|1|   |--[/3]------------|1|-|1|
> + *             | |---+------------------|0| | |----- [a5_clk]
> + *          +--|0|                          | |
> + * [xtal]---+-------------------------------|0|
> + *
> + *
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used?

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>

Is this include used?

> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>

Is this include used?

Missing

#include <linux/spinlock.h>

?

> +
> +#define MESON_CPU_CLK_CNTL1		0x00
> +#define MESON_CPU_CLK_CNTL		0x40
> +
> +#define MESON_CPU_CLK_MUX1		BIT(7)
> +#define MESON_CPU_CLK_MUX2		BIT(0)
> +
> +#define MESON_N_WIDTH			9
> +#define MESON_N_SHIFT			20
> +#define MESON_SEL_WIDTH			2
> +#define MESON_SEL_SHIFT			2
> +
> +#define MULT_ROUND_UP(r, m) ((r) * (m) + (m) - 1)
> +
> +#include "clkc.h"
> +
> +struct meson_clk_cpu {
> +	struct notifier_block	clk_nb;
> +	struct clk_hw		hw;
> +	void __iomem		*base;
> +	u16			reg_off;
> +	spinlock_t		*lock;
> +};
> +#define to_meson_clk_cpu_hw(_hw) container_of(_hw, struct meson_clk_cpu, hw)
> +#define to_meson_clk_cpu_nb(_nb) container_of(_nb, struct meson_clk_cpu, clk_nb)
> +
> +static bool is_valid_div(int i)
> +{
> +	if ((i % 2) && (i != 1) && (i != 3))
> +		return 0;
> +	return 1;
> +}
> +
> +static bool is_best_div(unsigned long rate, unsigned long now,
> +			unsigned long best)
> +{
> +	return abs(rate - now) < abs(rate - best);
> +}
> +
> +static int meson_clk_cpu_get_div(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long *best_parent_rate)
> +{
> +	unsigned long maxdiv, parent_rate, now;
> +	unsigned long best = 0;
> +	unsigned long parent_rate_saved = *best_parent_rate;
> +	int i, bestdiv = 0;
> +
> +	maxdiv = 2 * PMASK(MESON_N_WIDTH);
> +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +	for (i = 1; i <= maxdiv; i++) {
> +		if (!is_valid_div(i))
> +			continue;
> +		if (rate * i == parent_rate_saved) {
> +			*best_parent_rate = parent_rate_saved;
> +			return i;
> +		}
> +		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
> +				MULT_ROUND_UP(rate, i));
> +		now = DIV_ROUND_UP(parent_rate, i);
> +		if (is_best_div(rate, now, best)) {
> +			bestdiv = i;
> +			best = now;
> +			*best_parent_rate = parent_rate;
> +		}
> +	}
> +
> +	return bestdiv;
> +}
> +
> +static long meson_clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long *prate)
> +{
> +	int div;
> +
> +	div = meson_clk_cpu_get_div(hw, rate, prate);
> +
> +	return DIV_ROUND_UP(*prate, div);
> +}

How much of this is the same as the generic divider code? Can you
use the divider_*() functions for this code?

> +
> +static int meson_clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long parent_rate)
> +{
> +	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_hw(hw);
> +	unsigned int div, sel, N = 0;
> +	u32 reg;
> +
> +	div = DIV_ROUND_UP(parent_rate, rate);
> +
> +	if (div <= 3) {
> +		sel = div - 1;
> +	} else {
> +		sel = 3;
> +		N = div / 2;
> +	}
> +
> +	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL1);
> +	reg = PARM_SET(MESON_N_WIDTH, MESON_N_SHIFT, reg, N);
> +	writel(reg, clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL1);
> +
> +	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL);
> +	reg = PARM_SET(MESON_SEL_WIDTH, MESON_SEL_SHIFT, reg, sel);
> +	writel(reg, clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL);
> +
> +	return 0;
> +}
> +
> +static unsigned long meson_clk_cpu_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_hw(hw);
> +	unsigned int N, sel;
> +	unsigned int div = 1;
> +	u32 reg;
> +
> +	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL1);
> +	N = PARM_GET(MESON_N_WIDTH, MESON_N_SHIFT, reg);
> +
> +	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL);
> +	sel = PARM_GET(MESON_SEL_WIDTH, MESON_SEL_SHIFT, reg);
> +
> +	if (sel < 3)
> +		div = sel + 1;
> +	else
> +		div = 2 * N;
> +
> +	return parent_rate / div;
> +}
> +
> +static int meson_clk_cpu_pre_rate_change(struct meson_clk_cpu *clk_cpu,
> +					 struct clk_notifier_data *ndata)
> +{
> +	u32 cpu_clk_cntl;
> +
> +	spin_lock(clk_cpu->lock);

We don't need irqsave? What is this locking against? I only see
notifiers using it and notifiers are synchronized already.

> +
> +	/* switch MUX1 to xtal */
> +	cpu_clk_cntl = readl(clk_cpu->base + clk_cpu->reg_off
> +				+ MESON_CPU_CLK_CNTL);
> +	cpu_clk_cntl &= ~MESON_CPU_CLK_MUX1;
> +	writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
> +				+ MESON_CPU_CLK_CNTL);
> +	udelay(100);
> +
> +	/* switch MUX2 to sys-pll */
> +	cpu_clk_cntl |= MESON_CPU_CLK_MUX2;
> +	writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
> +				+ MESON_CPU_CLK_CNTL);
> +
> +	spin_unlock(clk_cpu->lock);
> +
> +	return 0;
> +}
> +
> +static int meson_clk_cpu_post_rate_change(struct meson_clk_cpu *clk_cpu,
> +					  struct clk_notifier_data *ndata)
> +{
> +	u32 cpu_clk_cntl;
> +
> +	spin_lock(clk_cpu->lock);
> +
> +	/* switch MUX1 to divisors' output */
> +	cpu_clk_cntl = readl(clk_cpu->base + clk_cpu->reg_off
> +				+ MESON_CPU_CLK_CNTL);
> +	cpu_clk_cntl |= MESON_CPU_CLK_MUX1;
> +	writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
> +				+ MESON_CPU_CLK_CNTL);
> +	udelay(100);
> +
> +	spin_unlock(clk_cpu->lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * This clock notifier is called when the frequency of the of the parent
> + * PLL clock is to be changed. We use the xtal input as temporary parent
> + * while the PLL frequency is stabilized.
> + */
> +static int meson_clk_cpu_notifier_cb(struct notifier_block *nb,
> +				     unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_nb(nb);
> +	int ret = 0;
> +
> +	if (event == PRE_RATE_CHANGE)
> +		ret = meson_clk_cpu_pre_rate_change(clk_cpu, ndata);
> +	else if (event == POST_RATE_CHANGE)
> +		ret = meson_clk_cpu_post_rate_change(clk_cpu, ndata);
> +
> +	return notifier_from_errno(ret);
> +}
> +
> +static const struct clk_ops meson_clk_cpu_ops = {
> +	.recalc_rate	= meson_clk_cpu_recalc_rate,
> +	.round_rate	= meson_clk_cpu_round_rate,
> +	.set_rate	= meson_clk_cpu_set_rate,
> +};
> +
> +struct clk *meson_clk_register_cpu(struct clk_conf *clk_conf,
> +				   void __iomem *reg_base,
> +				   spinlock_t *lock)
> +{
> +	struct clk *clk;
> +	struct clk *pclk;
> +	struct meson_clk_cpu *clk_cpu;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	clk_cpu = kzalloc(sizeof(*clk_cpu), GFP_KERNEL);
> +	if (!clk_cpu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk_cpu->lock = lock;
> +	clk_cpu->base = reg_base;
> +	clk_cpu->reg_off = clk_conf->reg_off;
> +	clk_cpu->clk_nb.notifier_call = meson_clk_cpu_notifier_cb;
> +
> +	init.name = clk_conf->clk_name;
> +	init.ops = &meson_clk_cpu_ops;
> +	init.flags = clk_conf->flags | CLK_GET_RATE_NOCACHE;
> +	init.flags |= CLK_SET_RATE_PARENT;
> +	init.parent_names = clk_conf->clks_parent;
> +	init.num_parents = 1;
> +
> +	clk_cpu->hw.init = &init;
> +
> +	pclk = __clk_lookup(clk_conf->clks_parent[0]);
> +	if (!pclk) {
> +		pr_err("%s: could not lookup parent clock %s\n",
> +				__func__, clk_conf->clks_parent[0]);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret = clk_notifier_register(pclk, &clk_cpu->clk_nb);
> +	if (ret) {
> +		pr_err("%s: failed to register clock notifier for %s\n",
> +				__func__, clk_conf->clk_name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	clk = clk_register(NULL, &clk_cpu->hw);
> +	if (IS_ERR(clk)) {
> +		clk_notifier_unregister(pclk, &clk_cpu->clk_nb);
> +		kfree(clk_cpu);
> +	}
> +
> +	return clk;
> +}
> +
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> new file mode 100644
> index 0000000..662d694
> --- /dev/null
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -0,0 +1,231 @@
> +/*
> + * Copyright (c) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
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
> +/*
> + * In the most basic form, a Meson PLL is composed as follows:
> + *
> + *                     PLL
> + *      +------------------------------+
> + *      |                              |
> + * in -----[ /N ]---[ *M ]---[ >>OD ]----->> out
> + *      |         ^        ^           |
> + *      +------------------------------+
> + *                |        |
> + *               FREF     VCO
> + *
> + * out = (in * M / N) >> OD
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used?

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "clkc.h"
> +
> +#define MESON_PLL_RESET				BIT(29)
> +#define MESON_PLL_LOCK				BIT(31)
> +
> +struct meson_clk_pll {
> +	struct clk_hw	hw;
> +	void __iomem	*base;
> +	struct pll_conf	*conf;
> +	unsigned int	rate_count;
> +	spinlock_t	*lock;
> +};
> +#define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
> +
> +static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
> +	struct parm *p;
> +	unsigned long parent_rate_mhz = parent_rate / 1000000;
> +	unsigned long rate_mhz;
> +	u16 n, m, od;
> +	u32 reg;
> +
> +	p = &pll->conf->n;
> +	reg = readl(pll->base + p->reg_off);
> +	n = PARM_GET(p->width, p->shift, reg);
> +
> +	p = &pll->conf->m;
> +	reg = readl(pll->base + p->reg_off);
> +	m = PARM_GET(p->width, p->shift, reg);
> +
> +	p = &pll->conf->od;
> +	reg = readl(pll->base + p->reg_off);
> +	od = PARM_GET(p->width, p->shift, reg);
> +
> +	rate_mhz = (parent_rate_mhz * m / n) >> od;
> +
> +	return rate_mhz * 1000000;
> +}
> +
> +static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long *parent_rate)
> +{
> +	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
> +	struct pll_rate_table *rate_table = pll->conf->rate_table;
> +	int i;
> +
> +	for (i = 0; i < pll->rate_count; i++) {
> +		if (rate <= rate_table[i].rate)
> +			return rate_table[i].rate;
> +	}
> +
> +	/* else return the smallest value */
> +	return rate_table[0].rate;
> +}
> +
> +static struct pll_rate_table *meson_clk_get_pll_settings(struct meson_clk_pll *pll,
> +							 unsigned long rate)
> +{
> +	struct pll_rate_table *rate_table = pll->conf->rate_table;
> +	int i;
> +
> +	for (i = 0; i < pll->rate_count; i++) {
> +		if (rate == rate_table[i].rate)
> +			return &rate_table[i];
> +	}
> +	return NULL;
> +}
> +
> +static int meson_clk_pll_wait_lock(struct meson_clk_pll *pll,
> +				   struct parm *p_n)
> +{
> +	int delay = 24000000;
> +	u32 reg;
> +
> +	while (delay > 0) {
> +		reg = readl(pll->base + p_n->reg_off);
> +
> +		if (reg & MESON_PLL_LOCK)
> +			return 0;
> +		delay--;

Do we somehow know that a delay-- takes so much time? It would
seem better to have a udelay() here. Otherwise we're left to the
speed of the CPU to execute these instructions.

> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long parent_rate)
> +{
> +	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
> +	struct parm *p;
> +	struct pll_rate_table *rate_set;
> +	unsigned long old_rate;
> +	int ret = 0;
> +	u32 reg;
> +
> +	if (parent_rate == 0 || rate == 0)
> +		return -EINVAL;
> +
> +	old_rate = rate;
> +
> +	rate_set = meson_clk_get_pll_settings(pll, rate);
> +	if (!rate_set)
> +		return -EINVAL;
> +
> +	/* PLL reset */
> +	p = &pll->conf->n;
> +	reg = readl(pll->base + p->reg_off);
> +	writel(reg | MESON_PLL_RESET, pll->base + p->reg_off);
> +
> +	reg = PARM_SET(p->width, p->shift, reg, rate_set->n);
> +	writel(reg, pll->base + p->reg_off);
> +
> +	p = &pll->conf->m;
> +	reg = readl(pll->base + p->reg_off);
> +	reg = PARM_SET(p->width, p->shift, reg, rate_set->m);
> +	writel(reg, pll->base + p->reg_off);
> +
> +	p = &pll->conf->od;
> +	reg = readl(pll->base + p->reg_off);
> +	reg = PARM_SET(p->width, p->shift, reg, rate_set->od);
> +	writel(reg, pll->base + p->reg_off);
> +
> +	p = &pll->conf->n;
> +	ret = meson_clk_pll_wait_lock(pll, p);
> +	if (ret) {
> +		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
> +			__func__, old_rate);
> +		meson_clk_pll_set_rate(hw, old_rate, parent_rate);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct clk_ops meson_clk_pll_ops = {
> +	.recalc_rate	= meson_clk_pll_recalc_rate,
> +	.round_rate	= meson_clk_pll_round_rate,
> +	.set_rate	= meson_clk_pll_set_rate,
> +};
> +
> +static const struct clk_ops meson_clk_pll_ro_ops = {
> +	.recalc_rate	= meson_clk_pll_recalc_rate,
> +};
> +
> +struct clk *meson_clk_register_pll(struct clk_conf *clk_conf,
> +				   void __iomem *reg_base,
> +				   spinlock_t *lock)
> +{
> +	struct clk *clk;
> +	struct meson_clk_pll *clk_pll;
> +	struct clk_init_data init;
> +
> +	clk_pll = kzalloc(sizeof(*clk_pll), GFP_KERNEL);
> +	if (!clk_pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk_pll->base = reg_base + clk_conf->reg_off;
> +	clk_pll->lock = lock;
> +	clk_pll->conf = clk_conf->conf.pll;
> +
> +	init.name = clk_conf->clk_name;
> +	init.flags = clk_conf->flags | CLK_GET_RATE_NOCACHE;
> +
> +	/* We usually don't touch PLLs */
> +	init.flags |= CLK_IGNORE_UNUSED;

Is this even important if the ops don't have an enable/disable
(read-only ops)?

> +
> +	init.parent_names = &clk_conf->clks_parent[0];
> +	init.num_parents = 1;
> +	init.ops = &meson_clk_pll_ro_ops;
> +
> +	/* If no rate_table is specified we assume the PLL is read-only */
> +	if (clk_pll->conf->rate_table) {
> +		int len;
> +
> +		for (len = 0; clk_pll->conf->rate_table[len].rate != 0; )
> +			len++;
> +
> +		 clk_pll->rate_count = len;
> +		 init.ops = &meson_clk_pll_ops;
> +	}
> +
> +	clk_pll->hw.init = &init;
> +
> +	clk = clk_register(NULL, &clk_pll->hw);
> +	if (IS_ERR(clk))
> +		kfree(clk_pll);
> +
> +	return clk;
> +}
> diff --git a/drivers/clk/meson/clkc.c b/drivers/clk/meson/clkc.c
> new file mode 100644
> index 0000000..8805772
> --- /dev/null
> +++ b/drivers/clk/meson/clkc.c
> @@ -0,0 +1,234 @@
> +/*
> + * Copyright (c) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
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
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/slab.h>
> +
> +#include "clkc.h"
> +
> +static DEFINE_SPINLOCK(clk_lock);
> +
> +static struct clk **clks;
> +static struct clk_onecell_data clk_data;
> +
> +struct clk __init **meson_clk_init(struct device_node *np,

This should be 

struct clk ** __init meson_clk_init(struct ...)

> +				   unsigned long nr_clks)
> +{
> +	clks = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);

sizeof(**clks) ?

> +	if (!clks) {
> +		pr_err("%s: could not allocate clock lookup table\n", __func__);

No need for error messages on allocation failures. Please run
checkpatch.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	clk_data.clks = clks;
> +	clk_data.clk_num = nr_clks;
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +
> +	return clks;
> +}
> +
> +static void meson_clk_add_lookup(struct clk *clk, unsigned int id)
> +{
> +	if (clks && id)
> +		clks[id] = clk;
> +}
> +
> +static struct clk __init *meson_clk_register_composite(struct clk_conf *clk_conf,
> +						       void __iomem *clk_base)
> +{
> +	struct clk *clk;
> +	struct clk_mux *mux = NULL;
> +	struct clk_divider *div = NULL;
> +	struct clk_gate *gate = NULL;
> +	const struct clk_ops *mux_ops = NULL;
> +	struct composite_conf *composite_conf;
> +
> +	composite_conf = clk_conf->conf.composite;
> +
> +	if (clk_conf->num_parents > 1) {
> +		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +		if (!mux)
> +			return ERR_PTR(-ENOMEM);
> +
> +		mux->reg = clk_base + clk_conf->reg_off
> +				+ composite_conf->mux_parm.reg_off;
> +		mux->shift = composite_conf->mux_parm.shift;
> +		mux->mask = BIT(composite_conf->mux_parm.width) - 1;
> +		mux->flags = composite_conf->mux_flags;
> +		mux->lock = &clk_lock;
> +		mux->table = composite_conf->mux_table;
> +		mux_ops = (composite_conf->mux_flags & CLK_MUX_READ_ONLY) ?
> +			  &clk_mux_ro_ops : &clk_mux_ops;
> +	}
> +
> +	if (MESON_PARM_APPLICABLE(&composite_conf->div_parm)) {
> +		div = kzalloc(sizeof(*div), GFP_KERNEL);
> +		if (!div)
> +			return ERR_PTR(-ENOMEM);

Did we just leak memory if we had a mux?

> +
> +		div->reg = clk_base + clk_conf->reg_off
> +				+ composite_conf->div_parm.reg_off;
> +		div->shift = composite_conf->div_parm.shift;
> +		div->width = composite_conf->div_parm.width;
> +		div->lock = &clk_lock;
> +		div->flags = composite_conf->div_flags;
> +		div->table = composite_conf->div_table;
> +	}
> +
> +	if (MESON_PARM_APPLICABLE(&composite_conf->gate_parm)) {
> +		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +		if (!gate)
> +			return ERR_PTR(-ENOMEM);

ditto

> +
> +		gate->reg = clk_base + clk_conf->reg_off
> +				+ composite_conf->div_parm.reg_off;
> +		gate->bit_idx = composite_conf->gate_parm.shift;
> +		gate->flags = composite_conf->gate_flags;
> +		gate->lock = &clk_lock;
> +	}
> +
> +	clk = clk_register_composite(NULL, clk_conf->clk_name,
> +				    clk_conf->clks_parent,
> +				    clk_conf->num_parents,
> +				    mux ? &mux->hw : NULL, mux_ops,
> +				    div ? &div->hw : NULL, &clk_divider_ops,
> +				    gate ? &gate->hw : NULL, &clk_gate_ops,
> +				    clk_conf->flags);
> +
> +	return clk;

Why not just return clk_register_composite() then?

> +}
> +
> +static struct clk __init *meson_clk_register_fixed_factor(struct clk_conf *clk_conf,
> +							  void __iomem *clk_base)
> +{
> +	struct clk *clk;
> +	struct fixed_fact_conf *fixed_fact_conf;
> +	struct parm *p;
> +	unsigned int mult, div;
> +	u32 reg;
> +
> +	fixed_fact_conf = &clk_conf->conf.fixed_fact;
> +
> +	mult = clk_conf->conf.fixed_fact.mult;
> +	div = clk_conf->conf.fixed_fact.div;
> +
> +	if (!mult) {
> +		mult = 1;
> +		p = &fixed_fact_conf->mult_parm;
> +		if (MESON_PARM_APPLICABLE(p)) {
> +			reg = readl(clk_base + clk_conf->reg_off + p->reg_off);
> +			mult = PARM_GET(p->width, p->shift, reg);
> +		}
> +	}
> +
> +	if (!div) {
> +		div = 1;
> +		p = &fixed_fact_conf->div_parm;
> +		if (MESON_PARM_APPLICABLE(p)) {
> +			reg = readl(clk_base + clk_conf->reg_off + p->reg_off);
> +			mult = PARM_GET(p->width, p->shift, reg);
> +		}
> +	}
> +
> +	clk = clk_register_fixed_factor(NULL,
> +			clk_conf->clk_name,
> +			clk_conf->clks_parent[0],
> +			clk_conf->flags,
> +			mult, div);
> +
> +	return clk;
> +}
> +
> +static struct clk __init *meson_clk_register_fixed_rate(struct clk_conf *clk_conf,
> +							void __iomem *clk_base)
> +{
> +	struct clk *clk;
> +	struct fixed_rate_conf *fixed_rate_conf;
> +	struct parm *r;
> +	unsigned long rate;
> +	u32 reg;
> +
> +	fixed_rate_conf = &clk_conf->conf.fixed_rate;
> +	rate = fixed_rate_conf->rate;
> +
> +	if (!rate) {
> +		r = &fixed_rate_conf->rate_parm;
> +		reg = readl(clk_base + clk_conf->reg_off + r->reg_off);
> +		rate = PARM_GET(r->width, r->shift, reg);
> +	}
> +
> +	rate *= 1000000;
> +
> +	clk = clk_register_fixed_rate(NULL,
> +			clk_conf->clk_name,
> +			clk_conf->num_parents
> +				? clk_conf->clks_parent[0] : NULL,
> +			clk_conf->flags, rate);
> +
> +	return clk;
> +}
> +
> +void __init meson_clk_register_clks(struct clk_conf *clk_confs,
> +				    unsigned int nr_confs,

size_t?

> +				    void __iomem *clk_base)
> +{
> +	unsigned int i;
> +	struct clk *clk = NULL;
> +
> +	for (i = 0; i < nr_confs; i++) {
> +		struct clk_conf *clk_conf = &clk_confs[i];
> +
> +		switch (clk_conf->clk_type) {
> +		case clk_fixed_rate:
> +			clk = meson_clk_register_fixed_rate(clk_conf,
> +							    clk_base);
> +			break;
> +		case clk_fixed_factor:
> +			clk = meson_clk_register_fixed_factor(clk_conf,
> +							      clk_base);
> +			break;
> +		case clk_composite:
> +			clk = meson_clk_register_composite(clk_conf,
> +							   clk_base);
> +			break;
> +		case clk_cpu:
> +			clk = meson_clk_register_cpu(clk_conf, clk_base,
> +						     &clk_lock);
> +			break;
> +		case clk_pll:
> +			clk = meson_clk_register_pll(clk_conf, clk_base,
> +						     &clk_lock);
> +			break;

default:
	clk = NULL;
	break;

> +		}
> +
> +		if (!clk) {
> +			pr_err("%s: unknown clock type %d\n", __func__,
> +			       clk_conf->clk_type);
> +			continue;
> +		}
> +
> +		if (IS_ERR(clk)) {
> +			pr_warn("%s: Unable to create %s clock\n", __func__,
> +				clk_conf->clk_name);
> +			continue;
> +		}
> +
> +		meson_clk_add_lookup(clk, clk_conf->clk_id);
> +	}
> +}
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> new file mode 100644
> index 0000000..f189228
> --- /dev/null
> +++ b/drivers/clk/meson/clkc.h
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (c) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
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
> +#ifndef __CLKC_H
> +#define __CLKC_H
> +
> +#include <linux/clk.h>

What is this include for?

> +
> +#define PMASK(width)			((1U << (width)) - 1)
> +#define SETPMASK(width, shift)		(PMASK(width) << (shift))
> +#define CLRPMASK(width, shift)		(~(SETPMASK(width, shift)))
> +

We have GENMASK for these sorts of things, please use it.

> +#define PARM_GET(width, shift, reg)					\
> +	(((reg) & SETPMASK(width, shift)) >> (shift))
> +#define PARM_SET(width, shift, reg, val)				\
> +	(((reg) & CLRPMASK(width, shift)) | (val << (shift)))
> +
> +#define MESON_PARM_APPLICABLE(p)		(!!((p)->width))
> +
> +struct parm {
> +	u16	reg_off;
> +	u8	shift;
> +	u8	width;
> +};
> +#define PARM(_r, _s, _w)						\
> +	{								\
> +		.reg_off	= (_r),					\
> +		.shift		= (_s),					\
> +		.width		= (_w),					\
> +	}								\
> +
> +struct pll_rate_table {
> +	unsigned long	rate;
> +	u16		m;
> +	u16		n;
> +	u16		od;
> +};
> +#define PLL_RATE(_r, _m, _n, _od)					\
> +	{								\
> +		.rate		= (_r),					\
> +		.m		= (_m),					\
> +		.n		= (_n),					\
> +		.od		= (_od),				\
> +	}								\
> +
> +struct pll_conf {
> +	struct pll_rate_table	*rate_table;
> +	struct parm		m;
> +	struct parm		n;
> +	struct parm		od;
> +};
> +
> +struct fixed_fact_conf {
> +	unsigned int	div;
> +	unsigned int	mult;
> +	struct parm	div_parm;
> +	struct parm	mult_parm;
> +};
> +
> +struct fixed_rate_conf {
> +	unsigned long	rate;
> +	struct parm	rate_parm;
> +};
> +
> +struct composite_conf {
> +	struct parm		mux_parm;
> +	struct parm		div_parm;
> +	struct parm		gate_parm;
> +	struct clk_div_table	*div_table;
> +	u32			*mux_table;
> +	u8			mux_flags;
> +	u8			div_flags;
> +	u8			gate_flags;
> +};
> +
> +#define PNAME(x) static const char *x[] __initconst

Is this used?

> +
> +enum clk_type {
> +	clk_fixed_factor,
> +	clk_fixed_rate,
> +	clk_composite,
> +	clk_cpu,
> +	clk_pll,
> +};

Please use upper case for enums

> +
> +struct clk_conf {
> +	u16				reg_off;
> +	enum clk_type			clk_type;
> +	unsigned int			clk_id;
> +	const char			*clk_name;
> +	const char			**clks_parent;
> +	int				num_parents;
> +	unsigned long			flags;
> +	union {
> +		struct fixed_fact_conf	fixed_fact;
> +		struct fixed_rate_conf	fixed_rate;
> +		struct composite_conf	*composite;
> +		struct pll_conf		*pll;
> +	} conf;
> +};
> +
> +#define FIXED_RATE_P(_ro, _ci, _cn, _f, _c)				\
> +	{								\
> +		.reg_off			= (_ro),		\
> +		.clk_type			= clk_fixed_rate,	\
> +		.clk_id				= (_ci),		\
> +		.clk_name			= (_cn),		\
> +		.flags				= (_f),			\
> +		.conf.fixed_rate.rate_parm	= _c,			\
> +	}								\
> +
> +#define FIXED_RATE(_ci, _cn, _f, _r)					\
> +	{								\
> +		.clk_type			= clk_fixed_rate,	\
> +		.clk_id				= (_ci),		\
> +		.clk_name			= (_cn),		\
> +		.flags				= (_f),			\
> +		.conf.fixed_rate.rate		= (_r),			\
> +	}								\
> +
> +#define PLL(_ro, _ci, _cn, _cp, _f, _c)					\
> +	{								\
> +		.reg_off			= (_ro),		\
> +		.clk_type			= clk_pll,		\
> +		.clk_id				= (_ci),		\
> +		.clk_name			= (_cn),		\
> +		.clks_parent			= (_cp),		\
> +		.num_parents			= ARRAY_SIZE(_cp),	\
> +		.flags				= (_f),			\
> +		.conf.pll			= (_c),			\
> +	}								\
> +
> +#define FIXED_FACTOR_DIV(_ci, _cn, _cp, _f, _d)				\
> +	{								\
> +		.clk_type			= clk_fixed_factor,	\
> +		.clk_id				= (_ci),		\
> +		.clk_name			= (_cn),		\
> +		.clks_parent			= (_cp),		\
> +		.num_parents			= ARRAY_SIZE(_cp),	\
> +		.conf.fixed_fact.div		= (_d),			\
> +	}								\
> +
> +#define CPU(_ro, _ci, _cn, _cp)						\
> +	{								\
> +		.reg_off			= (_ro),		\
> +		.clk_type			= clk_cpu,		\
> +		.clk_id				= (_ci),		\
> +		.clk_name			= (_cn),		\
> +		.clks_parent			= (_cp),		\
> +		.num_parents			= ARRAY_SIZE(_cp),	\
> +	}								\
> +
> +#define COMPOSITE(_ro, _ci, _cn, _cp, _f, _c)				\
> +	{								\
> +		.reg_off			= (_ro),		\
> +		.clk_type			= clk_composite,	\
> +		.clk_id				= (_ci),		\
> +		.clk_name			= (_cn),		\
> +		.clks_parent			= (_cp),		\
> +		.num_parents			= ARRAY_SIZE(_cp),	\
> +		.flags				= (_f),			\
> +		.conf.composite			= (_c),			\
> +	}								\

I couldn't find any usage of these defines. If they're used later
in the series, please add them when they're used.

> +
> +
> +#endif /* __CLKC_H */
> diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
> new file mode 100644
> index 0000000..9986c38
> --- /dev/null
> +++ b/include/dt-bindings/clock/meson8b-clkc.h
> @@ -0,0 +1,20 @@
> +/*
> + * Meson8b clock tree IDs
> + */

Does this need an ifdef guard?

> +
> +#define CLKID_UNUSED		0
> +#define CLKID_XTAL		1
> +#define CLKID_PLL_FIXED		2
> +#define CLKID_PLL_VID		3
> +#define CLKID_PLL_SYS		4
> +#define CLKID_FCLK_DIV2		5
> +#define CLKID_FCLK_DIV3		6
> +#define CLKID_FCLK_DIV4		7
> +#define CLKID_FCLK_DIV5		8
> +#define CLKID_FCLK_DIV7		9
> +#define CLKID_CLK81		10
> +#define CLKID_MALI		11
> +#define CLKID_CPUCLK		12
> +#define CLKID_ZERO		13
> +
> +#define CLK_NR_CLKS		(CLKID_ZERO + 1)
> -- 
> 1.9.1
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
