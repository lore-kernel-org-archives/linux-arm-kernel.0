From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 20 Oct 2015 10:23:15 +0100
Subject: [PATCH v4 4/4] drm/armada: Convert the probe function to the generic
 drm_of_component_probe()
In-Reply-To: <1445332995-11212-1-git-send-email-Liviu.Dudau@arm.com>
References: <1445332995-11212-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1445332995-11212-5-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada DRM driver keeps some old platform data compatibility in the
probe function that makes moving to the generic drm_of_component_probe()
a bit more complicated that it should. Refactor the probe function to do
the platform_data processing after the generic probe (and only if that
fails). This way future cleanup can further remove support for it.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_drv.c | 68 +++++++++++--------------------------
 1 file changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 63d909e..3a7ba69 100644
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
@@ -265,43 +266,29 @@ static void armada_add_endpoints(struct device *dev,
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
-
-			component_match_add(dev, match, compare_of, port);
-			of_node_put(port);
-		}
+static const struct component_master_ops armada_master_ops = {
+	.bind = armada_drm_bind,
+	.unbind = armada_drm_unbind,
+};
 
-		if (i == 0) {
-			dev_err(dev, "missing 'ports' property\n");
-			return -ENODEV;
-		}
+static int armada_drm_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	struct device *dev = &pdev->dev;
+	int ret;
 
-		for (i = 0; ; i++) {
-			port = of_parse_phandle(np, "ports", i);
-			if (!port)
-				break;
+	ret = drm_of_component_probe(dev, compare_dev_name, &armada_master_ops);
+	if (ret != -EINVAL)
+		return ret;
 
-			armada_add_endpoints(dev, match, port);
-			of_node_put(port);
-		}
-	} else if (dev->platform_data) {
+	if (dev->platform_data) {
 		char **devices = dev->platform_data;
+		struct device_node *port;
 		struct device *d;
+		int i;
 
 		for (i = 0; devices[i]; i++)
-			component_match_add(dev, match, compare_dev_name,
+			component_match_add(dev, &match, compare_dev_name,
 					    devices[i]);
 
 		if (i == 0) {
@@ -311,32 +298,15 @@ static int armada_drm_find_components(struct device *dev,
 
 		for (i = 0; devices[i]; i++) {
 			d = bus_find_device_by_name(&platform_bus_type, NULL,
-					devices[i]);
+						    devices[i]);
 			if (d && d->of_node) {
 				for_each_child_of_node(d->of_node, port)
-					armada_add_endpoints(dev, match, port);
+					armada_add_endpoints(dev, &match, port);
 			}
 			put_device(d);
 		}
 	}
 
-	return 0;
-}
-
-static const struct component_master_ops armada_master_ops = {
-	.bind = armada_drm_bind,
-	.unbind = armada_drm_unbind,
-};
-
-static int armada_drm_probe(struct platform_device *pdev)
-{
-	struct component_match *match = NULL;
-	int ret;
-
-	ret = armada_drm_find_components(&pdev->dev, &match);
-	if (ret < 0)
-		return ret;
-
 	return component_master_add_with_match(&pdev->dev, &armada_master_ops,
 					       match);
 }
-- 
2.6.0
