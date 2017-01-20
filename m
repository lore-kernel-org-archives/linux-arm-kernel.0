From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 16:56:38 +0100
Subject: [PATCH 1/6] rtc: sun6i: Expose the 32kHz oscillator
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f1b2a5053cf143dccf110ab0d40c082903a958a7.1484927680.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC controls the input source of the main 32kHz oscillator in the
system, feeding it to the clock unit too.

By default, this is using an internal, very inaccurate (+/- 30%)
oscillator with a divider to make it roughly around 32kHz. This is however
quite impractical for the RTC, since our time will not be tracked properly.

Since this oscillator is an input of the main clock unit, and since that
clock unit will be probed using CLK_OF_DECLARE, we have to use it as well,
leading to a two stage probe: one to enable the clock, the other one to
enable the RTC.

There is also a slight change in the binding that is required (and should
have been from the beginning), since we'll need a phandle to the external
oscillator used on that board. We support the old binding by not allowing
to switch to the external oscillator and only using the internal one (which
was the previous behaviour) in the case where we're missing that phandle.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt |   8 +-
 drivers/rtc/rtc-sun6i.c                             | 140 ++++++++++++-
 2 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index f007e428a1ab..44d788240162 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -8,10 +8,18 @@ Required properties:
 		  memory mapped region.
 - interrupts	: IRQ lines for the RTC alarm 0 and alarm 1, in that order.
 
+Required properties for new device trees
+- clocks	: phandle to the 32kHz external oscillator
+- clock-output-names : name of the LOSC clock created
+- #clock-cells  : must be equals to 0
+
 Example:
 
 rtc: rtc at 01f00000 {
 	compatible = "allwinner,sun6i-a31-rtc";
 	reg = <0x01f00000 0x54>;
 	interrupts = <0 40 4>, <0 41 4>;
+	clock-output-names = "osc32k";
+	clocks = <&ext_osc32k>;
+	#clock-cells = <0>;
 };
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index c169a2cd4727..408dd512a6ac 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -20,6 +20,8 @@
  * more details.
  */
 
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -33,15 +35,20 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
 /* Control register */
 #define SUN6I_LOSC_CTRL				0x0000
+#define SUN6I_LOSC_CTRL_KEY			(0x16aa << 16)
 #define SUN6I_LOSC_CTRL_ALM_DHMS_ACC		BIT(9)
 #define SUN6I_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
 #define SUN6I_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
+#define SUN6I_LOSC_CTRL_EXT_OSC			BIT(0)
 #define SUN6I_LOSC_CTRL_ACC_MASK		GENMASK(9, 7)
 
+#define SUN6I_LOSC_CLK_PRESCAL			0x0008
+
 /* RTC */
 #define SUN6I_RTC_YMD				0x0010
 #define SUN6I_RTC_HMS				0x0014
@@ -114,8 +121,128 @@ struct sun6i_rtc_dev {
 	void __iomem *base;
 	int irq;
 	unsigned long alarm;
+
+	struct clk_hw hw;
+	struct clk_hw *int_osc;
+	struct clk *losc;
 };
 
+static struct sun6i_rtc_dev *sun6i_rtc;
+
+static unsigned long sun6i_rtc_osc_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct sun6i_rtc_dev *rtc = container_of(hw, struct sun6i_rtc_dev, hw);
+	u32 val;
+
+	val = readl(rtc->base + SUN6I_LOSC_CTRL);
+	if (val & SUN6I_LOSC_CTRL_EXT_OSC)
+		return parent_rate;
+
+	val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
+	val &= GENMASK(4, 0);
+
+	return parent_rate / (val + 1);
+}
+
+static u8 sun6i_rtc_osc_get_parent(struct clk_hw *hw)
+{
+	struct sun6i_rtc_dev *rtc = container_of(hw, struct sun6i_rtc_dev, hw);
+
+	return readl(rtc->base + SUN6I_LOSC_CTRL) & SUN6I_LOSC_CTRL_EXT_OSC;
+}
+
+static int sun6i_rtc_osc_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sun6i_rtc_dev *rtc = container_of(hw, struct sun6i_rtc_dev, hw);
+	u32 val;
+
+	if (index > 1)
+		return -EINVAL;
+
+	val = readl(rtc->base + SUN6I_LOSC_CTRL);
+	val &= ~SUN6I_LOSC_CTRL_EXT_OSC;
+	val |= SUN6I_LOSC_CTRL_KEY;
+	val |= index ? SUN6I_LOSC_CTRL_EXT_OSC : 0;
+	writel(val, rtc->base + SUN6I_LOSC_CTRL);
+
+	return 0;
+}
+
+static const struct clk_ops sun6i_rtc_osc_ops = {
+	.recalc_rate	= sun6i_rtc_osc_recalc_rate,
+
+	.get_parent	= sun6i_rtc_osc_get_parent,
+	.set_parent	= sun6i_rtc_osc_set_parent,
+};
+
+static void __init sun6i_rtc_clk_init(struct device_node *node)
+{
+	struct sun6i_rtc_dev *rtc;
+	struct clk_init_data init = {
+		.ops		= &sun6i_rtc_osc_ops,
+	};
+	const char *parents[2];
+
+	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		pr_crit("Can't allocate RTC structure\n");
+
+	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!rtc->base) {
+		pr_crit("Can't map RTC registers");
+		return;
+	}
+
+	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
+								"rtc-int-osc",
+								NULL, 0,
+								667000,
+								300000000);
+	if (IS_ERR(rtc->int_osc)) {
+		pr_crit("Couldn't register the internal oscillator\n");
+		return;
+	}
+
+	/*
+	 * Due to the missing clocks property we had to express the
+	 * parenthood with the external oscillator that cannot fix (or
+	 * at least expect to have) in the old DTs, we have to be a
+	 * bit smart here.
+	 *
+	 * We deal with that by simply registering the internal
+	 * oscillator as our parent in all cases, and try to get the
+	 * external oscillator from the DT.
+	 *
+	 * In the case where we don't have it, of_clk_get_parent_name
+	 * will return NULL, which is ok, and of_clk_get_parent_count
+	 * will return 0, which is fine too. We will just register a
+	 * single parent, everything works.
+	 */
+	parents[0] = clk_hw_get_name(rtc->int_osc);
+	parents[1] = of_clk_get_parent_name(node, 0);
+
+	rtc->hw.init = &init;
+
+	init.parent_names = parents;
+	init.num_parents = of_clk_get_parent_count(node) + 1;
+	init.name = "rtc-osc";
+	of_property_read_string(node, "clock-output-names", &init.name);
+
+	rtc->losc = clk_register(NULL, &rtc->hw);
+	if (IS_ERR(rtc->losc)) {
+		pr_crit("Couldn't register the LOSC clock\n");
+		return;
+	}
+
+	of_clk_add_hw_provider(node, of_clk_hw_simple_get, &rtc->hw);
+
+	/* Yes, I know, this is ugly. */
+	sun6i_rtc = rtc;
+}
+CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
+		      sun6i_rtc_clk_init);
+
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
 	struct sun6i_rtc_dev *chip = (struct sun6i_rtc_dev *) id;
@@ -349,22 +476,15 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
 
 static int sun6i_rtc_probe(struct platform_device *pdev)
 {
-	struct sun6i_rtc_dev *chip;
-	struct resource *res;
+	struct sun6i_rtc_dev *chip = sun6i_rtc;
 	int ret;
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
-		return -ENOMEM;
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, chip);
 	chip->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(chip->base))
-		return PTR_ERR(chip->base);
-
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0) {
 		dev_err(&pdev->dev, "No IRQ resource\n");
@@ -404,6 +524,8 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	/* disable alarm wakeup */
 	writel(0, chip->base + SUN6I_ALARM_CONFIG);
 
+	clk_prepare_enable(chip->losc);
+
 	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
 					&sun6i_rtc_ops, THIS_MODULE);
 	if (IS_ERR(chip->rtc)) {
-- 
git-series 0.8.11
