From: joel@jms.id.au (Joel Stanley)
Date: Fri, 22 Dec 2017 13:15:21 +1030
Subject: [PATCH v7 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <20171222024522.10362-1-joel@jms.id.au>
References: <20171222024522.10362-1-joel@jms.id.au>
Message-ID: <20171222024522.10362-5-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The majority of the clocks in the system are gates paired with a reset
controller that holds the IP in reset.

This borrows from clk_hw_register_gate, but registers two 'gates', one
to control the clock enable register and the other to control the reset
IP. This allows us to enforce the ordering:

 1. Place IP in reset
 2. Enable clock
 3. Delay
 4. Release reset

There are some gates that do not have an associated reset; these are
handled by using -1 as the index for the reset.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v7:
 - Use mdelay instead of msleep and remove the todo. Stephen points out:
    > No you can't sleep here. It needs to delay because this is inside
    > spinlock_irqsave.
v5:
  - Add Andrew's Reviewed-by
v4:
 - Drop useless 'disable clock' comment
 - Drop CLK_IS_BASIC flag
 - Fix 'there are a number of clocks...' comment
 - Pass device to clk registration functions
 - Check for errors when registering clk_hws
v3:
 - Remove gates offset as gates are now at the start of the list

mdelay

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-aspeed.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index cf5ea63feb31..dbd3c7774831 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -204,6 +204,106 @@ static const struct aspeed_clk_soc_data ast2400_data = {
 	.calc_pll = aspeed_ast2400_calc_pll,
 };
 
+static int aspeed_clk_enable(struct clk_hw *hw)
+{
+	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
+	unsigned long flags;
+	u32 clk = BIT(gate->clock_idx);
+	u32 rst = BIT(gate->reset_idx);
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (gate->reset_idx >= 0) {
+		/* Put IP in reset */
+		regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, rst);
+
+		/* Delay 100us */
+		udelay(100);
+	}
+
+	/* Enable clock */
+	regmap_update_bits(gate->map, ASPEED_CLK_STOP_CTRL, clk, 0);
+
+	if (gate->reset_idx >= 0) {
+		/* A delay of 10ms is specified by the ASPEED docs */
+		mdelay(10);
+
+		/* Take IP out of reset */
+		regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, 0);
+	}
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void aspeed_clk_disable(struct clk_hw *hw)
+{
+	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
+	unsigned long flags;
+	u32 clk = BIT(gate->clock_idx);
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	regmap_update_bits(gate->map, ASPEED_CLK_STOP_CTRL, clk, clk);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int aspeed_clk_is_enabled(struct clk_hw *hw)
+{
+	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
+	u32 clk = BIT(gate->clock_idx);
+	u32 reg;
+
+	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
+
+	return (reg & clk) ? 0 : 1;
+}
+
+static const struct clk_ops aspeed_clk_gate_ops = {
+	.enable = aspeed_clk_enable,
+	.disable = aspeed_clk_disable,
+	.is_enabled = aspeed_clk_is_enabled,
+};
+
+static struct clk_hw *aspeed_clk_hw_register_gate(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		struct regmap *map, u8 clock_idx, u8 reset_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct aspeed_clk_gate *gate;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &aspeed_clk_gate_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->map = map;
+	gate->clock_idx = clock_idx;
+	gate->reset_idx = reset_idx;
+	gate->flags = clk_gate_flags;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
 static int aspeed_clk_probe(struct platform_device *pdev)
 {
 	const struct aspeed_clk_soc_data *soc_data;
@@ -211,6 +311,7 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 	struct regmap *map;
 	struct clk_hw *hw;
 	u32 val, rate;
+	int i;
 
 	map = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(map)) {
@@ -283,6 +384,35 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
 
+	/*
+	 * TODO: There are a number of clocks that not included in this driver
+	 * as more information is required:
+	 *   D2-PLL
+	 *   D-PLL
+	 *   YCLK
+	 *   RGMII
+	 *   RMII
+	 *   UART[1..5] clock source mux
+	 *   Video Engine (ECLK) mux and clock divider
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
+		const struct aspeed_gate_data *gd = &aspeed_gates[i];
+
+		hw = aspeed_clk_hw_register_gate(dev,
+				gd->name,
+				gd->parent_name,
+				gd->flags,
+				map,
+				gd->clock_idx,
+				gd->reset_idx,
+				CLK_GATE_SET_TO_DISABLE,
+				&aspeed_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+		aspeed_clk_data->hws[i] = hw;
+	}
+
 	return 0;
 };
 
-- 
2.15.1
