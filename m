From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 13 May 2014 21:27:17 +0200
Subject: [RFC PATCH 11/9] dt: deps: dtc: introduce new (virtual) property
 no-dependencies
In-Reply-To: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1400009237-5012-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some rare cases it might make sense for not wanting an automatic
dependency for some used phandles.

E.g. if a cpu depends on a regulator which depends on i2c which depends
on some bus and you want that the bus depends on the cpu. That would
end up in a cycle. Usually such doesn't make sense because the hw doesn't
support such circular dependencies too (you always have to start somewhere
with initializing things). But e.g. in the case of the regulator the cpu
depends on, it's very likely that the regulator was initialized
automatically (otherwise the cpu won't run), so there is no real need to
initialize the regulator before the cpu. But that's just an example for
one of such rare cases where it might make sense to avoid an otherwise
automatically added dependency.

The syntax is like

	bar: whatever {
		...
	};
	foo {
		my-option = <&bar 1 2 3>;
		no-dependencies = <&bar>;
	};

Without that 'no-dependencies' property dtc would automatically add a
dependency to bar to the property 'dependencies' of the node foo.
But with that 'no-dependencies' it will not automatically add the
listed dependencies.

The property 'no-dependencies' is virtual property and will not be added
to any output file.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 scripts/dtc/dependencies.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/dtc/dependencies.c b/scripts/dtc/dependencies.c
index 4579f6f..06f447b 100644
--- a/scripts/dtc/dependencies.c
+++ b/scripts/dtc/dependencies.c
@@ -73,6 +73,16 @@ static void add_deps(struct node *dt, struct node *node, struct property *prop)
 				is_parent_of(target, source))
 			continue;
 		phandle = get_node_phandle(dt, target);
+		prop_deps = get_property(node, "no-dependencies");
+		if (prop_deps) {
+			/* avoid adding non-dependencies */
+			cell = (cell_t *)prop_deps->val.val;
+			for (i = 0; i < prop_deps->val.len/4; ++i)
+				if (*cell++ == cpu_to_fdt32(phandle))
+					break;
+			if (i < prop_deps->val.len/4)
+				continue;
+		}
 		prop_deps = get_property(source, "dependencies");
 		if (!prop_deps) {
 			add_property(source,
@@ -102,9 +112,21 @@ static void process_nodes_props(struct node *dt, struct node *node)
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
1.8.3.1
