From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 16 Nov 2018 14:59:32 +0000
Subject: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <20181116145937.27660-1-phil.edworthy@renesas.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
Message-ID: <20181116145937.27660-2-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few drivers get an optional clock, e.g. a clock required to
access a peripheral's registers that is always enabled on some devices.
This adds the of_clk_get_by_name_optional() function for this purpose.

This function behaves the same as of_clk_get_by_name() except that it
will return NULL instead of -ENOENT. This allows for simpler error
handling in the callers.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
*Warning*
This changes the return values for of_clk_get_by_name() in some cases.
If the name arg is non-NULL, and the "clock-names" OF property can't be
found or the name is not in that prop, the code used to return -EINVAL,
but will now return -ENOENT.
Note that before and after this patch, if name=NULL and no "clocks" OF
property has been found, of_clk_get_by_name() returns -ENOENT.

I believe the new behaviour is correct. I cannot find any callers to
of_clk_get_by_name() that explicitly check for -EINVAL or -ENOENT, but
there is the possibility that something will break at runtime with this
change.

v6:
 - Rework the __of_clk_get_by_name() logic so as to avoid duplicate tests.
v5:
 - Simplified the code by handling all the error conditions on exit
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
 drivers/clk/clkdev.c | 76 ++++++++++++++++++++++++++++++++++++--------
 include/linux/clk.h  |  6 ++++
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..0c655d1ba1d9 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -52,9 +52,19 @@ struct clk *of_clk_get(struct device_node *np, int index)
 }
 EXPORT_SYMBOL(of_clk_get);
 
+/*
+ * This function tries to find a clock provider.
+ * If a name is provided, the function looks for a clock with that name in the
+ * OF node's "clock-names" property. If not found, the function will try the
+ * parent node and so on until a matching property is found or we reach the
+ * top of the tree.
+ * When no clock provider is found, if optional is true, the function will
+ * return NULL, otherwise return -ENOENT.
+ */
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
-					const char *name)
+					const char *name,
+					bool optional)
 {
 	struct clk *clk = ERR_PTR(-ENOENT);
 
@@ -65,18 +75,33 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		/*
 		 * For named clocks, first look up the name in the
 		 * "clock-names" property.  If it cannot be found, then
-		 * index will be an error code, and of_clk_get() will fail.
+		 * index will be an error code.
 		 */
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
-		clk = __of_clk_get(np, index, dev_id, name);
-		if (!IS_ERR(clk)) {
-			break;
-		} else if (name && index >= 0) {
-			if (PTR_ERR(clk) != -EPROBE_DEFER)
-				pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
-					np, name ? name : "", index);
-			return clk;
+
+		/*
+		 * If we are looking for an unnamed clock, or we have found the
+		 * named clock in the node, try to get the clock provider.
+		 */
+		if (index >= 0) {
+			clk = __of_clk_get(np, index, dev_id, name);
+			if (!IS_ERR(clk))
+				return clk;
+
+			/*
+			 * If the node specifies the clock name, do not walk up
+			 * the tree looking in parent nodes.
+			 */
+			if (name) {
+				/* Optional clock that's not there? */
+				if (optional && PTR_ERR(clk) == -ENOENT)
+					clk = NULL;
+				else if (PTR_ERR(clk) != -EPROBE_DEFER)
+					pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
+					       np, name, index);
+				return clk;
+			}
 		}
 
 		/*
@@ -89,6 +114,9 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 			break;
 	}
 
+	if (optional && PTR_ERR(clk) == -ENOENT)
+		clk = NULL;
+
 	return clk;
 }
 
@@ -106,15 +134,37 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
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
@@ -197,7 +247,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index a7773b5c0b9f..84512b3ecf5c 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -865,6 +865,7 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
+struct clk *of_clk_get_by_name_optional(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
@@ -876,6 +877,11 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
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
2.17.1
