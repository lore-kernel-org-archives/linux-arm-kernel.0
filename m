From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:14 +0200
Subject: [PATCH 3/8] clk: Constify pointers to parent names in init data
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'parent_names' member of 'clk_init_data' is not modified so it can
be made as an array of const pointers to constant strings.

Some drivers (e.g. arch/mips/alchemy/common/clock.c) already pass such
data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-composite.c  |  2 +-
 drivers/clk/clk-mux.c        |  8 ++++----
 include/linux/clk-provider.h | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 956b7e54fa1c..077f4c7148f1 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -188,7 +188,7 @@ static void clk_composite_disable(struct clk_hw *hw)
 }
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
-			const char **parent_names, int num_parents,
+			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 69a094c3783d..962e2a056381 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -114,8 +114,8 @@ const struct clk_ops clk_mux_ro_ops = {
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
@@ -166,8 +166,8 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
 	u32 mask = BIT(width) - 1;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 28abf1badb40..0bf0308963da 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -209,7 +209,7 @@ struct clk_ops {
 struct clk_init_data {
 	const char		*name;
 	const struct clk_ops	*ops;
-	const char		**parent_names;
+	const char * const	*parent_names;
 	u8			num_parents;
 	unsigned long		flags;
 };
@@ -426,13 +426,13 @@ extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
 void clk_unregister_mux(struct clk *clk);
@@ -518,7 +518,7 @@ struct clk_composite {
 };
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
-		const char **parent_names, int num_parents,
+		const char * const *parent_names, int num_parents,
 		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
-- 
1.9.1
