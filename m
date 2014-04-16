From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Apr 2014 18:37:32 +0200
Subject: [PATCH 01/11] clk: divider: add CLK_DIVIDER_READ_ONLY flag
In-Reply-To: <3673317.X1crLrrlCS@phil>
References: <3673317.X1crLrrlCS@phil>
Message-ID: <1613263.L2UpUtBNCh@phil>
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
index ec22112..f7e5df5 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -249,6 +249,11 @@ const struct clk_ops clk_divider_ops = {
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
@@ -274,7 +279,10 @@ static struct clk *_register_divider(struct device *dev, const char *name,
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
index 5119174..6a72c70 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -312,6 +312,8 @@ struct clk_div_table {
  *   of this register, and mask of divider bits are in higher 16-bit of this
  *   register.  While setting the divider bits, higher 16-bit should also be
  *   updated to indicate changing divider bits.
+ * CLK_DIVIDER_READ_ONLY - The divider settings are preconfigured and should
+ *	not be changed by the clock framework.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -327,8 +329,10 @@ struct clk_divider {
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 #define CLK_DIVIDER_HIWORD_MASK		BIT(3)
+#define CLK_DIVIDER_READ_ONLY		BIT(4)
 
 extern const struct clk_ops clk_divider_ops;
+extern const struct clk_ops clk_divider_ro_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-- 
1.9.0
