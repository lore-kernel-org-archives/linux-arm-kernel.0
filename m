From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:45 +0100
Subject: [PATCH v3 5/9] clk: stm32f4: Add I2S clock
In-Reply-To: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
References: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1480606069-5178-6-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces I2S clock for stm32f4 soc.
The I2S clock could be derived from an external clock or from pll-i2s

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 86244fc..3063b30 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -935,6 +935,8 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 
 static const char *lcd_parent[1] = { "pllsai-r-div" };
 
+static const char *i2s_parents[2] = { "plli2s-r", NULL };
+
 struct stm32_aux_clk {
 	int idx;
 	const char *name;
@@ -969,6 +971,12 @@ struct stm32f4_clk_data {
 		STM32F4_RCC_APB2ENR, 26,
 		CLK_SET_RATE_PARENT
 	},
+	{
+		CLK_I2S, "i2s", i2s_parents, ARRAY_SIZE(i2s_parents),
+		STM32F4_RCC_CFGR, 23, 1,
+		NO_GATE, 0,
+		CLK_SET_RATE_PARENT
+	},
 };
 
 static const struct stm32f4_clk_data stm32f429_clk_data = {
@@ -1063,7 +1071,7 @@ static struct clk_hw *stm32_register_aux_clk(const char *name,
 
 static void __init stm32f4_rcc_init(struct device_node *np)
 {
-	const char *hse_clk;
+	const char *hse_clk, *i2s_in_clk;
 	int n;
 	const struct of_device_id *match;
 	const struct stm32f4_clk_data *data;
@@ -1098,6 +1106,10 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	hse_clk = of_clk_get_parent_name(np, 0);
 
+	i2s_in_clk = of_clk_get_parent_name(np, 1);
+
+	i2s_parents[1] = i2s_in_clk;
+
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
 			16000000, 160000);
 	pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
-- 
1.9.1
