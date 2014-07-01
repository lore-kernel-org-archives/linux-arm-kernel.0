From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 01 Jul 2014 15:46:49 +0100
Subject: [PATCH v3 4/8] drm: msm: update to use component match support
In-Reply-To: <20140701144011.GU32514@n2100.arm.linux.org.uk>
Message-ID: <E1X1zKb-0000cS-9d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update MSM's DRM driver to use the component match support rather than
add_components.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This patch is destined for Greg's driver and David's DRM trees.

 drivers/gpu/drm/msm/msm_drv.c | 83 ++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9a5d87db5c23..a322029983ce 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -905,12 +905,41 @@ static int compare_of(struct device *dev, void *data)
 {
 	return dev->of_node == data;
 }
+#else
+static int compare_dev(struct device *dev, void *data)
+{
+	return dev == data;
+}
+#endif
+
+static int msm_drm_bind(struct device *dev)
+{
+	return drm_platform_init(&msm_driver, to_platform_device(dev));
+}
+
+static void msm_drm_unbind(struct device *dev)
+{
+	drm_put_dev(platform_get_drvdata(to_platform_device(dev)));
+}
+
+static const struct component_master_ops msm_drm_ops = {
+	.bind = msm_drm_bind,
+	.unbind = msm_drm_unbind,
+};
+
+/*
+ * Platform driver:
+ */
 
-static int msm_drm_add_components(struct device *master, struct master *m)
+static int msm_pdev_probe(struct platform_device *pdev)
 {
-	struct device_node *np = master->of_node;
+	struct component_match *match = NULL;
+#ifdef CONFIG_OF
+	/* NOTE: the CONFIG_OF case duplicates the same code as exynos or imx
+	 * (or probably any other).. so probably some room for some helpers
+	 */
+	struct device_node *np = pdev->dev.of_node;
 	unsigned i;
-	int ret;
 
 	for (i = 0; ; i++) {
 		struct device_node *node;
@@ -919,22 +948,9 @@ static int msm_drm_add_components(struct device *master, struct master *m)
 		if (!node)
 			break;
 
-		ret = component_master_add_child(m, compare_of, node);
-		of_node_put(node);
-
-		if (ret)
-			return ret;
+		component_match_add(&pdev->dev, &match, compare_of, node);
 	}
-	return 0;
-}
 #else
-static int compare_dev(struct device *dev, void *data)
-{
-	return dev == data;
-}
-
-static int msm_drm_add_components(struct device *master, struct master *m)
-{
 	/* For non-DT case, it kinda sucks.  We don't actually have a way
 	 * to know whether or not we are waiting for certain devices (or if
 	 * they are simply not present).  But for non-DT we only need to
@@ -958,41 +974,12 @@ static int msm_drm_add_components(struct device *master, struct master *m)
 			return -EPROBE_DEFER;
 		}
 
-		ret = component_master_add_child(m, compare_dev, dev);
-		if (ret) {
-			DBG("could not add child: %d", ret);
-			return ret;
-		}
+		component_match_add(&pdev->dev, &match, compare_dev, dev);
 	}
-
-	return 0;
-}
 #endif
 
-static int msm_drm_bind(struct device *dev)
-{
-	return drm_platform_init(&msm_driver, to_platform_device(dev));
-}
-
-static void msm_drm_unbind(struct device *dev)
-{
-	drm_put_dev(platform_get_drvdata(to_platform_device(dev)));
-}
-
-static const struct component_master_ops msm_drm_ops = {
-		.add_components = msm_drm_add_components,
-		.bind = msm_drm_bind,
-		.unbind = msm_drm_unbind,
-};
-
-/*
- * Platform driver:
- */
-
-static int msm_pdev_probe(struct platform_device *pdev)
-{
 	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	return component_master_add(&pdev->dev, &msm_drm_ops);
+	return component_master_add_with_match(&pdev->dev, &msm_drm_ops, match);
 }
 
 static int msm_pdev_remove(struct platform_device *pdev)
-- 
1.8.3.1
