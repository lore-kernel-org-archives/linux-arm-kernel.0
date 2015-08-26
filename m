From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:16 +0200
Subject: [PATCH 04/16] deps: dtc: introduce new (virtual) property
 no-dependencies
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-5-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases it makes sense to handle some phandles not as dependencies.

This is escpecially true for 'remote-endpoint' properties, because these
otherwise introducing dependency cycles into the graph. To avoid these,
one end of each remote-endpoint pairs has not to be handled as a
dependency.

The syntax is like

	foo {
		remote-endpoint = <&bar>;
	};
	bar {
		remote-endpoint = <&foo>;
		no-dependencies = <&foo>;
	};

Without that 'no-dependencies' property dtc would automatically add a
dependency to foo to the property 'dependencies' of the node bar.
But with that 'no-dependencies' it will not automatically add the
listed dependencies.

The property 'no-dependencies' is virtual property and will not be added
to any output file.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 scripts/dtc/dependencies.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/scripts/dtc/dependencies.c b/scripts/dtc/dependencies.c
index 2c1e0d4..76e4d91 100644
--- a/scripts/dtc/dependencies.c
+++ b/scripts/dtc/dependencies.c
@@ -44,6 +44,23 @@ static bool is_parent_of(struct node *node1, struct node *node2)
 
 }
 
+static bool is_no_dependency(struct node *dt, struct property *prop, cell_t ph)
+{
+	struct node *node;
+	unsigned i;
+	cell_t *cell = (cell_t *)(prop->val.val);
+
+	for (i = 0; i < prop->val.len/4; ++i) {
+		node = get_node_by_phandle(dt, cpu_to_fdt32(*cell++));
+		if (node) {
+			node = find_compatible_not_disabled(node);
+			if (node && get_node_phandle(dt, node) == ph)
+				return true;
+		}
+	}
+	return false;
+}
+
 static void add_deps(struct node *dt, struct node *node, struct property *prop)
 {
 	struct marker *m = prop->val.markers;
@@ -73,6 +90,10 @@ static void add_deps(struct node *dt, struct node *node, struct property *prop)
 				is_parent_of(target, source))
 			continue;
 		phandle = get_node_phandle(dt, target);
+		prop_deps = get_property(node, "no-dependencies");
+		if (prop_deps && is_no_dependency(dt, prop_deps, phandle))
+			/* avoid adding non-dependencies */
+			continue;
 		prop_deps = get_property(source, "dependencies");
 		if (!prop_deps) {
 			add_property(source,
@@ -102,9 +123,21 @@ static void process_nodes_props(struct node *dt, struct node *node)
 		process_nodes_props(dt, child);
 }
 
+static void del_prop_no_dependencies(struct node *node)
+{
+	struct node *child;
+
+	if (!node)
+		return;
+	delete_property_by_name(node, "no-dependencies");
+	for_each_child(node, child)
+		del_prop_no_dependencies(child);
+}
+
 void add_dependencies(struct boot_info *bi)
 {
 	process_nodes_props(bi->dt, bi->dt);
+	del_prop_no_dependencies(bi->dt);
 }
 
 /*
-- 
2.1.0
