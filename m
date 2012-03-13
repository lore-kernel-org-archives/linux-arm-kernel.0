From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Mar 2012 18:22:24 -0500
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock node
 setup iterator
In-Reply-To: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331680947-29861-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
[Rob Herring] Rework to use common clock infrastructure
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/clock.c     |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/of_clk.h |    4 ++++
 2 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/drivers/of/clock.c b/drivers/of/clock.c
index 6519e96..06fd5ad 100644
--- a/drivers/of/clock.c
+++ b/drivers/of/clock.c
@@ -2,7 +2,8 @@
  * Clock infrastructure for device tree platforms
  */
 
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -163,3 +164,45 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 
 	return clk;
 }
+
+/**
+ * of_clk_init() - Scan and init clock providers from the DT
+ * @matches: array of compatible values and init functions for providers.
+ *
+ * This function scans the device tree for matching clock providers and
+ * calls their initialization functions
+ */
+void __init of_clk_init(const struct of_device_id *matches)
+{
+	struct device_node *np;
+
+	for_each_matching_node(np, matches) {
+		const struct of_device_id *match = of_match_node(matches, np);
+		of_clk_init_cb_t clk_init_cb = match->data;
+		clk_init_cb(np);
+	}
+}
+
+static struct clk *of_fixed_clk_get(struct of_phandle_args *a, void *data)
+{
+	return data;
+}
+
+/**
+ * of_fixed_clk_setup() - Setup function for simple fixed rate clock
+ */
+void __init of_fixed_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	u32 rate;
+
+	if (of_property_read_u32(node, "clock-frequency", &rate))
+		return;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
+	if (clk)
+		of_clk_add_provider(node, of_fixed_clk_get, clk);
+}
diff --git a/include/linux/of_clk.h b/include/linux/of_clk.h
index dcbd27b..02ecc98 100644
--- a/include/linux/of_clk.h
+++ b/include/linux/of_clk.h
@@ -10,6 +10,7 @@ struct clk;
 #ifdef CONFIG_OF_CLOCK
 
 struct device_node;
+typedef void (*of_clk_init_cb_t)(struct device_node *);
 
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
@@ -21,6 +22,9 @@ void of_clk_del_provider(struct device_node *np);
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 
+void of_clk_init(const struct of_device_id *matches);
+extern void of_fixed_clk_setup(struct device_node *np);
+
 #else
 static struct clk *of_clk_get(struct device_node *np, int index)
 {
-- 
1.7.5.4
