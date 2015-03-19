From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Mar 2015 09:42:05 +0100
Subject: [PATCH 1/6] clk: make strings in parent name arrays const
In-Reply-To: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
References: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426754530-3137-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk functions and structs declare the parent_name arrays as
'const char **parent_names' which means the parent name strings
are const, but the array itself is not. Use
'const char * const * parent_names' instead which also makes
the array const. This allows us to put the parent_name arrays into
the __initconst section.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clk-composite.c  | 2 +-
 drivers/clk/clk-mux.c        | 4 ++--
 include/linux/clk-provider.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 956b7e5..077f4c714 100644
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
index 69a094c..1fa2a8d 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -114,7 +114,7 @@ const struct clk_ops clk_mux_ro_ops = {
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
@@ -166,7 +166,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5591ea7..410684d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -209,7 +209,7 @@ struct clk_ops {
 struct clk_init_data {
 	const char		*name;
 	const struct clk_ops	*ops;
-	const char		**parent_names;
+	const char		* const *parent_names;
 	u8			num_parents;
 	unsigned long		flags;
 };
@@ -426,12 +426,12 @@ extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
@@ -518,7 +518,7 @@ struct clk_composite {
 };
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
-		const char **parent_names, int num_parents,
+		const char * const *parent_names, int num_parents,
 		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
-- 
2.1.4
