From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:37 +0200
Subject: [PATCH v2 06/22] device property: add fwnode_ensure_device()
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checks if the device associated with this firmware node has been already
probed, and probes it if not.

It can be used by resource getters to make sure that the requested
resource is available, if at all possible.

For OF nodes, it finds the platform device that encloses this node and
tries to probe it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Add fwnode_ensure_device() so the mechanism for probing devices on
  demand is independent of the firmware format.

 drivers/base/property.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index efa74803af30..a63d9bc3d8f7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -15,8 +15,11 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/property.h>
 
+#include "base.h"
+
 /**
  * device_add_property_set - Add a collection of properties to a device object.
  * @dev: Device to add properties to.
@@ -548,3 +551,58 @@ const char *fwnode_get_name(struct fwnode_handle *fwnode)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_name);
+
+/**
+ * fwnode_ensure_device - probes the device associated to this firmware node
+ * @fwnode: Firmware node whose device is to be probed
+ *
+ * Checks if the device associated with this firmware node has been already
+ * probed, and probes it if not.  It can be used by resource getters to make
+ * sure that the requested resource is available, if at all possible.
+ */
+void fwnode_ensure_device(struct fwnode_handle *fwnode)
+{
+	struct device *dev = NULL;
+
+	/*
+	 * In general, OF nodes don't have a single device associated to them,
+	 * but those directly beneath the root of the tree or that are
+	 * children of simple memory mapped bus nodes do have just one
+	 * platform device. See Documentation/devicetree/usage-model.txt for
+	 * a more extended explanation.
+	 *
+	 * of_platform_device_find() will return such a platform device and
+	 * probing it should cause the target device to be probed as well
+	 * because platform devices are expected to register their children
+	 * when probing.
+	 */
+	if (is_of_node(fwnode))
+		dev = of_platform_device_find(to_of_node(fwnode));
+	else if (is_acpi_node(fwnode))
+		dev = acpi_dev_get_device(to_acpi_node(fwnode));
+
+	if (!dev) {
+		/*
+		 * Cannot be a warning because some fwnodes will have
+		 * matching data but aren't really supposed to be probed.
+		 */
+		pr_debug("Couldn't find device for %s\n",
+			 fwnode_get_name(fwnode));
+		return;
+	}
+
+	/*
+	 * Device is bound or is being probed right now. If we have bad luck
+	 * and the dependency isn't ready when it's needed, deferred probe
+	 * will save us.
+	 */
+	if (dev->driver)
+		return;
+
+	bus_probe_device(dev);
+
+	if (!dev->driver)
+		pr_warn("Probe failed for %s (%s)\n",
+			fwnode_get_name(fwnode), dev_name(dev));
+}
+EXPORT_SYMBOL_GPL(fwnode_ensure_device);
diff --git a/include/linux/property.h b/include/linux/property.h
index 826f156f7288..6b99296bcad7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -168,4 +168,6 @@ void device_add_property_set(struct device *dev, struct property_set *pset);
 
 bool device_dma_is_coherent(struct device *dev);
 
+void fwnode_ensure_device(struct fwnode_handle *fwnode);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.4.3
