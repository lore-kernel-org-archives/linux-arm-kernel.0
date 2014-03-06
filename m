From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu,  6 Mar 2014 14:54:40 +0100
Subject: [PATCH 2/2] imx-drm: imx-ldb: Use OF graph to find connected panel
In-Reply-To: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
References: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394114080-27223-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch depends on the OF graph parsing helper and imx-drm-dt series.
It allows to connect the panel to the output port (port at 1 on i.MX53, port at 4
on i.MX6) via the OF graph bindings.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-ldb.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 38a0795..4d1446a 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -27,8 +27,8 @@
 #include <drm/drm_panel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <video/of_videomode.h>
 #include <linux/regmap.h>
 #include <linux/videodev2.h>
@@ -506,7 +506,7 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 
 	for_each_child_of_node(np, child) {
 		struct imx_ldb_channel *channel;
-		struct device_node *panel_node;
+		struct device_node *port;
 
 		ret = of_property_read_u32(child, "reg", &i);
 		if (ret || i < 0 || i > 1)
@@ -566,9 +566,18 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 			return -EINVAL;
 		}
 
-		panel_node = of_parse_phandle(child, "fsl,panel", 0);
-		if (panel_node)
-			channel->panel = of_drm_find_panel(panel_node);
+		/* The output port is port at 4 with mux or port at 1 without mux */
+		port = of_graph_get_port_by_id(child, imx_ldb->lvds_mux ? 4 : 1);
+		if (port) {
+			struct device_node *endpoint, *remote;
+
+			endpoint = of_get_child_by_name(port, "endpoint");
+			if (endpoint) {
+				remote = of_graph_get_remote_port_parent(endpoint);
+				if (remote)
+					channel->panel = of_drm_find_panel(remote);
+			}
+		}
 
 		ret = imx_ldb_register(drm, channel);
 		if (ret)
-- 
1.9.0
