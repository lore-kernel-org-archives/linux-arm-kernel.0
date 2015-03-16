From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 11:33:27 +0000
Subject: [PATCH 10/10] clk: zx: add zx296702 clock support
In-Reply-To: <1426333785-3952-11-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-11-git-send-email-jun.nie@linaro.org>
Message-ID: <20150316113327.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 07:49:45PM +0800, Jun Nie wrote:
> +static int hw_to_idx(struct clk_zx_pll *zx_pll)
> +{
> +	const struct zx_pll_config *config = zx_pll->lookup_table;
> +	u32 hw_cfg0, hw_cfg1;
> +	unsigned long flags = 0;
> +	int i;
> +
> +	if (zx_pll->lock)
> +		spin_lock_irqsave(zx_pll->lock, flags);
> +
> +	hw_cfg0 = readl(zx_pll->reg_base);
> +	hw_cfg1 = readl(zx_pll->reg_base + 4);
> +
> +	if (zx_pll->lock)
> +		spin_unlock_irqrestore(zx_pll->lock, flags);
> +
> +	/* For matching the value in lookup table */
> +	hw_cfg0 &= ~BIT(30); /* clear lock bit */
> +	hw_cfg0 |= BIT(31); /* set PD bit */

Use definitions for these bits rather than BIT(n) and a comment.

> +static int zx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			   unsigned long parent_rate)
> +{
> +	/* Assume current cpu is not running on current PLL */
> +	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
> +	const struct zx_pll_config *config;
> +	unsigned long flags = 0;
> +	int idx;
> +	u32 reg;
> +
> +	idx = rate_to_idx(zx_pll, rate);
> +	config = &zx_pll->lookup_table[idx];
> +
> +	if (zx_pll->lock)
> +		spin_lock_irqsave(zx_pll->lock, flags);

Is this code ever safe without having a lock to take?

> +
> +	writel(config->cfg0, zx_pll->reg_base);
> +	writel(config->cfg1, zx_pll->reg_base + 4);

Use a definition for this +4 (and also for the first register too.)

> +	reg = readl(zx_pll->reg_base);
> +	reg &= ~BIT(31);
> +	writel(reg, zx_pll->reg_base);

You've only just written zx_pll->reg_base - why do you need to read it
back?  Wouldn't this be better (and in any case, using relaxed
accessors is probably a good idea):

	writel_relaxed(config->cfg0, zx_pll->reg_base);
	writel_relaxed(config->cfg1, zx_pll->reg_base + 4);
	writel_relaxed(config->cfg0 & ~ZX_PLL_PD, zx_pll->reg_base);

Looks nicer, doesn't it?

In any case, why should setting the rate enable the PLL?  I notice you
use the PD bit below in the enable/disable functions, so this seems
rather silly - it looks like it should be preserved, and then the wait
for the PLL to lock (below) should be conditional on the PLL being
enabled.

> +	while (!(readl(zx_pll->reg_base) & BIT(30)))
> +		cpu_relax();

What if the bit never sets?  You can probably use readl_relaxed() here.

> +
> +	if (zx_pll->lock)
> +		spin_unlock_irqrestore(zx_pll->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int zx_pll_enable(struct clk_hw *hw)
> +{
> +	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
> +	unsigned long flags = 0;
> +	u32 reg;
> +
> +	if (zx_pll->lock)
> +		spin_lock_irqsave(zx_pll->lock, flags);
> +
> +	reg = readl(zx_pll->reg_base);
> +	writel(reg & ~BIT(31), zx_pll->reg_base);
> +	while (!(readl(zx_pll->reg_base) & BIT(30)))
> +		cpu_relax();

What if the bit never sets?

> +
> +	if (zx_pll->lock)
> +		spin_unlock_irqrestore(zx_pll->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void zx_pll_disable(struct clk_hw *hw)
> +{
> +	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
> +	unsigned long flags = 0;
> +	u32 reg;
> +
> +	if (zx_pll->lock)
> +		spin_lock_irqsave(zx_pll->lock, flags);
> +
> +	reg = readl(zx_pll->reg_base);
> +	writel(reg | BIT(31), zx_pll->reg_base);
> +
> +	if (zx_pll->lock)
> +		spin_unlock_irqrestore(zx_pll->lock, flags);
> +}
> +
> +static int zx_pll_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
> +	unsigned long flags = 0;
> +	u32 reg;
> +
> +	if (zx_pll->lock)
> +		spin_lock_irqsave(zx_pll->lock, flags);
> +
> +	reg = readl(zx_pll->reg_base);
> +
> +	if (zx_pll->lock)
> +		spin_unlock_irqrestore(zx_pll->lock, flags);

You don't need locking to read from a single register.

> +
> +	return !(reg & BIT(31));
> +}
> +
> +static const struct clk_ops zx_pll_ops = {
> +	.recalc_rate = zx_pll_recalc_rate,
> +	.round_rate = zx_pll_round_rate,
> +	.set_rate = zx_pll_set_rate,
> +	.enable = zx_pll_enable,
> +	.disable = zx_pll_disable,
> +	.is_enabled = zx_pll_is_enabled,
> +};
> +
> +struct clk *clk_register_zx_pll(const char *name, const char *parent_name,
> +	unsigned long flags, void __iomem *reg_base,
> +	const struct zx_pll_config *lookup_table, int count, spinlock_t *lock)
> +{
> +	struct clk_zx_pll *zx_pll;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	zx_pll = kzalloc(sizeof(*zx_pll), GFP_KERNEL);
> +	if (!zx_pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &zx_pll_ops;
> +	init.flags = flags;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +
> +	zx_pll->reg_base = reg_base;
> +	zx_pll->lookup_table = lookup_table;
> +	zx_pll->count = count;
> +	zx_pll->lock = lock;

As mentioned above, I think this is unsafe if lock is NULL.  You probably
want to subsitute a lock specific to the PLL if none was provided.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
