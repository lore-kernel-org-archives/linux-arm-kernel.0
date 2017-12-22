From: joel@jms.id.au (Joel Stanley)
Date: Fri, 22 Dec 2017 13:15:19 +1030
Subject: [PATCH v7 2/5] clk: aspeed: Register core clocks
In-Reply-To: <20171222024522.10362-1-joel@jms.id.au>
References: <20171222024522.10362-1-joel@jms.id.au>
Message-ID: <20171222024522.10362-3-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the core clocks; those which are required to calculate
the rate of the timer peripheral so the system can load a clocksource
driver.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v5:
  - Add Andrew's Reviewed-by
v4:
  - Add defines to document the BIT() macros
v3:
  - Fix ast2400 ahb calculation
  - Remove incorrect 'this is wrong' comment
  - Separate out clkin calc to be per platform
  - Support 48MHz clkin on ast2400
---
 drivers/clk/clk-aspeed.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 7a86ee08ea4f..5adedda82d26 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -13,7 +13,23 @@
 
 #define ASPEED_NUM_CLKS		35
 
+#define ASPEED_RESET_CTRL	0x04
+#define ASPEED_CLK_SELECTION	0x08
+#define ASPEED_CLK_STOP_CTRL	0x0c
+#define ASPEED_MPLL_PARAM	0x20
+#define ASPEED_HPLL_PARAM	0x24
+#define  AST2500_HPLL_BYPASS_EN	BIT(20)
+#define  AST2400_HPLL_STRAPPED	BIT(18)
+#define  AST2400_HPLL_BYPASS_EN	BIT(17)
+#define ASPEED_MISC_CTRL	0x2c
+#define  UART_DIV13_EN		BIT(12)
 #define ASPEED_STRAP		0x70
+#define  CLKIN_25MHZ_EN		BIT(23)
+#define  AST2400_CLK_SOURCE_SEL	BIT(18)
+#define ASPEED_CLK_SELECTION_2	0xd8
+
+/* Globally visible clocks */
+static DEFINE_SPINLOCK(aspeed_clk_lock);
 
 /* Keeps track of all clocks */
 static struct clk_hw_onecell_data *aspeed_clk_data;
@@ -91,6 +107,160 @@ static const struct aspeed_gate_data aspeed_gates[] = {
 	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
 };
 
+static const struct clk_div_table ast2400_div_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 4 },
+	{ 0x2, 6 },
+	{ 0x3, 8 },
+	{ 0x4, 10 },
+	{ 0x5, 12 },
+	{ 0x6, 14 },
+	{ 0x7, 16 },
+	{ 0 }
+};
+
+static const struct clk_div_table ast2500_div_table[] = {
+	{ 0x0, 4 },
+	{ 0x1, 8 },
+	{ 0x2, 12 },
+	{ 0x3, 16 },
+	{ 0x4, 20 },
+	{ 0x5, 24 },
+	{ 0x6, 28 },
+	{ 0x7, 32 },
+	{ 0 }
+};
+
+static struct clk_hw *aspeed_ast2400_calc_pll(const char *name, u32 val)
+{
+	unsigned int mult, div;
+
+	if (val & AST2400_HPLL_BYPASS_EN) {
+		/* Pass through mode */
+		mult = div = 1;
+	} else {
+		/* F = 24Mhz * (2-OD) * [(N + 2) / (D + 1)] */
+		u32 n = (val >> 5) & 0x3f;
+		u32 od = (val >> 4) & 0x1;
+		u32 d = val & 0xf;
+
+		mult = (2 - od) * (n + 2);
+		div = d + 1;
+	}
+	return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
+			mult, div);
+};
+
+static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
+{
+	unsigned int mult, div;
+
+	if (val & AST2500_HPLL_BYPASS_EN) {
+		/* Pass through mode */
+		mult = div = 1;
+	} else {
+		/* F = clkin * [(M+1) / (N+1)] / (P + 1) */
+		u32 p = (val >> 13) & 0x3f;
+		u32 m = (val >> 5) & 0xff;
+		u32 n = val & 0x1f;
+
+		mult = (m + 1) / (n + 1);
+		div = p + 1;
+	}
+
+	return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
+			mult, div);
+}
+
+static void __init aspeed_ast2400_cc(struct regmap *map)
+{
+	struct clk_hw *hw;
+	u32 val, freq, div;
+
+	/*
+	 * CLKIN is the crystal oscillator, 24, 48 or 25MHz selected by
+	 * strapping
+	 */
+	regmap_read(map, ASPEED_STRAP, &val);
+	if (val & CLKIN_25MHZ_EN)
+		freq = 25000000;
+	else if (val & AST2400_CLK_SOURCE_SEL)
+		freq = 48000000;
+	else
+		freq = 24000000;
+	hw = clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, freq);
+	pr_debug("clkin @%u MHz\n", freq / 1000000);
+
+	/*
+	 * High-speed PLL clock derived from the crystal. This the CPU clock,
+	 * and we assume that it is enabled
+	 */
+	regmap_read(map, ASPEED_HPLL_PARAM, &val);
+	WARN(val & AST2400_HPLL_STRAPPED, "hpll is strapped not configured");
+	aspeed_clk_data->hws[ASPEED_CLK_HPLL] = aspeed_ast2400_calc_pll("hpll", val);
+
+	/*
+	 * Strap bits 11:10 define the CPU/AHB clock frequency ratio (aka HCLK)
+	 *   00: Select CPU:AHB = 1:1
+	 *   01: Select CPU:AHB = 2:1
+	 *   10: Select CPU:AHB = 4:1
+	 *   11: Select CPU:AHB = 3:1
+	 */
+	regmap_read(map, ASPEED_STRAP, &val);
+	val = (val >> 10) & 0x3;
+	div = val + 1;
+	if (div == 3)
+		div = 4;
+	else if (div == 4)
+		div = 3;
+	hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, div);
+	aspeed_clk_data->hws[ASPEED_CLK_AHB] = hw;
+
+	/* APB clock clock selection register SCU08 (aka PCLK) */
+	hw = clk_hw_register_divider_table(NULL, "apb", "hpll", 0,
+			scu_base + ASPEED_CLK_SELECTION, 23, 3, 0,
+			ast2400_div_table,
+			&aspeed_clk_lock);
+	aspeed_clk_data->hws[ASPEED_CLK_APB] = hw;
+}
+
+static void __init aspeed_ast2500_cc(struct regmap *map)
+{
+	struct clk_hw *hw;
+	u32 val, freq, div;
+
+	/* CLKIN is the crystal oscillator, 24 or 25MHz selected by strapping */
+	regmap_read(map, ASPEED_STRAP, &val);
+	if (val & CLKIN_25MHZ_EN)
+		freq = 25000000;
+	else
+		freq = 24000000;
+	hw = clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, freq);
+	pr_debug("clkin @%u MHz\n", freq / 1000000);
+
+	/*
+	 * High-speed PLL clock derived from the crystal. This the CPU clock,
+	 * and we assume that it is enabled
+	 */
+	regmap_read(map, ASPEED_HPLL_PARAM, &val);
+	aspeed_clk_data->hws[ASPEED_CLK_HPLL] = aspeed_ast2500_calc_pll("hpll", val);
+
+	/* Strap bits 11:9 define the AXI/AHB clock frequency ratio (aka HCLK)*/
+	regmap_read(map, ASPEED_STRAP, &val);
+	val = (val >> 9) & 0x7;
+	WARN(val == 0, "strapping is zero: cannot determine ahb clock");
+	div = 2 * (val + 1);
+	hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, div);
+	aspeed_clk_data->hws[ASPEED_CLK_AHB] = hw;
+
+	/* APB clock clock selection register SCU08 (aka PCLK) */
+	regmap_read(map, ASPEED_CLK_SELECTION, &val);
+	val = (val >> 23) & 0x7;
+	div = 4 * (val + 1);
+	hw = clk_hw_register_fixed_factor(NULL, "apb", "hpll", 0, 1, div);
+	aspeed_clk_data->hws[ASPEED_CLK_APB] = hw;
+};
+
 static void __init aspeed_cc_init(struct device_node *np)
 {
 	struct regmap *map;
@@ -132,6 +302,13 @@ static void __init aspeed_cc_init(struct device_node *np)
 		return;
 	}
 
+	if (of_device_is_compatible(np, "aspeed,ast2400-scu"))
+		aspeed_ast2400_cc(map);
+	else if (of_device_is_compatible(np, "aspeed,ast2500-scu"))
+		aspeed_ast2500_cc(map);
+	else
+		pr_err("unknown platform, failed to add clocks\n");
+
 	aspeed_clk_data->num = ASPEED_NUM_CLKS;
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, aspeed_clk_data);
 	if (ret)
-- 
2.15.1
