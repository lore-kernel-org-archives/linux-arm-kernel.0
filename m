From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 May 2011 13:14:47 -0500
Subject: [RFC PATCH] drivers/amba: probe via device tree reworked
Message-ID: <1305742487-28325-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This reworks the original amba bus device tree probing to be more inline with
how platform bus probing via device tree is done using a match table.

The amba bus code doesn't support creation of parent devices, so a flat tree
is created even if the device tree contains a heirarchy of devices.

Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/amba/bus.c       |   84 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/amba/bus.h |    4 ++-
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ed5c49d..4e46b54 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define DEBUG
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -797,7 +798,7 @@ EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
 
 #ifdef CONFIG_OF
-static int of_amba_device_create(struct device_node *node,struct device *parent)
+static struct amba_device *of_amba_device_create(struct device_node *node,struct device *parent)
 {
 	struct amba_device *dev;
 	const void *prop;
@@ -805,7 +806,7 @@ static int of_amba_device_create(struct device_node *node,struct device *parent)
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		return -ENOMEM;
+		return NULL;
 
 	/* setup generic device info */
 	dev->dev.coherent_dma_mask = ~0;
@@ -839,22 +840,87 @@ static int of_amba_device_create(struct device_node *node,struct device *parent)
 				    "probed value (0x%08x) don't agree.",
 				    of_read_ulong(prop, 1), dev->periphid);
 
-	return 0;
+	return dev;
 
 err_free:
 	kfree(dev);
-	return ret;
+	return NULL;
+}
+
+/**
+ * of_amba_bus_create() - Create a device for a node and its children.
+ * @bus: device node of the bus to instantiate
+ * @matches: match table for bus nodes
+ * disallow recursive creation of child buses
+ * @parent: parent for new device, or NULL for top level.
+ *
+ * Recursively create devices for all the child nodes.
+ */
+static int of_amba_bus_create(struct device_node *bus,
+				  const struct of_device_id *matches,
+				  struct device *parent, bool strict)
+{
+	struct device_node *child;
+	struct amba_device *dev = NULL;
+	int rc = 0;
+
+	/* Make sure it has a compatible property */
+	if (strict && (!of_get_property(bus, "compatible", NULL))) {
+		pr_debug("%s() - skipping %s, no compatible prop\n",
+			 __func__, bus->full_name);
+		return 0;
+	}
+
+	if (of_device_is_compatible(bus, "arm,amba-device"))
+		dev = of_amba_device_create(bus, parent);
+	else if (!of_match_node(matches, bus))
+		return 0;
+
+	for_each_child_of_node(bus, child) {
+		pr_debug("   create child: %s\n", child->full_name);
+		rc = of_amba_bus_create(child, matches, parent, strict);
+		if (rc) {
+			of_node_put(child);
+			break;
+		}
+	}
+	return rc;
 }
 
-void of_amba_bus_populate(struct device_node *node, struct device *parent)
+/**
+ * of_amba_bus_probe() - Probe the device-tree for amba buses
+ * @root: parent of the first level to probe or NULL for the root of the tree
+ * @matches: match table for bus nodes
+ * @parent: parent to hook devices from, NULL for toplevel
+ *
+ * Note that children of the provided root are not instantiated as devices
+ * unless the specified root itself matches the bus list and is not NULL.
+ */
+int of_amba_bus_probe(struct device_node *root,
+		       const struct of_device_id *matches,
+		       struct device *parent)
 {
+	int rc = 0;
 	struct device_node *child;
 
-	for_each_child_of_node(node, child) {
-		if (of_device_is_compatible(child, "arm,amba-device"))
-			of_amba_device_create(child, parent);
+	root = root ? of_node_get(root) : of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	/* Do a self check of bus type, if there's a match, create children */
+	if (of_match_node(matches, root)) {
+		rc = of_amba_bus_create(root, matches, parent, false);
+	} else for_each_child_of_node(root, child) {
+		if (!of_match_node(matches, child))
+			continue;
+		rc = of_amba_bus_create(child, matches, parent, false);
+		if (rc)
+			break;
 	}
+
+	of_node_put(root);
+	return rc;
 }
-EXPORT_SYMBOL(of_amba_bus_populate);
+EXPORT_SYMBOL(of_amba_bus_probe);
 
 #endif /* CONFIG_OF */
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index cb17dfd..6df9535 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -96,7 +96,9 @@ void amba_release_regions(struct amba_device *);
 
 #ifdef CONFIG_OF
 struct device_node;
-void of_amba_bus_populate(struct device_node *node, struct device *parent);
+int of_amba_bus_probe(struct device_node *root,
+		      const struct of_device_id *matches,
+		      struct device *parent);
 #endif
 
 #endif
-- 
1.7.4.1
