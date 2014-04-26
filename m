From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 27 Apr 2014 00:02:03 +0100
Subject: [PATCH RFC 4/8] drm: msm: update to use component match support
In-Reply-To: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeBbf-0002Gi-DT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update MSM's DRM driver to use the component match support rather than
add_components.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/msm/msm_drv.c | 81 ++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f9de156b9e65..26be58bd611d 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -865,12 +865,41 @@ static int compare_of(struct device *dev, void *data)
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
+	struct component_match *match = NULL;
+#ifdef CONFIG_OF
+	/* NOTE: the CONFIG_OF case duplicates the same code as exynos or imx
+	 * (or probably any other).. so probably some room for some helpers
+	 */
 	struct device_node *np = master->of_node;
 	unsigned i;
-	int ret;
 
 	for (i = 0; ; i++) {
 		struct device_node *node;
@@ -879,22 +908,9 @@ static int msm_drm_add_components(struct device *master, struct master *m)
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
@@ -918,41 +934,12 @@ static int msm_drm_add_components(struct device *master, struct master *m)
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
