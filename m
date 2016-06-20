From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Jun 2016 10:52:15 +0800
Subject: [PATCH v3 5/8] rtc: ac100: Add clk output support
In-Reply-To: <1466391138-12862-1-git-send-email-wens@csie.org>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
Message-ID: <1466391138-12862-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AC100's RTC side has 3 clock outputs on external pins, which can
provide a clock signal to the SoC or other modules, such as WiFi or
GSM modules.

Support this with a custom clk driver integrated with the rtc driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2: none
Changes since v1: none
---
 drivers/rtc/rtc-ac100.c | 319 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 752bc0771d71..ef5bf102d2fc 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -32,6 +33,15 @@
 /* Control register */
 #define AC100_RTC_CTRL_24HOUR	BIT(0)
 
+/* Clock output register bits */
+#define AC100_CLK32K_PRE_DIV_SHIFT	5
+#define AC100_CLK32K_PRE_DIV_WIDTH	3
+#define AC100_CLK32K_MUX_SHIFT		4
+#define AC100_CLK32K_MUX_WIDTH		1
+#define AC100_CLK32K_DIV_SHIFT		1
+#define AC100_CLK32K_DIV_WIDTH		3
+#define AC100_CLK32K_EN			BIT(0)
+
 /* RTC */
 #define AC100_RTC_SEC_MASK	GENMASK(6, 0)
 #define AC100_RTC_MIN_MASK	GENMASK(6, 0)
@@ -68,6 +78,26 @@
 #define AC100_YEAR_MAX				2069
 #define AC100_YEAR_OFF				(AC100_YEAR_MIN - 1900)
 
+struct ac100_clk32k {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u8 offset;
+};
+
+#define to_ac100_clk32k(_hw) container_of(_hw, struct ac100_clk32k, hw)
+
+#define AC100_RTC_32K_NAME	"ac100-rtc-32k"
+#define AC100_RTC_32K_RATE	32768
+#define AC100_ADDA_4M_NAME	"ac100-adda-4M"
+#define AC100_ADDA_4M_RATE	4000000
+#define AC100_CLK32K_NUM	3
+
+static const char * const ac100_clk32k_names[] = {
+	"ac100-clk32k-ap",
+	"ac100-clk32k-bb",
+	"ac100-clk32k-md",
+};
+
 struct ac100_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
@@ -75,8 +105,283 @@ struct ac100_rtc_dev {
 	struct mutex mutex;
 	int irq;
 	unsigned long alarm;
+
+	struct clk_hw *rtc_32k_clk;
+	struct clk_hw *adda_4M_clk;
+	struct ac100_clk32k clks[AC100_CLK32K_NUM];
+	struct clk_hw_onecell_data *clk_data;
+};
+
+/**
+ * Clock controls for 3 clock output pins
+ */
+
+static const struct clk_div_table ac100_clk32k_prediv[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 8 },
+	{ .val = 4, .div = 16 },
+	{ .val = 5, .div = 32 },
+	{ .val = 6, .div = 64 },
+	{ .val = 7, .div = 122 },
+	{ },
+};
+
+/* Abuse the fact that one parent is 32768 Hz, and the other is 4 MHz */
+static unsigned long ac100_clk32k_recalc_rate(struct clk_hw *hw,
+					      unsigned long prate)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+	unsigned int reg, div;
+
+	regmap_read(clk->regmap, clk->offset, &reg);
+
+	/* Handle pre-divider first */
+	if (prate != AC100_RTC_32K_RATE) {
+		div = (reg >> AC100_CLK32K_PRE_DIV_SHIFT) &
+			((1 << AC100_CLK32K_PRE_DIV_WIDTH) - 1);
+		prate = divider_recalc_rate(hw, prate, div,
+					    ac100_clk32k_prediv, 0);
+	}
+
+	div = (reg >> AC100_CLK32K_DIV_SHIFT) &
+		(BIT(AC100_CLK32K_DIV_WIDTH) - 1);
+	return divider_recalc_rate(hw, prate, div, NULL,
+				   CLK_DIVIDER_POWER_OF_TWO);
+}
+
+static long ac100_clk32k_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate)
+{
+	unsigned long best_rate = 0, tmp_rate, tmp_prate;
+	int i;
+
+	if (prate == AC100_RTC_32K_RATE)
+		return divider_round_rate(hw, rate, &prate, NULL,
+					  AC100_CLK32K_DIV_WIDTH,
+					  CLK_DIVIDER_POWER_OF_TWO);
+
+	for (i = 0; ac100_clk32k_prediv[i].div; i++) {
+		tmp_prate = DIV_ROUND_UP(prate, ac100_clk32k_prediv[i].val);
+		tmp_rate = divider_round_rate(hw, rate, &tmp_prate, NULL,
+					      AC100_CLK32K_DIV_WIDTH,
+					      CLK_DIVIDER_POWER_OF_TWO);
+
+		if (tmp_rate > rate)
+			continue;
+		if (rate - tmp_rate < best_rate - tmp_rate)
+			best_rate = tmp_rate;
+	}
+
+	return best_rate;
+}
+
+static int ac100_clk32k_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct clk_hw *best_parent;
+	unsigned long best = 0;
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	for (i = 0; i < num_parents; i++) {
+		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
+		unsigned long tmp, prate = clk_hw_get_rate(parent);
+
+		tmp = ac100_clk32k_round_rate(hw, req->rate, prate);
+
+		if (tmp > req->rate)
+			continue;
+		if (req->rate - tmp < req->rate - best) {
+			best = tmp;
+			best_parent = parent;
+		}
+	}
+
+	if (!best)
+		return -EINVAL;
+
+	req->best_parent_hw = best_parent;
+	req->best_parent_rate = best;
+	req->rate = best;
+
+	return 0;
+}
+
+static int ac100_clk32k_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long prate)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+	int div = 0, pre_div = 0;
+
+	do {
+		div = divider_get_val(rate * ac100_clk32k_prediv[pre_div].div,
+				      prate, NULL, AC100_CLK32K_DIV_WIDTH,
+				      CLK_DIVIDER_POWER_OF_TWO);
+		if (div >= 0)
+			break;
+	} while (prate == AC100_ADDA_4M_RATE &&
+		 ac100_clk32k_prediv[++pre_div].div);
+
+	if (div < 0)
+		return div;
+
+	pre_div = ac100_clk32k_prediv[pre_div].val;
+
+	regmap_update_bits(clk->regmap, clk->offset,
+			   ((1 << AC100_CLK32K_DIV_WIDTH) - 1) << AC100_CLK32K_DIV_SHIFT |
+			   ((1 << AC100_CLK32K_PRE_DIV_WIDTH) - 1) << AC100_CLK32K_PRE_DIV_SHIFT,
+			   (div - 1) << AC100_CLK32K_DIV_SHIFT |
+			   (pre_div - 1) << AC100_CLK32K_PRE_DIV_SHIFT);
+
+	return 0;
+}
+
+static int ac100_clk32k_prepare(struct clk_hw *hw)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+
+	return regmap_update_bits(clk->regmap, clk->offset, AC100_CLK32K_EN,
+				  AC100_CLK32K_EN);
+}
+
+static void ac100_clk32k_unprepare(struct clk_hw *hw)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+
+	regmap_update_bits(clk->regmap, clk->offset, AC100_CLK32K_EN, 0);
+}
+
+static int ac100_clk32k_is_prepared(struct clk_hw *hw)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+	unsigned int reg;
+
+	regmap_read(clk->regmap, clk->offset, &reg);
+
+	return reg & AC100_CLK32K_EN;
+}
+
+static u8 ac100_clk32k_get_parent(struct clk_hw *hw)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+	unsigned int reg;
+
+	regmap_read(clk->regmap, clk->offset, &reg);
+
+	return (reg >> AC100_CLK32K_MUX_SHIFT) & 0x1;
+}
+
+static int ac100_clk32k_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ac100_clk32k *clk = to_ac100_clk32k(hw);
+
+	return regmap_update_bits(clk->regmap, clk->offset,
+				  BIT(AC100_CLK32K_MUX_SHIFT),
+				  index ? BIT(AC100_CLK32K_MUX_SHIFT) : 0);
+}
+
+static const struct clk_ops ac100_clk32k_ops = {
+	.prepare	= ac100_clk32k_prepare,
+	.unprepare	= ac100_clk32k_unprepare,
+	.is_prepared	= ac100_clk32k_is_prepared,
+	.recalc_rate	= ac100_clk32k_recalc_rate,
+	.determine_rate	= ac100_clk32k_determine_rate,
+	.get_parent	= ac100_clk32k_get_parent,
+	.set_parent	= ac100_clk32k_set_parent,
+	.set_rate	= ac100_clk32k_set_rate,
 };
 
+static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
+{
+	struct device_node *np = chip->dev->of_node;
+	const char *parents[2] = {AC100_RTC_32K_NAME, AC100_ADDA_4M_NAME};
+	int i, ret;
+
+	chip->clk_data = devm_kzalloc(chip->dev, sizeof(*chip->clk_data) +
+						 sizeof(*chip->clk_data->hws) *
+						 AC100_CLK32K_NUM,
+						 GFP_KERNEL);
+	if (!chip->clk_data)
+		return -ENOMEM;
+
+	chip->rtc_32k_clk = clk_hw_register_fixed_rate(chip->dev,
+						       AC100_RTC_32K_NAME,
+						       NULL, 0,
+						       AC100_RTC_32K_RATE);
+	if (IS_ERR(chip->rtc_32k_clk)) {
+		ret = PTR_ERR(chip->rtc_32k_clk);
+		dev_err(chip->dev, "Failed to register RTC-32k clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * The ADDA 4 MHz clock is from the codec side of the AC100,
+	 * which is likely a different power domain. However, boards
+	 * always have both sides powered on, so it is impossible to
+	 * test this.
+	 */
+	chip->adda_4M_clk = clk_hw_register_fixed_rate(chip->dev,
+						       AC100_ADDA_4M_NAME,
+						       NULL, 0,
+						       AC100_ADDA_4M_RATE);
+	if (IS_ERR(chip->adda_4M_clk)) {
+		ret = PTR_ERR(chip->adda_4M_clk);
+		dev_err(chip->dev, "Failed to register ADDA-4M clock: %d\n",
+			ret);
+		goto err_unregister_rtc_32k;
+	}
+
+	for (i = 0; i < AC100_CLK32K_NUM; i++) {
+		struct ac100_clk32k *clk = &chip->clks[i];
+		struct clk_init_data init = {
+			.name = ac100_clk32k_names[i],
+			.ops = &ac100_clk32k_ops,
+			.parent_names = parents,
+			.num_parents = ARRAY_SIZE(parents),
+			.flags = 0,
+		};
+
+		clk->regmap = chip->regmap;
+		clk->offset = AC100_CLK32K_OUT_CTRL1 + i;
+		clk->hw.init = &init;
+
+		ret = devm_clk_hw_register(chip->dev, &clk->hw);
+		if (ret) {
+			dev_err(chip->dev, "Failed to register clk '%s': %d\n",
+				init.name, ret);
+			goto err_unregister_adda_4M;
+		}
+
+		chip->clk_data->hws[i] = &clk->hw;
+	}
+
+	chip->clk_data->num = i;
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, chip->clk_data);
+	if (ret)
+		goto err_unregister_adda_4M;
+
+	return 0;
+
+err_unregister_adda_4M:
+	clk_unregister_fixed_rate(chip->adda_4M_clk->clk);
+err_unregister_rtc_32k:
+	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
+
+	return ret;
+}
+
+static void ac100_rtc_unregister_clks(struct ac100_rtc_dev *chip)
+{
+	of_clk_del_provider(chip->dev->of_node);
+	clk_unregister_fixed_rate(chip->adda_4M_clk->clk);
+	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
+}
+
+/**
+ * RTC related bits
+ */
 static int ac100_rtc_get_time(struct device *dev, struct rtc_time *rtc_tm)
 {
 	struct ac100_rtc_dev *chip = dev_get_drvdata(dev);
@@ -347,13 +652,27 @@ static int ac100_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->rtc);
 	}
 
+	ret = ac100_rtc_register_clks(chip);
+	if (ret)
+		return ret;
+
 	dev_info(&pdev->dev, "RTC enabled\n");
 
 	return 0;
 }
 
+static int ac100_rtc_remove(struct platform_device *pdev)
+{
+	struct ac100_rtc_dev *chip = platform_get_drvdata(pdev);
+
+	ac100_rtc_unregister_clks(chip);
+
+	return 0;
+}
+
 static struct platform_driver ac100_rtc_driver = {
 	.probe		= ac100_rtc_probe,
+	.remove		= ac100_rtc_remove,
 	.driver		= {
 		.name		= "ac100-rtc",
 	},
-- 
2.8.1
