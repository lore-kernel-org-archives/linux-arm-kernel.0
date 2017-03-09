From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Mar 2017 18:05:30 +0800
Subject: [PATCH 07/11] drm/sun4i: Fetch backend ID from device tree
In-Reply-To: <20170309100534.14023-1-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
Message-ID: <20170309100534.14023-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Allwinner SoCs have 2 display pipelines, as in 2 of each
components, including the frontend, backend, TCON, and any other
extras.

As the backend and TCON are always paired together and form the CRTC,
we need to know which backend or TCON we are currently probing, so we
can pair them when initializing the CRTC.

This patch figures out the backend's ID from the device tree and stores
it in the backend's data structure. It does this by looking at the "reg"
property of any remote endpoints connected to the backend's input port.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 44 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index d660741ba475..f3c92d54c8e4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -19,6 +19,7 @@
 #include <drm/drm_plane_helper.h>
 
 #include <linux/component.h>
+#include <linux/of_graph.h>
 #include <linux/reset.h>
 
 #include "sun4i_backend.h"
@@ -288,6 +289,45 @@ static int sun4i_backend_free_sat(struct device *dev) {
 	return 0;
 }
 
+/*
+ * The display backend can take video output from the display frontend, or
+ * the display enhancement unit on the A80, as input for one it its layers.
+ * This relationship within the display pipeline is encoded in the device
+ * tree with of_graph, and we use it here to figure out which backend, if
+ * there are 2 or more, we are currently probing. The number would be in
+ * the "reg" property of the upstream output port endpoint.
+ */
+static int sun4i_backend_of_get_id(struct device_node *node)
+{
+	struct device_node *port, *ep;
+	int ret = -EINVAL;
+
+	/* input is port 0 */
+	port = of_graph_get_port_by_id(node, 0);
+	if (!port)
+		return -EINVAL;
+
+	/* try finding an upstream endpoint */
+	for_each_available_child_of_node(port, ep) {
+		struct device_node *remote;
+		u32 reg;
+
+		remote = of_parse_phandle(ep, "remote-endpoint", 0);
+		if (!remote)
+			continue;
+
+		ret = of_property_read_u32(remote, "reg", &reg);
+		if (ret)
+			continue;
+
+		ret = reg;
+	}
+
+	of_node_put(port);
+
+	return ret;
+}
+
 static struct regmap_config sun4i_backend_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -312,6 +352,10 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, backend);
 	drv->backend = backend;
 
+	backend->id = sun4i_backend_of_get_id(dev->of_node);
+	if (backend->id < 0)
+		return backend->id;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 83e63cc702b4..d9a7df55c63f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -149,6 +149,8 @@ struct sun4i_backend {
 
 	struct clk		*sat_clk;
 	struct reset_control	*sat_reset;
+
+	int			id;
 };
 
 void sun4i_backend_apply_color_correction(struct sun4i_backend *backend);
-- 
2.11.0
