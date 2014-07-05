From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:43 +0100
Subject: [PATCH RFC 10/15] drm/armada: convert to componentized support
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMh-0000AL-4L@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Armada DRM driver to use the component helpers, which will
permit us to clean up the driver and move towards an implementation
which is compatible with a DT description of the hardware.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_drv.c | 155 ++++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 3995be3c686b..2b6fc6cf62f2 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -6,7 +6,9 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_graph.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include "armada_crtc.h"
@@ -52,6 +54,11 @@ static const struct armada_drm_slave_config tda19988_config = {
 };
 #endif
 
+static bool is_componentized(struct device *dev)
+{
+	return dev->of_node || dev->platform_data;
+}
+
 static void armada_drm_unref_work(struct work_struct *work)
 {
 	struct armada_private *priv =
@@ -166,26 +173,35 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 			goto err_kms;
 	}
 
+	if (is_componentized(dev->dev)) {
+		ret = component_bind_all(dev->dev, dev);
+		if (ret)
+			goto err_kms;
+	} else {
 #ifdef CONFIG_DRM_ARMADA_TDA1998X
-	ret = armada_drm_connector_slave_create(dev, &tda19988_config);
-	if (ret)
-		goto err_kms;
+		ret = armada_drm_connector_slave_create(dev, &tda19988_config);
+		if (ret)
+			goto err_kms;
 #endif
+	}
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret)
-		goto err_kms;
+		goto err_comp;
 
 	dev->vblank_disable_allowed = 1;
 
 	ret = armada_fbdev_init(dev);
 	if (ret)
-		goto err_kms;
+		goto err_comp;
 
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
 
+ err_comp:
+	if (is_componentized(dev->dev))
+		component_unbind_all(dev->dev, dev);
  err_kms:
 	drm_mode_config_cleanup(dev);
 	drm_mm_takedown(&priv->linear);
@@ -200,6 +216,10 @@ static int armada_drm_unload(struct drm_device *dev)
 
 	drm_kms_helper_poll_fini(dev);
 	armada_fbdev_fini(dev);
+
+	if (is_componentized(dev->dev))
+		component_unbind_all(dev->dev, dev);
+
 	drm_mode_config_cleanup(dev);
 	drm_mm_takedown(&priv->linear);
 	flush_work(&priv->fb_unref_work);
@@ -314,14 +334,135 @@ static struct drm_driver armada_drm_driver = {
 	.fops			= &armada_drm_fops,
 };
 
+static int armada_drm_bind(struct device *dev)
+{
+	return drm_platform_init(&armada_drm_driver, to_platform_device(dev));
+}
+
+static void armada_drm_unbind(struct device *dev)
+{
+	drm_put_dev(dev_get_drvdata(dev));
+}
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int compare_dev_name(struct device *dev, void *data)
+{
+	const char *name = data;
+	return !strcmp(dev_name(dev), name);
+}
+
+static void armada_add_endpoints(struct device *dev,
+	struct component_match **match, struct device_node *port)
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
+static int armada_drm_find_components(struct device *dev,
+	struct component_match **match)
+{
+	struct device_node *port;
+	int i;
+
+	if (dev->of_node) {
+		struct device_node *np = dev->of_node;
+
+		for (i = 0; ; i++) {
+			port = of_parse_phandle(np, "ports", i);
+			if (!port)
+				break;
+
+			component_match_add(dev, match, compare_of, port);
+			of_node_put(port);
+		}
+
+		if (i == 0) {
+			dev_err(dev, "missing 'ports' property\n");
+			return -ENODEV;
+		}
+
+		for (i = 0; ; i++) {
+			port = of_parse_phandle(np, "ports", i);
+			if (!port)
+				break;
+
+			armada_add_endpoints(dev, match, port);
+			of_node_put(port);
+		}
+	} else if (dev->platform_data) {
+		char **devices = dev->platform_data;
+		struct device *d;
+
+		for (i = 0; devices[i]; i++)
+			component_match_add(dev, match, compare_dev_name,
+					    devices[i]);
+
+		if (i == 0) {
+			dev_err(dev, "missing 'ports' property\n");
+			return -ENODEV;
+		}
+
+		for (i = 0; devices[i]; i++) {
+			d = bus_find_device_by_name(&platform_bus_type, NULL,
+					devices[i]);
+			if (d && d->of_node) {
+				for_each_child_of_node(d->of_node, port)
+					armada_add_endpoints(dev, match, port);
+			}
+			put_device(d);
+		}
+	}
+
+	return 0;
+}
+
+static const struct component_master_ops armada_master_ops = {
+	.bind = armada_drm_bind,
+	.unbind = armada_drm_unbind,
+};
+
 static int armada_drm_probe(struct platform_device *pdev)
 {
-	return drm_platform_init(&armada_drm_driver, pdev);
+	if (is_componentized(&pdev->dev)) {
+		struct component_match *match = NULL;
+		int ret;
+
+		ret = armada_drm_find_components(&pdev->dev, &match);
+		if (ret < 0)
+			return ret;
+
+		return component_master_add_with_match(&pdev->dev,
+				&armada_master_ops, match);
+	} else {
+		return drm_platform_init(&armada_drm_driver, pdev);
+	}
 }
 
 static int armada_drm_remove(struct platform_device *pdev)
 {
-	drm_put_dev(platform_get_drvdata(pdev));
+	if (is_componentized(&pdev->dev))
+		component_master_del(&pdev->dev, &armada_master_ops);
+	else
+		drm_put_dev(platform_get_drvdata(pdev));
 	return 0;
 }
 
-- 
1.8.3.1
