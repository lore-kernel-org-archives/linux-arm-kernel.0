From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 7 Nov 2016 14:05:38 +0100
Subject: [PATCH 1/6] clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469
 boards
In-Reply-To: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
References: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1478523943-23142-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces PLL_I2S and PLL_SAI.
Vco clock of these PLLs can be modify by DT (only n multiplicator,
m divider is still fixed by the boot-loader).
Each PLL has 3 dividers. PLL should be off when we modify the rate.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 371 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 359 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index c2661e2..7641acd 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -28,6 +28,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
+#define STM32F4_RCC_CR			0x00
 #define STM32F4_RCC_PLLCFGR		0x04
 #define STM32F4_RCC_CFGR		0x08
 #define STM32F4_RCC_AHB1ENR		0x30
@@ -37,6 +38,9 @@
 #define STM32F4_RCC_APB2ENR		0x44
 #define STM32F4_RCC_BDCR		0x70
 #define STM32F4_RCC_CSR			0x74
+#define STM32F4_RCC_PLLI2SCFGR		0x84
+#define STM32F4_RCC_PLLSAICFGR		0x88
+#define STM32F4_RCC_DCKCFGR		0x8c
 
 struct stm32f4_gate_data {
 	u8	offset;
@@ -208,7 +212,11 @@ struct stm32f4_gate_data {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
-enum { SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC, END_PRIMARY_CLK };
+enum {
+	SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC,
+	PLL_VCO_I2S, PLL_VCO_SAI,
+	END_PRIMARY_CLK
+};
 
 /*
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
@@ -324,23 +332,344 @@ static struct clk *clk_register_apb_mul(struct device *dev, const char *name,
 	return clk;
 }
 
+enum {
+	PLL,
+	PLL_I2S,
+	PLL_SAI,
+};
+
+struct stm32f4_pll {
+	spinlock_t *lock;
+	struct clk_hw hw;
+	u8 offset;
+	u8 bit_idx;
+	u8 bit_rdy_idx;
+	u8 status;
+	u8 n_start;
+};
+
+struct stm32f4_pll_data {
+	u8 pll_num;
+	u8 n_start;
+	const char *vco_name;
+	const char *p_name;
+	const char *q_name;
+	const char *r_name;
+};
+
+static const struct stm32f4_pll_data stm32f429_pll[] = {
+	{ PLL,	   192, "vco",	   "pll", "pll48",    NULL, },
+	{ PLL_I2S, 192, "vco-i2s", NULL,  "plli2s-q", "plli2s-r", },
+	{ PLL_SAI,  49, "vco-sai", NULL,  "pllsai-q", "pllsai-r", },
+};
+
+static const struct stm32f4_pll_data stm32f469_pll[] = {
+	{ PLL,	   50, "vco",	  "pll",      "pll-q",    NULL, },
+	{ PLL_I2S, 50, "vco-i2s", NULL,	      "plli2s-q", "plli2s-r", },
+	{ PLL_SAI, 50, "vco-sai", "pllsai-p", "pllsai-q", "pllsai-r", },
+};
+
+#define to_stm32f4_pll(_hw) container_of(_hw, struct stm32f4_pll, hw)
+
+static int stm32f4_pll_is_enabled(struct clk_hw *hw)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+
+	return pll->status;
+}
+
+static int __stm32f4_pll_enable(struct clk_hw *hw)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	unsigned long reg;
+	int ret = 0;
+
+	if (stm32f4_pll_is_enabled(hw))
+		return 0;
+
+	reg = readl(base + STM32F4_RCC_CR) | (1 << pll->bit_idx);
+	writel(reg, base + STM32F4_RCC_CR);
+
+	ret = readl_relaxed_poll_timeout_atomic(base + STM32F4_RCC_CR, reg,
+			reg & (1 << pll->bit_rdy_idx), 0, 10000);
+
+	pll->status = 1;
+
+	return ret;
+}
+
+static int stm32f4_pll_enable(struct clk_hw *hw)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	int ret = 0;
+	unsigned long flags = 0;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	ret = __stm32f4_pll_enable(hw);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+
+	return ret;
+}
+
+static void __stm32f4_pll_disable(struct clk_hw *hw)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	unsigned long reg;
+
+	reg = readl(base + STM32F4_RCC_CR) & ~(1 << pll->bit_idx);
+
+	writel(reg, base + STM32F4_RCC_CR);
+
+	pll->status = 0;
+}
+
+static void stm32f4_pll_disable(struct clk_hw *hw)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	unsigned long flags = 0;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	__stm32f4_pll_disable(hw);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+}
+
+static unsigned long stm32f4_pll_recalc(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	unsigned long pllm = pllcfgr & 0x3f;
+	unsigned long plln = (readl(base + pll->offset) >> 6) & 0x1ff;
+
+	return (parent_rate / pllm) * plln;
+}
+
+static long stm32f4_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	unsigned long m = pllcfgr & 0x3f;
+	unsigned long n;
+
+	n = (rate * m) / *prate;
+
+	if (n < pll->n_start)
+		n = pll->n_start;
+	else if (n > 432)
+		n = 432;
+
+	return (*prate / m) * n;
+}
+
+static int stm32f4_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct stm32f4_pll *pll = to_stm32f4_pll(hw);
+	unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	unsigned long m = pllcfgr & 0x3f;
+	unsigned long n;
+	unsigned long val;
+	int pll_state;
+
+	pll_state = stm32f4_pll_is_enabled(hw);
+
+	if (pll_state)
+		stm32f4_pll_disable(hw);
+
+	n = (rate * m) / parent_rate;
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
+static const struct clk_div_table pll_divp_table[] = {
+	{ 0, 2 }, { 1, 4 }, { 2, 6 }, { 3, 8 },
+};
+
 /*
  * Decode current PLL state and (statically) model the state we inherit from
  * the bootloader.
  */
-static void stm32f4_rcc_register_pll(const char *hse_clk, const char *hsi_clk)
+
+static struct clk_hw *stm32f4_rcc_register_pll(const char *pllsrc,
+		const struct stm32f4_pll_data *data,  spinlock_t *lock)
 {
-	unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	struct stm32f4_pll *pll;
+	struct clk_init_data init = { NULL };
+	void __iomem *reg;
+	struct clk_hw *pll_hw;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = data->vco_name;
+	init.ops = &stm32f4_pll_gate_ops;
+	init.flags = CLK_IGNORE_UNUSED;
+	init.parent_names = &pllsrc;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+
+	switch (data->pll_num) {
+	case PLL:
+		pll->offset = STM32F4_RCC_PLLCFGR;
+		pll->bit_idx = 24;
+		pll->bit_rdy_idx = 25;
+		break;
+	case PLL_I2S:
+		pll->offset = STM32F4_RCC_PLLI2SCFGR;
+		pll->bit_idx = 26;
+		pll->bit_rdy_idx = 27;
+		break;
+	case PLL_SAI:
+		pll->offset = STM32F4_RCC_PLLSAICFGR;
+		pll->bit_idx = 28;
+		pll->bit_rdy_idx = 29;
+		break;
+	};
+
+	pll->n_start = data->n_start;
+	pll->status = (readl(base + STM32F4_RCC_CR) >> pll->bit_idx) & 0x1;
+	reg = base + pll->offset;
+
+	pll_hw = &pll->hw;
+	ret = clk_hw_register(NULL, pll_hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	if (data->p_name)
+		clk_register_pll_div(data->p_name, data->vco_name, 0, reg,
+				16, 2, 0, pll_divp_table, pll_hw, lock);
+
+	if (data->q_name)
+		clk_register_pll_div(data->q_name, data->vco_name, 0, reg,
+				24, 4, CLK_DIVIDER_ONE_BASED, NULL,
+				pll_hw, lock);
 
-	unsigned long pllm   = pllcfgr & 0x3f;
-	unsigned long plln   = (pllcfgr >> 6) & 0x1ff;
-	unsigned long pllp   = BIT(((pllcfgr >> 16) & 3) + 1);
-	const char   *pllsrc = pllcfgr & BIT(22) ? hse_clk : hsi_clk;
-	unsigned long pllq   = (pllcfgr >> 24) & 0xf;
+	if (data->r_name)
+		clk_register_pll_div(data->r_name, data->vco_name, 0, reg,
+				28, 3, CLK_DIVIDER_ONE_BASED, NULL,  pll_hw,
+				lock);
 
-	clk_register_fixed_factor(NULL, "vco", pllsrc, 0, plln, pllm);
-	clk_register_fixed_factor(NULL, "pll", "vco", 0, 1, pllp);
-	clk_register_fixed_factor(NULL, "pll48", "vco", 0, 1, pllq);
+	return pll_hw;
 }
 
 /*
@@ -615,18 +944,24 @@ struct stm32f4_clk_data {
 	const struct stm32f4_gate_data *gates_data;
 	const u64 *gates_map;
 	int gates_num;
+	const struct stm32f4_pll_data *pll_data;
+	int pll_num;
 };
 
 static const struct stm32f4_clk_data stm32f429_clk_data = {
 	.gates_data	= stm32f429_gates,
 	.gates_map	= stm32f42xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f429_gates),
+	.pll_data	= stm32f429_pll,
+	.pll_num	= ARRAY_SIZE(stm32f429_pll),
 };
 
 static const struct stm32f4_clk_data stm32f469_clk_data = {
 	.gates_data	= stm32f469_gates,
 	.gates_map	= stm32f46xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f469_gates),
+	.pll_data	= stm32f469_pll,
+	.pll_num	= ARRAY_SIZE(stm32f469_pll),
 };
 
 static const struct of_device_id stm32f4_of_match[] = {
@@ -647,6 +982,8 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	int n;
 	const struct of_device_id *match;
 	const struct stm32f4_clk_data *data;
+	unsigned long pllcfgr;
+	const char *pllsrc;
 
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -677,7 +1014,17 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
 			16000000, 160000);
-	stm32f4_rcc_register_pll(hse_clk, "hsi");
+	pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
+	pllsrc = pllcfgr & BIT(22) ? hse_clk : "hsi";
+
+	stm32f4_rcc_register_pll(pllsrc, &data->pll_data[0],
+			&stm32f4_clk_lock);
+
+	clks[PLL_VCO_I2S] = stm32f4_rcc_register_pll(pllsrc,
+			&data->pll_data[1], &stm32f4_clk_lock);
+
+	clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll(pllsrc,
+			&data->pll_data[2], &stm32f4_clk_lock);
 
 	sys_parents[1] = hse_clk;
 	clk_register_mux_table(
-- 
1.9.1
