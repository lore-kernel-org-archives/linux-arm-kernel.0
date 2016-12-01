From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:46 +0100
Subject: [PATCH v3 6/9] clk: stm32f4: Add SAI clocks
In-Reply-To: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
References: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1480606069-5178-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces SAI clocks for stm32f4 socs.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 3063b30..02339d1 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -937,6 +937,9 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 
 static const char *i2s_parents[2] = { "plli2s-r", NULL };
 
+static const char *sai_parents[4] = { "pllsai-q-div", "plli2s-q-div", NULL,
+	"no-clock" };
+
 struct stm32_aux_clk {
 	int idx;
 	const char *name;
@@ -977,6 +980,18 @@ struct stm32f4_clk_data {
 		NO_GATE, 0,
 		CLK_SET_RATE_PARENT
 	},
+	{
+		CLK_SAI1, "sai1-a", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 20, 3,
+		STM32F4_RCC_APB2ENR, 22,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_SAI2, "sai1-b", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 22, 3,
+		STM32F4_RCC_APB2ENR, 22,
+		CLK_SET_RATE_PARENT
+	},
 };
 
 static const struct stm32f4_clk_data stm32f429_clk_data = {
@@ -1109,6 +1124,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	i2s_in_clk = of_clk_get_parent_name(np, 1);
 
 	i2s_parents[1] = i2s_in_clk;
+	sai_parents[2] = i2s_in_clk;
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
 			16000000, 160000);
-- 
1.9.1
