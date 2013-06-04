From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  4 Jun 2013 23:05:13 +0800
Subject: [PATCH v2 2/6] clk: mux: add CLK_MUX_HIWORD_MASK
In-Reply-To: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1370358317-12768-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a HIWORD mask field in Hisilicon Hi3620 clock mux register. This
field must be set while update the clk mux register. In order to reuse
the clk-mux driver, append the CLK_MUX_HIWORD_MASK field into mux->flags.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clk/clk-mux.c        | 8 ++++++++
 include/linux/clk-provider.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 25b1734..887f462 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -70,6 +70,7 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
+	u8 width = 0;
 	unsigned long flags = 0;
 
 	if (mux->table)
@@ -89,6 +90,13 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	val = readl(mux->reg);
 	val &= ~(mux->mask << mux->shift);
 	val |= index << mux->shift;
+	if (mux->flags & CLK_MUX_HIWORD_MASK) {
+		width = fls(mux->mask) - ffs(mux->mask) + 1;
+		if (width + mux->shift > 16)
+			pr_warn("mux value exceeds LOWORD field\n");
+		else
+			val |= mux->mask << (mux->shift + 16);
+	}
 	writel(val, mux->reg);
 
 	if (mux->lock)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1186098..6ba32bc 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -299,6 +299,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
  * Flags:
  * CLK_MUX_INDEX_ONE - register index starts at 1, not 0
  * CLK_MUX_INDEX_BIT - register index is a single bit (power of two)
+ * CLK_MUX_HIWORD_MASK - register contains high 16-bit as mask field
  */
 struct clk_mux {
 	struct clk_hw	hw;
@@ -312,6 +313,7 @@ struct clk_mux {
 
 #define CLK_MUX_INDEX_ONE		BIT(0)
 #define CLK_MUX_INDEX_BIT		BIT(1)
+#define CLK_MUX_HIWORD_MASK		BIT(2)
 
 extern const struct clk_ops clk_mux_ops;
 
-- 
1.8.1.2
