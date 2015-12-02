From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 2 Dec 2015 17:09:26 +0800
Subject: [RFC PATCH 2/4] device property: Introduce helper
 device_get_reference_node()
In-Reply-To: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1449047368-5768-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With of_parse_phandle() and acpi_dev_get_reference_device(), we can introduce
a universal helper device_get_reference_node() to read and parse a device
property and return a pointer to the resulting firmware node.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/property.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  6 ++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1325ff2..6517140 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -568,6 +568,46 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
+ * fwnode_get_reference_node - Find the firmware node referenced
+ * @fwnode: Firmware node to get the property from.
+ * @propname: Name of the property
+ * @index: Index of the reference
+ *
+ * Returns referenced fwnode handler pointer, or an NULL if not found
+ */
+struct fwnode_handle *fwnode_get_reference_node(struct fwnode_handle *fwnode,
+					 const char *propname, int index)
+{
+	if (is_of_node(fwnode)) {
+		struct device_node *np;
+		np = of_parse_phandle(to_of_node(fwnode), propname, index);
+		return np ? &np->fwnode : NULL;
+	} else if (is_acpi_node(fwnode)) {
+		struct acpi_device *adev;
+		adev = acpi_dev_get_reference_device(to_acpi_device_node(fwnode),
+						     propname, index);
+		return adev ? acpi_fwnode_handle(adev) : NULL;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_reference_node);
+
+/**
+ * dev_get_reference_node - Find the firmware node referenced
+ * @dev: Device to get the property from.
+ * @propname: Name of the property
+ * @index: Index of the reference
+ *
+ * Returns referenced fwnode handler pointer, or an NULL if not found
+ */
+struct fwnode_handle *device_get_reference_node(struct device *dev,
+					 const char *propname, int index)
+{
+	return fwnode_get_reference_node(dev_fwnode(dev), propname, index);
+}
+EXPORT_SYMBOL_GPL(device_get_reference_node);
+
+/**
  * fwnode_handle_put - Drop reference to a device node
  * @fwnode: Pointer to the device node to drop the reference to.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 0a3705a..d77e6a2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -70,6 +70,12 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 int fwnode_property_match_string(struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
+struct fwnode_handle *fwnode_get_reference_node(struct fwnode_handle *fwnode,
+						const char *propname, int index);
+
+struct fwnode_handle *device_get_reference_node(struct device *dev,
+						const char *propname, int index);
+
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
-- 
1.7.12.4
