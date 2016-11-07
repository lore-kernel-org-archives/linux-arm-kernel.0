From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 7 Nov 2016 14:05:41 +0100
Subject: [PATCH 4/6] clk: stm32f4: Add I2S clock
In-Reply-To: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
References: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1478523943-23142-5-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces I2S clock for stm32f4 soc.
The I2S clock could be derived from an external clock or from pll-i2s

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 5fa5d51..b7cb359 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -216,6 +216,7 @@ enum {
 	SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC,
 	PLL_VCO_I2S, PLL_VCO_SAI,
 	CLK_LCD,
+	CLK_I2S,
 	END_PRIMARY_CLK
 };
 
@@ -967,6 +968,8 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 
 static const char *sdmux_parents[2] = { "pll48", "sys" };
 
+static const char *i2s_parents[2] = { "plli2s-r", NULL };
+
 struct stm32f4_clk_data {
 	const struct stm32f4_gate_data *gates_data;
 	const u64 *gates_map;
@@ -1005,7 +1008,7 @@ struct stm32f4_clk_data {
 
 static void __init stm32f4_rcc_init(struct device_node *np)
 {
-	const char *hse_clk;
+	const char *hse_clk, *i2s_in_clk;
 	int n;
 	const struct of_device_id *match;
 	const struct stm32f4_clk_data *data;
@@ -1038,6 +1041,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	stm32f4_gate_map = data->gates_map;
 
 	hse_clk = of_clk_get_parent_name(np, 0);
+	i2s_in_clk = of_clk_get_parent_name(np, 1);
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
 			16000000, 160000);
@@ -1053,6 +1057,12 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll(pllsrc,
 			&data->pll_data[2], &stm32f4_clk_lock);
 
+	i2s_parents[1] = i2s_in_clk;
+
+	clks[CLK_I2S] =	clk_hw_register_mux_table(NULL, "i2s",
+				i2s_parents, ARRAY_SIZE(i2s_parents), 0,
+				base + STM32F4_RCC_CFGR, 23, 1, 0, NULL,
+				&stm32f4_clk_lock);
 	sys_parents[1] = hse_clk;
 	clk_register_mux_table(
 	    NULL, "sys", sys_parents, ARRAY_SIZE(sys_parents), 0,
-- 
1.9.1
