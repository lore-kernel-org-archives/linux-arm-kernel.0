From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 18 Jan 2018 13:31:40 +0100
Subject: [net-next: PATCH v4 3/7] device property: Introduce fwnode_irq_get()
In-Reply-To: <1516278704-17141-1-git-send-email-mw@semihalf.com>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
Message-ID: <1516278704-17141-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now there were two very similar functions allowing
to get Linux IRQ number from ACPI handle (acpi_irq_get())
and OF node (of_irq_get()). The first one appeared to be used
only as a subroutine of platform_irq_get(), which (in the generic
code) limited IRQ obtaining from _CRS method only to nodes
associated to kernel's struct platform_device.

This patch introduces a new helper routine - fwnode_irq_get(),
which allows to get the IRQ number directly from the fwnode
to be used as common for OF/ACPI worlds. It is usable not
only for the parents fwnodes, but also for the child nodes
comprising their own _CRS methods with interrupts description.

In order to be able o satisfy compilation with !CONFIG_ACPI
and also simplify the new code, introduce a helper macro
(ACPI_HANDLE_FWNODE), with which it is possible to reach
an ACPI handle directly from its fwnode.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/base/property.c  | 26 ++++++++++++++++++++
 include/linux/acpi.h     |  3 +++
 include/linux/property.h |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7c4a53d..1d6c9d9 100644
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
@@ -1230,6 +1231,31 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
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
+	struct device_node *of_node = to_of_node(fwnode);
+	struct resource res;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_OF) && of_node)
+		return of_irq_get(of_node, index);
+
+	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index dc1ebfe..f05b9b6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -56,6 +56,8 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 #define ACPI_COMPANION_SET(dev, adev)	set_primary_fwnode(dev, (adev) ? \
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
+#define ACPI_HANDLE_FWNODE(fwnode)	\
+				acpi_device_handle(to_acpi_device_node(fwnode))
 
 static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 {
@@ -626,6 +628,7 @@ int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count)
 #define ACPI_COMPANION(dev)		(NULL)
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
+#define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
 #define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
 
 struct fwnode_handle;
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
