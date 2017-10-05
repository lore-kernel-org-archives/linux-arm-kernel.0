From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 05 Oct 2017 18:07:52 +1030
Subject: [PATCH v4 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <20171003065540.11722-5-joel@jms.id.au>
References: <20171003065540.11722-1-joel@jms.id.au>
 <20171003065540.11722-5-joel@jms.id.au>
Message-ID: <1507189072.5452.67.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-03 at 17:25 +1030, Joel Stanley wrote:
> The majority of the clocks in the system are gates paired with a reset
> controller that holds the IP in reset.
>?
> This borrows from clk_hw_register_gate, but registers two 'gates', one
> to control the clock enable register and the other to control the reset
> IP. This allows us to enforce the ordering:
>?
> ?1. Place IP in reset
> ?2. Enable clock
> ?3. Delay
> ?4. Release reset
>?
> There are some gates that do not have an associated reset; these are
> handled by using -1 as the index for the reset.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
>?
> ---
> v4:
> ?- Drop useless 'disable clock' comment
> ?- Drop CLK_IS_BASIC flag
> ?- Fix 'there are a number of clocks...' comment
> ?- Pass device to clk registration functions
> ?- Check for errors when registering clk_hws
> v3:
> ?- Remove gates offset as gates are now at the start of the list
> ---
> ?drivers/clk/clk-aspeed.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++
> ?1 file changed, 130 insertions(+)
>?
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index adb295292189..a424b056e767 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -228,6 +228,107 @@ static const struct aspeed_clk_soc_data ast2400_data = {
> ?	.calc_pll = aspeed_ast2400_calc_pll,
> ?};
> ?
> +static int aspeed_clk_enable(struct clk_hw *hw)
> +{
> +	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> +	unsigned long flags;
> +	u32 clk = BIT(gate->clock_idx);
> +	u32 rst = BIT(gate->reset_idx);
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	if (gate->reset_idx >= 0) {
> +		/* Put IP in reset */
> +		regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, rst);
> +
> +		/* Delay 100us */
> +		udelay(100);
> +	}
> +
> +	/* Enable clock */
> +	regmap_update_bits(gate->map, ASPEED_CLK_STOP_CTRL, clk, 0);
> +
> +	if (gate->reset_idx >= 0) {
> +		/* Delay 10ms */
> +		/* TODO: can we sleep here? */
> +		msleep(10);
> +
> +		/* Take IP out of reset */
> +		regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, 0);
> +	}
> +
> +	spin_unlock_irqrestore(gate->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void aspeed_clk_disable(struct clk_hw *hw)
> +{
> +	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> +	unsigned long flags;
> +	u32 clk = BIT(gate->clock_idx);
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	regmap_update_bits(gate->map, ASPEED_CLK_STOP_CTRL, clk, clk);
> +
> +	spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static int aspeed_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> +	u32 clk = BIT(gate->clock_idx);
> +	u32 reg;
> +
> +	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
> +
> +	return (reg & clk) ? 0 : 1;

Kill a branch, save the internet: return !(reg & clk);

But regardless, the patch seems sensible to me modulo the power domain
discussion. However as it's more clk-y than Aspeed-y I don't feel entirely
qualified to provide a r-b, so instead:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> +}
> +
> +static const struct clk_ops aspeed_clk_gate_ops = {
> +	.enable = aspeed_clk_enable,
> +	.disable = aspeed_clk_disable,
> +	.is_enabled = aspeed_clk_is_enabled,
> +};
> +
> +static struct clk_hw *aspeed_clk_hw_register_gate(struct device *dev,
> +		const char *name, const char *parent_name, unsigned long flags,
> +		struct regmap *map, u8 clock_idx, u8 reset_idx,
> +		u8 clk_gate_flags, spinlock_t *lock)
> +{
> +	struct aspeed_clk_gate *gate;
> +	struct clk_init_data init;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &aspeed_clk_gate_ops;
> +	init.flags = flags;
> +	init.parent_names = parent_name ? &parent_name : NULL;
> +	init.num_parents = parent_name ? 1 : 0;
> +
> +	gate->map = map;
> +	gate->clock_idx = clock_idx;
> +	gate->reset_idx = reset_idx;
> +	gate->flags = clk_gate_flags;
> +	gate->lock = lock;
> +	gate->hw.init = &init;
> +
> +	hw = &gate->hw;
> +	ret = clk_hw_register(dev, hw);
> +	if (ret) {
> +		kfree(gate);
> +		hw = ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +
> ?static int aspeed_clk_probe(struct platform_device *pdev)
> ?{
> ?	const struct aspeed_clk_soc_data *soc_data;
> @@ -235,6 +336,7 @@ static int aspeed_clk_probe(struct platform_device *pdev)
> ?	struct regmap *map;
> ?	struct clk_hw *hw;
> ?	u32 val, rate;
> +	int i;
> ?
> ?	map = syscon_node_to_regmap(dev->of_node);
> ?	if (IS_ERR(map)) {
> @@ -323,6 +425,34 @@ static int aspeed_clk_probe(struct platform_device *pdev)
> ?		return PTR_ERR(hw);
> ?	aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
> ?
> +	/*
> +	?* TODO: There are a number of clocks that not included in this driver
> +	?* as more information is required:
> +	?*???D2-PLL
> +	?*???D-PLL
> +	?*???YCLK
> +	?*???RGMII
> +	?*???RMII
> +	?*???UART[1..5] clock source mux
> +	?*/
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
> +		const struct aspeed_gate_data *gd = &aspeed_gates[i];
> +
> +		hw = aspeed_clk_hw_register_gate(dev,
> +				gd->name,
> +				gd->parent_name,
> +				gd->flags,
> +				map,
> +				gd->clock_idx,
> +				gd->reset_idx,
> +				CLK_GATE_SET_TO_DISABLE,
> +				&aspeed_clk_lock);
> +		if (IS_ERR(hw))
> +			return PTR_ERR(hw);
> +		aspeed_clk_data->hws[i] = hw;
> +	}
> +
> ?	return 0;
> ?};
> ?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/716a881a/attachment.sig>
