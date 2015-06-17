From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:22 +0200
Subject: [PATCH 12/13] device property: add fwnode_get_name()
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-13-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting a textual representation of a device node can be very useful for
debugging.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/base/property.c  | 15 +++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 28645a9..05e45f8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -542,3 +542,18 @@ struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
+/**
+ * fwnode_get_name - return the name of a device node
+ * @fwnode: Device node to find the name of
+ */
+const char *fwnode_get_name(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		return of_node(fwnode)->full_name;
+	else if (is_acpi_node(fwnode))
+		return acpi_dev_name(acpi_node(fwnode));
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_name);
diff --git a/include/linux/property.h b/include/linux/property.h
index 01e0483..7b7c0e8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -65,6 +65,8 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
 
+const char *fwnode_get_name(struct fwnode_handle *fwnode);
+
 #define device_for_each_child_node(dev, child) \
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
-- 
2.4.1
