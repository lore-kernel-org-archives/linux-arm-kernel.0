From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:19 +0200
Subject: [PATCH 07/16] deps: add debug configuration options
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-8-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some debug options to print annotated initcalls, the ordered list of
annotated initcalls and to print a message right before an annotated
initcall is called.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/of/Kconfig           | 18 ++++++++++++++
 drivers/of/of_dependencies.c | 57 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 9bf6c73..26c4b1a 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -114,4 +114,22 @@ config OF_DEPENDENCIES
 
 	  If unsure, say N here.
 
+config OF_DEPENDENCIES_PRINT_INIT_ORDER
+	bool "Print dependency based initialization order"
+	depends on OF_DEPENDENCIES
+	help
+	  Used for debugging purposes.
+
+config OF_DEPENDENCIES_PRINT_ANNOTATED_INITCALLS
+	bool "Print names of annotated drivers"
+	depends on OF_DEPENDENCIES
+	help
+	  Used for debugging purposes.
+
+config OF_DEPENDENCIES_DEBUG_CALLS_OF_ANNOTATED_INITCALLS
+	bool "Show when annotated initcalls are actually called"
+	depends on OF_DEPENDENCIES
+	help
+	  Used for debugging purposes.
+
 endif # OF
diff --git a/drivers/of/of_dependencies.c b/drivers/of/of_dependencies.c
index 64ed049..06435d5 100644
--- a/drivers/of/of_dependencies.c
+++ b/drivers/of/of_dependencies.c
@@ -336,6 +336,41 @@ static void __init of_init_remove_duplicates(void)
 		}
 }
 
+#ifdef CONFIG_OF_DEPENDENCIES_PRINT_INIT_ORDER
+static void __init of_init_print_order(void)
+{
+	unsigned i;
+	struct property *prop;
+	const char *cp;
+
+	pr_info("Initialization order:\n");
+	for (i = 0; i < order.count; ++i) {
+		pr_info("init %u 0x%x", i, order.order[i]->phandle);
+		if (order.order[i]->name)
+			pr_cont(" %s", order.order[i]->name);
+		if (order.order[i]->full_name)
+			pr_cont(" (%s)", order.order[i]->full_name);
+		prop = __of_find_property(order.order[i], "compatible", NULL);
+		for (cp = of_prop_next_string(prop, NULL); cp;
+		     cp = of_prop_next_string(prop, cp))
+			pr_cont(" %s", cp);
+	}
+}
+#endif
+
+#ifdef CONFIG_OF_DEPENDENCIES_PRINT_ANNOTATED_INITCALLS
+static void __init of_init_print_annotated(void)
+{
+	struct _annotated_initcall *ac;
+
+	pr_info("Annotated drivers:\n");
+	ac = __annotated_initcall_start;
+	for (; ac < __annotated_initcall_end; ++ac)
+		pr_info("Driver '%s' (%s)\n", ac->driver->name,
+				ac->driver->of_match_table->compatible);
+}
+#endif
+
 static int __init of_init_build_order(void)
 {
 	int rc = 0;
@@ -363,7 +398,12 @@ static int __init of_init_build_order(void)
 		return -EINVAL; /* cycle found */
 
 	of_init_remove_duplicates();
-
+#ifdef CONFIG_OF_DEPENDENCIES_PRINT_INIT_ORDER
+	of_init_print_order();
+#endif
+#ifdef CONFIG_OF_DEPENDENCIES_PRINT_ANNOTATED_INITCALLS
+	of_init_print_annotated();
+#endif
 	return rc;
 }
 
@@ -386,6 +426,12 @@ static void __init init_if_matched(struct device_node *node)
 		if (ac->initcall && ac->driver->of_match_table)
 			if (of_match_node(ac->driver->of_match_table,
 					 node)) {
+#ifdef CONFIG_OF_DEPENDENCIES_DEBUG_CALLS_OF_ANNOTATED_INITCALLS
+				pr_info("Calling (ordered) initcall for driver %s (%s)\n",
+					ac->driver->name,
+					ac->driver->of_match_table ?
+						ac->driver->of_match_table->compatible : "");
+#endif
 				do_one_initcall(*ac->initcall);
 				ac->initcall = 0;
 			}
@@ -404,7 +450,14 @@ void __init of_init_drivers(void)
 	}
 	ac = __annotated_initcall_start;
 	for (; ac < __annotated_initcall_end; ++ac) {
-		if (ac->initcall)
+		if (ac->initcall) {
+#ifdef CONFIG_OF_DEPENDENCIES_DEBUG_CALLS_OF_ANNOTATED_INITCALLS
+			pr_info("Calling (unordered) initcall for driver %s (%s)\n",
+				ac->driver->name,
+				ac->driver->of_match_table ?
+					ac->driver->of_match_table->compatible : "");
+#endif
 			do_one_initcall(*ac->initcall);
+		}
 	}
 }
-- 
2.1.0
