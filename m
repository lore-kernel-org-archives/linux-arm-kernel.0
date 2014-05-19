From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 19 May 2014 19:22:50 +0200
Subject: [PATCH/RFC V6 1/2] clk: Add of_clk_get_by_clkspec() helper
In-Reply-To: <1400520171-6698-1-git-send-email-s.nawrocki@samsung.com>
References: <1400520171-6698-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1400520171-6698-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds of_clk_get_by_clkspec() helper function, which does only
a struct clk lookup from the clock providers. It is used in the subsequent
patch where parsing of a clock from device tree and the lookup from
providers needed to be split.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v5:
 - dropped of_clk_get_by_property(), added of_clk_get_by_clkspec().

Changes since v4:
 - none.

Changes since v3:
 - added missing 'static inline' to the function stub definition.

Changes since v2:
 - moved the function declaration from drivers/clk/clk.h to
   include/linux/clk.h

Changes since v1:
 - s/of_clk_get_list_entry/of_clk_get_by_property.
---
 drivers/clk/clk.h    |    1 +
 drivers/clk/clkdev.c |   34 +++++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 795cc9f..c798138 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -10,6 +10,7 @@
  */

 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec);
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
 void of_clk_lock(void);
 void of_clk_unlock(void);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index a360b2e..f890b90 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -27,6 +27,32 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);

 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+
+/**
+ * of_clk_get_by_clkspec() - Lookup a clock form a clock provider
+ * @clkspec: pointer to a clock specifier data structure
+ *
+ * This function looks up a struct clk from the registered list of clock
+ * providers, an input is a clock specifier data structure as returned
+ * from the of_parse_phandle_with_args() function call.
+ */
+struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
+{
+	struct clk *clk;
+
+	if (!clkspec)
+		return ERR_PTR(-EINVAL);
+
+	of_clk_lock();
+	clk = __of_clk_get_from_provider(clkspec);
+
+	if (!IS_ERR(clk) && !__clk_get(clk))
+		clk = ERR_PTR(-ENOENT);
+
+	of_clk_unlock();
+	return clk;
+}
+
 struct clk *of_clk_get(struct device_node *np, int index)
 {
 	struct of_phandle_args clkspec;
@@ -41,13 +67,7 @@ struct clk *of_clk_get(struct device_node *np, int index)
 	if (rc)
 		return ERR_PTR(rc);

-	of_clk_lock();
-	clk = __of_clk_get_from_provider(&clkspec);
-
-	if (!IS_ERR(clk) && !__clk_get(clk))
-		clk = ERR_PTR(-ENOENT);
-
-	of_clk_unlock();
+	clk = of_clk_get_by_clkspec(&clkspec);
 	of_node_put(clkspec.np);
 	return clk;
 }
--
1.7.9.5
