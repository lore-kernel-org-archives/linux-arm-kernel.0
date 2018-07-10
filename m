From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 10 Jul 2018 22:35:03 +0200
Subject: [PATCH v2 10/18] drm/sun4i: mixer: Read id from DT
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
Message-ID: <20180710203511.18454-11-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, TCON supports 2 ways to match TCON with engine (mixer in this
case). Old way is to just traverse of graph backwards and compare node
pointer. New way is to match TCON and engine by their respective ids.
All SoCs with DE2 enabled till now used the old way, which means mixer
id was never used and thus never implemented.

However, for R40, only the new way will be used. To prepare for that,
implement mixer id fetching from DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 40 +++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index aa81b9838ae8..4bd4d8ccb34f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -22,6 +22,7 @@
 #include <linux/component.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <linux/reset.h>
 
 #include "sun4i_drv.h"
@@ -322,6 +323,42 @@ static struct regmap_config sun8i_mixer_regmap_config = {
 	.max_register	= 0xbfffc, /* guessed */
 };
 
+static int sun8i_mixer_of_get_id(struct device_node *node)
+{
+	struct device_node *port, *ep;
+	int ret = -EINVAL;
+
+	/* output is port 1 */
+	port = of_graph_get_port_by_id(node, 1);
+	if (!port)
+		return -EINVAL;
+
+	/* try to find downstream endpoint */
+	for_each_available_child_of_node(port, ep) {
+		struct device_node *remote;
+		u32 reg;
+
+		remote = of_graph_get_remote_endpoint(ep);
+		if (!remote)
+			continue;
+
+		ret = of_property_read_u32(remote, "reg", &reg);
+		if (!ret) {
+			of_node_put(remote);
+			of_node_put(ep);
+			of_node_put(port);
+
+			return reg;
+		}
+
+		of_node_put(remote);
+	}
+
+	of_node_put(port);
+
+	return ret;
+}
+
 static int sun8i_mixer_bind(struct device *dev, struct device *master,
 			      void *data)
 {
@@ -353,8 +390,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, mixer);
 	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
-	/* The ID of the mixer currently doesn't matter */
-	mixer->engine.id = -1;
+	mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
 
 	mixer->cfg = of_device_get_match_data(dev);
 	if (!mixer->cfg)
-- 
2.18.0
