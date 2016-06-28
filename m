From: megi@xff.cz (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Tue, 28 Jun 2016 21:31:06 +0200
Subject: [linux-sunxi] [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <bfb8ceb4-5445-3f43-0a16-bd0e83f2af22@xff.cz>
References: <bfb8ceb4-5445-3f43-0a16-bd0e83f2af22@xff.cz>
Message-ID: <536aa072-d110-1b08-fa25-72c1645e2459@xff.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28.6.2016 17:37, Jean-Francois Moine wrote:
> Most of the clocks in the Allwinner's SoCs are configured in the CCU
> (Clock Configuration Unit).
> 
> The PLL clocks are driven from the main clock. Their rates are controlled
> by a set of multiply and divide factors, named from the Allwinner's
> documentation:
> - multipliers: 'n' and 'k'
> - dividers: 'd1', 'd2', 'm' and 'p'
> 
> The peripheral clocks may receive their inputs from one or more parents,
> thanks to a mux. Their rates are controlled by a set of divide factors
> only, named 'm' and 'p'.
> 
> This driver also handles:
> - fixed clocks,
> - the phase delays for the MMCs,
> - the clock gates,
> - the bus gates,
> - and the resets.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/clk/sunxi/Makefile |   2 +
>  drivers/clk/sunxi/ccu.c    | 980 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi/ccu.h    | 153 +++++++
>  3 files changed, 1135 insertions(+)
>  create mode 100644 drivers/clk/sunxi/ccu.c
>  create mode 100644 drivers/clk/sunxi/ccu.h
> 
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index 39d2044..b8ca3e2 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -26,3 +26,5 @@ obj-$(CONFIG_MACH_SUN9I) += clk-sun9i-cpus.o
>  obj-$(CONFIG_MFD_SUN6I_PRCM) += \
>  	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
>  	clk-sun8i-apb0.o
> +
> +obj-y += ccu.o
> diff --git a/drivers/clk/sunxi/ccu.c b/drivers/clk/sunxi/ccu.c
> new file mode 100644
> index 0000000..5749f9c
> --- /dev/null
> +++ b/drivers/clk/sunxi/ccu.c
> @@ -0,0 +1,980 @@
> +/*
> + * Allwinner system CCU
> + *
> + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> + * Rewrite from 'sunxi-ng':
> + * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/reset-controller.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/rational.h>
> +#include <linux/of_address.h>
> +
> +#include "ccu.h"
> +
> +#define CCU_DEBUG 0
> +
> +#define CCU_MASK(shift, width) (((1 << width) - 1) << shift)
> +

You may use macros from:

http://lxr.free-electrons.com/source/include/linux/bitops.h

At least as a basis for the CCU_MASK macro.

> +/*
> + * factors:
> + *	n: multiplier (PLL)
> + *	d1, d2: boolean dividers by 2 (d2 is p with 1 bit width - PLL)
> + *	k: multiplier (PLL)
> + *	m: divider
> + *	p: divider by power of 2
> + */
> +struct values {
> +	int n, d1, k, m, p;
> +};
> +
> +static DEFINE_SPINLOCK(ccu_lock);
> +
> +void ccu_set_clock(struct ccu *ccu, int reg, u32 mask, u32 val)
> +{
> +
> +#if CCU_DEBUG
> +	pr_info("** ccu %s set %03x %08x\n",
> +		clk_hw_get_name(&ccu->hw), reg,
> +		(readl(ccu->base + reg) & ~mask) | val);
> +#endif
> +	spin_lock(&ccu_lock);
> +	writel((readl(ccu->base + reg) & ~mask) | val, ccu->base + reg);
> +	spin_unlock(&ccu_lock);
> +}
> +
> +/* --- prepare / enable --- */
> +int ccu_prepare(struct clk_hw *hw)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	if (!ccu->reset_reg && !ccu->bus_reg)
> +		return 0;
> +
> +#if CCU_DEBUG
> +	pr_info("** ccu %s prepare\n", clk_hw_get_name(&ccu->hw));
> +#endif
> +	spin_lock(&ccu_lock);
> +	if (ccu->reset_reg)
> +		writel(readl(ccu->base + ccu->reset_reg) |
> +							BIT(ccu->reset_bit),
> +				ccu->base + ccu->reset_reg);
> +	if (ccu->bus_reg)
> +		writel(readl(ccu->base + ccu->bus_reg) | BIT(ccu->bus_bit),
> +				ccu->base + ccu->bus_reg);
> +	spin_unlock(&ccu_lock);
> +
> +	return 0;
> +}
> +
> +void ccu_unprepare(struct clk_hw *hw)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	if (!ccu->reset_reg && !ccu->bus_reg)
> +		return;
> +
> +#if CCU_DEBUG
> +	pr_info("** ccu %s unprepare\n", clk_hw_get_name(&ccu->hw));
> +#endif
> +	spin_lock(&ccu_lock);
> +	if (ccu->bus_reg)
> +		writel(readl(ccu->base + ccu->bus_reg) & ~BIT(ccu->bus_bit),
> +				ccu->base + ccu->bus_reg);
> +	if (ccu->reset_reg)
> +		writel(readl(ccu->base + ccu->reset_reg) &
> +							~BIT(ccu->reset_bit),
> +				ccu->base + ccu->reset_reg);
> +	spin_unlock(&ccu_lock);
> +}
> +
> +int ccu_enable(struct clk_hw *hw)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	if (!ccu->has_gate)
> +		return 0;
> +
> +#if CCU_DEBUG
> +	pr_info("** ccu %s enable\n", clk_hw_get_name(&ccu->hw));
> +#endif
> +	spin_lock(&ccu_lock);
> +	writel(readl(ccu->base + ccu->reg) | BIT(ccu->gate_bit),
> +				ccu->base + ccu->reg);
> +	spin_unlock(&ccu_lock);
> +
> +	return 0;
> +}
> +
> +void ccu_disable(struct clk_hw *hw)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	if (!ccu->has_gate)
> +		return;
> +
> +#if CCU_DEBUG
> +	pr_info("** ccu %s disable\n", clk_hw_get_name(&ccu->hw));
> +#endif
> +	spin_lock(&ccu_lock);
> +	writel(readl(ccu->base + ccu->reg) & ~BIT(ccu->gate_bit),
> +				ccu->base + ccu->reg);
> +	spin_unlock(&ccu_lock);
> +}
> +
> +/* --- PLL --- */
> +static int ccu_pll_find_best(struct ccu *ccu,
> +				unsigned long rate,
> +				unsigned long parent_rate,
> +				struct values *p_v)
> +{
> +	int max_mul, max_div, mul, div, t;
> +	int n = 1, d1 = 1, k = 1, m = 1, p = 0;
> +	int max_n = 1 << ccu->n_width;
> +	int max_d1 = 1 << ccu->d1_width;
> +	int max_k = 1 << ccu->k_width;
> +	int max_m = 1 << ccu->m_width;
> +	int max_p = 1 << ccu->p_width;
> +
> +	if (ccu->features & CCU_FEATURE_N0)
> +		max_n--;
> +
> +	/* compute n */
> +	if (max_n > 1) {
> +		max_mul = max_n * max_k;
> +		if (rate > parent_rate * max_mul) {
> +			pr_err("%s: Clock rate too high %ld > %ld * %d * %d\n",
> +				clk_hw_get_name(&ccu->hw),
> +				rate, parent_rate, max_n, max_k);
> +			return -EINVAL;
> +		}
> +		max_div = max_m * max_d1 << max_p;
> +		if (max_div > 1) {
> +			unsigned long lmul, ldiv;
> +
> +			rational_best_approximation(rate, parent_rate,
> +						max_mul - 1,
> +						max_div - 1,
> +						&lmul, &ldiv);
> +			mul = lmul;
> +			div = ldiv;
> +			if (ccu->n_min && mul < ccu->n_min) {
> +				t = (ccu->n_min + mul - 1) / mul;
> +				mul *= t;
> +				div *= t;
> +			}
> +		} else {
> +			mul = (rate + parent_rate - 1) / parent_rate;
> +			div = 1;
> +		}
> +
> +		/* compute k (present only when 'n' is present) */
> +		if (max_k > 1) {
> +			int k_min, k_opt, delta_opt = 100, delta;
> +
> +			k = (mul + max_n - 1) / max_n;
> +			k_opt = k_min = k;
> +			for (k = max_k; k > k_min; k--) {
> +				n = (mul + k - 1) / k;
> +				t = n * k;
> +				delta = t - mul;
> +				if (delta == 0) {
> +					k_opt = k;
> +					break;
> +				}
> +				if (delta < 0)
> +					delta = -delta;
> +				if (delta < delta_opt) {
> +					delta_opt = delta;
> +					k_opt = k;
> +				}
> +			}
> +			k = k_opt;
> +			n = (mul + k - 1) / k;
> +		} else {
> +			n = mul;
> +		}
> +	} else {
> +		div = (parent_rate + rate - 1) / rate;
> +	}
> +
> +	/* compute d1 (value is only 1 or 2) */
> +	if (max_d1 > 1) {
> +		if (div % 2 == 0) {
> +			d1 = 2;
> +			div /= 2;
> +		}
> +	}
> +
> +	/* compute p */
> +/*	p = 0; */
> +	while (div % 2 == 0 && p <= max_p) {
> +		p++;
> +		div /= 2;
> +	}
> +
> +	/* compute m */
> +	if (max_m > 1) {
> +		if (div <= max_m)
> +			m = div;
> +		else
> +			m = max_m;
> +		div /= m;
> +	}
> +
> +	/* adjust n */
> +	n = DIV_ROUND_CLOSEST((rate << p) * m * d1, parent_rate);
> +	n = DIV_ROUND_CLOSEST(n, k);
> +
> +	p_v->n = n;
> +	p_v->d1 = d1;
> +	p_v->k = k;
> +	p_v->m = m;
> +	p_v->p = p;
> +
> +	return 0;
> +}
> +
> +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	const struct ccu_extra *extra = ccu->extra;
> +	unsigned long rate;
> +	int i, n, d1, m, k, p;
> +	u32 reg;
> +
> +	reg = readl(ccu->base + ccu->reg);
> +
> +	if (extra) {
> +		for (i = 0; i < extra->num_frac - 1; i++) {
> +			if ((reg & extra->frac[i].mask) == extra->frac[i].val)
> +				return rate = extra->frac[i].rate;
> +		}
> +	}
> +
> +	rate = parent_rate;
> +
> +	if (ccu->d1_width) {
> +		d1 = reg >> ccu->d1_shift;
> +		d1 &= (1 << ccu->d1_width) - 1;
> +		rate /= (d1 + 1);
> +	}
> +
> +	if (ccu->n_width) {
> +		n = reg >> ccu->n_shift;
> +		n &= (1 << ccu->n_width) - 1;
> +		if (!(ccu->features & CCU_FEATURE_N0))
> +			n++;
> +		rate *= n;
> +	}
> +
> +	if (ccu->m_width) {
> +		m = reg >> ccu->m_shift;
> +		m &= (1 << ccu->m_width) - 1;
> +		rate /= (m + 1);
> +	}
> +
> +	if (ccu->k_width) {
> +		k = reg >> ccu->k_shift;
> +		k &= (1 << ccu->k_width) - 1;
> +		rate *= (k + 1);
> +	}
> +
> +	if (ccu->p_width) {
> +		p = reg >> ccu->p_shift;
> +		p &= (1 << ccu->p_width) - 1;
> +		rate >>= p;
> +	}
> +
> +	if (extra && (ccu->features & CCU_FEATURE_FIXED_POSTDIV))
> +		rate /= extra->fixed_div[0];
> +
> +	return rate;
> +}
> +
> +static long ccu_pll_round_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	const struct ccu_extra *extra = ccu->extra;
> +	struct values v;
> +	int i, ret;
> +
> +	if (extra) {
> +		for (i = 0; i < extra->num_frac - 1; i++) {
> +			if (extra->frac[i].rate == rate)
> +				return rate;
> +		}
> +
> +		if (ccu->features & CCU_FEATURE_FIXED_POSTDIV)
> +			rate *= extra->fixed_div[0];
> +	}
> +
> +	ret = ccu_pll_find_best(ccu, rate, *parent_rate, &v);
> +	if (ret)
> +		return ret;
> +
> +	rate = *parent_rate / v.d1 * v.n / v.m * v.k >> v.p;
> +
> +	if (extra && (ccu->features & CCU_FEATURE_FIXED_POSTDIV))
> +		rate /= extra->fixed_div[0];
> +
> +	return rate;
> +}
> +
> +static void ccu_pll_set_flat_factors(struct ccu *ccu, u32 mask, u32 val)
> +{
> +	u32 reg, m_val, p_val;
> +	u32 m_mask = (1 << ccu->m_width) - 1;
> +	u32 p_mask = (1 << ccu->p_width) - 1;

I see you have shifted the factor values to be set in the caller of this
function, but then you have to shift masks too, to match. It might be
clearer to do both shifts in this function.

> +	reg = readl(ccu->base + ccu->reg);
> +	m_val = reg & m_mask;
> +	p_val = reg & p_mask;
> +
> +	spin_lock(&ccu_lock);
> +
> +	/* increase p, then m */
> +	if (ccu->p_width && p_val < (val & p_mask)) {
> +		reg &= ~p_mask;
> +		reg |= val & p_mask;
> +		writel(reg, ccu->base + ccu->reg);
> +		udelay(10);
> +	}
> +	if (ccu->m_width && m_val < (val & m_mask)) {
> +		reg &= ~m_mask;
> +		reg |= val & m_mask;
> +		writel(reg, ccu->base + ccu->reg);
> +		udelay(10);
> +	}
> +
> +	/* set other factors */
> +	reg &= ~(mask & ~(p_mask | m_mask));
> +	reg |= val & ~(p_mask | m_mask);
> +	writel(reg, ccu->base + ccu->reg);
> +
> +	/* decrease m */
> +	if (ccu->m_width && m_val > (val & m_mask)) {
> +		reg &= ~m_mask;
> +		reg |= val & m_mask;
> +		writel(reg, ccu->base + ccu->reg);
> +		udelay(10);
> +	}
> +
> +	/* wait for PLL stable */
> +	if (ccu->lock_reg) {
> +		u32 lock;
> +
> +		lock = BIT(ccu->lock_bit);
> +		WARN_ON(readl_relaxed_poll_timeout(ccu->base + ccu->lock_reg,
> +							reg, !(reg & lock),
> +							100, 70000));
> +	}

Any reason why you're waiting for the lock after decreasing m and not
before? PLL output may till run too fast before reducing the postdivider
potentially causing a crash. But I might be misunderstanding what m is
exactly.

regards,
  Ondrej Jirman

> +	/* decrease p */
> +	if (ccu->p_width && p_val > (val & p_mask)) {
> +		reg &= ~p_mask;
> +		reg |= val & p_mask;
> +		writel(reg, ccu->base + ccu->reg);
> +		udelay(10);
> +	}
> +
> +	spin_unlock(&ccu_lock);
> +}
> +
> +static int ccu_pll_set_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	const struct ccu_extra *extra = ccu->extra;
> +	struct values v;
> +	u32 mask, val;
> +	int ret;
> +
> +	mask =  CCU_MASK(ccu->n_shift, ccu->n_width) |
> +		CCU_MASK(ccu->d1_shift, ccu->d1_width) |
> +		CCU_MASK(ccu->k_shift, ccu->k_width) |
> +		CCU_MASK(ccu->m_shift, ccu->m_width) |
> +		CCU_MASK(ccu->p_shift, ccu->p_width);
> +	val = 0;
> +
> +	if (extra && extra->num_frac) {
> +		int i;
> +
> +		for (i = 0; i < extra->num_frac - 1; i++) {
> +			if (extra->frac[i].rate == rate) {
> +				ccu_set_clock(ccu, ccu->reg,
> +						extra->frac[i].mask,
> +						extra->frac[i].val);
> +				return 0;
> +			}
> +		}
> +		mask |= extra->frac[i].mask;
> +		val |= extra->frac[i].val;
> +	}
> +
> +	if (extra && (ccu->features & CCU_FEATURE_FIXED_POSTDIV))
> +		rate *= extra->fixed_div[0];
> +
> +
> +	ret = ccu_pll_find_best(ccu, rate, parent_rate, &v);
> +	if (ret)
> +		return ret;
> +
> +	if (!(ccu->features & CCU_FEATURE_N0))
> +		v.n--;
> +
> +	val |=  (v.n << ccu->n_shift) |
> +		((v.d1 - 1) << ccu->d1_shift) |
> +		((v.k - 1) << ccu->k_shift) |
> +		((v.m - 1) << ccu->m_shift) |
> +		(v.p << ccu->p_shift);
> +
> +	if (ccu->upd_bit)				/* cannot be 0 */
> +		val |= BIT(ccu->upd_bit);
> +
> +	if (!(ccu->features & CCU_FEATURE_FLAT_FACTORS))
> +		ccu_set_clock(ccu, ccu->reg, mask, val);
> +	else
> +		ccu_pll_set_flat_factors(ccu, mask, val);
> +
> +	/* wait for PLL stable */
> +	if (ccu->lock_reg) {
> +		u32 lock, reg;
> +
> +		lock = BIT(ccu->lock_bit);
> +		WARN_ON(readl_relaxed_poll_timeout(ccu->base + ccu->lock_reg,
> +							reg, !(reg & lock),
> +							100, 70000));
> +	}
> +
> +	return 0;
> +}
> +
> +const struct clk_ops ccu_pll_ops = {
> +	.prepare	= ccu_prepare,
> +	.unprepare	= ccu_unprepare,
> +	.enable		= ccu_enable,
> +	.disable	= ccu_disable,
> +/*	.is_enabled	= NULL;	(don't disable the clocks at startup time) */
> +
> +	.recalc_rate	= ccu_pll_recalc_rate,
> +	.round_rate	= ccu_pll_round_rate,
> +	.set_rate	= ccu_pll_set_rate,
> +};
> +
> +/* --- mux parent --- */
> +u8 ccu_get_parent(struct clk_hw *hw)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	if (!ccu->mux_width)
> +		return 0;
> +
> +	return (readl(ccu->base + ccu->reg) >> ccu->mux_shift) &
> +				((1 << ccu->mux_width) - 1);
> +}
> +
> +int ccu_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	u32 mask;
> +
> +	if (!ccu->mux_width)
> +		return 0;
> +
> +	mask = CCU_MASK(ccu->mux_shift, ccu->mux_width);
> +
> +	ccu_set_clock(ccu, ccu->reg, mask, index << ccu->mux_shift);
> +
> +	return 0;
> +}
> +
> +/* --- mux --- */
> +static void ccu_mux_adjust_parent_for_prediv(struct ccu *ccu,
> +					     int parent_index,
> +					     unsigned long *parent_rate)
> +{
> +	const struct ccu_extra *extra = ccu->extra;
> +	int prediv = 1;
> +	u32 reg;
> +
> +	if (!(extra &&
> +	      (ccu->features & (CCU_FEATURE_MUX_FIXED_PREDIV |
> +				CCU_FEATURE_MUX_VARIABLE_PREDIV))))
> +		return;
> +
> +	reg = readl(ccu->base + ccu->reg);
> +	if (parent_index < 0)
> +		parent_index = (reg >> ccu->mux_shift) &
> +					((1 << ccu->mux_width) - 1);
> +
> +	if (ccu->features & CCU_FEATURE_MUX_FIXED_PREDIV)
> +		prediv = extra->fixed_div[parent_index];
> +
> +	if (ccu->features & CCU_FEATURE_MUX_VARIABLE_PREDIV)
> +		if (parent_index == extra->variable_prediv.index) {
> +			u8 div;
> +
> +			div = reg >> extra->variable_prediv.shift;
> +			div &= (1 << extra->variable_prediv.width) - 1;
> +			prediv = div + 1;
> +		}
> +
> +	*parent_rate /= prediv;
> +}
> +
> +/* --- periph --- */
> +static unsigned long ccu_m_round_rate(struct ccu *ccu,
> +					unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	int m;
> +
> +	/*
> +	 * We can't use divider_round_rate that assumes that there's
> +	 * several parents, while we might be called to evaluate
> +	 * several different parents.
> +	 */
> +	m = divider_get_val(rate, parent_rate,
> +			ccu->div_table, ccu->m_width, ccu->div_flags);
> +
> +	return divider_recalc_rate(&ccu->hw, parent_rate, m,
> +				   ccu->div_table, ccu->div_flags);
> +}
> +
> +static unsigned long ccu_mp_round_rate(struct ccu *ccu,
> +				unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct values v;
> +	int ret;
> +
> +	ret = ccu_pll_find_best(ccu, rate, parent_rate, &v);
> +	if (ret)
> +		return 0;
> +
> +	return parent_rate / v.m >> v.p;
> +}
> +
> +unsigned long ccu_periph_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	int m, p;
> +	u32 reg;
> +
> +	ccu_mux_adjust_parent_for_prediv(ccu, -1, &parent_rate);
> +
> +	if (!ccu->m_width && !ccu->p_width)
> +		return parent_rate;
> +
> +	reg = readl(ccu->base + ccu->reg);
> +	m = (reg >> ccu->m_shift) & ((1 << ccu->m_width) - 1);
> +
> +	if (ccu->p_width) {
> +		reg = readl(ccu->base + ccu->reg);
> +		p = (reg >> ccu->p_shift) & ((1 << ccu->p_width) - 1);
> +
> +		return parent_rate / (m + 1) >> p;
> +	}
> +
> +	return divider_recalc_rate(hw, parent_rate, m,
> +				ccu->div_table, ccu->div_flags);
> +}
> +
> +int ccu_periph_determine_rate(struct clk_hw *hw,
> +				struct clk_rate_request *req)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	unsigned long best_parent_rate = 0, best_rate = 0;
> +	struct clk_hw *best_parent;
> +	unsigned int i;
> +	unsigned long (*round)(struct ccu *,
> +				unsigned long,
> +				unsigned long);
> +
> +	if (ccu->p_width)
> +		round = ccu_mp_round_rate;
> +	else if (ccu->m_width)
> +		round = ccu_m_round_rate;
> +	else
> +		return __clk_mux_determine_rate(hw, req);
> +
> +	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> +		unsigned long new_rate, parent_rate;
> +		struct clk_hw *parent;
> +
> +		parent = clk_hw_get_parent_by_index(hw, i);
> +		if (!parent)
> +			continue;
> +
> +		parent_rate = clk_hw_get_rate(parent);
> +		ccu_mux_adjust_parent_for_prediv(ccu, i, &parent_rate);
> +		new_rate = round(ccu, req->rate, parent_rate);
> +
> +		if (new_rate == req->rate) {
> +			best_parent = parent;
> +			best_parent_rate = parent_rate;
> +			best_rate = new_rate;
> +			goto out;
> +		}
> +
> +		if ((req->rate - new_rate) < (req->rate - best_rate)) {
> +			best_rate = new_rate;
> +			best_parent_rate = parent_rate;
> +			best_parent = parent;
> +		}
> +	}
> +
> +	if (best_rate == 0)
> +		return -EINVAL;
> +
> +out:
> +	req->best_parent_hw = best_parent;
> +	req->best_parent_rate = best_parent_rate;
> +	req->rate = best_rate;
> +
> +	return 0;
> +}
> +
> +int ccu_periph_set_rate(struct clk_hw *hw, unsigned long rate,
> +			unsigned long parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	const struct ccu_extra *extra = ccu->extra;
> +	struct values v;
> +	u32 mask;
> +	int ret;
> +
> +	if (!ccu->m_width && !ccu->p_width)
> +		return 0;
> +
> +	ccu_mux_adjust_parent_for_prediv(ccu, -1, &parent_rate);
> +
> +	if (extra && (ccu->features & CCU_FEATURE_MODE_SELECT)) {
> +		/* fixme: should use new mode */
> +		if (rate == extra->mode_select.rate)
> +			rate /= 2;
> +	}
> +
> +	if (ccu->p_width) {				/* m and p */
> +		ret = ccu_pll_find_best(ccu, rate, parent_rate, &v);
> +		if (ret)
> +			return ret;
> +	} else {					/* m alone */
> +		v.m = divider_get_val(rate, parent_rate,
> +				ccu->div_table, ccu->m_width, ccu->div_flags);
> +		v.p = 0;
> +		return 0;
> +	}
> +
> +	mask = CCU_MASK(ccu->m_shift, ccu->m_width) |
> +		CCU_MASK(ccu->p_shift, ccu->p_width);
> +
> +	if (ccu->features & CCU_FEATURE_SET_RATE_UNGATE)
> +		ccu_disable(hw);
> +	ccu_set_clock(ccu, ccu->reg, mask, ((v.m - 1) << ccu->m_shift) |
> +					    (v.p << ccu->p_shift));
> +	if (ccu->features & CCU_FEATURE_SET_RATE_UNGATE)
> +		ccu_enable(hw);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops ccu_periph_ops = {
> +	.prepare	= ccu_prepare,
> +	.unprepare	= ccu_unprepare,
> +	.enable		= ccu_enable,
> +	.disable	= ccu_disable,
> +/*	.is_enabled	= NULL;	(don't disable the clocks at startup time) */
> +
> +	.get_parent	= ccu_get_parent,
> +	.set_parent	= ccu_set_parent,
> +
> +	.determine_rate	= ccu_periph_determine_rate,
> +	.recalc_rate	= ccu_periph_recalc_rate,
> +	.set_rate	= ccu_periph_set_rate,
> +};
> +
> +/* --- fixed factor --- */
> +/* mul is n_width - div is m_width */
> +unsigned long ccu_fixed_factor_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	return parent_rate / ccu->m_width * ccu->n_width;
> +}
> +
> +long ccu_fixed_factor_round_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +
> +	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
> +		unsigned long best_parent;
> +
> +		best_parent = (rate / ccu->n_width) * ccu->m_width;
> +		*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
> +						 best_parent);
> +	}
> +
> +	return *parent_rate / ccu->m_width * ccu->n_width;
> +}
> +
> +int ccu_fixed_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long parent_rate)
> +{
> +	return 0;
> +}
> +
> +const struct clk_ops ccu_fixed_factor_ops = {
> +	.disable	= ccu_disable,
> +	.enable		= ccu_enable,
> +/*	.is_enabled	= NULL, */
> +
> +	.recalc_rate	= ccu_fixed_factor_recalc_rate,
> +	.round_rate	= ccu_fixed_factor_round_rate,
> +	.set_rate	= ccu_fixed_factor_set_rate,
> +};
> +
> +/* --- phase --- */
> +static int ccu_phase_get_phase(struct clk_hw *hw)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	struct clk_hw *parent, *grandparent;
> +	unsigned int parent_rate, grandparent_rate;
> +	u16 step, parent_div;
> +	u32 reg;
> +	u8 delay;
> +
> +	reg = readl(ccu->base + ccu->reg);
> +	delay = (reg >> ccu->p_shift);
> +	delay &= (1 << ccu->p_width) - 1;
> +
> +	if (!delay)
> +		return 180;
> +
> +	/* Get our parent clock, it's the one that can adjust its rate */
> +	parent = clk_hw_get_parent(hw);
> +	if (!parent)
> +		return -EINVAL;
> +
> +	/* And its rate */
> +	parent_rate = clk_hw_get_rate(parent);
> +	if (!parent_rate)
> +		return -EINVAL;
> +
> +	/* Now, get our parent's parent (most likely some PLL) */
> +	grandparent = clk_hw_get_parent(parent);
> +	if (!grandparent)
> +		return -EINVAL;
> +
> +	/* And its rate */
> +	grandparent_rate = clk_hw_get_rate(grandparent);
> +	if (!grandparent_rate)
> +		return -EINVAL;
> +
> +	/* Get our parent clock divider */
> +	parent_div = grandparent_rate / parent_rate;
> +
> +	step = DIV_ROUND_CLOSEST(360, parent_div);
> +	return delay * step;
> +}
> +
> +static int ccu_phase_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct ccu *ccu = hw2ccu(hw);
> +	struct clk_hw *parent, *grandparent;
> +	unsigned int parent_rate, grandparent_rate;
> +	u32 mask;
> +	u8 delay = 0;
> +	u16 step, parent_div;
> +
> +	if (degrees == 180)
> +		goto set_phase;
> +
> +	/* Get our parent clock, it's the one that can adjust its rate */
> +	parent = clk_hw_get_parent(hw);
> +	if (!parent)
> +		return -EINVAL;
> +
> +	/* And its rate */
> +	parent_rate = clk_hw_get_rate(parent);
> +	if (!parent_rate)
> +		return -EINVAL;
> +
> +	/* Now, get our parent's parent (most likely some PLL) */
> +	grandparent = clk_hw_get_parent(parent);
> +	if (!grandparent)
> +		return -EINVAL;
> +
> +	/* And its rate */
> +	grandparent_rate = clk_hw_get_rate(grandparent);
> +	if (!grandparent_rate)
> +		return -EINVAL;
> +
> +	/* Get our parent divider */
> +	parent_div = grandparent_rate / parent_rate;
> +
> +	/*
> +	 * We can only outphase the clocks by multiple of the
> +	 * PLL's period.
> +	 *
> +	 * Since our parent clock is only a divider, and the
> +	 * formula to get the outphasing in degrees is deg =
> +	 * 360 * delta / period
> +	 *
> +	 * If we simplify this formula, we can see that the
> +	 * only thing that we're concerned about is the number
> +	 * of period we want to outphase our clock from, and
> +	 * the divider set by our parent clock.
> +	 */
> +	step = DIV_ROUND_CLOSEST(360, parent_div);
> +	delay = DIV_ROUND_CLOSEST(degrees, step);
> +
> +set_phase:
> +	mask = CCU_MASK(ccu->p_shift, ccu->p_width);
> +	ccu_set_clock(ccu, ccu->reg, mask, delay << ccu->p_shift);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops ccu_phase_ops = {
> +	.get_phase	= ccu_phase_get_phase,
> +	.set_phase	= ccu_phase_set_phase,
> +};
> +
> +/* --- reset --- */
> +static inline
> +struct ccu_reset *rcdev_to_ccu_reset(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct ccu_reset, rcdev);
> +}
> +
> +static void ccu_set_reset_clock(struct ccu_reset *ccu_reset,
> +				int reg, int bit, int enable)
> +{
> +	u32 mask;
> +
> +	if (!reg)			/* compatibility */
> +		return;
> +
> +#if CCU_DEBUG
> +	pr_info("** ccu reset %03x %d %sassert\n",
> +		reg, bit, enable ? "de-" : "");
> +#endif
> +	mask = BIT(bit);
> +
> +	spin_lock(&ccu_lock);
> +	if (enable)
> +		writel(readl(ccu_reset->base + reg) | mask,
> +			ccu_reset->base + reg);
> +	else
> +		writel(readl(ccu_reset->base + reg) & ~mask,
> +			ccu_reset->base + reg);
> +	spin_unlock(&ccu_lock);
> +}
> +
> +static int ccu_reset_assert(struct reset_controller_dev *rcdev,
> +			    unsigned long id)
> +{
> +	struct ccu_reset *ccu_reset = rcdev_to_ccu_reset(rcdev);
> +	const struct ccu_reset_map *map = &ccu_reset->reset_map[id];
> +
> +	ccu_set_reset_clock(ccu_reset, map->reg, map->bit, 0);
> +
> +	return 0;
> +}
> +
> +static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct ccu_reset *ccu_reset = rcdev_to_ccu_reset(rcdev);
> +	const struct ccu_reset_map *map = &ccu_reset->reset_map[id];
> +
> +	ccu_set_reset_clock(ccu_reset, map->reg, map->bit, 1);
> +
> +	return 0;
> +}
> +
> +const struct reset_control_ops ccu_reset_ops = {
> +	.assert		= ccu_reset_assert,
> +	.deassert	= ccu_reset_deassert,
> +};
> +
> +/* --- init --- */
> +int __init ccu_probe(struct device_node *node,
> +			struct clk_hw_onecell_data *data,
> +			struct ccu_reset *resets)
> +{
> +	struct clk_hw *hw;
> +	struct ccu *ccu;
> +	void __iomem *reg;
> +	int i, ret;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Clock mapping failed %d\n",
> +			of_node_full_name(node), (int) PTR_ERR(reg));
> +		return PTR_ERR(reg);
> +	}
> +
> +	/* register the clocks */
> +	for (i = 0; i < data->num; i++) {
> +		hw = data->hws[i];
> +#if CCU_DEBUG
> +		if (!hw) {
> +			pr_err("%s: Bad number of clocks %d != %d\n",
> +				of_node_full_name(node),
> +				i + 1, data->num);
> +			data->num = i;
> +			break;
> +		}
> +#endif
> +		ccu = hw2ccu(hw);
> +		ccu->base = reg;
> +		ret = clk_hw_register(NULL, hw);
> +		if (ret < 0) {
> +			pr_err("%s: Register clock %s failed %d\n",
> +				of_node_full_name(node),
> +				clk_hw_get_name(hw), ret);
> +			data->num = i;
> +			break;
> +		}
> +	}
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
> +	if (ret < 0)
> +		goto err;
> +
> +	/* register the resets */
> +	resets->rcdev.of_node = node;
> +	resets->base = reg;
> +
> +	ret = reset_controller_register(&resets->rcdev);
> +	if (ret) {
> +		pr_err("%s: Reset register failed %d\n",
> +			of_node_full_name(node), ret);
> +		goto err;
> +	}
> +
> +	return ret;
> +
> +err:
> +	/* don't do anything, otherwise no uart anymore */
> +	return ret;
> +}
> diff --git a/drivers/clk/sunxi/ccu.h b/drivers/clk/sunxi/ccu.h
> new file mode 100644
> index 0000000..5597681
> --- /dev/null
> +++ b/drivers/clk/sunxi/ccu.h
> @@ -0,0 +1,153 @@
> +/*
> + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef _CCU_H_
> +#define _CCU_H_
> +
> +struct device_node;
> +
> +#define CCU_HW(_name, _parent, _ops, _flags)			\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.flags		= _flags,			\
> +		.name		= _name,			\
> +		.parent_names	= (const char *[]) { _parent },	\
> +		.num_parents	= 1,				\
> +		.ops		= _ops,				\
> +	}
> +
> +#define CCU_HW_PARENTS(_name, _parents, _ops, _flags)		\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.flags		= _flags,			\
> +		.name		= _name,			\
> +		.parent_names	= _parents,			\
> +		.num_parents	= ARRAY_SIZE(_parents),		\
> +		.ops		= _ops,				\
> +	}
> +
> +#define CCU_REG(_reg) .reg = _reg
> +#define CCU_RESET(_reg, _bit) .reset_reg = _reg, .reset_bit = _bit
> +#define CCU_BUS(_reg, _bit) .bus_reg = _reg, .bus_bit = _bit
> +#define CCU_GATE(_bit) .has_gate = 1, .gate_bit = _bit
> +#define CCU_LOCK(_reg, _bit) .lock_reg = _reg, .lock_bit = _bit
> +#define CCU_MUX(_shift, _width) .mux_shift = _shift, .mux_width = _width
> +#define CCU_N(_shift, _width) .n_shift = _shift, .n_width = _width
> +#define CCU_D1(_shift, _width) .d1_shift = _shift, .d1_width = _width
> +#define CCU_D2(_shift, _width) .p_shift = _shift, .p_width = _width
> +#define CCU_K(_shift, _width) .k_shift = _shift, .k_width = _width
> +#define CCU_M(_shift, _width) .m_shift = _shift, .m_width = _width
> +#define CCU_P(_shift, _width) .p_shift = _shift, .p_width = _width
> +#define CCU_UPD(_bit) .upd_bit = _bit
> +/* with ccu_fixed_factor_ops */
> +#define CCU_FIXED(_mul, _div) .n_width = _mul, .m_width = _div
> +/* with ccu_phase_ops */
> +#define CCU_PHASE(_shift, _width) .p_shift = _shift, .p_width = _width
> +
> +#define CCU_FEATURE_FRACTIONAL		BIT(0)
> +#define CCU_FEATURE_MUX_VARIABLE_PREDIV	BIT(1)
> +#define CCU_FEATURE_MUX_FIXED_PREDIV	BIT(2)
> +#define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
> +#define CCU_FEATURE_N0			BIT(4)
> +#define CCU_FEATURE_MODE_SELECT		BIT(5)
> +#define CCU_FEATURE_FLAT_FACTORS	BIT(6)
> +#define CCU_FEATURE_SET_RATE_UNGATE	BIT(7)
> +
> +/* extra */
> +#define CCU_EXTRA_FRAC(_frac) .frac = _frac, .num_frac = ARRAY_SIZE(_frac)
> +#define CCU_EXTRA_POST_DIV(_div) .fixed_div[0] = _div
> +
> +/* fractional values */
> +struct frac {
> +	unsigned long rate;
> +	u32 mask;
> +	u32 val;
> +};
> +
> +/* extra features */
> +struct ccu_extra {
> +	const struct frac *frac; /* array - last is the fractional mask/value */
> +	u8 num_frac;
> +
> +	u8 fixed_div[4];
> +
> +	struct {
> +		u8 index;
> +		u8 shift;
> +		u8 width;
> +	} variable_prediv;
> +
> +	struct {
> +		unsigned long rate;
> +		u8 bit;
> +	} mode_select;
> +};
> +
> +struct ccu {
> +	struct clk_hw	hw;
> +
> +	void __iomem *base;
> +	u16 reg;
> +
> +	u16 reset_reg, bus_reg, lock_reg;
> +	u8  reset_bit, bus_bit, lock_bit;
> +	u8 has_gate, gate_bit;
> +
> +	u8 mux_shift, mux_width;
> +	u8 n_shift, n_width, n_min;
> +	u8 d1_shift, d1_width;
> +	u8 k_shift, k_width;
> +	u8 m_shift, m_width;
> +	u8 p_shift, p_width;
> +
> +	u8 upd_bit;
> +
> +	u8 features;
> +
> +	const struct clk_div_table *div_table;
> +	u32 div_flags;
> +
> +	const struct ccu_extra *extra;
> +};
> +
> +struct ccu_reset_map {
> +	u16	reg;
> +	u16	bit;
> +};
> +
> +struct ccu_reset {
> +	void __iomem			*base;
> +	const struct ccu_reset_map	*reset_map;
> +	struct reset_controller_dev	rcdev;
> +};
> +
> +extern const struct clk_ops ccu_fixed_factor_ops;
> +extern const struct clk_ops ccu_periph_ops;
> +extern const struct clk_ops ccu_pll_ops;
> +extern const struct clk_ops ccu_phase_ops;
> +extern const struct reset_control_ops ccu_reset_ops;
> +
> +static inline struct ccu *hw2ccu(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ccu, hw);
> +}
> +
> +int ccu_probe(struct device_node *node,
> +		struct clk_hw_onecell_data *data,
> +		struct ccu_reset *resets);
> +
> +/* functions exported for specific features */
> +void ccu_set_clock(struct ccu *ccu, int reg, u32 mask, u32 val);
> +unsigned long ccu_fixed_factor_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate);
> +long ccu_fixed_factor_round_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long *parent_rate);
> +int ccu_fixed_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate);
> +
> +#endif /* _CCU_H_ */
> 



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/78183468/attachment-0001.sig>
