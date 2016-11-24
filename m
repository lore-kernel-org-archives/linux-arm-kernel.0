From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 24 Nov 2016 15:45:45 +0100
Subject: [PATCH v2 5/9] clk: stm32f4: Add I2S clock
In-Reply-To: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1479998749-20358-6-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces I2S clock for stm32f4 soc.
The I2S clock could be derived from an external clock or from pll-i2s

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 Documentation/devicetree/bindings/clock/st,stm32-rcc.txt |  4 +++-
 drivers/clk/clk-stm32f4.c                                | 14 +++++++++++++-
 include/dt-bindings/clock/stm32f4-clock.h                |  3 ++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 4cd08da6..8c1ca68 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -19,6 +19,7 @@ Required properties:
   use.
 - clocks: External oscillator clock phandle
   - high speed external clock signal (HSE)
+  - external I2S clock (I2S_CKIN)
 
 Example:
 
@@ -27,7 +28,7 @@ Example:
 		#clock-cells = <2>
 		compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
 		reg = <0x40023800 0x400>;
-		clocks = <&clk_hse>;
+		clocks = <&clk_hse>, <&clk_i2s_ckin>;
 	};
 
 Specifying gated clocks
@@ -77,6 +78,7 @@ The secondary index is bound with the following magic numbers:
 	6	PLL_VCO_I2S	(vco frequency of I2S pll)
 	7	PLL_VCO_SAI	(vco frequency of SAI pll)
 	8	CLK_LCD		(LCD-TFT)
+	9	CLK_I2S		(I2S clocks)
 
 Example:
 
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
diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
index 1be4a3a..b129ab9 100644
--- a/include/dt-bindings/clock/stm32f4-clock.h
+++ b/include/dt-bindings/clock/stm32f4-clock.h
@@ -28,7 +28,8 @@
 #define PLL_VCO_I2S		6
 #define PLL_VCO_SAI		7
 #define CLK_LCD			8
+#define CLK_I2S			9
 
-#define END_PRIMARY_CLK		9
+#define END_PRIMARY_CLK		10
 
 #endif
-- 
1.9.1
