From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 03 Jul 2014 17:49:05 +0100
Subject: [PATCH RFC] drm: add of_graph endpoint helper to find possible CRTCs
Message-ID: <E1X2kC1-0000sH-C6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to allow encoders to find their possible CRTCs from the
OF graph without having to re-implement this functionality.  We add a
device_node to drm_crtc which corresponds with the port node in the
DT description of the CRTC device.

We can then scan the DRM device list for CRTCs to find their index,
matching the appropriate CRTC using the port device_node, thus building
up the possible CRTC mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This helper will be shared between imx-drm and Armada DRM, and should
be useful for other OF-based drivers.  At the moment, this is being
sent for comments and acks; I need to build upon this patch in order
to convert Armada DRM to DT.

 drivers/gpu/drm/Makefile |  1 +
 drivers/gpu/drm/drm_of.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc.h   |  2 ++
 include/drm/drm_of.h     | 18 ++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_of.c
 create mode 100644 include/drm/drm_of.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index dd2ba4269740..533d011eab3e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -20,6 +20,7 @@ drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
 drm-$(CONFIG_PCI) += ati_pcigart.o
 drm-$(CONFIG_DRM_PANEL) += drm_panel.o
+drm-$(CONFIG_OF) += drm_of.o
 
 drm-usb-y   := drm_usb.o
 
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
new file mode 100644
index 000000000000..46d967881689
--- /dev/null
+++ b/drivers/gpu/drm/drm_of.c
@@ -0,0 +1,65 @@
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/of_graph.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_of.h>
+
+/**
+ * drm_crtc_port_mask - find the mask of a registered CRTC by port OF node
+ * @dev: DRM device
+ * @port: port OF node
+ *
+ * Given a port OF node, return the possible mask of the corresponding
+ * CRTC within a device's list of CRTCs.  Returns zero if not found.
+ */
+static uint32_t drm_crtc_port_mask(struct drm_device *dev,
+				   struct device_node *port)
+{
+	unsigned int index = 0;
+	struct drm_crtc *tmp;
+
+	list_for_each_entry(tmp, &dev->mode_config.crtc_list, head) {
+		if (tmp->port == port)
+			return 1 << index;
+
+		index++;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_of_find_possible_crtcs - find the possible CRTCs for an encoder port
+ * @dev: DRM device
+ * @port: encoder port to scan for endpoints
+ *
+ * Scan all endpoints attached to a port, locate their attached CRTCs,
+ * and generate the DRM mask of CRTCs which may be attached to this
+ * encoder.
+ */
+uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
+				    struct device_node *port)
+{
+	struct device_node *remote_port, *ep = NULL;
+	uint32_t possible_crtcs = 0;
+
+	do {
+		ep = of_graph_get_next_endpoint(port, ep);
+		if (!ep)
+			break;
+
+		remote_port = of_graph_get_remote_port(ep);
+		if (!remote_port) {
+			of_node_put(ep);
+			return 0;
+		}
+
+		possible_crtcs |= drm_crtc_port_mask(dev, remote_port);
+
+		of_node_put(remote_port);
+	} while (1);
+
+	return possible_crtcs;
+}
+EXPORT_SYMBOL(drm_of_find_possible_crtcs);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 251b75e6bf7a..6a94909f1ca9 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -41,6 +41,7 @@ struct drm_framebuffer;
 struct drm_object_properties;
 struct drm_file;
 struct drm_clip_rect;
+struct device_node;
 
 #define DRM_MODE_OBJECT_CRTC 0xcccccccc
 #define DRM_MODE_OBJECT_CONNECTOR 0xc0c0c0c0
@@ -314,6 +315,7 @@ struct drm_crtc_funcs {
  */
 struct drm_crtc {
 	struct drm_device *dev;
+	struct device_node *port;
 	struct list_head head;
 
 	/**
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
new file mode 100644
index 000000000000..2441f7112074
--- /dev/null
+++ b/include/drm/drm_of.h
@@ -0,0 +1,18 @@
+#ifndef __DRM_OF_H__
+#define __DRM_OF_H__
+
+struct drm_device;
+struct device_node;
+
+#ifdef CONFIG_OF
+extern uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
+					   struct device_node *port);
+#else
+static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
+						  struct device_node *port)
+{
+	return 0;
+}
+#endif
+
+#endif /* __DRM_OF_H__ */
-- 
1.8.3.1
