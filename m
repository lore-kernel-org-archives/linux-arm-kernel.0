From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 30 Jul 2018 09:36:07 +0100
Subject: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

This function behaves the same as of_clk_get_by_name() except that
it will return NULL instead of -ENOENT. This makes error checking
for users easier and allows clk_prepare_enable, etc to be called
on the returned reference without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/clkdev.c | 34 ++++++++++++++++++++++++++++++----
 include/linux/clk.h  |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8..c1b7262 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -54,7 +54,8 @@ EXPORT_SYMBOL(of_clk_get);
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
-					const char *name)
+					const char *name,
+					bool optional)
 {
 	struct clk *clk = ERR_PTR(-ENOENT);
 
@@ -73,6 +74,8 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >= 0) {
+			if (optional && PTR_ERR(clk) == -ENOENT)
+				clk = NULL;
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
 					np, name ? name : "", index);
@@ -106,15 +109,38 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
-	return __of_clk_get_by_name(np, np->full_name, name);
+	return __of_clk_get_by_name(np, np->full_name, name, false);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
 
+/**
+ * of_clk_get_by_name_optional() - Parse and lookup an optional clock referenced
+ * by a device node
+ * @np: pointer to clock consumer node
+ * @name: name of consumer's clock input, or NULL for the first clock reference
+ *
+ * This function parses the clocks and clock-names properties,
+ * and uses them to look up the struct clk from the registered list of clock
+ * providers.
+ * It behaves the same as of_clk_get_by_name(), except when no clock is found.
+ * In this case, instead of returning -ENOENT, it returns NULL.
+ */
+struct clk *of_clk_get_by_name_optional(struct device_node *np,
+					const char *name)
+{
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	return __of_clk_get_by_name(np, np->full_name, name, true);
+}
+EXPORT_SYMBOL(of_clk_get_by_name_optional);
+
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
-					const char *name)
+					const char *name,
+					bool optional)
 {
 	return ERR_PTR(-ENOENT);
 }
@@ -197,7 +223,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c4..8cb5455 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -777,6 +777,7 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
+struct clk *of_clk_get_by_name_optional(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
-- 
2.7.4
