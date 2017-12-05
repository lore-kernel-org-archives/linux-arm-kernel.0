From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  5 Dec 2017 12:04:48 -0500
Subject: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an OF/ACPI function to obtain the driver data. We want to hide
OF/ACPI details from the device drivers and abstract following the device
family of functions.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/base/property.c  | 6 ++++++
 include/linux/fwnode.h   | 4 ++++
 include/linux/property.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7ed99c1..65bf6f2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1335,3 +1335,9 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
+
+void *device_get_match_data(struct device *dev)
+{
+	return fwnode_call_ptr_op(dev_fwnode(dev), get_match_data, dev);
+}
+EXPORT_SYMBOL_GPL(device_get_match_data);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0c35b6c..ab9aab5 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 struct fwnode_operations;
+struct device;
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -66,6 +67,7 @@ struct fwnode_reference_args {
  *			       endpoint node.
  * @graph_get_port_parent: Return the parent node of a port node.
  * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
+ * @get_match_data: Return the driver match data.
  */
 struct fwnode_operations {
 	void (*get)(struct fwnode_handle *fwnode);
@@ -101,6 +103,8 @@ struct fwnode_operations {
 	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
+	void *(*get_match_data)(const struct fwnode_handle *fwnode,
+				struct device *dev);
 };
 
 #define fwnode_has_op(fwnode, op)				\
diff --git a/include/linux/property.h b/include/linux/property.h
index 6bebee1..01fa55b 100644
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
