From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 18:52:13 +0100
Subject: [PATCH 1/4] of: Add of_parse_phandle_with_opt_args() helper function
In-Reply-To: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442944336-11754-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_parse_phandle_with_args() is slightly inflexible as it doesn't
allow the (unusual) case where the #*-cells property is not defined.
In order to support this, introduce of_parse_phandle_with_opt_args()
which assumes that #*-cells is zero when it is not defined,
as required by the msi-parent binding

This is done by turning __of_parse_phandle_with_args into an even
bigger monster, which is a bit frightening.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/base.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/of.h |  3 +++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8b5a187..1612342e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1479,6 +1479,10 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 			 * (i.e. cells_name not set, but cell_count is set),
 			 * except when we're going to return the found node
 			 * below.
+			 *
+			 * If #*-cells is not found, but cell_count is set
+			 * to a non-zero value, use (cell_count-1) as a
+			 * fallback value.
 			 */
 			if (cells_name || cur_index == index) {
 				node = of_find_node_by_phandle(phandle);
@@ -1490,13 +1494,21 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 			}
 
 			if (cells_name) {
-				if (of_property_read_u32(node, cells_name,
-							 &count)) {
+				int ret;
+				ret = of_property_read_u32(node, cells_name,
+							   &count);
+				if (ret && !cell_count) {
 					pr_err("%s: could not get %s for %s\n",
 						np->full_name, cells_name,
 						node->full_name);
 					goto err;
 				}
+				if (ret) {
+					count = cell_count - 1;
+					pr_debug("%s: could not get %s for %s, assuming %d\n",
+						 np->full_name, cells_name,
+						 node->full_name, count);
+				}
 			} else {
 				count = cell_count;
 			}
@@ -1628,6 +1640,54 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 EXPORT_SYMBOL(of_parse_phandle_with_args);
 
 /**
+ * of_parse_phandle_with_opt_args() - Find a node pointed by phandle in a list
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * If cells_name is not found, then it is assumed to be zero.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->np
+ * pointer.
+ *
+ * Example:
+ *
+ * phandle1: node1 {
+ *	#list-cells = <2>;
+ * }
+ *
+ * phandle2: node2 {
+ * }
+ *
+ * phandle3: node3 {
+ *	#list-cells = <1>;
+ * }
+ *
+ * node3 {
+ *	list = <&phandle1 1 2 &phandle2 &phandle 3>;
+ * }
+ *
+ * To get a device_node of the `node2' node you may call this:
+ * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
+ */
+int of_parse_phandle_with_opt_args(const struct device_node *np,
+				   const char *list_name,
+				   const char *cells_name, int index,
+				   struct of_phandle_args *out_args)
+{
+	if (index < 0)
+		return -EINVAL;
+	return __of_parse_phandle_with_args(np, list_name, cells_name, 1,
+					    index, out_args);
+}
+EXPORT_SYMBOL(of_parse_phandle_with_opt_args);
+
+/**
  * of_parse_phandle_with_fixed_args() - Find a node pointed by phandle in a list
  * @np:		pointer to a device tree node containing a list
  * @list_name:	property name that contains a list
diff --git a/include/linux/of.h b/include/linux/of.h
index 2194b8c..ae6cd03 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -328,6 +328,9 @@ extern struct device_node *of_parse_phandle(const struct device_node *np,
 extern int of_parse_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name, int index,
 	struct of_phandle_args *out_args);
+extern int of_parse_phandle_with_opt_args(const struct device_node *np,
+	const char *list_name, const char *cells_name, int index,
+	struct of_phandle_args *out_args);
 extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	const char *list_name, int cells_count, int index,
 	struct of_phandle_args *out_args);
-- 
2.1.4
