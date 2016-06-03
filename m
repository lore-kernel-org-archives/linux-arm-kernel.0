From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 03 Jun 2016 15:21:25 +0100
Subject: [PATCH v2 2/3] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <20160603141548.GC1041@n2100.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
Message-ID: <E1b8pyX-0005OP-2s@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert DT component matching to use component_match_add_release().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/arm/hdlcd_drv.c             |  9 +++------
 drivers/gpu/drm/armada/armada_drv.c         |  8 ++------
 drivers/gpu/drm/drm_of.c                    |  6 ++++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 11 ++---------
 drivers/gpu/drm/msm/msm_drv.c               |  8 ++------
 drivers/gpu/drm/msm/msm_drv.h               |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 12 +++---------
 drivers/gpu/drm/sti/sti_drv.c               |  9 ++-------
 drivers/gpu/drm/tilcdc/tilcdc_external.c    |  8 ++------
 9 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index b987c63ba8d6..f00845c25795 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/list.h>
+#include <linux/of_component.h>
 #include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
@@ -443,11 +444,6 @@ static const struct component_master_ops hdlcd_master_ops = {
 	.unbind		= hdlcd_drm_unbind,
 };
 
-static int compare_dev(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int hdlcd_probe(struct platform_device *pdev)
 {
 	struct device_node *port, *ep;
@@ -474,7 +470,8 @@ static int hdlcd_probe(struct platform_device *pdev)
 		return -EAGAIN;
 	}
 
-	component_match_add(&pdev->dev, &match, compare_dev, port);
+	component_match_add_of(&pdev->dev, &match, port);
+	of_node_put(port);
 
 	return component_master_add_with_match(&pdev->dev, &hdlcd_master_ops,
 					       match);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 439824a61aa5..f2716d20c257 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/of_component.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_of.h>
@@ -227,11 +228,6 @@ static void armada_drm_unbind(struct device *dev)
 	drm_put_dev(dev_get_drvdata(dev));
 }
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int compare_dev_name(struct device *dev, void *data)
 {
 	const char *name = data;
@@ -255,7 +251,7 @@ static void armada_add_endpoints(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, match, compare_of, remote);
+		component_match_add_of(dev, match, remote);
 		of_node_put(remote);
 	}
 }
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index bc98bb94264d..d13fc633aeea 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -1,6 +1,7 @@
 #include <linux/component.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <linux/of_component.h>
 #include <linux/of_graph.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
@@ -101,7 +102,7 @@ int drm_of_component_probe(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, &match, compare_of, port);
+		component_match_add_of(dev, &match, compare_of, port);
 		of_node_put(port);
 	}
 
@@ -140,7 +141,8 @@ int drm_of_component_probe(struct device *dev,
 				continue;
 			}
 
-			component_match_add(dev, &match, compare_of, remote);
+			component_match_add_of_compare(dev, &match, compare_of,
+						       remote);
 			of_node_put(remote);
 		}
 		of_node_put(port);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 3d4f56df8359..a0e0764a6269 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/component.h>
+#include <linux/of_component.h>
 #include <linux/of_platform.h>
 
 #include "etnaviv_drv.h"
@@ -606,13 +607,6 @@ static const struct component_master_ops etnaviv_master_ops = {
 	.unbind = etnaviv_unbind,
 };
 
-static int compare_of(struct device *dev, void *data)
-{
-	struct device_node *np = data;
-
-	return dev->of_node == np;
-}
-
 static int compare_str(struct device *dev, void *data)
 {
 	return !strcmp(dev_name(dev), data);
@@ -635,8 +629,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!core_node)
 				break;
 
-			component_match_add(&pdev->dev, &match, compare_of,
-					    core_node);
+			component_match_add_of(&pdev->dev, &match, core_node);
 			of_node_put(core_node);
 		}
 	} else if (dev->platform_data) {
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9c654092ef78..5293aa775c5a 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -800,11 +800,6 @@ static const struct dev_pm_ops msm_pm_ops = {
  * NOTE: duplication of the same code as exynos or imx (or probably any other).
  * so probably some room for some helpers
  */
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int add_components(struct device *dev, struct component_match **matchptr,
 		const char *name)
 {
@@ -818,7 +813,8 @@ static int add_components(struct device *dev, struct component_match **matchptr,
 		if (!node)
 			break;
 
-		component_match_add(dev, matchptr, compare_of, node);
+		component_match_add_of(dev, matchptr, node);
+		of_node_put(node);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 5b2963f32291..66dafecaf115 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
+#include <linux/of_component.h>
 #include <linux/of_graph.h>
 #include <linux/of_device.h>
 #include <asm/sizes.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index a409d1f703cb..84c50f6770c3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -22,6 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
+#include <linux/of_component.h>
 #include <linux/of_graph.h>
 #include <linux/component.h>
 
@@ -414,13 +415,6 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
 				rockchip_drm_sys_resume)
 };
 
-static int compare_of(struct device *dev, void *data)
-{
-	struct device_node *np = data;
-
-	return dev->of_node == np;
-}
-
 static void rockchip_add_endpoints(struct device *dev,
 				   struct component_match **match,
 				   struct device_node *port)
@@ -439,7 +433,7 @@ static void rockchip_add_endpoints(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, match, compare_of, remote);
+		component_match_add_of(dev, match, remote);
 		of_node_put(remote);
 	}
 }
@@ -518,7 +512,7 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 			is_support_iommu = false;
 		}
 
-		component_match_add(dev, &match, compare_of, port->parent);
+		component_match_add_of(dev, &match, port->parent);
 		of_node_put(port);
 	}
 
diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 872495e72294..aeb2787c9bd4 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_component.h>
 #include <linux/of_platform.h>
 
 #include <drm/drm_atomic.h>
@@ -341,11 +342,6 @@ static struct drm_driver sti_driver = {
 	.minor = DRIVER_MINOR,
 };
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int sti_bind(struct device *dev)
 {
 	return drm_platform_init(&sti_driver, to_platform_device(dev));
@@ -375,8 +371,7 @@ static int sti_platform_probe(struct platform_device *pdev)
 	child_np = of_get_next_available_child(node, NULL);
 
 	while (child_np) {
-		component_match_add(dev, &match, compare_of, child_np);
-		of_node_put(child_np);
+		component_match_add_of(dev, &match, child_np);
 		child_np = of_get_next_available_child(node, child_np);
 	}
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index 03acb4f99982..1b3fd9fa4bef 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/component.h>
+#include <linux/of_component.h>
 #include <linux/of_graph.h>
 
 #include "tilcdc_drv.h"
@@ -130,11 +131,6 @@ void tilcdc_remove_external_encoders(struct drm_device *dev)
 						 priv->connector_funcs[i]);
 }
 
-static int dev_match_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 int tilcdc_get_external_components(struct device *dev,
 				   struct component_match **match)
 {
@@ -152,7 +148,7 @@ int tilcdc_get_external_components(struct device *dev,
 
 		dev_dbg(dev, "Subdevice node '%s' found\n", node->name);
 		if (match)
-			component_match_add(dev, match, dev_match_of, node);
+			component_match_add_of(dev, match, node);
 		of_node_put(node);
 		count++;
 	}
-- 
2.1.0
