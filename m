From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Aug 2017 14:18:54 +0200
Subject: [PATCH] rtc: sun6i: Add support for the external oscillator gate
Message-ID: <20170824121854.23995-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC can output its 32kHz clock outside of the SoC, for example to clock
a WiFi chip.

Create a new clock that other devices will be able to retrieve, while
maintaining the DT stability by providing a default name for that clock if
clock-output-names doesn't list one.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/rtc/sun6i-rtc.txt          |  4 ++--
 drivers/rtc/rtc-sun6i.c                            | 24 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index 945934918b71..d5e26d313f62 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Required properties for new device trees
 - clocks	: phandle to the 32kHz external oscillator
-- clock-output-names : name of the LOSC clock created
+- clock-output-names : names of the LOSC and its external output clocks created
 - #clock-cells  : must be equals to 1. The RTC provides two clocks: the
 		  LOSC and its external output, with index 0 and 1
 		  respectively.
@@ -21,7 +21,7 @@ rtc: rtc at 01f00000 {
 	compatible = "allwinner,sun6i-a31-rtc";
 	reg = <0x01f00000 0x54>;
 	interrupts = <0 40 4>, <0 41 4>;
-	clock-output-names = "osc32k";
+	clock-output-names = "osc32k", "osc32k-out";
 	clocks = <&ext_osc32k>;
 	#clock-cells = <1>;
 };
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 39cbc1238b92..d4a6ddbfd872 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -73,6 +73,9 @@
 #define SUN6I_ALARM_CONFIG			0x0050
 #define SUN6I_ALARM_CONFIG_WAKEUP		BIT(0)
 
+#define SUN6I_LOSC_OUT_GATING			0x0060
+#define SUN6I_LOSC_OUT_GATING_EN		BIT(0)
+
 /*
  * Get date values
  */
@@ -125,6 +128,7 @@ struct sun6i_rtc_dev {
 	struct clk_hw hw;
 	struct clk_hw *int_osc;
 	struct clk *losc;
+	struct clk *ext_losc;
 
 	spinlock_t lock;
 };
@@ -188,6 +192,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	struct clk_init_data init = {
 		.ops		= &sun6i_rtc_osc_ops,
 	};
+	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
 
 	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
@@ -195,7 +200,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 		return;
 	spin_lock_init(&rtc->lock);
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws),
+	clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
 			   GFP_KERNEL);
 	if (!clk_data)
 		return;
@@ -235,7 +240,8 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 
 	init.parent_names = parents;
 	init.num_parents = of_clk_get_parent_count(node) + 1;
-	of_property_read_string(node, "clock-output-names", &init.name);
+	of_property_read_string_index(node, "clock-output-names", 0,
+				      &init.name);
 
 	rtc->losc = clk_register(NULL, &rtc->hw);
 	if (IS_ERR(rtc->losc)) {
@@ -243,8 +249,20 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 		return;
 	}
 
-	clk_data->num = 1;
+	of_property_read_string_index(node, "clock-output-names", 1,
+				      &clkout_name);
+	rtc->ext_losc = clk_register_gate(NULL, clkout_name, rtc->hw.init->name,
+					  0, rtc->base + SUN6I_LOSC_OUT_GATING,
+					  SUN6I_LOSC_OUT_GATING_EN, 0,
+					  &rtc->lock);
+	if (IS_ERR(rtc->ext_losc)) {
+		pr_crit("Couldn't register the LOSC external gate\n");
+		return;
+	}
+
+	clk_data->num = 2;
 	clk_data->hws[0] = &rtc->hw;
+	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
-- 
2.13.5
