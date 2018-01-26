From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Jan 2018 14:20:33 +0100
Subject: [PATCH 4/4] drm/pl111: Support multiple endpoints on the CLCD
In-Reply-To: <20180126132033.19744-1-linus.walleij@linaro.org>
References: <20180126132033.19744-1-linus.walleij@linaro.org>
Message-ID: <20180126132033.19744-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile PL110 implementations use multiple endpoints:
from the PL111 port, the lines are routed through a PLD,
and from there forked so the same lines go to a VGA DAC and
an external TFT panel connector. This is discrete wireing
so there is no way to turn of one output, i.e. this is
really two endpoints, not two ports.

We model this with multiple endpoints, so we need to loop
over the available endpoints, check for panel or bridge on
each and accumulate the result before continuing.

The code already will give the panel preference over the
bridge, if present, so the output will be sent to the panel
if both a panel and a bridge is present on two endpoints
of the same port.

If they all return -EPROBE_DEFER we return -EPROBE_DEFER
as well.

If just one endpoint is present on the port, the behaviour
is the same as before.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 62 +++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index f1f1b87b0e44..7e9f5efe3274 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -58,6 +58,8 @@
 #include <linux/dma-buf.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
@@ -84,9 +86,13 @@ static int pl111_modeset_init(struct drm_device *dev)
 {
 	struct drm_mode_config *mode_config;
 	struct pl111_drm_dev_private *priv = dev->dev_private;
-	struct drm_panel *panel;
-	struct drm_bridge *bridge;
+	struct device_node *np = dev->dev->of_node;
+	struct device_node *remote;
+	struct drm_panel *panel = NULL;
+	struct drm_bridge *bridge = NULL;
+	bool defer = false;
 	int ret = 0;
+	int i;
 
 	drm_mode_config_init(dev);
 	mode_config = &dev->mode_config;
@@ -96,10 +102,54 @@ static int pl111_modeset_init(struct drm_device *dev)
 	mode_config->min_height = 1;
 	mode_config->max_height = 768;
 
-	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
-					  0, 0, &panel, &bridge);
-	if (ret && ret != -ENODEV)
-		return ret;
+	i = 0;
+	for_each_endpoint_of_node(np, remote) {
+		struct drm_panel *tmp_panel;
+		struct drm_bridge *tmp_bridge;
+
+		dev_dbg(dev->dev, "checking endpoint %d\n", i);
+
+		ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
+						  0, i,
+						  &tmp_panel,
+						  &tmp_bridge);
+		if (ret) {
+			if (ret == -EPROBE_DEFER) {
+				/*
+				 * Something deferred, but that is often just
+				 * another way of saying -ENODEV, but let's
+				 * cast a vote for later deferral.
+				 */
+				defer = true;
+			} else if (ret != -ENODEV) {
+				/* Continue, maybe something else is working */
+				dev_err(dev->dev,
+					"endpoint %d returns %d\n", i, ret);
+			}
+		}
+
+		if (tmp_panel) {
+			dev_info(dev->dev,
+				 "found panel on endpoint %d\n", i);
+			panel = tmp_panel;
+		}
+		if (tmp_bridge) {
+			dev_info(dev->dev,
+				 "found bridge on endpoint %d\n", i);
+			bridge = tmp_bridge;
+		}
+
+		i++;
+	}
+
+	/*
+	 * If we can't find neither panel nor bridge on any of the
+	 * endpoints, and any of them retured -EPROBE_DEFER, then
+	 * let's defer this driver too.
+	 */
+	if ((!panel && !bridge) && defer)
+		return -EPROBE_DEFER;
+
 	if (panel) {
 		bridge = drm_panel_bridge_add(panel,
 					      DRM_MODE_CONNECTOR_Unknown);
-- 
2.14.3
