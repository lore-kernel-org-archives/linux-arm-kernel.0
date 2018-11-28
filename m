From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:03 +0800
Subject: [PATCH 06/15] rtc: sun6i: Add support for different variants
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amongst the Allwinner SoCs that have seen some kind of coverage by the
linux-sunxi community, whether it be mainline Linux or U-boot support,
or just available datasheets, most newer chips use the RTC design first
seen in the A31 (sun6i).

Overall there have been some minor differences. This patch covers the
following:

  - average clock rate of the internal RC oscillator
    + presence of fixed and adjustable prescaler for this clock
  - availability of an external (to the SoC) clock output

One major difference regarding the H6 is the 24 MHz crystal is now
routed through the RTC, as a digitally compensated oscillator (DCXO).
This is not covered in this patch and will be supported later.

Other differences are either unrelated to RTC or clock functionality,
such as boot or crypto related registers, or the driver simply doesn't
use the feature in question. One example of the latter is the
calibration function for the RC oscillator. We consider this clock to
be very bad and avoid using it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 58 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 8edd9e1ec007..d1866d90b9ef 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -118,9 +118,30 @@
 #define SUN6I_YEAR_MAX				2033
 #define SUN6I_YEAR_OFF				(SUN6I_YEAR_MIN - 1900)
 
+/*
+ * There are other differences between models, including:
+ *
+ *   - number of GPIO pins that can be configured to hold a certain level
+ *   - crypto-key related registers (H5, H6)
+ *   - boot process related (super standby, secondary processor entry address)
+ *     registers (R40, H6)
+ *   - SYS power domain controls (R40)
+ *   - DCXO controls (H6)
+ *   - RC oscillator calibration (H6)
+ *
+ * These functions are not covered by this driver.
+ */
+struct sun6i_rtc_clk_data {
+	unsigned long rc_osc_rate;
+	unsigned int fixed_prescaler : 16;
+	unsigned int has_prescaler : 1;
+	unsigned int has_out_clk : 1;
+};
+
 struct sun6i_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
+	const struct sun6i_rtc_clk_data *data;
 	void __iomem *base;
 	int irq;
 	unsigned long alarm;
@@ -139,14 +160,19 @@ static unsigned long sun6i_rtc_osc_recalc_rate(struct clk_hw *hw,
 					       unsigned long parent_rate)
 {
 	struct sun6i_rtc_dev *rtc = container_of(hw, struct sun6i_rtc_dev, hw);
-	u32 val;
+	u32 val = 0;
 
 	val = readl(rtc->base + SUN6I_LOSC_CTRL);
 	if (val & SUN6I_LOSC_CTRL_EXT_OSC)
 		return parent_rate;
 
-	val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
-	val &= GENMASK(4, 0);
+	if (rtc->data->fixed_prescaler)
+		parent_rate /= rtc->data->fixed_prescaler;
+
+	if (rtc->data->has_prescaler) {
+		val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
+		val &= GENMASK(4, 0);
+	}
 
 	return parent_rate / (val + 1);
 }
@@ -185,7 +211,8 @@ static const struct clk_ops sun6i_rtc_osc_ops = {
 	.set_parent	= sun6i_rtc_osc_set_parent,
 };
 
-static void __init sun6i_rtc_clk_init(struct device_node *node)
+static void __init sun6i_rtc_clk_init(struct device_node *node,
+				      const struct sun6i_rtc_clk_data *data)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct sun6i_rtc_dev *rtc;
@@ -200,6 +227,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	if (!rtc)
 		return;
 
+	rtc->data = data;
 	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
@@ -228,7 +256,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
 								"rtc-int-osc",
 								NULL, 0,
-								667000,
+								rtc->data->rc_osc_rate,
 								300000000);
 	if (IS_ERR(rtc->int_osc)) {
 		pr_crit("Couldn't register the internal oscillator\n");
@@ -271,8 +299,18 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 err:
 	kfree(clk_data);
 }
-CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
-		      sun6i_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun6i_a31_rtc_data = {
+	.rc_osc_rate = 667000, /* datasheet says 600 ~ 700 KHz */
+	.has_prescaler = 1,
+};
+
+static void __init sun6i_a31_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun6i_a31_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun6i_a31_rtc_clk, "allwinner,sun6i-a31-rtc",
+		      sun6i_a31_rtc_clk_init);
 
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
@@ -579,6 +617,12 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * As far as RTC functionality goes, all models are the same. The
+ * datasheets claim that different models have different number of
+ * registers available for non-volatile storage, but experiments show
+ * that all SoCs have 16 registers available for this purpose.
+ */
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ /* sentinel */ },
-- 
2.20.0.rc1
