From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Tue, 31 Jul 2018 13:10:59 +0100
Subject: [PATCH v4 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
References: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1533039060-18779-2-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

This function behaves the same as of_clk_get_by_name() except that
it will return NULL instead of -ENOENT.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v4:
 - For optional named clocks of_property_match_string() will return
   -EINVAL if the "clock-names" property is missing, or -ENODATA if
   the specified clock name in the "clock-names" property is missing.
   If we then call __of_clk_get() with these errors as the index, we
   get clk = -EINVAL. This is then filtered later on so users don't
   see it. However, if the clock is not named, __of_clk_get() will
   return -ENOENT is the clock provide is not there.
   So for optional named clocks, use index to determine if the clock
   provider is there or not, and for unnamed clocks, simply check if
   __of_clk_get() returns -ENOENT.

v3:
 - Fix check for clock not present. __of_clk_get() returns -EINVAL
   if it's not there. Cover case of when there is no clock name.
 - of_clk_get_by_name_optional() should return NULL if !np.
 - Add dummy version of of_clk_get_by_name_optional() for the
   !OF || !COMMON_CLK case.
---
 drivers/clk/clkdev.c | 43 +++++++++++++++++++++++++++++++++++++++----
 include/linux/clk.h  |  6 ++++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8..f8f6ba9 100644
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
 
@@ -70,6 +71,12 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
 		clk = __of_clk_get(np, index, dev_id, name);
+		if (optional && (index == -EINVAL || index == -ENODATA ||
+		    PTR_ERR(clk) == -ENOENT)) {
+			clk = NULL;
+			pr_info("optional clock is not present %pOF:%s\n", np,
+				name ? name : "");
+		}
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >= 0) {
@@ -89,6 +96,12 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 			break;
 	}
 
+	if (optional && PTR_ERR(clk) == -ENOENT) {
+		clk = NULL;
+		pr_info("optional clock is not present %pOF:%s\n", np,
+			name ? name : "");
+	}
+
 	return clk;
 }
 
@@ -106,15 +119,37 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
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
+ * This function parses the clocks and clock-names properties, and uses them to
+ * look up the struct clk from the registered list of clock providers.
+ * It behaves the same as of_clk_get_by_name(), except when np is NULL or no
+ * clock provider is found, when it then returns NULL.
+ */
+struct clk *of_clk_get_by_name_optional(struct device_node *np,
+					const char *name)
+{
+	if (!np)
+		return NULL;
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
@@ -197,7 +232,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c4..de0e5e0 100644
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
@@ -788,6 +789,11 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline struct clk *of_clk_get_by_name_optional(struct device_node *np,
+						      const char *name)
+{
+	return NULL;
+}
 static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	return ERR_PTR(-ENOENT);
-- 
2.7.4
