From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:26 +0800
Subject: [PATCH 07/10] clk: Constify parent name arrays
In-Reply-To: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1332833009-4121-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Drivers should be able to declare their arrays of parent names as const
so the APIs need to accept const arguments.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk-fixed-rate.c |    2 +-
 drivers/clk/clk-mux.c        |    2 +-
 drivers/clk/clk.c            |    2 +-
 include/linux/clk-private.h  |    2 +-
 include/linux/clk-provider.h |    6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 1f87a03..295f0d5 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -43,7 +43,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		unsigned long fixed_rate)
 {
 	struct clk_fixed_rate *fixed;
-	char **parent_names = NULL;
+	const char **parent_names = NULL;
 
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
 
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 19f3116..1ff90a6 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -89,7 +89,7 @@ const struct clk_ops clk_mux_ops = {
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		char **parent_names, u8 num_parents, unsigned long flags,
+		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9cf6f59..33ef0df 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1322,7 +1322,7 @@ out:
  */
 struct clk *clk_register(struct device *dev, const char *name,
 		const struct clk_ops *ops, struct clk_hw *hw,
-		char **parent_names, u8 num_parents, unsigned long flags)
+		const char **parent_names, u8 num_parents, unsigned long flags)
 {
 	struct clk *clk;
 
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index f19fee0..e9c8b98 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -30,7 +30,7 @@ struct clk {
 	const struct clk_ops	*ops;
 	struct clk_hw		*hw;
 	struct clk		*parent;
-	char			**parent_names;
+	const char		**parent_names;
 	struct clk		**parents;
 	u8			num_parents;
 	unsigned long		rate;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 6eb8e5d..24c5013 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -214,7 +214,7 @@ struct clk_divider {
 	u8		width;
 	u8		flags;
 	spinlock_t	*lock;
-	char		*parent[1];
+	const char	*parent[1];
 };
 
 #define CLK_DIVIDER_ONE_BASED		BIT(0)
@@ -257,7 +257,7 @@ struct clk_mux {
 
 extern const struct clk_ops clk_mux_ops;
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		char **parent_names, u8 num_parents, unsigned long flags,
+		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
 
@@ -278,7 +278,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
  */
 struct clk *clk_register(struct device *dev, const char *name,
 		const struct clk_ops *ops, struct clk_hw *hw,
-		char **parent_names, u8 num_parents, unsigned long flags);
+		const char **parent_names, u8 num_parents, unsigned long flags);
 
 /* helper functions */
 const char *__clk_get_name(struct clk *clk);
-- 
1.7.5.4
