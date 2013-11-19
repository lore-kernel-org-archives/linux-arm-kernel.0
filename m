From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 19 Nov 2013 13:13:05 -0500
Subject: [PATCH 1/4] clk: keystone: use clkod register bits for postdiv
Message-ID: <1384884788-29137-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DDR3A/B, ARM and PA PLL controllers have clkod register bits for
configuring postdiv values. So use it instead of using fixed
post dividers for these pll controllers. Assume that if fixed-postdiv
attribute is not present, use clkod register value for pistdiv.

Also update the Documentation of bindings to reflect the same.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 .../devicetree/bindings/clock/keystone-pll.txt     |    8 +++----
 drivers/clk/keystone/pll.c                         |   25 ++++++++++++++++----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/keystone-pll.txt b/Documentation/devicetree/bindings/clock/keystone-pll.txt
index 12bd726..225990f 100644
--- a/Documentation/devicetree/bindings/clock/keystone-pll.txt
+++ b/Documentation/devicetree/bindings/clock/keystone-pll.txt
@@ -17,13 +17,14 @@ Required properties:
 - reg - pll control0 and pll multipler registers
 - reg-names : control and multiplier. The multiplier is applicable only for
 		main pll clock
-- fixed-postdiv : fixed post divider value
+- fixed-postdiv : fixed post divider value. If absent, use clkod register bits
+		for postdiv
 
 Example:
 	mainpllclk: mainpllclk at 2310110 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclksys>;
 		reg = <0x02620350 4>, <0x02310110 4>;
 		reg-names = "control", "multiplier";
 		fixed-postdiv = <2>;
@@ -32,11 +33,10 @@ Example:
 	papllclk: papllclk at 2620358 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkpass>;
 		clock-output-names = "pa-pll-clk";
 		reg = <0x02620358 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 Required properties:
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index 47a1bd9..f59d5db 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -24,6 +24,8 @@
 #define MAIN_PLLM_HIGH_MASK	0x7f000
 #define PLLM_HIGH_SHIFT		6
 #define PLLD_MASK		0x3f
+#define CLKOD_MASK		0x780000
+#define CLKOD_SHIFT		19
 
 /**
  * struct clk_pll_data - pll data structure
@@ -41,7 +43,10 @@
  * @pllm_upper_mask: multiplier upper mask
  * @pllm_upper_shift: multiplier upper shift
  * @plld_mask: divider mask
- * @postdiv: Post divider
+ * @clkod_mask: output divider mask
+ * @clkod_shift: output divider shift
+ * @plld_mask: divider mask
+ * @postdiv: Fixed post divider
  */
 struct clk_pll_data {
 	bool has_pllctrl;
@@ -53,6 +58,8 @@ struct clk_pll_data {
 	u32 pllm_upper_mask;
 	u32 pllm_upper_shift;
 	u32 plld_mask;
+	u32 clkod_mask;
+	u32 clkod_shift;
 	u32 postdiv;
 };
 
@@ -87,10 +94,17 @@ static unsigned long clk_pllclk_recalc(struct clk_hw *hw,
 
 	/* bit6-12 of PLLM is in Main PLL control register */
 	val = readl(pll_data->pll_ctl0);
+
 	mult |= ((val & pll_data->pllm_upper_mask)
 			>> pll_data->pllm_upper_shift);
 	prediv = (val & pll_data->plld_mask);
-	postdiv = pll_data->postdiv;
+
+	if (!pll_data->has_pllctrl)
+		/* read post divider from od bits*/
+		postdiv = ((val & pll_data->clkod_mask) >>
+				 pll_data->clkod_shift) + 1;
+	else
+		postdiv = pll_data->postdiv;
 
 	rate /= (prediv + 1);
 	rate = (rate * (mult + 1));
@@ -155,8 +169,11 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 	parent_name = of_clk_get_parent_name(node, 0);
-	if (of_property_read_u32(node, "fixed-postdiv",	&pll_data->postdiv))
-		goto out;
+	if (of_property_read_u32(node, "fixed-postdiv",	&pll_data->postdiv)) {
+		/* assume the PLL has output divider register bits */
+		pll_data->clkod_mask = CLKOD_MASK;
+		pll_data->clkod_shift = CLKOD_SHIFT;
+	}
 
 	i = of_property_match_string(node, "reg-names", "control");
 	pll_data->pll_ctl0 = of_iomap(node, i);
-- 
1.7.9.5
