From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Dec 2017 02:20:49 -0500
Subject: [PATCH V8 3/7] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
References: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513149653-19451-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an OF/ACPI function to obtain the driver data. We want to hide
OF/ACPI details from the device drivers and abstract following the device
family of functions.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 7 +++++++
 include/linux/fwnode.h   | 4 ++++
 include/linux/property.h | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 851b1b6..09eaac9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1340,3 +1340,10 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
+
+void *device_get_match_data(struct device *dev)
+{
+	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
+				  dev);
+}
+EXPORT_SYMBOL_GPL(device_get_match_data);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 411a84c..4fa1a48 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 struct fwnode_operations;
+struct device;
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -51,6 +52,7 @@ struct fwnode_reference_args {
  * struct fwnode_operations - Operations for fwnode interface
  * @get: Get a reference to an fwnode.
  * @put: Put a reference to an fwnode.
+ * @device_get_match_data: Return the device driver match data.
  * @property_present: Return true if a property is present.
  * @property_read_integer_array: Read an array of integer properties. Return
  *				 zero on success, a negative error code
@@ -71,6 +73,8 @@ struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
+	void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
+				       const struct device *dev);
 	bool (*property_present)(const struct fwnode_handle *fwnode,
 				 const char *propname);
 	int (*property_read_int_array)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index f6189a3..6653ed4 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -275,6 +275,8 @@ int device_add_properties(struct device *dev,
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
 
+void *device_get_match_data(struct device *dev);
+
 int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
-- 
1.9.1
