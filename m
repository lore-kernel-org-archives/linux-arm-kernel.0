From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 29 Jan 2016 12:09:31 -0300
Subject: [PATCH] drm/exynos: dp: Fix panel and bridge lookup logic
Message-ID: <1454080171-23769-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a9fa852886fd ("drm/exynos: dp: add of_graph dt binding support
for panel") made the Exynos DP DT binding more consistent since the OF
graph could be used to lookup either a panel or a bridge device node.

Before that commit, a panel would be looked up using a phandle and a
bridge using the OF graph which made the DT binding not consistent.

But the patch broke the later case since not finding a panel dev node
would cause the driver's to do a probe deferral instead of attempting
to lookup a bridge device node associated with the remote endpoint.

So instead of returning a -EPROBE_DEFER if a panel is not found, check
if there's a bridge and only do a probe deferral if both aren't found.

Fixes: a9fa852886fd ("drm/exynos: dp: add of_graph dt binding support for panel")
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/gpu/drm/exynos/exynos_dp_core.c | 55 +++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index b79c316c2ad2..673164b331c8 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -1392,7 +1392,7 @@ static const struct component_ops exynos_dp_ops = {
 static int exynos_dp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *panel_node = NULL, *bridge_node, *endpoint = NULL;
+	struct device_node *np = NULL, *endpoint = NULL;
 	struct exynos_dp_device *dp;
 	int ret;
 
@@ -1404,41 +1404,36 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dp);
 
 	/* This is for the backward compatibility. */
-	panel_node = of_parse_phandle(dev->of_node, "panel", 0);
-	if (panel_node) {
-		dp->panel = of_drm_find_panel(panel_node);
-		of_node_put(panel_node);
+	np = of_parse_phandle(dev->of_node, "panel", 0);
+	if (np) {
+		dp->panel = of_drm_find_panel(np);
+		of_node_put(np);
 		if (!dp->panel)
 			return -EPROBE_DEFER;
-	} else {
-		endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
-		if (endpoint) {
-			panel_node = of_graph_get_remote_port_parent(endpoint);
-			if (panel_node) {
-				dp->panel = of_drm_find_panel(panel_node);
-				of_node_put(panel_node);
-				if (!dp->panel)
-					return -EPROBE_DEFER;
-			} else {
-				DRM_ERROR("no port node for panel device.\n");
-				return -EINVAL;
-			}
-		}
-	}
-
-	if (endpoint)
 		goto out;
+	}
 
 	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
 	if (endpoint) {
-		bridge_node = of_graph_get_remote_port_parent(endpoint);
-		if (bridge_node) {
-			dp->ptn_bridge = of_drm_find_bridge(bridge_node);
-			of_node_put(bridge_node);
-			if (!dp->ptn_bridge)
-				return -EPROBE_DEFER;
-		} else
-			return -EPROBE_DEFER;
+		np = of_graph_get_remote_port_parent(endpoint);
+		if (np) {
+			/* The remote port can be either a panel or a bridge */
+			dp->panel = of_drm_find_panel(np);
+			if (!dp->panel) {
+				dp->ptn_bridge = of_drm_find_bridge(np);
+				if (!dp->ptn_bridge) {
+					of_node_put(np);
+					return -EPROBE_DEFER;
+				}
+			}
+			of_node_put(np);
+		} else {
+			DRM_ERROR("no remote endpoint device node found.\n");
+			return -EINVAL;
+		}
+	} else {
+		DRM_ERROR("no port endpoint subnode found.\n");
+		return -EINVAL;
 	}
 
 out:
-- 
2.5.0
