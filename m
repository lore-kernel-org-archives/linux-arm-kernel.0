From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  4 Jun 2013 23:05:14 +0800
Subject: [PATCH v2 3/6] clk: divider: add CLK_DIVIDER_HIWORD_MASK flag
In-Reply-To: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1370358317-12768-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Hisilicon Hi3620 clock divider register, 16-bit HIWORD is mask field.
Support the HIWORD mask to reuse clock divider driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clk/clk-divider.c    | 6 ++++++
 include/linux/clk-provider.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 6d96741..4c344b4 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -220,6 +220,12 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	val = readl(divider->reg);
 	val &= ~(div_mask(divider) << divider->shift);
 	val |= value << divider->shift;
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+		if (divider->width + divider->shift > 16)
+			pr_warn("divider value exceeds LOWORD field\n");
+		else
+			val |= div_mask(divider) << (divider->shift + 16);
+	}
 	writel(val, divider->reg);
 
 	if (divider->lock)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 6ba32bc..dbb9bd9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -257,6 +257,7 @@ struct clk_div_table {
  *	Some hardware implementations gracefully handle this case and allow a
  *	zero divisor by not modifying their input clock
  *	(divide by one / bypass).
+ * CLK_DIVIDER_HIWORD_MASK - register contains high 16-bit as mask field
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -271,6 +272,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ONE_BASED		BIT(0)
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
+#define CLK_DIVIDER_HIWORD_MASK		BIT(3)
 
 extern const struct clk_ops clk_divider_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
-- 
1.8.1.2
