From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:34 +0200
Subject: [PATCH v2 03/22] device property: add fwnode_get_name()
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting a textual representation of a device node can be very useful for
debugging.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Use of_node_full_name()

 drivers/base/property.c  | 15 +++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f3f6d167f3f1..efa74803af30 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -533,3 +533,18 @@ bool device_dma_is_coherent(struct device *dev)
 	return coherent;
 }
 EXPORT_SYMBOL_GPL(device_dma_is_coherent);
+
+/**
+ * fwnode_get_name - return the name of a device node
+ * @fwnode: Device node to find the name of
+ */
+const char *fwnode_get_name(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		return of_node_full_name(to_of_node(fwnode));
+	else if (is_acpi_node(fwnode))
+		return acpi_dev_name(to_acpi_node(fwnode));
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_name);
diff --git a/include/linux/property.h b/include/linux/property.h
index 76ebde9c11d4..826f156f7288 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -63,6 +63,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
+const char *fwnode_get_name(struct fwnode_handle *fwnode);
+
 #define device_for_each_child_node(dev, child) \
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
-- 
2.4.3
