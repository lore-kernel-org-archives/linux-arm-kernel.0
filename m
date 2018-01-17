From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 17 Jan 2018 17:55:43 +0100
Subject: [net-next: PATCH v3 4/7] device property: Allow iterating over
 available child fwnodes
In-Reply-To: <1516208146-4144-1-git-send-email-mw@semihalf.com>
References: <1516208146-4144-1-git-send-email-mw@semihalf.com>
Message-ID: <1516208146-4144-5-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement a new helper function fwnode_get_next_available_child_node(),
which enables obtaining next enabled child fwnode, which
works on a similar basis to OF's of_get_next_available_child().

This commit also introduces a macro, thanks to which it is
possible to iterate over the available fwnodes, using the
new function described above.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/base/property.c  | 26 ++++++++++++++++++++
 include/linux/property.h |  6 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index adb3893..2343906 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -998,6 +998,32 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
 /**
+ * fwnode_get_next_available_child_node - Return the next
+ * available child node handle for a node
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the node's child nodes or a %NULL handle.
+ */
+struct fwnode_handle *
+fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
+				     struct fwnode_handle *child)
+{
+	struct fwnode_handle *next_child = child;
+
+	if (!fwnode)
+		return NULL;
+
+	do {
+		next_child = fwnode_get_next_child_node(fwnode, next_child);
+
+		if (!next_child || fwnode_device_is_available(next_child))
+			break;
+	} while (next_child);
+
+	return next_child;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
+
+/**
  * device_get_next_child_node - Return the next child node handle for a device
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
diff --git a/include/linux/property.h b/include/linux/property.h
index e05889f..5b0563a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -83,11 +83,17 @@ struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
+struct fwnode_handle *fwnode_get_next_available_child_node(
+	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 
 #define fwnode_for_each_child_node(fwnode, child)			\
 	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child = fwnode_get_next_child_node(fwnode, child))
 
+#define fwnode_for_each_available_child_node(fwnode, child)		       \
+	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
+	     child = fwnode_get_next_available_child_node(fwnode, child))
+
 struct fwnode_handle *device_get_next_child_node(
 	struct device *dev, struct fwnode_handle *child);
 
-- 
2.7.4
