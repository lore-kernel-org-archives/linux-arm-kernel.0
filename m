From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 20 Nov 2015 14:22:05 +0000
Subject: [PATCH v2 2/2] drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1448029325-14602-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial attempt to convert rockchip to drm_of_component_probe() missed the
difference between ports and encoders when using the compare_of() function.
Now that drm_of_component_probe() has been enhanced, let's try again the
conversion.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 98 ++++++-----------------------
 1 file changed, 18 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f22e1e1..574324e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -19,6 +19,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_of.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
@@ -411,36 +412,6 @@ int rockchip_drm_encoder_get_mux_id(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(rockchip_drm_encoder_get_mux_id);
 
-static int compare_of(struct device *dev, void *data)
-{
-	struct device_node *np = data;
-
-	return dev->of_node == np;
-}
-
-static void rockchip_add_endpoints(struct device *dev,
-				   struct component_match **match,
-				   struct device_node *port)
-{
-	struct device_node *ep, *remote;
-
-	for_each_child_of_node(port, ep) {
-		remote = of_graph_get_remote_port_parent(ep);
-		if (!remote || !of_device_is_available(remote)) {
-			of_node_put(remote);
-			continue;
-		} else if (!of_device_is_available(remote->parent)) {
-			dev_warn(dev, "parent device of %s is not available\n",
-				 remote->full_name);
-			of_node_put(remote);
-			continue;
-		}
-
-		component_match_add(dev, match, compare_of, remote);
-		of_node_put(remote);
-	}
-}
-
 static int rockchip_drm_bind(struct device *dev)
 {
 	struct drm_device *drm;
@@ -481,63 +452,30 @@ static const struct component_master_ops rockchip_drm_ops = {
 	.unbind = rockchip_drm_unbind,
 };
 
-static int rockchip_drm_platform_probe(struct platform_device *pdev)
+static int compare_port(struct device *dev, void *data)
 {
-	struct device *dev = &pdev->dev;
-	struct component_match *match = NULL;
-	struct device_node *np = dev->of_node;
-	struct device_node *port;
-	int i;
+	struct device_node *np = data;
 
-	if (!np)
-		return -ENODEV;
-	/*
-	 * Bind the crtc ports first, so that
-	 * drm_of_find_possible_crtcs called from encoder .bind callbacks
-	 * works as expected.
-	 */
-	for (i = 0;; i++) {
-		port = of_parse_phandle(np, "ports", i);
-		if (!port)
-			break;
-
-		if (!of_device_is_available(port->parent)) {
-			of_node_put(port);
-			continue;
-		}
+	return dev->of_node == np->parent;
+}
 
-		component_match_add(dev, &match, compare_of, port->parent);
-		of_node_put(port);
-	}
+static int compare_encoder(struct device *dev, void *data)
+{
+	struct device_node *np = data;
 
-	if (i == 0) {
-		dev_err(dev, "missing 'ports' property\n");
-		return -ENODEV;
-	}
+	return dev->of_node == np;
+}
 
-	if (!match) {
-		dev_err(dev, "No available vop found for display-subsystem.\n");
-		return -ENODEV;
-	}
-	/*
-	 * For each bound crtc, bind the encoders attached to its
-	 * remote endpoint.
-	 */
-	for (i = 0;; i++) {
-		port = of_parse_phandle(np, "ports", i);
-		if (!port)
-			break;
-
-		if (!of_device_is_available(port->parent)) {
-			of_node_put(port);
-			continue;
-		}
+static int rockchip_drm_platform_probe(struct platform_device *pdev)
+{
+	int ret = drm_of_component_probe(&pdev->dev, compare_port,
+					 compare_encoder, &rockchip_drm_ops);
 
-		rockchip_add_endpoints(dev, &match, port);
-		of_node_put(port);
-	}
+	/* keep compatibility with old code that was returning -ENODEV */
+	if (ret == -EINVAL)
+		return -ENODEV;
 
-	return component_master_add_with_match(dev, &rockchip_drm_ops, match);
+	return ret;
 }
 
 static int rockchip_drm_platform_remove(struct platform_device *pdev)
-- 
2.6.2
