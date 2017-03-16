From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 16 Mar 2017 09:16:41 +0100
Subject: [PATCH v2 2/2] clk: stm32f4: fix timeout management for pll and ready
 gate
In-Reply-To: <1489652201-19889-1-git-send-email-gabriel.fernandez@st.com>
References: <1489652201-19889-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1489652201-19889-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Use a classic polling to test bit ready.
And the shift of the bit ready of LSE & LSI were wrongs.

Fixes: 861adc44d290 ("clk: stm32f4: Add LSI & LSE clocks")

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index cf9449b3..68e2a4e 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -531,19 +531,26 @@ static int stm32f4_pll_is_enabled(struct clk_hw *hw)
 	return clk_gate_ops.is_enabled(hw);
 }
 
+#define PLL_TIMEOUT 10000
+
 static int stm32f4_pll_enable(struct clk_hw *hw)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	struct stm32f4_pll *pll = to_stm32f4_pll(gate);
-	int ret = 0;
-	unsigned long reg;
+	int bit_status;
+	unsigned int timeout = PLL_TIMEOUT;
 
-	ret = clk_gate_ops.enable(hw);
+	if (clk_gate_ops.is_enabled(hw))
+		return 0;
+
+	clk_gate_ops.enable(hw);
 
-	ret = readl_relaxed_poll_timeout_atomic(base + STM32F4_RCC_CR, reg,
-			reg & (1 << pll->bit_rdy_idx), 0, 10000);
+	do {
+		bit_status = !(readl(gate->reg) & BIT(pll->bit_rdy_idx));
 
-	return ret;
+	} while (bit_status && --timeout);
+
+	return bit_status;
 }
 
 static void stm32f4_pll_disable(struct clk_hw *hw)
@@ -834,24 +841,32 @@ struct stm32_rgate {
 	u8	bit_rdy_idx;
 };
 
-#define RTC_TIMEOUT 1000000
+#define RGATE_TIMEOUT 50000
 
 static int rgclk_enable(struct clk_hw *hw)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	struct stm32_rgate *rgate = to_rgclk(gate);
-	u32 reg;
-	int ret;
+	int bit_status;
+	unsigned int timeout = RGATE_TIMEOUT;
+
+	if (clk_gate_ops.is_enabled(hw))
+		return 0;
 
 	disable_power_domain_write_protection();
 
 	clk_gate_ops.enable(hw);
 
-	ret = readl_relaxed_poll_timeout_atomic(gate->reg, reg,
-			reg & rgate->bit_rdy_idx, 1000, RTC_TIMEOUT);
+	do {
+		bit_status = !(readl(gate->reg) & BIT(rgate->bit_rdy_idx));
+		if (bit_status)
+			udelay(100);
+
+	} while (bit_status && --timeout);
 
 	enable_power_domain_write_protection();
-	return ret;
+
+	return bit_status;
 }
 
 static void rgclk_disable(struct clk_hw *hw)
@@ -1533,7 +1548,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	}
 
 	clks[CLK_LSI] = clk_register_rgate(NULL, "lsi", "clk-lsi", 0,
-			base + STM32F4_RCC_CSR, 0, 2, 0, &stm32f4_clk_lock);
+			base + STM32F4_RCC_CSR, 0, 1, 0, &stm32f4_clk_lock);
 
 	if (IS_ERR(clks[CLK_LSI])) {
 		pr_err("Unable to register lsi clock\n");
@@ -1541,7 +1556,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	}
 
 	clks[CLK_LSE] = clk_register_rgate(NULL, "lse", "clk-lse", 0,
-			base + STM32F4_RCC_BDCR, 0, 2, 0, &stm32f4_clk_lock);
+			base + STM32F4_RCC_BDCR, 0, 1, 0, &stm32f4_clk_lock);
 
 	if (IS_ERR(clks[CLK_LSE])) {
 		pr_err("Unable to register lse clock\n");
-- 
1.9.1
