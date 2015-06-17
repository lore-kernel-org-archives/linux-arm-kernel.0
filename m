From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:21 +0200
Subject: [PATCH 11/13] device property: add fwnode_get_parent()
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-12-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So we can query the parent of a fwnode without having to resort to API
that is specific to a firmware data format.

Also adds a acpi_get_parent_dev() function to retrieve the parent
of an acpi_device. acpi_get_parent() already existed but it works with
acpi_handles.

The interface covers both ACPI and Device Trees.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/base/property.c  | 23 +++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  5 +++++
 include/linux/acpi.h     |  5 +++++
 include/linux/property.h |  2 ++
 4 files changed, 35 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1d0b116..28645a9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -519,3 +519,26 @@ unsigned int device_get_child_node_count(struct device *dev)
 	return count;
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
+
+/**
+ * fwnode_get_parent - return the parent node of a device node
+ * @fwnode: Device node to find the parent node of
+ */
+struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode)) {
+		struct device_node *node = of_node(fwnode);
+
+		if (node->parent)
+			return &node->parent->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		struct acpi_device *node;
+
+		node = acpi_get_parent_dev(acpi_node(fwnode));
+		if (node)
+			return acpi_fwnode_handle(node);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5dec08d..bf8ef1a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -401,6 +401,11 @@ static inline void *acpi_driver_data(struct acpi_device *d)
 	return d->driver_data;
 }
 
+static inline struct acpi_device *acpi_get_parent_dev(struct acpi_device *adev)
+{
+	return adev->parent;
+}
+
 #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
 #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a4acb55..d9dfacc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -825,6 +825,11 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
 	return NULL;
 }
 
+static inline struct acpi_device *acpi_get_parent_dev(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/property.h b/include/linux/property.h
index de8bdf4..01e0483 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -63,6 +63,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
+struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
+
 #define device_for_each_child_node(dev, child) \
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
-- 
2.4.1
