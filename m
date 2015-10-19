From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 19 Oct 2015 13:21:50 +0100
Subject: [RFC PATCH v2 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <1445257313-7147-1-git-send-email-Liviu.Dudau@arm.com>
References: <1445257313-7147-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1445257313-7147-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of component based DRM drivers use a variant of the same code
as the probe function. They bind the crtc ports in the first iteration
and then scan through the child nodes and bind the encoders attached
to the remote endpoints. Factor the common code into a separate
function called drm_of_component_probe() in order to increase code
reuse.

Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/gpu/drm/drm_of.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_of.h     | 12 +++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index be38840..cf16240 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -1,3 +1,4 @@
+#include <linux/component.h>
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/of_graph.h>
@@ -61,3 +62,94 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 	return possible_crtcs;
 }
 EXPORT_SYMBOL(drm_of_find_possible_crtcs);
+
+/**
+ * drm_of_component_probe - Generic probe function for a component based master
+ * @dev: master device containing the OF node
+ * @compare_of: compare function used for matching components
+ * @master_ops: component master ops to be used
+ *
+ * Parse the platform device OF node and bind all the components associated
+ * with the master. Interface ports are added before the encoders in order to
+ * satisfy their .bind requirements
+ * See Documentation/devicetree/bindings/graph.txt for the bindings.
+ *
+ * Returns zero if successful, or one of the standard error codes if it fails.
+ */
+int drm_of_component_probe(struct device *dev,
+			   int (*compare_of)(struct device *, void *),
+			   const struct component_master_ops *master_ops)
+{
+	struct device_node *ep, *port, *remote;
+	struct component_match *match = NULL;
+	int i, ret;
+
+	if (!dev->of_node)
+		return -EINVAL;
+
+	/*
+	 * Bind the crtc's ports first, so that drm_of_find_possible_crtcs()
+	 * called from encoder's .bind callbacks works as expected
+	 */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(dev->of_node, "ports", i);
+		if (!port)
+			break;
+
+		if (!of_device_is_available(port->parent)) {
+			of_node_put(port);
+			continue;
+		}
+
+		component_match_add(dev, &match, compare_of, port);
+		of_node_put(port);
+	}
+
+	if (i == 0) {
+		dev_err(dev, "missing 'ports' property\n");
+		return -ENODEV;
+	}
+
+	if (!match) {
+		dev_err(dev, "no available port\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * For bound crtcs, bind the encoders attached to their remote endpoint
+	 */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(dev->of_node, "ports", i);
+		if (!port)
+			break;
+
+		if (!of_device_is_available(port->parent)) {
+			of_node_put(port);
+			continue;
+		}
+
+		for_each_child_of_node(port, ep) {
+			remote = of_graph_get_remote_port_parent(ep);
+			if (!remote || !of_device_is_available(remote)) {
+				of_node_put(remote);
+				continue;
+			} else if (!of_device_is_available(remote->parent)) {
+				dev_warn(dev, "parent device of %s is not available\n",
+					 remote->full_name);
+				of_node_put(remote);
+				continue;
+			}
+
+			component_match_add(dev, &match, compare_of, remote);
+			of_node_put(remote);
+		}
+		of_node_put(port);
+	}
+
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	return component_master_add_with_match(dev, master_ops, match);
+}
+EXPORT_SYMBOL(drm_of_component_probe);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 2441f71..7c0c05b 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -1,18 +1,30 @@
 #ifndef __DRM_OF_H__
 #define __DRM_OF_H__
 
+struct component_master_ops;
+struct device;
 struct drm_device;
 struct device_node;
 
 #ifdef CONFIG_OF
 extern uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 					   struct device_node *port);
+extern int drm_of_component_probe(struct device *dev,
+				  int (*compare_of)(struct device *, void *),
+				  const struct component_master_ops *master_ops);
 #else
 static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 						  struct device_node *port)
 {
 	return 0;
 }
+
+static inline int drm_of_component_probe(struct device *dev,
+					int (*compare_of)(struct device *, void *),
+					 const struct component_master_ops *master_ops)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* __DRM_OF_H__ */
-- 
2.6.0
