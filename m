From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jun 2016 22:45:02 +0200
Subject: [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <a55dc5d1a9f02dc4d71d5c21064bffebe5a7b149.1467135898.git.moinejf@free.fr>
References: <cover.1467135898.git.moinejf@free.fr>
 <a55dc5d1a9f02dc4d71d5c21064bffebe5a7b149.1467135898.git.moinejf@free.fr>
Message-ID: <20160628204502.GG5550@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 05:37:35PM +0200, Jean-Francois Moine wrote:
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

Like I already said, this is a no-go.

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

So. In order to move away from an unmaintainable mess, we create a new
unmaintainable mess? Looks like the way to go.

> +const struct clk_ops ccu_pll_ops = {
> +	.prepare	= ccu_prepare,
> +	.unprepare	= ccu_unprepare,
> +	.enable		= ccu_enable,
> +	.disable	= ccu_disable,
> +/*	.is_enabled	= NULL;	(don't disable the clocks at startup time) */

Why?

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

Sooo, basically my code.

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

That needs synchronisation with the MMC driver. How are you dealing
with this?

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

ungating means enable, and this is already dealt with by the core.

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

This is redundant with the core.

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

You have tracepoints for that.

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

What's the point of this, if we're not using (or exposing for that
matter) any of it?

I'm sorry, but the whole point of the initial serie was to rework and
simplify things, precisely because dealing with the clk_factors code
was just too difficult nowadays. And this doesn't solve anything on
that aspect.

We came with an approach that have all the maintainers involved
agreeing on it, I don't see why we should start over. There's some
useful features there (like tracing). But it's something that can be
added, and should be done differently anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/7cc33781/attachment.sig>
