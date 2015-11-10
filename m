From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 10 Nov 2015 16:47:19 +0800
Subject: [PATCH] Revert "drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()"
Message-ID: <1447145239-10546-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 52f5eb60940de889ce98a876f6933b574ead3225.

Rockchip drm can't work with generic drm_of_component_probe now

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   81 +++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index d26e0cc..f22e1e1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -19,7 +19,6 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_of.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
@@ -419,6 +418,29 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == np;
 }
 
+static void rockchip_add_endpoints(struct device *dev,
+				   struct component_match **match,
+				   struct device_node *port)
+{
+	struct device_node *ep, *remote;
+
+	for_each_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote || !of_device_is_available(remote)) {
+			of_node_put(remote);
+			continue;
+		} else if (!of_device_is_available(remote->parent)) {
+			dev_warn(dev, "parent device of %s is not available\n",
+				 remote->full_name);
+			of_node_put(remote);
+			continue;
+		}
+
+		component_match_add(dev, match, compare_of, remote);
+		of_node_put(remote);
+	}
+}
+
 static int rockchip_drm_bind(struct device *dev)
 {
 	struct drm_device *drm;
@@ -461,14 +483,61 @@ static const struct component_master_ops rockchip_drm_ops = {
 
 static int rockchip_drm_platform_probe(struct platform_device *pdev)
 {
-	int ret = drm_of_component_probe(&pdev->dev, compare_of,
-					 &rockchip_drm_ops);
+	struct device *dev = &pdev->dev;
+	struct component_match *match = NULL;
+	struct device_node *np = dev->of_node;
+	struct device_node *port;
+	int i;
 
-	/* keep compatibility with old code that was returning -ENODEV */
-	if (ret == -EINVAL)
+	if (!np)
 		return -ENODEV;
+	/*
+	 * Bind the crtc ports first, so that
+	 * drm_of_find_possible_crtcs called from encoder .bind callbacks
+	 * works as expected.
+	 */
+	for (i = 0;; i++) {
+		port = of_parse_phandle(np, "ports", i);
+		if (!port)
+			break;
+
+		if (!of_device_is_available(port->parent)) {
+			of_node_put(port);
+			continue;
+		}
 
-	return ret;
+		component_match_add(dev, &match, compare_of, port->parent);
+		of_node_put(port);
+	}
+
+	if (i == 0) {
+		dev_err(dev, "missing 'ports' property\n");
+		return -ENODEV;
+	}
+
+	if (!match) {
+		dev_err(dev, "No available vop found for display-subsystem.\n");
+		return -ENODEV;
+	}
+	/*
+	 * For each bound crtc, bind the encoders attached to its
+	 * remote endpoint.
+	 */
+	for (i = 0;; i++) {
+		port = of_parse_phandle(np, "ports", i);
+		if (!port)
+			break;
+
+		if (!of_device_is_available(port->parent)) {
+			of_node_put(port);
+			continue;
+		}
+
+		rockchip_add_endpoints(dev, &match, port);
+		of_node_put(port);
+	}
+
+	return component_master_add_with_match(dev, &rockchip_drm_ops, match);
 }
 
 static int rockchip_drm_platform_remove(struct platform_device *pdev)
-- 
1.7.9.5
