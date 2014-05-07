From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:10:22 +0200
Subject: [PATCH v2 01/11] clk: divider: add CLK_DIVIDER_READ_ONLY flag
In-Reply-To: <3477211.Gkyeur83TV@diego>
References: <3477211.Gkyeur83TV@diego>
Message-ID: <1445808.WceTxW3oRk@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to muxes which already have a read-only flag there sometimes
exist dividers which should not be changed by the clock framework
but whose value still should be readable.

Therefore add a READ_ONLY flag similar to the mux-one to clk-divider

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-divider.c    | 10 +++++++++-
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b3c8396..c9343f5 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -361,6 +361,11 @@ const struct clk_ops clk_divider_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
 
+const struct clk_ops clk_divider_ro_ops = {
+	.recalc_rate = clk_divider_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
+
 static struct clk *_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
@@ -386,7 +391,10 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	}
 
 	init.name = name;
-	init.ops = &clk_divider_ops;
+	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
+		init.ops = &clk_divider_ro_ops;
+	else
+		init.ops = &clk_divider_ops;
 	init.flags = flags | CLK_IS_BASIC;
 	init.parent_names = (parent_name ? &parent_name: NULL);
 	init.num_parents = (parent_name ? 1 : 0);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 59e2eb5..9c2cf89 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -314,6 +314,8 @@ struct clk_div_table {
  *   updated to indicate changing divider bits.
  * CLK_DIVIDER_ROUND_CLOSEST - Makes the best calculated divider to be rounded
  *	to the closest integer instead of the up one.
+ * CLK_DIVIDER_READ_ONLY - The divider settings are preconfigured and should
+ *	not be changed by the clock framework.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -330,8 +332,10 @@ struct clk_divider {
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 #define CLK_DIVIDER_HIWORD_MASK		BIT(3)
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
+#define CLK_DIVIDER_READ_ONLY		BIT(4)
 
 extern const struct clk_ops clk_divider_ops;
+extern const struct clk_ops clk_divider_ro_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-- 
1.9.0
