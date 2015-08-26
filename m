From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:15 +0200
Subject: [PATCH 03/16] deps: dtc: Add option to print dependency graph as dot
 (Graphviz)
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-4-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add option -T do print a dependency graph in dot format for
generating a picture with Graphviz.

E.g.

	dtc -T foo.dts | dot -T svg -o foo.svg

would generate the picture foo.png with the dependency graph.

Convential dependencies (those based on the tree structure) are having
black arrows, dependencies based on the property 'dependencies' are
having cyan arrows.

Option -D to not automatically add dependencies does still work, so
you could build a classic dependency graph with

	dtc -D -T foo.dts | dot -T png -o foo_no_auto_deps.png

This works with binary blobs as input too. E.g.

	CROSS_COMPILE=gcc-foo ARCH=arm make foo.dtb
	scripts/dtc/dtc -I dtb -T arch/arm/boot/dts/foo.dtb

would print the dot file.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 scripts/dtc/dependencies.c | 49 ++++++++++++++++++++++++++++++++++++++++------
 scripts/dtc/dtc.c          | 19 +++++++++++++++---
 scripts/dtc/dtc.h          |  2 +-
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/scripts/dtc/dependencies.c b/scripts/dtc/dependencies.c
index 3fb5cef..2c1e0d4 100644
--- a/scripts/dtc/dependencies.c
+++ b/scripts/dtc/dependencies.c
@@ -298,7 +298,7 @@ static void __init topological_sort(void)
 			depth_first_search(i);
 }
 
-static int __init add_dep_list(struct device_node *node)
+static int __init add_dep_list(struct device_node *node, bool print_dot)
 {
 	const __be32 *list, *list_end;
 	uint32_t ph;
@@ -328,6 +328,9 @@ static int __init add_dep_list(struct device_node *node)
 		rc = insert_edge(node->phandle, ph);
 		if (rc)
 			break;
+		if (print_dot)
+			printf("      node0x%x -> node0x%x [color=cyan]\n",
+				node->phandle, ph);
 	}
 
 	return rc;
@@ -352,9 +355,10 @@ static const char *of_prop_next_string(struct property *prop, const char *cur)
 }
 
 static int __init add_deps_lnx(struct device_node *parent,
-				struct device_node *node)
+				struct device_node *node, bool print_dot)
 {
 	struct device_node *child;
+	const char *cp;
 	int rc = 0;
 
 	if (!__of_device_is_available(node))
@@ -375,13 +379,34 @@ static int __init add_deps_lnx(struct device_node *parent,
 			return -EINVAL;
 		}
 		order.parent_by_phandle[node->phandle] = parent->phandle;
-		rc = add_dep_list(node);
+		if (print_dot) {
+			struct property *prop;
+
+			printf("    node0x%x [label=\"0x%x %s", node->phandle,
+						node->phandle, node->name);
+			if (node->full_name)
+				printf(" (%s)", node->full_name);
+			prop = get_property(node, "compatible");
+			if (prop) {
+				printf("\\n");
+				for (cp = of_prop_next_string(prop, NULL); cp;
+				     cp = of_prop_next_string(prop, cp)) {
+					if (cp != prop->val.val)
+						putchar(' ');
+					printf("%s", cp);
+				}
+			}
+			printf("\"];\n");
+			printf("      node0x%x -> node0x%x\n", node->phandle,
+							parent->phandle);
+		}
+		rc = add_dep_list(node, print_dot);
 		if (unlikely(rc))
 			return rc;
 		parent = node; /* change the parent only if node is a driver */
 	}
 	for_each_child_of_node(node, child) {
-		rc = add_deps_lnx(parent, child);
+		rc = add_deps_lnx(parent, child, print_dot);
 		if (unlikely(rc))
 			break;
 	}
@@ -424,7 +449,7 @@ void __init of_init_print_order(const char *name)
 	}
 }
 
-int __init of_init_build_order(struct device_node *root)
+int __init of_init_build_order(struct device_node *root, const char *print_dot)
 {
 	struct device_node *child;
 	int rc = 0;
@@ -436,12 +461,24 @@ int __init of_init_build_order(struct device_node *root)
 	calc_max_phandle(root);
 	order.old_max_phandle = order.max_phandle;
 
+	if (print_dot) {
+		printf("digraph G {\n");
+		printf("    node0x%x [label=\"0x%x root (/)\"];\n",
+			order.max_phandle+1, order.max_phandle+1);
+	}
+
 	for_each_child_of_node(root, child) {
-		rc = add_deps_lnx(root, child);
+		rc = add_deps_lnx(root, child, print_dot);
 		if (unlikely(rc))
 			break;
 	}
 
+	if (print_dot) {
+		printf("  graph [label=\"Dependency Graph for %s (%u nodes, %u edges)\"];\n",
+			print_dot, graph.nvertices, graph.nedges);
+		printf("}\n");
+	}
+
 	of_node_put(root);
 	topological_sort();
 
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index 494c531..b1ca363 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -51,7 +51,7 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
 #define FDT_VERSION(version)	_FDT_VERSION(version)
 #define _FDT_VERSION(version)	#version
 static const char usage_synopsis[] = "dtc [options] <input file>";
-static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sDtW:E:hv";
+static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sDtTW:E:hv";
 static struct option const usage_long_opts[] = {
 	{"quiet",            no_argument, NULL, 'q'},
 	{"in-format",         a_argument, NULL, 'I'},
@@ -68,6 +68,7 @@ static struct option const usage_long_opts[] = {
 	{"sort",             no_argument, NULL, 's'},
 	{"no-deps",          no_argument, NULL, 'D'},
 	{"initialization-order", no_argument, NULL, 't'},
+	{"dot",              no_argument, NULL, 'T'},
 	{"phandle",           a_argument, NULL, 'H'},
 	{"warning",           a_argument, NULL, 'W'},
 	{"error",             a_argument, NULL, 'E'},
@@ -97,6 +98,7 @@ static const char * const usage_opts_help[] = {
 	"\n\tSort nodes and properties before outputting (useful for comparing trees)",
 	"\n\tDo not automatically add dependencies for phandle references",
 	"\n\tPrint (default) initialization order",
+	"\n\tPrint dot with dependency graph (for use with Graphviz)",
 	"\n\tValid phandle formats are:\n"
 	 "\t\tlegacy - \"linux,phandle\" properties only\n"
 	 "\t\tepapr  - \"phandle\" properties only\n"
@@ -118,6 +120,7 @@ int main(int argc, char *argv[])
 	bool force = false, sort = false;
 	bool dependencies = true;
 	bool init_order = false;
+	bool print_dot = false;
 	const char *arg;
 	int opt;
 	FILE *outf = NULL;
@@ -193,6 +196,10 @@ int main(int argc, char *argv[])
 			init_order = true;
 			break;
 
+		case 'T':
+			print_dot = true;
+			break;
+
 		case 'W':
 			parse_checks_option(true, false, optarg);
 			break;
@@ -254,12 +261,18 @@ int main(int argc, char *argv[])
 		add_dependencies(bi);
 
 	if (init_order) {
-		if (of_init_build_order(bi->dt))
+		if (of_init_build_order(bi->dt, 0))
 			exit(2);
 		of_init_print_order(arg);
 		exit(0);
 	}
 
+	if (print_dot) {
+		if (of_init_build_order(bi->dt, arg))
+			exit(2);
+		exit(0);
+	}
+
 	if (streq(outname, "-")) {
 		outf = stdout;
 	} else {
@@ -286,7 +299,7 @@ int main(int argc, char *argv[])
 	 * This is done after the output was saved because it
 	 * changes the tree slightly.
 	 */
-	if (of_init_build_order(bi->dt))
+	if (of_init_build_order(bi->dt, 0))
 		exit(2);
 
 	exit(0);
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 9ae4bfc..8ef8e6f 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -269,6 +269,6 @@ struct boot_info *dt_from_fs(const char *dirname);
 /* Dependencies */
 void add_dependencies(struct boot_info *bi);
 void of_init_print_order(const char *name);
-int of_init_build_order(struct node *root);
+int of_init_build_order(struct node *root, const char *print_dot);
 
 #endif /* _DTC_H */
-- 
2.1.0
