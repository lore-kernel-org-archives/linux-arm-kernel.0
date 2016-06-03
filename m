From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 03 Jun 2016 08:58:10 +0100
Subject: [PATCH] drm: convert DT component matching to
 component_match_add_release()
Message-ID: <E1b8jze-00046l-K5@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert DT component matching to use component_match_add_release().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/arm/hdlcd_drv.c             | 10 ++++++++--
 drivers/gpu/drm/armada/armada_drv.c         |  9 +++++++--
 drivers/gpu/drm/drm_of.c                    | 13 +++++++++----
 drivers/gpu/drm/msm/msm_drv.c               |  8 +++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 13 ++++++++++---
 drivers/gpu/drm/sti/sti_drv.c               |  9 +++++++--
 drivers/gpu/drm/tilcdc/tilcdc_external.c    |  9 +++++++--
 7 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index b987c63ba8d6..bbde48c4f550 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -443,11 +443,16 @@ static const struct component_master_ops hdlcd_master_ops = {
 	.unbind		= hdlcd_drm_unbind,
 };
 
-static int compare_dev(struct device *dev, void *data)
+static int compare_of(struct device *dev, void *data)
 {
 	return dev->of_node == data;
 }
 
+static void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static int hdlcd_probe(struct platform_device *pdev)
 {
 	struct device_node *port, *ep;
@@ -474,7 +479,8 @@ static int hdlcd_probe(struct platform_device *pdev)
 		return -EAGAIN;
 	}
 
-	component_match_add(&pdev->dev, &match, compare_dev, port);
+	component_match_add_release(&pdev->dev, &match, release_of,
+				    compare_of, port);
 
 	return component_master_add_with_match(&pdev->dev, &hdlcd_master_ops,
 					       match);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 439824a61aa5..6ca2aa36515e 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -232,6 +232,11 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static int compare_dev_name(struct device *dev, void *data)
 {
 	const char *name = data;
@@ -255,8 +260,8 @@ static void armada_add_endpoints(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, match, compare_of, remote);
-		of_node_put(remote);
+		component_match_add_release(dev, match, release_of,
+					    compare_of, remote);
 	}
 }
 
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index bc98bb94264d..5d183479d7d6 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -6,6 +6,11 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_of.h>
 
+static void drm_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 /**
  * drm_crtc_port_mask - find the mask of a registered CRTC by port OF node
  * @dev: DRM device
@@ -101,8 +106,8 @@ int drm_of_component_probe(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, &match, compare_of, port);
-		of_node_put(port);
+		component_match_add_release(dev, &match, drm_release_of,
+					    compare_of, port);
 	}
 
 	if (i == 0) {
@@ -140,8 +145,8 @@ int drm_of_component_probe(struct device *dev,
 				continue;
 			}
 
-			component_match_add(dev, &match, compare_of, remote);
-			of_node_put(remote);
+			component_match_add_release(dev, &match, drm_release_of,
+						    compare_of, remote);
 		}
 		of_node_put(port);
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9c654092ef78..1f7de47d817e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -805,6 +805,11 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static int add_components(struct device *dev, struct component_match **matchptr,
 		const char *name)
 {
@@ -818,7 +823,8 @@ static int add_components(struct device *dev, struct component_match **matchptr,
 		if (!node)
 			break;
 
-		component_match_add(dev, matchptr, compare_of, node);
+		component_match_add_release(dev, matchptr, release_of,
+					    compare_of, node);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index a409d1f703cb..f5a68fc031ed 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -421,6 +421,11 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == np;
 }
 
+static void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static void rockchip_add_endpoints(struct device *dev,
 				   struct component_match **match,
 				   struct device_node *port)
@@ -439,8 +444,8 @@ static void rockchip_add_endpoints(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, match, compare_of, remote);
-		of_node_put(remote);
+		component_match_add_release(dev, match, release_of,
+					    compare_of, remote);
 	}
 }
 
@@ -518,7 +523,9 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 			is_support_iommu = false;
 		}
 
-		component_match_add(dev, &match, compare_of, port->parent);
+		of_node_get(port->parent);
+		component_match_add_release(dev, &match, release_of,
+					    compare_of, port->parent);
 		of_node_put(port);
 	}
 
diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 872495e72294..4ee6fa4f1beb 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -346,6 +346,11 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static int sti_bind(struct device *dev)
 {
 	return drm_platform_init(&sti_driver, to_platform_device(dev));
@@ -375,8 +380,8 @@ static int sti_platform_probe(struct platform_device *pdev)
 	child_np = of_get_next_available_child(node, NULL);
 
 	while (child_np) {
-		component_match_add(dev, &match, compare_of, child_np);
-		of_node_put(child_np);
+		component_match_add_release(dev, &match, release_of,
+					    compare_of, child_np);
 		child_np = of_get_next_available_child(node, child_np);
 	}
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index 03acb4f99982..7e11b5ecdd4a 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -135,6 +135,11 @@ static int dev_match_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static void dev_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 int tilcdc_get_external_components(struct device *dev,
 				   struct component_match **match)
 {
@@ -152,8 +157,8 @@ int tilcdc_get_external_components(struct device *dev,
 
 		dev_dbg(dev, "Subdevice node '%s' found\n", node->name);
 		if (match)
-			component_match_add(dev, match, dev_match_of, node);
-		of_node_put(node);
+			component_match_add_release(dev, match, dev_release_of,
+						    dev_match_of, node);
 		count++;
 	}
 
-- 
2.1.0
