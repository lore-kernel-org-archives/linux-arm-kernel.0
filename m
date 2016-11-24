From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 24 Nov 2016 15:45:43 +0100
Subject: [PATCH v2 3/9] clk: stm32f4: Add post divisor for I2S & SAI PLLs
In-Reply-To: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1479998749-20358-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds post dividers of I2S & SAI PLLs.
These dividers are managed by a dedicated register (RCC_DCKCFGR).
The PLL should be off before a set rate.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index c2b62cc..3918305 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -357,6 +357,18 @@ struct stm32f4_pll {
 
 #define to_stm32f4_pll(_gate) container_of(_gate, struct stm32f4_pll, gate)
 
+struct stm32f4_pll_post_div_data {
+	u8 pll_num;
+	const char *name;
+	const char *parent;
+	u8 flag;
+	u8 offset;
+	u8 shift;
+	u8 width;
+	u8 flag_div;
+	const struct clk_div_table *div_table;
+};
+
 struct stm32f4_vco_data {
 	const char *vco_name;
 	u8 offset;
@@ -370,6 +382,18 @@ struct stm32f4_vco_data {
 	{ "vco-sai", STM32F4_RCC_PLLSAICFGR, 28, 29 },
 };
 
+#define MAX_POST_DIV 3
+static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
+	{ PLL_I2S, "plli2s-q-div", "plli2s-q", CLK_SET_RATE_PARENT,
+		STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},
+
+	{ PLL_SAI, "pllsai-q-div", "pllsai-q", CLK_SET_RATE_PARENT,
+		STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },
+
+	{ PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
+		STM32F4_RCC_DCKCFGR, 16, 2, CLK_DIVIDER_POWER_OF_TWO},
+};
+
 struct stm32f4_div_data {
 	u8 shift;
 	u8 width;
@@ -996,6 +1020,23 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
 			&data->pll_data[2], &stm32f4_clk_lock);
 
+	for (n = 0; n < MAX_POST_DIV; n++) {
+		const struct stm32f4_pll_post_div_data *post_div;
+
+		post_div = &post_div_data[n];
+
+		clk_register_pll_div(post_div->name,
+				post_div->parent,
+				post_div->flag,
+				base + post_div->offset,
+				post_div->shift,
+				post_div->width,
+				post_div->flag_div,
+				post_div->div_table,
+				clks[post_div->pll_num],
+				&stm32f4_clk_lock);
+	}
+
 	sys_parents[1] = hse_clk;
 	clk_register_mux_table(
 	    NULL, "sys", sys_parents, ARRAY_SIZE(sys_parents), 0,
-- 
1.9.1
