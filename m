From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 24 Nov 2016 15:45:46 +0100
Subject: [PATCH v2 6/9] clk: stm32f4: Add SAI clocks
In-Reply-To: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1479998749-20358-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces SAI clocks for stm32f4 socs.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 Documentation/devicetree/bindings/clock/st,stm32-rcc.txt |  2 ++
 drivers/clk/clk-stm32f4.c                                | 16 ++++++++++++++++
 include/dt-bindings/clock/stm32f4-clock.h                |  4 +++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 8c1ca68..8f93740 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -79,6 +79,8 @@ The secondary index is bound with the following magic numbers:
 	7	PLL_VCO_SAI	(vco frequency of SAI pll)
 	8	CLK_LCD		(LCD-TFT)
 	9	CLK_I2S		(I2S clocks)
+	10	CLK_SAI1	(audio clocks)
+	11	CLK_SAI2
 
 Example:
 
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
diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
index b129ab9..5431f00 100644
--- a/include/dt-bindings/clock/stm32f4-clock.h
+++ b/include/dt-bindings/clock/stm32f4-clock.h
@@ -29,7 +29,9 @@
 #define PLL_VCO_SAI		7
 #define CLK_LCD			8
 #define CLK_I2S			9
+#define CLK_SAI1		10
+#define CLK_SAI2		11
 
-#define END_PRIMARY_CLK		10
+#define END_PRIMARY_CLK		12
 
 #endif
-- 
1.9.1
