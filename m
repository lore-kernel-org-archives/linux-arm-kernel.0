From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 17 Jan 2018 17:55:42 +0100
Subject: [net-next: PATCH v3 3/7] device property: Introduce fwnode_irq_get()
In-Reply-To: <1516208146-4144-1-git-send-email-mw@semihalf.com>
References: <1516208146-4144-1-git-send-email-mw@semihalf.com>
Message-ID: <1516208146-4144-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now there were two very similar functions allowing
to get Linux IRQ number from ACPI handle (acpi_irq_get())
and OF node (of_irq_get()). The first one appeared to be used
only as a subroutine of platform_irq_get(), which (in the generic
code) limited IRQ obtaining from _CRS method only to nodes
associated to kernel's struct platform_device.

This patch introduces new helper routine - fwnode_irq_get(),
which allows to get the IRQ number directly from the fwnode
to be used as common for OF/ACPI worlds.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/base/property.c  | 27 ++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7c4a53d..adb3893 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/of_irq.h>
 #include <linux/property.h>
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
@@ -1230,6 +1231,32 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
 EXPORT_SYMBOL(device_get_mac_address);
 
 /**
+ * fwnode_irq_get - Get IRQ directly from a fwnode
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Zero-based index of the IRQ
+ *
+ * Returns Linux IRQ number on success. Other values are determined
+ * accordingly to acpi_/of_ irq_get() operation.
+ */
+int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
+{
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
+	struct device_node *of_node = to_of_node(fwnode);
+	struct resource res;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_OF) && of_node)
+		return of_irq_get(of_node, index);
+
+	ret = acpi_irq_get(acpi_device_handle(adev), index, &res);
+	if (ret)
+		return ret;
+
+	return res.start;
+}
+EXPORT_SYMBOL(fwnode_irq_get);
+
+/**
  * device_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
  * @prev: Previous endpoint node or %NULL to get the first
diff --git a/include/linux/property.h b/include/linux/property.h
index 9b13332..e05889f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -103,6 +103,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.7.4
