From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:06 +0800
Subject: [PATCH 08/15] rtc: sun6i: Expose internal oscillator through device
 tree
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings have been updated to expose the RTC's internal oscillator,
for some SoCs that have it directly feeding the PRCM block. The changes
include the index 2 for the clock outputs, as well as the clock output
names.

This patch adds the internal oscillator to the list of clocks exposed
through of_clk_add_hw_provider(), and also have the driver optionally
fetch the name of the clock from the device tree if it's available.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 62ed9ce53d8c..273ab7fbbbe3 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -220,6 +220,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		.ops		= &sun6i_rtc_osc_ops,
 		.name		= "losc",
 	};
+	const char *iosc_name = "rtc-int-osc";
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
 
@@ -228,7 +229,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		return;
 
 	rtc->data = data;
-	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, 3), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
 		return;
@@ -253,8 +254,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	if (!of_get_property(node, "clocks", NULL))
 		goto err;
 
+	of_property_read_string_index(node, "clock-output-names", 2,
+				      &iosc_name);
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
-								"rtc-int-osc",
+								iosc_name,
 								NULL, 0,
 								rtc->data->rc_osc_rate,
 								300000000);
@@ -290,9 +293,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		return;
 	}
 
-	clk_data->num = 2;
+	clk_data->num = 3;
 	clk_data->hws[0] = &rtc->hw;
 	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
+	clk_data->hws[2] = rtc->int_osc;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	return;
 
-- 
2.20.0.rc1
