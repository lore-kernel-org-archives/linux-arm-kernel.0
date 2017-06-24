From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 23 Jun 2017 18:56:28 -0600
Subject: [PATCH] drm: exynos: dsi: release DSI_PORT_OUT node right after
 of_drm_find_bridge()
Message-ID: <20170624005628.5896-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix to call of_node_put() right after of_drm_find_bridge() instead of
holding on to it until exynos_dsi_remove().

Suggested-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index e337cd2..7513b88 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1689,6 +1689,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 
 	if (dsi->bridge_node) {
 		bridge = of_drm_find_bridge(dsi->bridge_node);
+		of_node_put(dsi->bridge_node);
 		if (bridge)
 			drm_bridge_attach(encoder, bridge, NULL);
 	}
@@ -1807,10 +1808,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 
 static int exynos_dsi_remove(struct platform_device *pdev)
 {
-	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
-
-	of_node_put(dsi->bridge_node);
-
 	pm_runtime_disable(&pdev->dev);
 
 	component_del(&pdev->dev, &exynos_dsi_component_ops);
-- 
2.7.4
