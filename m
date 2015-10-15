From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 15 Oct 2015 17:11:09 +0100
Subject: [RFC PATCH 3/4] drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1444925470-9963-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444925470-9963-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1444925470-9963-4-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic drm_of_component_probe() function to probe for components.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 84 ++---------------------------
 1 file changed, 5 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 9a0c291..8cd6397 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -47,10 +47,6 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 	struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
 	int ret;
 
-	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
 	return arm_iommu_attach_device(dev, mapping);
@@ -416,29 +412,6 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == np;
 }
 
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
@@ -481,61 +454,14 @@ static const struct component_master_ops rockchip_drm_ops = {
 
 static int rockchip_drm_platform_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct component_match *match = NULL;
-	struct device_node *np = dev->of_node;
-	struct device_node *port;
-	int i;
-
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
+	int ret = drm_of_component_probe(&pdev->dev, compare_of,
+					 &rockchip_drm_ops);
 
-		component_match_add(dev, &match, compare_of, port->parent);
-		of_node_put(port);
-	}
-
-	if (i == 0) {
-		dev_err(dev, "missing 'ports' property\n");
+	/* keep compatibility with old code that was returning -ENODEV */
+	if (ret == -EINVAL)
 		return -ENODEV;
-	}
-
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
 
-		rockchip_add_endpoints(dev, &match, port);
-		of_node_put(port);
-	}
-
-	return component_master_add_with_match(dev, &rockchip_drm_ops, match);
+	return ret;
 }
 
 static int rockchip_drm_platform_remove(struct platform_device *pdev)
-- 
2.6.0
