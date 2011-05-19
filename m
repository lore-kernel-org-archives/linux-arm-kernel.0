From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 May 2011 13:28:24 -0500
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
Message-ID: <1305829704-11774-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add functions to parse the AMBA bus through the device tree.

Based on the original version by Jeremy Kerr. This reworks the original amba
bus device tree probing to be more inline with how platform bus probing via
device tree is done using a match table.

Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/amba/bus.c       |  133 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/bus.h |    7 +++
 2 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 7025593..8e55754 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -13,6 +13,11 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
@@ -780,3 +785,131 @@ EXPORT_SYMBOL(amba_device_unregister);
 EXPORT_SYMBOL(amba_find_device);
 EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
+
+#ifdef CONFIG_OF
+int of_amba_device_create(struct device_node *node,struct device *parent)
+{
+	struct amba_device *dev;
+	const void *prop;
+	int i, ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	/* setup generic device info */
+	dev->dev.coherent_dma_mask = ~0;
+	dev->dev.of_node = node;
+	dev->dev.parent = parent;
+	of_device_make_bus_id(&dev->dev);
+
+	/* setup amba-specific device info */
+	dev->dma_mask = ~0;
+
+	/* Decode the IRQs and address ranges */
+	for (i = 0; i < AMBA_NR_IRQS; i++)
+		dev->irq[i] = irq_of_parse_and_map(node, i);
+
+	ret = of_address_to_resource(node, 0, &dev->res);
+	if (ret)
+		goto err_free;
+
+	ret = amba_device_register(dev, &iomem_resource);
+	if (ret)
+		goto err_free;
+
+	/* Sanity check the arm,amba-deviceid value */
+	prop = of_get_property(node, "arm,amba-deviceid", NULL);
+	if (!prop)
+		dev_warn(&dev->dev, "arm,amba-deviceid property missing; "
+				    "probe gives 0x%08x.\n", dev->periphid);
+
+	if (prop && (dev->periphid != of_read_ulong(prop, 1)))
+		dev_warn(&dev->dev, "arm,amba-deviceid value (0x%08lx) and "
+				    "probed value (0x%08x) don't agree.",
+				    of_read_ulong(prop, 1), dev->periphid);
+
+	return 0;
+
+err_free:
+	kfree(dev);
+	return ret;
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
+			      const struct of_device_id *matches,
+			      struct device *parent)
+{
+	struct of_platform_prepare_data *prep;
+	struct device_node *child;
+	struct platform_device *dev;
+	int rc = 0;
+
+	/* Make sure it has a compatible property */
+	if (!of_get_property(bus, "compatible", NULL)) {
+		pr_debug("%s() - skipping %s, no compatible prop\n",
+			 __func__, bus->full_name);
+		return 0;
+	}
+
+	if (!of_match_node(matches, bus))
+		return 0;
+
+	dev = of_platform_device_create(bus, NULL, parent);
+	if (!dev)
+		return 0;
+
+	for_each_child_of_node(bus, child) {
+		pr_debug("   create child: %s\n", child->full_name);
+		if (of_device_is_compatible(child, "arm,amba-device"))
+			of_amba_device_create(child, &dev->dev);
+		else
+			rc = of_amba_bus_create(child, matches, &dev->dev);
+		if (rc) {
+			of_node_put(child);
+			break;
+		}
+	}
+	return rc;
+}
+
+/**
+ * of_amba_bus_populate() - Probe the device-tree for amba buses
+ * @root: parent of the first level to probe or NULL for the root of the tree
+ * @matches: match table for bus nodes
+ * @parent: parent to hook devices from, NULL for toplevel
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_amba_bus_populate(struct device_node *root,
+			 const struct of_device_id *matches,
+			 struct device *parent)
+{
+	struct device_node *child;
+	int rc = 0;
+
+	root = root ? of_node_get(root) : of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	for_each_child_of_node(root, child) {
+		rc = of_amba_bus_create(child, matches, parent);
+		if (rc)
+			break;
+	}
+
+	of_node_put(root);
+	return rc;
+}
+EXPORT_SYMBOL(of_amba_bus_populate);
+
+#endif /* CONFIG_OF */
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index fcbbe71..9968354 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -94,4 +94,11 @@ void amba_release_regions(struct amba_device *);
 #define amba_manf(d)	AMBA_MANF_BITS((d)->periphid)
 #define amba_part(d)	AMBA_PART_BITS((d)->periphid)
 
+#ifdef CONFIG_OF
+struct device_node;
+int of_amba_bus_populate(struct device_node *root,
+			 const struct of_device_id *matches,
+			 struct device *parent);
+#endif
+
 #endif
-- 
1.7.4.1
