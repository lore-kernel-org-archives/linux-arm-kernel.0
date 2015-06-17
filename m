From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:17 +0200
Subject: [PATCH 07/13] driver-core: Add class.get_dependencies() callback
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Classes can implement this callback to provide a list of dependencies
for a firmware node. These dependencies can be used to probe devices in
order and to give proper warnings when dependencies cannot be fulfilled.

This functionality is implemented in a class callback because subsystems
implement the bindings that define how dependencies are expressed in the
firmware.

Adds struct fwnode_dependency, to be used to represent lists of
dependencies of fwnodes.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 include/linux/device.h | 6 ++++++
 include/linux/fwnode.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5a31bf3..c52f290 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -367,6 +367,10 @@ int subsys_virtual_register(struct bus_type *subsys,
  * @dev_release: Called to release the device.
  * @suspend:	Used to put the device to sleep mode, usually to a low power
  *		state.
+ * @get_dependencies: Returns a list of struct fwnode_dependency containing
+ *		the dependencies of the passed firmware node. The class is
+ *		expected to inspect the firmware node and extract dependencies
+ *		from its properties, based on bindings documentation.
  * @resume:	Used to bring the device from the sleep mode.
  * @ns_type:	Callbacks so sysfs can detemine namespaces.
  * @namespace:	Namespace of the device belongs to this class.
@@ -397,6 +401,8 @@ struct class {
 	int (*suspend)(struct device *dev, pm_message_t state);
 	int (*resume)(struct device *dev);
 
+	struct list_head *(*get_dependencies)(struct fwnode_handle *fwnode);
+
 	const struct kobj_ns_type_operations *ns_type;
 	const void *(*namespace)(struct device *dev);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0408545..68ab558 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -24,4 +24,9 @@ struct fwnode_handle {
 	struct fwnode_handle *secondary;
 };
 
+struct fwnode_dependency {
+	struct fwnode_handle *fwnode;
+	struct list_head dependency;
+};
+
 #endif
-- 
2.4.1
