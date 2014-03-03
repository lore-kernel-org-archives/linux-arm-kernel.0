From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 03 Mar 2014 19:22:10 +0100
Subject: [RFC PATCH v2 1/2] clk: Add function parsing arbitrary clock list DT
 property
In-Reply-To: <1393870533-20845-1-git-send-email-s.nawrocki@samsung.com>
References: <1393870533-20845-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1393870930-20971-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_clk_get_by_property() function added by this patch is similar to
of_clk_get(), except it allows to pass name of a DT property containing
list of phandles and clock specifiers. For of_clk_get() this has been
hard coded to "clocks".

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since v1:
 - s/of_clk_get_list_entry/of_clk_get_by_property.
---
 drivers/clk/clk.h    |    3 +++
 drivers/clk/clkdev.c |   25 +++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 795cc9f..666bc50 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -10,7 +10,10 @@
  */
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
 void of_clk_lock(void);
 void of_clk_unlock(void);
+struct clk *of_clk_get_by_property(struct device_node *np,
+				   const char *list_name, int index);
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index a360b2e..1d41540 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -27,17 +27,28 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-struct clk *of_clk_get(struct device_node *np, int index)
+/**
+ * of_clk_get_by_property() - Parse and lookup a clock referenced by a device node
+ * @np: pointer to clock consumer node
+ * @list_name: name of the clock list property
+ * @index: index to the clock list
+ *
+ * This function parses the @list_name property and together with @index
+ * value indicating an entry of the list uses it to look up the struct clk
+ * from the registered list of clock providers.
+ */
+struct clk *of_clk_get_by_property(struct device_node *np,
+				   const char *list_name, int index)
 {
 	struct of_phandle_args clkspec;
 	struct clk *clk;
 	int rc;
 
-	if (index < 0)
+	if (index < 0 || !list_name)
 		return ERR_PTR(-EINVAL);
 
-	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
-					&clkspec);
+	rc = of_parse_phandle_with_args(np, list_name, "#clock-cells",
+					index, &clkspec);
 	if (rc)
 		return ERR_PTR(rc);
 
@@ -51,6 +62,12 @@ struct clk *of_clk_get(struct device_node *np, int index)
 	of_node_put(clkspec.np);
 	return clk;
 }
+EXPORT_SYMBOL(of_clk_get_by_property);
+
+struct clk *of_clk_get(struct device_node *np, int index)
+{
+	return of_clk_get_by_property(np, "clocks", index);
+}
 EXPORT_SYMBOL(of_clk_get);
 
 /**
-- 
1.7.9.5
