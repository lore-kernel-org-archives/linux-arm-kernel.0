From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 15 Oct 2015 17:11:10 +0100
Subject: [RFC PATCH 4/4] drm/armada: Convert the probe function to the generic
 drm_of_component_probe()
In-Reply-To: <1444925470-9963-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444925470-9963-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1444925470-9963-5-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada DRM driver keeps some old platform data compatibility in the
probe function that makes moving to the generic drm_of_component_probe()
a bit more complicated that it should. Refactor the probe function to do
the platform_data processing after the generic probe (and if that fails).
This way future cleanup can further remove support for it.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/gpu/drm/armada/armada_drv.c | 83 +++++++++++++------------------------
 1 file changed, 28 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 225034b..990080d 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -11,6 +11,7 @@
 #include <linux/of_graph.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
 #include "armada_crtc.h"
 #include "armada_drm.h"
 #include "armada_gem.h"
@@ -370,47 +371,36 @@ static void armada_add_endpoints(struct device *dev,
 	}
 }
 
-static int armada_drm_find_components(struct device *dev,
-	struct component_match **match)
-{
-	struct device_node *port;
-	int i;
-
-	if (dev->of_node) {
-		struct device_node *np = dev->of_node;
-
-		for (i = 0; ; i++) {
-			port = of_parse_phandle(np, "ports", i);
-			if (!port)
-				break;
+static const struct component_master_ops armada_master_ops = {
+	.bind = armada_drm_bind,
+	.unbind = armada_drm_unbind,
+};
 
-			component_match_add(dev, match, compare_of, port);
-			of_node_put(port);
-		}
+static int armada_drm_probe(struct platform_device *pdev)
+{
+	int ret;
 
-		if (i == 0) {
-			dev_err(dev, "missing 'ports' property\n");
-			return -ENODEV;
-		}
+	if (!is_componentized(&pdev->dev))
+		return drm_platform_init(&armada_drm_driver, pdev);
 
-		for (i = 0; ; i++) {
-			port = of_parse_phandle(np, "ports", i);
-			if (!port)
-				break;
+	ret = drm_of_component_probe(&pdev->dev, compare_dev_name,
+				     &armada_master_ops);
+	if (ret != -EINVAL)
+		return ret;
 
-			armada_add_endpoints(dev, match, port);
-			of_node_put(port);
-		}
-	} else if (dev->platform_data) {
-		char **devices = dev->platform_data;
+	if (pdev->dev.platform_data) {
+		struct component_match *match = NULL;
+		char **devices = pdev->dev.platform_data;
+		struct device_node *port;
 		struct device *d;
+		int i;
 
 		for (i = 0; devices[i]; i++)
-			component_match_add(dev, match, compare_dev_name,
+			component_match_add(&pdev->dev, &match, compare_dev_name,
 					    devices[i]);
 
 		if (i == 0) {
-			dev_err(dev, "missing 'ports' property\n");
+			dev_err(&pdev->dev, "missing 'ports' property\n");
 			return -ENODEV;
 		}
 
@@ -419,35 +409,18 @@ static int armada_drm_find_components(struct device *dev,
 					devices[i]);
 			if (d && d->of_node) {
 				for_each_child_of_node(d->of_node, port)
-					armada_add_endpoints(dev, match, port);
+					armada_add_endpoints(&pdev->dev,
+							     &match, port);
 			}
 			put_device(d);
 		}
-	}
-
-	return 0;
-}
-
-static const struct component_master_ops armada_master_ops = {
-	.bind = armada_drm_bind,
-	.unbind = armada_drm_unbind,
-};
 
-static int armada_drm_probe(struct platform_device *pdev)
-{
-	if (is_componentized(&pdev->dev)) {
-		struct component_match *match = NULL;
-		int ret;
-
-		ret = armada_drm_find_components(&pdev->dev, &match);
-		if (ret < 0)
-			return ret;
-
-		return component_master_add_with_match(&pdev->dev,
-				&armada_master_ops, match);
-	} else {
-		return drm_platform_init(&armada_drm_driver, pdev);
+		ret = component_master_add_with_match(&pdev->dev,
+						      &armada_master_ops,
+						      match);
 	}
+
+	return ret;
 }
 
 static int armada_drm_remove(struct platform_device *pdev)
-- 
2.6.0
