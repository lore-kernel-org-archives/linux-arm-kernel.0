From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 13 Dec 2016 15:20:17 +0100
Subject: [PATCH v4 6/9] clk: stm32f4: Add SAI clocks
In-Reply-To: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1481638820-29324-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces SAI clocks for stm32f4 socs.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index a7a6a16..2bff436 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -948,6 +948,9 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 
 static const char *i2s_parents[2] = { "plli2s-r", NULL };
 
+static const char *sai_parents[4] = { "pllsai-q-div", "plli2s-q-div", NULL,
+	"no-clock" };
+
 struct stm32_aux_clk {
 	int idx;
 	const char *name;
@@ -983,6 +986,18 @@ struct stm32f4_clk_data {
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
@@ -1115,6 +1130,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	i2s_in_clk = of_clk_get_parent_name(np, 1);
 
 	i2s_parents[1] = i2s_in_clk;
+	sai_parents[2] = i2s_in_clk;
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
 			16000000, 160000);
-- 
1.9.1
