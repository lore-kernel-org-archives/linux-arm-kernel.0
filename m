From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:05 +0800
Subject: [PATCH 07/15] rtc: sun6i: Add support for all known variants
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are different variants to the RTC hardware first seen on sun6i
(A31). The differences we care about in this driver are the clock rate
for the internal oscillator, prescalers, and the presence of an external
clock output.

This patch adds support for all the known base compatibles using the
variants data structure previously introduced.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index d1866d90b9ef..0a635e9cc25f 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -312,6 +312,50 @@ static void __init sun6i_a31_rtc_clk_init(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(sun6i_a31_rtc_clk, "allwinner,sun6i-a31-rtc",
 		      sun6i_a31_rtc_clk_init);
 
+static const struct sun6i_rtc_clk_data sun8i_a23_rtc_data = {
+	.rc_osc_rate = 667000, /* datasheet says 600 ~ 700 KHz */
+	.has_prescaler = 1,
+	.has_out_clk = 1,
+};
+
+static void __init sun8i_a23_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun8i_a23_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_a23_rtc_clk, "allwinner,sun8i-a23-rtc",
+		      sun8i_a23_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
+	.rc_osc_rate = 16000000,
+	.fixed_prescaler = 32,
+	.has_prescaler = 1,
+	.has_out_clk = 1,
+};
+
+static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun8i_h3_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_h3_rtc_clk, "allwinner,sun8i-h3-rtc",
+		      sun8i_h3_rtc_clk_init);
+/* As far as we are concerned, clocks for H5 and H6 are the same as H3 */
+CLK_OF_DECLARE_DRIVER(sun50i_h5_rtc_clk, "allwinner,sun50i-h5-rtc",
+		      sun8i_h3_rtc_clk_init);
+CLK_OF_DECLARE_DRIVER(sun50i_h6_rtc_clk, "allwinner,sun50i-h6-rtc",
+		      sun8i_h3_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun8i_v3_rtc_data = {
+	.rc_osc_rate = 32000,
+	.has_out_clk = 1,
+};
+
+static void __init sun8i_v3_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun8i_v3_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_v3_rtc_clk, "allwinner,sun8i-v3-rtc",
+		      sun8i_v3_rtc_clk_init);
+
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
 	struct sun6i_rtc_dev *chip = (struct sun6i_rtc_dev *) id;
@@ -625,6 +669,11 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
  */
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
+	{ .compatible = "allwinner,sun8i-a23-rtc" },
+	{ .compatible = "allwinner,sun8i-h3-rtc" },
+	{ .compatible = "allwinner,sun8i-v3-rtc" },
+	{ .compatible = "allwinner,sun50i-h5-rtc" },
+	{ .compatible = "allwinner,sun50i-h6-rtc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.19.1
