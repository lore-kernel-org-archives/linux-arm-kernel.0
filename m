From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:18 +0200
Subject: [PATCH 06/16] deps: deterministic driver initialization sequence
 based on dependencies from the DT
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-7-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use annotated initcalls along with dependencies found in the DT to sort
the initialization of drivers.

This makes stuff like in-driver hacks (e.g. omap), bruteforce
trial-and-error (deferred probe calls which are killing error messages)
and similar workarounds to circumvent the limited level based
driver initialization sequence unnecessary.

If enabled, this changes the driver initialization sequence as
described in the following table.

old (level based)	new (ordered, in parts)
-------------------------------------------------------------
early			early
pure (0)		pure (0)
core (1, 1s)		core (1, 1s)
postcore (2, 2s)	postcore (2, 2s)
arch (3, 3s)		arch (3, 3s)
subsys (4. 4s)		subsys (4, 4s)
fs (5, 5s)		fs (5, 5s)
rootfs			rootfs
device (6. 6s)		annotated initcalls (ordered by DT)
			annotated initcalls (not found in DT)
			device (6. 6s)
late (7, 7s)		late (7, 7s)

To use this feature new binary DT blobs which are including dependencies
(type information for phandles) have to be used and most drivers found
in the DT should have been annotated.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/of/Kconfig              |  12 ++
 drivers/of/Makefile             |   1 +
 drivers/of/of_dependencies.c    | 410 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of_dependencies.h |  20 ++
 init/main.c                     |  11 +-
 5 files changed, 453 insertions(+), 1 deletion(-)
 create mode 100644 drivers/of/of_dependencies.c
 create mode 100644 include/linux/of_dependencies.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 59bb855..9bf6c73 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -102,4 +102,16 @@ config OF_OVERLAY
 	  While this option is selected automatically when needed, you can
 	  enable it manually to improve device tree unit test coverage.
 
+config OF_DEPENDENCIES
+	bool "Device Tree dependency based initialization order (EXPERIMENTAL)"
+	select ANNOTATED_INITCALLS
+	help
+	  Enables dependency based initialization order of drivers.
+
+	  For correct operation the binary DT blob should have been
+	  populated with properties of type "dependencies" and the
+	  drivers referenced in the DT should have been annotated.
+
+	  If unsure, say N here.
+
 endif # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 156c072..05ced0d 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_OF_MTD)	+= of_mtd.o
 obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
+obj-$(CONFIG_OF_DEPENDENCIES)	+= of_dependencies.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/of_dependencies.c b/drivers/of/of_dependencies.c
new file mode 100644
index 0000000..64ed049
--- /dev/null
+++ b/drivers/of/of_dependencies.c
@@ -0,0 +1,410 @@
+/*
+ * Code for building a deterministic initialization order based on dependencies
+ * defined in the device tree.
+ *
+ * Copyright (C) 2014 Alexander Holler <holler@ahsoftware.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/of_dependencies.h>
+
+#define MAX_DT_NODES 1000 /* maximum number of vertices */
+#define MAX_EDGES (MAX_DT_NODES*2) /* maximum number of edges (dependencies) */
+
+struct edgenode {
+	uint32_t y; /* phandle */
+	struct edgenode *next; /* next edge in list */
+};
+
+/*
+ * Vertex numbers do correspond to phandle numbers. That means the graph
+ * does contain as much vertices as the maximum of all phandles.
+ * Or in other words, we assume that for all phandles in the device tree
+ * 0 < phandle < MAX_DT_NODES+1 is true.
+ */
+struct dep_graph {
+	struct edgenode edge_slots[MAX_EDGES]; /* used to avoid kmalloc */
+	struct edgenode *edges[MAX_DT_NODES+1]; /* adjacency info */
+	unsigned nvertices; /* number of vertices in graph */
+	unsigned nedges; /* number of edges in graph */
+	bool processed[MAX_DT_NODES+1]; /* which vertices have been processed */
+	bool include_node[MAX_DT_NODES+1]; /* which nodes to consider */
+	bool discovered[MAX_DT_NODES+1]; /* which vertices have been found */
+	bool finished; /* if true, cut off search immediately */
+};
+static struct dep_graph graph __initdata;
+
+struct init_order {
+	uint32_t max_phandle; /* the max used phandle */
+	uint32_t old_max_phandle; /* used to keep track of added phandles */
+	struct device_node *order[MAX_DT_NODES+1];
+	unsigned count;
+	uint32_t ph_root; /* the phandle of the root */
+};
+static struct init_order order __initdata;
+
+/* Copied from drivers/of/base.c (because it's lockless). */
+static struct property * __init __of_find_property(const struct device_node *np,
+					   const char *name, int *lenp)
+{
+	struct property *pp;
+
+	if (!np)
+		return NULL;
+
+	for (pp = np->properties; pp; pp = pp->next) {
+		if (of_prop_cmp(pp->name, name) == 0) {
+			if (lenp)
+				*lenp = pp->length;
+			break;
+		}
+	}
+
+	return pp;
+}
+
+/* Copied from drivers/of/base.c (because it's lockless). */
+static const void * __init __of_get_property(const struct device_node *np,
+				     const char *name, int *lenp)
+{
+	struct property *pp = __of_find_property(np, name, lenp);
+
+	return pp ? pp->value : NULL;
+}
+
+/* Copied from drivers/of/base.c (because it's lockless). */
+static int __init __of_device_is_available(const struct device_node *device)
+{
+	const char *status;
+	int statlen;
+
+	if (!device)
+		return 0;
+
+	status = __of_get_property(device, "status", &statlen);
+	if (status == NULL)
+		return 1;
+
+	if (statlen > 0) {
+		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * x is a dependant of y or in other words
+ * y will be initialized before x.
+ */
+static int __init insert_edge(uint32_t x, uint32_t y)
+{
+	struct edgenode *p; /* temporary pointer */
+
+	if (unlikely(x > MAX_DT_NODES || y > MAX_DT_NODES)) {
+		pr_err("Node found with phandle 0x%x > MAX_DT_NODES (%d)!\n",
+			x > MAX_DT_NODES ? x : y, MAX_DT_NODES);
+		return -EINVAL;
+	}
+	if (unlikely(!x || !y))
+		return 0;
+	if (unlikely(graph.nedges >= MAX_EDGES)) {
+		pr_err("Maximum number of edges (%d) reached!\n", MAX_EDGES);
+		return -EINVAL;
+	}
+	p = &graph.edge_slots[graph.nedges++];
+	graph.include_node[x] = 1;
+	graph.include_node[y] = 1;
+	p->y = y;
+	p->next = graph.edges[x];
+	graph.edges[x] = p; /* insert at head of list */
+
+	graph.nvertices = (x > graph.nvertices) ? x : graph.nvertices;
+	graph.nvertices = (y > graph.nvertices) ? y : graph.nvertices;
+	return 0;
+}
+
+static void __init print_node_name(uint32_t v)
+{
+	struct device_node *node;
+
+	node = of_find_node_by_phandle(v);
+	if (!node) {
+		pr_cont("Node for phandle 0x%x not found", v);
+		return;
+	}
+	if (node->name)
+		pr_cont("%s", node->name);
+	if (node->full_name)
+		pr_cont(" (%s)", node->full_name);
+	of_node_put(node);
+}
+
+/*
+ * I would prefer to use the BGL (Boost Graph Library), but as I can't use it
+ * here (for obvious reasons), the next four functions below are based on
+ * code of Steven Skiena's book 'The Algorithm Design Manual'.
+ */
+
+static void __init process_edge(uint32_t x, uint32_t y)
+{
+	if (unlikely(graph.discovered[y] && !graph.processed[y])) {
+		pr_err("Cycle found 0x%x ", x);
+		print_node_name(x);
+		pr_cont(" <-> 0x%x ", y);
+		print_node_name(y);
+		pr_cont("!\n");
+		graph.finished = 1;
+	}
+}
+
+static void __init process_vertex_late(uint32_t v)
+{
+	struct device_node *node;
+
+	node = of_find_node_by_phandle(v);
+	if (!node) {
+		pr_err("No node for phandle 0x%x not found", v);
+		return;
+	}
+	order.order[order.count++] = node;
+}
+
+static void __init depth_first_search(uint32_t v)
+{
+	struct edgenode *p;
+	uint32_t y; /* successor vertex */
+
+	if (graph.finished)
+		return;
+	graph.discovered[v] = 1;
+	p = graph.edges[v];
+	while (p) {
+		y = p->y;
+		if (!graph.discovered[y]) {
+			process_edge(v, y);
+			depth_first_search(y);
+		} else
+			process_edge(v, y);
+		if (graph.finished)
+			return;
+		p = p->next;
+	}
+	process_vertex_late(v);
+	graph.processed[v] = 1;
+}
+
+static void __init topological_sort(void)
+{
+	unsigned i;
+
+	for (i = 1; i <= graph.nvertices; ++i)
+		if (!graph.discovered[i] && graph.include_node[i])
+			depth_first_search(i);
+}
+
+static int __init add_dep_list(struct device_node *node)
+{
+	const __be32 *list, *list_end;
+	uint32_t ph;
+	int size;
+	int rc = 0;
+	struct device_node *dep;
+
+	list = __of_get_property(node, "dependencies", &size);
+	if (!list || !size || size%sizeof(*list))
+		return 0;
+	list_end = list + size / sizeof(*list);
+	while (list < list_end) {
+		ph = be32_to_cpup(list++);
+		if (unlikely(!ph)) {
+			/* Should never happen */
+			if (node->name)
+				pr_warn("phandle == 0 for %s\n", node->name);
+			continue;
+		}
+		dep = of_find_node_by_phandle(ph);
+		if (unlikely(!dep)) {
+			pr_err("No DT node for dependency with phandle 0x%x found\n",
+				ph);
+			continue;
+		}
+		rc = insert_edge(node->phandle, ph);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+static int __init add_deps(struct device_node *parent, struct device_node *node)
+{
+	struct device_node *child;
+	int rc = 0;
+
+	if (!__of_device_is_available(node))
+		return 0;
+	if (__of_get_property(node, "compatible", NULL)) {
+		if (!parent->phandle) {
+			if (__of_get_property(parent, "compatible", NULL))
+				parent->phandle = 1 + order.max_phandle++;
+		}
+		if (!node->phandle)
+			node->phandle = 1 + order.max_phandle++;
+		rc = insert_edge(node->phandle, parent->phandle);
+		if (rc)
+			return rc;
+		rc = add_dep_list(node);
+		if (unlikely(rc))
+			return rc;
+		parent = node; /* change the parent only if node is a driver */
+	}
+	for_each_child_of_node(node, child) {
+		rc = add_deps(parent, child);
+		if (unlikely(rc))
+			break;
+	}
+
+	return rc;
+}
+
+static void __init calc_max_phandle(void)
+{
+	struct device_node *np;
+	uint32_t t = 0;
+
+	for_each_of_allnodes(np)
+		if (np->phandle > t)
+			t = np->phandle;
+	order.max_phandle = t;
+}
+
+static bool __init all_compatibles_same(struct device_node *node1,
+					struct device_node *node2)
+{
+	const char *cp1;
+	const char *cp2;
+	unsigned count1 = 0;
+	unsigned count2 = 0;
+	struct property *prop1;
+	struct property *prop2;
+
+	prop1 = __of_find_property(node1, "compatible", NULL);
+	prop2 = __of_find_property(node2, "compatible", NULL);
+	for (cp1 = of_prop_next_string(prop1, NULL); cp1;
+					cp1 = of_prop_next_string(prop1, cp1)) {
+		++count1;
+		for (cp2 = of_prop_next_string(prop2, NULL); cp2;
+					cp2 = of_prop_next_string(prop2, cp2))
+			if (!strcmp(cp1, cp2))
+				break;
+		if (!cp2)
+			return 0;
+	}
+	for (cp2 = of_prop_next_string(prop2, NULL); cp2;
+					cp2 = of_prop_next_string(prop2, cp2))
+		++count2;
+	if (count1 == count2)
+		return 1;
+	return 0;
+}
+
+/*
+ * The order is based on devices but we are calling drivers.
+ * Therefor the order contains some drivers more than once.
+ * Remove the duplicates.
+ */
+static void __init of_init_remove_duplicates(void)
+{
+	unsigned i, j;
+
+	for (i = 1; i < order.count; ++i)
+		for (j = 0; j < i; ++j) {
+			if (all_compatibles_same(order.order[j],
+							order.order[i])) {
+				--order.count;
+				memmove(&order.order[i], &order.order[i+1],
+					(order.count - i) *
+						sizeof(order.order[0]));
+				--i;
+				break;
+			}
+		}
+}
+
+static int __init of_init_build_order(void)
+{
+	int rc = 0;
+	struct device_node *child;
+	struct device_node *root =  of_find_node_by_path("/");
+
+	if (unlikely(!root))
+		return -EINVAL;
+
+	calc_max_phandle();
+	order.old_max_phandle = order.max_phandle;
+
+	for_each_child_of_node(root, child) {
+		rc = add_deps(root, child);
+		if (unlikely(rc))
+			break;
+	}
+
+	order.ph_root = root->phandle;
+
+	of_node_put(root);
+	topological_sort();
+
+	if (graph.finished)
+		return -EINVAL; /* cycle found */
+
+	of_init_remove_duplicates();
+
+	return rc;
+}
+
+static void __init of_init_free_order(void)
+{
+	unsigned i;
+
+	for (i = 0; i < order.count; ++i)
+		of_node_put(order.order[i]);
+	order.count = 0;
+	/* remove_new_phandles(); */
+}
+
+static void __init init_if_matched(struct device_node *node)
+{
+	struct _annotated_initcall *ac;
+
+	ac = __annotated_initcall_start;
+	for (; ac < __annotated_initcall_end; ++ac) {
+		if (ac->initcall && ac->driver->of_match_table)
+			if (of_match_node(ac->driver->of_match_table,
+					 node)) {
+				do_one_initcall(*ac->initcall);
+				ac->initcall = 0;
+			}
+	}
+}
+
+void __init of_init_drivers(void)
+{
+	unsigned i;
+	struct _annotated_initcall *ac;
+
+	if (!of_init_build_order()) {
+		for (i = 0; i < order.count; ++i)
+			init_if_matched(order.order[i]);
+		of_init_free_order();
+	}
+	ac = __annotated_initcall_start;
+	for (; ac < __annotated_initcall_end; ++ac) {
+		if (ac->initcall)
+			do_one_initcall(*ac->initcall);
+	}
+}
diff --git a/include/linux/of_dependencies.h b/include/linux/of_dependencies.h
new file mode 100644
index 0000000..1c8c20a
--- /dev/null
+++ b/include/linux/of_dependencies.h
@@ -0,0 +1,20 @@
+#ifndef _LINUX_OF_DEPENDENCIES_H
+#define _LINUX_OF_DEPENDENCIES_H
+/*
+ * Definitions for building a deterministic initialization order based on
+ * dependencies defined in the device tree.
+ *
+ * Copyright (C) 2014 Alexander Holler <holler@ahsoftware.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/of_platform.h>
+
+/* Calls annotated initcalls in an ordered way based on dependencies. */
+extern void of_init_drivers(void);
+
+#endif	/* _LINUX_OF_DEPENDENCIES_H */
diff --git a/init/main.c b/init/main.c
index 5650655..532b330 100644
--- a/init/main.c
+++ b/init/main.c
@@ -81,6 +81,7 @@
 #include <linux/integrity.h>
 #include <linux/proc_ns.h>
 #include <linux/io.h>
+#include <linux/of_dependencies.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -863,8 +864,16 @@ static void __init do_initcalls(void)
 {
 	int level;
 
-	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++)
+	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 3; level++)
 		do_initcall_level(level);
+#ifdef CONFIG_OF_DEPENDENCIES
+	/* call annotated drivers (sorted) */
+	of_init_drivers();
+#endif
+	/* call normal and not annoted drivers (not sorted) */
+	do_initcall_level(level++);
+	/* call late drivers */
+	do_initcall_level(level);
 }
 
 /*
-- 
2.1.0
