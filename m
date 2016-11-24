From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 24 Nov 2016 15:45:42 +0100
Subject: [PATCH v2 2/9] clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469
 boards
In-Reply-To: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1479998749-20358-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces PLL_I2S and PLL_SAI.
Vco clock of these PLLs can be modify by DT (only n multiplicator,
m divider is still fixed by the boot-loader).
Each PLL has 3 dividers. PLL should be off when we modify the rate.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |   2 +
 drivers/clk/clk-stm32f4.c                          | 342 ++++++++++++++++++++-
 include/dt-bindings/clock/stm32f4-clock.h          |   4 +-
 3 files changed, 332 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 18e05c2..eb6733c 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -74,6 +74,8 @@ The secondary index is bound with the following magic numbers:
 				 crystal or ceramic resonator)
 	4	CLK_HSE_RTC	(HSE division factor for RTC clock)
 	5	CLK_RTC		(real-time clock)
+	6	PLL_VCO_I2S	(vco frequency of I2S pll)
+	7	PLL_VCO_SAI	(vco frequency of SAI pll)
 
 Example:
 
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 39965ab..c2b62cc 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -35,6 +35,7 @@
  */
 #include <dt-bindings/clock/stm32f4-clock.h>
 
+#define STM32F4_RCC_CR			0x00
 #define STM32F4_RCC_PLLCFGR		0x04
 #define STM32F4_RCC_CFGR		0x08
 #define STM32F4_RCC_AHB1ENR		0x30
@@ -44,6 +45,8 @@
 #define STM32F4_RCC_APB2ENR		0x44
 #define STM32F4_RCC_BDCR		0x70
 #define STM32F4_RCC_CSR			0x74
+#define STM32F4_RCC_PLLI2SCFGR		0x84
+#define STM32F4_RCC_PLLSAICFGR		0x88
 
 struct stm32f4_gate_data {
 	u8	offset;
@@ -329,23 +332,312 @@ static struct clk *clk_register_apb_mul(struct device *dev, const char *name,
 	return clk;
 }
 
-/*
- * Decode current PLL state and (statically) model the state we inherit from
- * the bootloader.
- */
-static void stm32f4_rcc_register_pll(const char *hse_clk, const char *hsi_clk)
+enum {
+	PLL,
+	PLL_I2S,
+	PLL_SAI,
+};
+
+static const struct clk_div_table pll_divp_table[] = {
+	{ 0, 2 }, { 1, 4 }, { 2, 6 }, { 3, 8 }, { 0 }
+};
+
+static const struct clk_div_table pll_divr_table[] = {
+	{ 2, 2 }, { 3, 3 }, { 4, 4 }, { 5, 5 }, { 6, 6 }, { 7, 7 }, { 0 }
+};
+
+struct stm32f4_pll {
+	spinlock_t *lock;
+	struct	clk_gate gate;
+	u8 offset;
+	u8 bit_rdy_idx;
+	u8 status;
+	u8 n_start;
+};
+
+#define to_stm32f4_pll(_gate) container_of(_gate, struct stm32f4_pll, gate)
+
+struct stm32f4_vco_data {
+	const char *vco_name;
+	u8 offset;
+	u8 bit_idx;
+	u8 bit_rdy_idx;
+};
+
+static const struct stm32f4_vco_data  vco_data[] = {
+	{ "vco",     STM32F4_RCC_PLLCFGR,    24, 25 },
+	{ "vco-i2s", STM32F4_RCC_PLLI2SCFGR, 26, 27 },
+	{ "vco-sai", STM32F4_RCC_PLLSAICFGR, 28, 29 },
+};
+
+struct stm32f4_div_data {
+	u8 shift;
+	u8 width;
+	u8 flag_div;
+	const struct clk_div_table *div_table;
+};
+
+#define MAX_PLL_DIV 3
+static const struct stm32f4_div_data  div_data[MAX_PLL_DIV] = {
+	{ 16, 2, 0,			pll_divp_table	},
+	{ 24, 4, CLK_DIVIDER_ONE_BASED, NULL		},
+	{ 28, 3, 0,			pll_divr_table	},
+};
+
+struct stm32f4_pll_data {
+	u8 pll_num;
+	u8 n_start;
+	const char *div_name[MAX_PLL_DIV];
+};
+
+static const struct stm32f4_pll_data stm32f429_pll[MAX_PLL_DIV] = {
+	{ PLL,	   192, { "pll", "pll48",    NULL	} },
+	{ PLL_I2S, 192, { NULL,  "plli2s-q", "plli2s-r" } },
+	{ PLL_SAI,  49, { NULL,  "pllsai-q", "pllsai-r" } },
+};
+
+static const struct stm32f4_pll_data stm32f469_pll[MAX_PLL_DIV] = {
+	{ PLL,	   50, { "pll",	     "pll-q",    NULL	    } },
+	{ PLL_I2S, 50, { "plli2s-p", "plli2s-q", "plli2s-r" } },
+	{ PLL_SAI, 50, { "pllsai-p", "pllsai-q", "pllsai-r" } },
+};
+
+static int stm32f4_pll_is_enabled(struct clk_hw *hw)
+{
+	return clk_gate_ops.is_enabled(hw);
+}
+
+static int stm32f4_pll_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32f4_pll *pll = to_stm32f4_pll(gate);
+	int ret = 0;
+	unsigned long reg;
+
+	ret = clk_gate_ops.enable(hw);
+
+	ret = readl_relaxed_poll_timeout_atomic(base + STM32F4_RCC_CR, reg,
+			reg & (1 << pll->bit_rdy_idx), 0, 10000);
+
+	return ret;
+}
+
+static void stm32f4_pll_disable(struct clk_hw *hw)
 {
-	unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	clk_gate_ops.disable(hw);
+}
 
-	unsigned long pllm   = pllcfgr & 0x3f;
-	unsigned long plln   = (pllcfgr >> 6) & 0x1ff;
-	unsigned long pllp   = BIT(((pllcfgr >> 16) & 3) + 1);
-	const char   *pllsrc = pllcfgr & BIT(22) ? hse_clk : hsi_clk;
-	unsigned long pllq   = (pllcfgr >> 24) & 0xf;
+static unsigned long stm32f4_pll_recalc(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32f4_pll *pll = to_stm32f4_pll(gate);
+	unsigned long n;
 
-	clk_register_fixed_factor(NULL, "vco", pllsrc, 0, plln, pllm);
-	clk_register_fixed_factor(NULL, "pll", "vco", 0, 1, pllp);
-	clk_register_fixed_factor(NULL, "pll48", "vco", 0, 1, pllq);
+	n = (readl(base + pll->offset) >> 6) & 0x1ff;
+
+	return parent_rate * n;
+}
+
+static long stm32f4_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32f4_pll *pll = to_stm32f4_pll(gate);
+	unsigned long n;
+
+	n = rate / *prate;
+
+	if (n < pll->n_start)
+		n = pll->n_start;
+	else if (n > 432)
+		n = 432;
+
+	return *prate * n;
+}
+
+static int stm32f4_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32f4_pll *pll = to_stm32f4_pll(gate);
+
+	unsigned long n;
+	unsigned long val;
+	int pll_state;
+
+	pll_state = stm32f4_pll_is_enabled(hw);
+
+	if (pll_state)
+		stm32f4_pll_disable(hw);
+
+	n = rate  / parent_rate;
+
+	val = readl(base + pll->offset) & ~(0x1ff << 6);
+
+	writel(val | ((n & 0x1ff) <<  6), base + pll->offset);
+
+	if (pll_state)
+		stm32f4_pll_enable(hw);
+
+	return 0;
+}
+
+static const struct clk_ops stm32f4_pll_gate_ops = {
+	.enable		= stm32f4_pll_enable,
+	.disable	= stm32f4_pll_disable,
+	.is_enabled	= stm32f4_pll_is_enabled,
+	.recalc_rate	= stm32f4_pll_recalc,
+	.round_rate	= stm32f4_pll_round_rate,
+	.set_rate	= stm32f4_pll_set_rate,
+};
+
+struct stm32f4_pll_div {
+	struct clk_divider div;
+	struct clk_hw *hw_pll;
+};
+
+#define to_pll_div_clk(_div) container_of(_div, struct stm32f4_pll_div, div)
+
+static unsigned long stm32f4_pll_div_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long stm32f4_pll_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	return clk_divider_ops.round_rate(hw, rate, prate);
+}
+
+static int stm32f4_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	int pll_state, ret;
+
+	struct clk_divider *div = to_clk_divider(hw);
+	struct stm32f4_pll_div *pll_div = to_pll_div_clk(div);
+
+	pll_state = stm32f4_pll_is_enabled(pll_div->hw_pll);
+
+	if (pll_state)
+		stm32f4_pll_disable(pll_div->hw_pll);
+
+	ret = clk_divider_ops.set_rate(hw, rate, parent_rate);
+
+	if (pll_state)
+		stm32f4_pll_enable(pll_div->hw_pll);
+
+	return ret;
+}
+
+const struct clk_ops stm32f4_pll_div_ops = {
+	.recalc_rate = stm32f4_pll_div_recalc_rate,
+	.round_rate = stm32f4_pll_div_round_rate,
+	.set_rate = stm32f4_pll_div_set_rate,
+};
+
+static struct clk_hw *clk_register_pll_div(const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		struct clk_hw *pll_hw, spinlock_t *lock)
+{
+	struct stm32f4_pll_div *pll_div;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	/* allocate the divider */
+	pll_div = kzalloc(sizeof(*pll_div), GFP_KERNEL);
+	if (!pll_div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &stm32f4_pll_div_ops;
+	init.flags = flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_divider assignments */
+	pll_div->div.reg = reg;
+	pll_div->div.shift = shift;
+	pll_div->div.width = width;
+	pll_div->div.flags = clk_divider_flags;
+	pll_div->div.lock = lock;
+	pll_div->div.table = table;
+	pll_div->div.hw.init = &init;
+
+	pll_div->hw_pll = pll_hw;
+
+	/* register the clock */
+	hw = &pll_div->div.hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll_div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+static struct clk_hw *stm32f4_rcc_register_pll(const char *pllsrc,
+		const struct stm32f4_pll_data *data,  spinlock_t *lock)
+{
+	struct stm32f4_pll *pll;
+	struct clk_init_data init = { NULL };
+	void __iomem *reg;
+	struct clk_hw *pll_hw;
+	int ret;
+	int i;
+	const struct stm32f4_vco_data *vco;
+
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	vco = &vco_data[data->pll_num];
+
+	init.name = vco->vco_name;
+	init.ops = &stm32f4_pll_gate_ops;
+	init.flags = CLK_SET_RATE_GATE;
+	init.parent_names = &pllsrc;
+	init.num_parents = 1;
+
+	pll->gate.lock = lock;
+	pll->gate.reg = base + STM32F4_RCC_CR;
+	pll->gate.bit_idx = vco->bit_idx;
+	pll->gate.hw.init = &init;
+
+	pll->offset = vco->offset;
+	pll->n_start = data->n_start;
+	pll->bit_rdy_idx = vco->bit_rdy_idx;
+	pll->status = (readl(base + STM32F4_RCC_CR) >> vco->bit_idx) & 0x1;
+
+	reg = base + pll->offset;
+
+	pll_hw = &pll->gate.hw;
+	ret = clk_hw_register(NULL, pll_hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	for (i = 0; i < MAX_PLL_DIV; i++)
+		if (data->div_name[i])
+			clk_register_pll_div(data->div_name[i],
+					vco->vco_name,
+					0,
+					reg,
+					div_data[i].shift,
+					div_data[i].width,
+					div_data[i].flag_div,
+					div_data[i].div_table,
+					pll_hw,
+					lock);
+	return pll_hw;
 }
 
 /*
@@ -620,18 +912,21 @@ struct stm32f4_clk_data {
 	const struct stm32f4_gate_data *gates_data;
 	const u64 *gates_map;
 	int gates_num;
+	const struct stm32f4_pll_data *pll_data;
 };
 
 static const struct stm32f4_clk_data stm32f429_clk_data = {
 	.gates_data	= stm32f429_gates,
 	.gates_map	= stm32f42xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f429_gates),
+	.pll_data	= stm32f429_pll,
 };
 
 static const struct stm32f4_clk_data stm32f469_clk_data = {
 	.gates_data	= stm32f469_gates,
 	.gates_map	= stm32f46xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f469_gates),
+	.pll_data	= stm32f469_pll,
 };
 
 static const struct of_device_id stm32f4_of_match[] = {
@@ -652,6 +947,9 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	int n;
 	const struct of_device_id *match;
 	const struct stm32f4_clk_data *data;
+	unsigned long pllcfgr;
+	const char *pllsrc;
+	unsigned long pllm;
 
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -682,7 +980,21 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
 			16000000, 160000);
-	stm32f4_rcc_register_pll(hse_clk, "hsi");
+	pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	pllsrc = pllcfgr & BIT(22) ? hse_clk : "hsi";
+	pllm = pllcfgr & 0x3f;
+
+	clk_hw_register_fixed_factor(NULL, "vco_in", pllsrc,
+					       0, 1, pllm);
+
+	stm32f4_rcc_register_pll("vco_in", &data->pll_data[0],
+			&stm32f4_clk_lock);
+
+	clks[PLL_VCO_I2S] = stm32f4_rcc_register_pll("vco_in",
+			&data->pll_data[1], &stm32f4_clk_lock);
+
+	clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
+			&data->pll_data[2], &stm32f4_clk_lock);
 
 	sys_parents[1] = hse_clk;
 	clk_register_mux_table(
diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
index 3132b6a..56b8e10 100644
--- a/include/dt-bindings/clock/stm32f4-clock.h
+++ b/include/dt-bindings/clock/stm32f4-clock.h
@@ -25,7 +25,9 @@
 #define CLK_LSE			3
 #define CLK_HSE_RTC		4
 #define CLK_RTC			5
+#define PLL_VCO_I2S		6
+#define PLL_VCO_SAI		7
 
-#define END_PRIMARY_CLK		6
+#define END_PRIMARY_CLK		8
 
 #endif
-- 
1.9.1
