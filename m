From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 29 Jan 2017 18:13:43 +0800
Subject: [PATCH] rtc: sun6i: Fix compatibility with old DT binding
Message-ID: <20170129101343.7222-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator") adds
a new clock for the rtc block with a 2 step probe mechanism. To share
the register region between both the clock and rtc instance, a static
pointer is used to keep the related data structure.

To preserve compatibility with the old binding, the data structure
should be saved as soon as the registers are mapped in, regardless
of the presence of the clock bindings, so that the rtc device can
retrieve it when it is probed.

This fixes the rtc device not probing when we use the updated driver
with an old device tree blob.

Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 613f42ade533..08510ca58996 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -211,6 +211,9 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
 	       rtc->base + SUN6I_LOSC_CTRL);
 
+	/* Yes, I know, this is ugly. */
+	sun6i_rtc = rtc;
+
 	/* Deal with old DTs */
 	if (!of_get_property(node, "clocks", NULL))
 		return;
@@ -243,9 +246,6 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	clk_data->num = 1;
 	clk_data->hws[0] = &rtc->hw;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	/* Yes, I know, this is ugly. */
-	sun6i_rtc = rtc;
 }
 CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
 		      sun6i_rtc_clk_init);
-- 
2.11.0
