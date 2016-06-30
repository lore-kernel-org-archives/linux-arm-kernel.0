From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jun 2016 23:16:35 +0200
Subject: [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <20160629101256.93895e6ff9184efa340f69dd@free.fr>
References: <cover.1467135898.git.moinejf@free.fr>
 <a55dc5d1a9f02dc4d71d5c21064bffebe5a7b149.1467135898.git.moinejf@free.fr>
 <20160628204502.GG5550@lukather>
 <20160629101256.93895e6ff9184efa340f69dd@free.fr>
Message-ID: <20160630211635.GE5485@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 10:12:56AM +0200, Jean-Francois Moine wrote:
> On Tue, 28 Jun 2016 22:45:02 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Tue, Jun 28, 2016 at 05:37:35PM +0200, Jean-Francois Moine wrote:
> > > +/* --- prepare / enable --- */
> > > +int ccu_prepare(struct clk_hw *hw)
> > > +{
> > > +	struct ccu *ccu = hw2ccu(hw);
> > > +
> > > +	if (!ccu->reset_reg && !ccu->bus_reg)
> > > +		return 0;
> > > +
> > > +#if CCU_DEBUG
> > > +	pr_info("** ccu %s prepare\n", clk_hw_get_name(&ccu->hw));
> > > +#endif
> > > +	spin_lock(&ccu_lock);
> > > +	if (ccu->reset_reg)
> > > +		writel(readl(ccu->base + ccu->reset_reg) |
> > > +							BIT(ccu->reset_bit),
> > > +				ccu->base + ccu->reset_reg);
> > > +	if (ccu->bus_reg)
> > > +		writel(readl(ccu->base + ccu->bus_reg) | BIT(ccu->bus_bit),
> > > +				ccu->base + ccu->bus_reg);
> > 
> > Like I already said, this is a no-go.
> 
> I don't see why: prepare/unprepare do the right job.

This is a huge hack.

These clocks and reset lines are doing something different, should and
can be enabled at totally different times, have different behaviour
that is already relied on by the drivers. So we *need* to expose them
as different clocks and reset lines, because they *are* different
clocks and reset lines.

Plus, I'd like to see the behaviour of that clocks when you call
clk_set_rate or clk_set_parent. It's going to be interesting.

> 
> > > +
> > > +/* --- PLL --- */
> > > +static int ccu_pll_find_best(struct ccu *ccu,
> > > +				unsigned long rate,
> > > +				unsigned long parent_rate,
> > > +				struct values *p_v)
> > > +{
> > > +	int max_mul, max_div, mul, div, t;
> > > +	int n = 1, d1 = 1, k = 1, m = 1, p = 0;
> > > +	int max_n = 1 << ccu->n_width;
> > > +	int max_d1 = 1 << ccu->d1_width;
> > > +	int max_k = 1 << ccu->k_width;
> > > +	int max_m = 1 << ccu->m_width;
> > > +	int max_p = 1 << ccu->p_width;
> > > +
> > > +	if (ccu->features & CCU_FEATURE_N0)
> > > +		max_n--;
> > > +
> > > +	/* compute n */
> > > +	if (max_n > 1) {
> > > +		max_mul = max_n * max_k;
> > > +		if (rate > parent_rate * max_mul) {
> > > +			pr_err("%s: Clock rate too high %ld > %ld * %d * %d\n",
> > > +				clk_hw_get_name(&ccu->hw),
> > > +				rate, parent_rate, max_n, max_k);
> > > +			return -EINVAL;
> > > +		}
> > > +		max_div = max_m * max_d1 << max_p;
> > > +		if (max_div > 1) {
> > > +			unsigned long lmul, ldiv;
> > > +
> > > +			rational_best_approximation(rate, parent_rate,
> > > +						max_mul - 1,
> > > +						max_div - 1,
> > > +						&lmul, &ldiv);
> > > +			mul = lmul;
> > > +			div = ldiv;
> > > +			if (ccu->n_min && mul < ccu->n_min) {
> > > +				t = (ccu->n_min + mul - 1) / mul;
> > > +				mul *= t;
> > > +				div *= t;
> > > +			}
> > > +		} else {
> > > +			mul = (rate + parent_rate - 1) / parent_rate;
> > > +			div = 1;
> > > +		}
> > > +
> > > +		/* compute k (present only when 'n' is present) */
> > > +		if (max_k > 1) {
> > > +			int k_min, k_opt, delta_opt = 100, delta;
> > > +
> > > +			k = (mul + max_n - 1) / max_n;
> > > +			k_opt = k_min = k;
> > > +			for (k = max_k; k > k_min; k--) {
> > > +				n = (mul + k - 1) / k;
> > > +				t = n * k;
> > > +				delta = t - mul;
> > > +				if (delta == 0) {
> > > +					k_opt = k;
> > > +					break;
> > > +				}
> > > +				if (delta < 0)
> > > +					delta = -delta;
> > > +				if (delta < delta_opt) {
> > > +					delta_opt = delta;
> > > +					k_opt = k;
> > > +				}
> > > +			}
> > > +			k = k_opt;
> > > +			n = (mul + k - 1) / k;
> > > +		} else {
> > > +			n = mul;
> > > +		}
> > > +	} else {
> > > +		div = (parent_rate + rate - 1) / rate;
> > > +	}
> > > +
> > > +	/* compute d1 (value is only 1 or 2) */
> > > +	if (max_d1 > 1) {
> > > +		if (div % 2 == 0) {
> > > +			d1 = 2;
> > > +			div /= 2;
> > > +		}
> > > +	}
> > > +
> > > +	/* compute p */
> > > +/*	p = 0; */
> > > +	while (div % 2 == 0 && p <= max_p) {
> > > +		p++;
> > > +		div /= 2;
> > > +	}
> > > +
> > > +	/* compute m */
> > > +	if (max_m > 1) {
> > > +		if (div <= max_m)
> > > +			m = div;
> > > +		else
> > > +			m = max_m;
> > > +		div /= m;
> > > +	}
> > > +
> > > +	/* adjust n */
> > > +	n = DIV_ROUND_CLOSEST((rate << p) * m * d1, parent_rate);
> > > +	n = DIV_ROUND_CLOSEST(n, k);
> > > +
> > > +	p_v->n = n;
> > > +	p_v->d1 = d1;
> > > +	p_v->k = k;
> > > +	p_v->m = m;
> > > +	p_v->p = p;
> > > +
> > > +	return 0;
> > > +}
> > 
> > So. In order to move away from an unmaintainable mess, we create a new
> > unmaintainable mess? Looks like the way to go.
> 
> Why is it unmaintainable? This routine should work fine for most
> Allwinner's SoCs.

Define the algorithm used in three sentences. Maintainability is also
about having code that is concise, clear and easy to debug and review.

This functions fails in all four.

> If it would not for some particular SoC, an other one could be written
> and called for this case.

The point is to have *common* code.

> Maybe are you thinking about the pre/post-divider order. Yes, this
> routine should enhanced if some rounding problem would be found.
> 
> > > +const struct clk_ops ccu_pll_ops = {
> > > +	.prepare	= ccu_prepare,
> > > +	.unprepare	= ccu_unprepare,
> > > +	.enable		= ccu_enable,
> > > +	.disable	= ccu_disable,
> > > +/*	.is_enabled	= NULL;	(don't disable the clocks at startup time) */
> > 
> > Why?
> 
> 3 reasons:
> 
> - as the unused clocks are disabled at system startup time, all the
>   critical clocks should be flagged as such. A problem exists when
>   trying a new SoC: we may not know which clocks are critical, and
>   we stay in front of a black screen when trying to boot.

Then we find which clock it is, and we flag it as such. That's
actually quite easy to do, since the clocks very late in the boot
process, way after your UART has been initialised, so this is totally
something you can trace.

> - the clocks may be enabled again when already enabled without any
>   problem.

Indeed

> So, it is not important to know if they are already enabled by
> hardware: the software enable counter is enough.

It is important to know it if we have some unused clock running, so
that we can disable it. And disabling it has a bunch of side effects,
most notably saving polar bears, and pointing out clocks that should
be flagged as such.

> - less code!

I fail to see how that's an argument.

> > > +int ccu_periph_set_rate(struct clk_hw *hw, unsigned long rate,
> > > +			unsigned long parent_rate)
> > > +{
> > > +	struct ccu *ccu = hw2ccu(hw);
> > > +	const struct ccu_extra *extra = ccu->extra;
> > > +	struct values v;
> > > +	u32 mask;
> > > +	int ret;
> > > +
> > > +	if (!ccu->m_width && !ccu->p_width)
> > > +		return 0;
> > > +
> > > +	ccu_mux_adjust_parent_for_prediv(ccu, -1, &parent_rate);
> > > +
> > > +	if (extra && (ccu->features & CCU_FEATURE_MODE_SELECT)) {
> > > +		/* fixme: should use new mode */
> > > +		if (rate == extra->mode_select.rate)
> > > +			rate /= 2;
> > > +	}
> > 
> > That needs synchronisation with the MMC driver. How are you dealing
> > with this?
> 
> I have problems with the MMCs. I will propose the necessary changes in
> both the clock and MMC drivers as soon as I have the 3 MMCs working
> (SDcard, wifi and eMMC) in the Banana Pi M3.

For the time being, that code is broken. And you are using it.

> > > +
> > > +	if (ccu->p_width) {				/* m and p */
> > > +		ret = ccu_pll_find_best(ccu, rate, parent_rate, &v);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {					/* m alone */
> > > +		v.m = divider_get_val(rate, parent_rate,
> > > +				ccu->div_table, ccu->m_width, ccu->div_flags);
> > > +		v.p = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	mask = CCU_MASK(ccu->m_shift, ccu->m_width) |
> > > +		CCU_MASK(ccu->p_shift, ccu->p_width);
> > > +
> > > +	if (ccu->features & CCU_FEATURE_SET_RATE_UNGATE)
> > > +		ccu_disable(hw);
> > 
> > ungating means enable, and this is already dealt with by the core.
> 
> Right, the name is wrong.
> But nothing is done by the core: when CLK_SET_RATE_GATE is set, and
> when the gate is enabled, set_rate() fails.

I was talking about CLK_SET_RATE_UNGATE.

> > > +const struct clk_ops ccu_fixed_factor_ops = {
> > > +	.disable	= ccu_disable,
> > > +	.enable		= ccu_enable,
> > > +/*	.is_enabled	= NULL, */
> > > +
> > > +	.recalc_rate	= ccu_fixed_factor_recalc_rate,
> > > +	.round_rate	= ccu_fixed_factor_round_rate,
> > > +	.set_rate	= ccu_fixed_factor_set_rate,
> > > +};
> > 
> > This is redundant with the core.
> 
> I don't see how:
> - the 'mul' and 'div' fields are not at the same offset
> - some fixed_factor clocks may have a gate.

Which ones?

> > > +	mask = BIT(bit);
> > > +
> > > +	spin_lock(&ccu_lock);
> > > +	if (enable)
> > > +		writel(readl(ccu_reset->base + reg) | mask,
> > > +			ccu_reset->base + reg);
> > > +	else
> > > +		writel(readl(ccu_reset->base + reg) & ~mask,
> > > +			ccu_reset->base + reg);
> > > +	spin_unlock(&ccu_lock);
> > > +}
> > > +
> > > +static int ccu_reset_assert(struct reset_controller_dev *rcdev,
> > > +			    unsigned long id)
> > > +{
> > > +	struct ccu_reset *ccu_reset = rcdev_to_ccu_reset(rcdev);
> > > +	const struct ccu_reset_map *map = &ccu_reset->reset_map[id];
> > > +
> > > +	ccu_set_reset_clock(ccu_reset, map->reg, map->bit, 0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
> > > +			      unsigned long id)
> > > +{
> > > +	struct ccu_reset *ccu_reset = rcdev_to_ccu_reset(rcdev);
> > > +	const struct ccu_reset_map *map = &ccu_reset->reset_map[id];
> > > +
> > > +	ccu_set_reset_clock(ccu_reset, map->reg, map->bit, 1);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +const struct reset_control_ops ccu_reset_ops = {
> > > +	.assert		= ccu_reset_assert,
> > > +	.deassert	= ccu_reset_deassert,
> > > +};
> > > +
> > > +/* --- init --- */
> > > +int __init ccu_probe(struct device_node *node,
> > > +			struct clk_hw_onecell_data *data,
> > > +			struct ccu_reset *resets)
> > > +{
> > > +	struct clk_hw *hw;
> > > +	struct ccu *ccu;
> > > +	void __iomem *reg;
> > > +	int i, ret;
> > > +
> > > +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > > +	if (IS_ERR(reg)) {
> > > +		pr_err("%s: Clock mapping failed %d\n",
> > > +			of_node_full_name(node), (int) PTR_ERR(reg));
> > > +		return PTR_ERR(reg);
> > > +	}
> > > +
> > > +	/* register the clocks */
> > > +	for (i = 0; i < data->num; i++) {
> > > +		hw = data->hws[i];
> > > +#if CCU_DEBUG
> > > +		if (!hw) {
> > > +			pr_err("%s: Bad number of clocks %d != %d\n",
> > > +				of_node_full_name(node),
> > > +				i + 1, data->num);
> > > +			data->num = i;
> > > +			break;
> > > +		}
> > > +#endif
> > > +		ccu = hw2ccu(hw);
> > > +		ccu->base = reg;
> > > +		ret = clk_hw_register(NULL, hw);
> > > +		if (ret < 0) {
> > > +			pr_err("%s: Register clock %s failed %d\n",
> > > +				of_node_full_name(node),
> > > +				clk_hw_get_name(hw), ret);
> > > +			data->num = i;
> > > +			break;
> > > +		}
> > > +	}
> > > +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
> > > +	if (ret < 0)
> > > +		goto err;
> > > +
> > > +	/* register the resets */
> > > +	resets->rcdev.of_node = node;
> > > +	resets->base = reg;
> > > +
> > > +	ret = reset_controller_register(&resets->rcdev);
> > > +	if (ret) {
> > > +		pr_err("%s: Reset register failed %d\n",
> > > +			of_node_full_name(node), ret);
> > > +		goto err;
> > > +	}
> > > +
> > > +	return ret;
> > 
> > What's the point of this, if we're not using (or exposing for that
> > matter) any of it?
> 
> Maybe I was misunderstood:
> - the control of the reset state may be needed for some clocks or by
>   some drivers, but,
> - most clocks / drivers don't need it, so, it is possible to hide these
>   resets inside the clock stuff. You may note that some drivers are
>   already prepared to this fact. For example, in the sunxi MMC driver,
>   the reset is optional.

Because you don't have a reset line on the first SoCs. This has
nothing to do with our discussion.

> - in case a driver requests a reset, this last one should exist.
>   But, this reset may point to a void one (reg = null) when the real
>   reset has been moved to the prepare/unprepare of the associated clock.

And what if this driver wants to be reset, by calling
reset_control_reset? You realize you're going against the semantics of
the reset and clock APIs, and what the hardware expose here right?

> > I'm sorry, but the whole point of the initial serie was to rework and
> > simplify things, precisely because dealing with the clk_factors code
> > was just too difficult nowadays. And this doesn't solve anything on
> > that aspect.
> 
> In my code, all the clock factors I know about are handled.
> Basically, the requested and the parent rates give a multiplier and a
> divider. These ones are dispatched into the specific clock factors
> according to their constraints.

You missed the "simplify" part. The other reason for this serie to
exist was to be consistent with what the other architectures are
doing, which is not the case here either.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/e732bdbd/attachment.sig>
