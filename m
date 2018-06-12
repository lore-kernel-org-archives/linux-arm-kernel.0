From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:21 +0200
Subject: [PATCH v2 12/27] drm/sun4i: tcon: Generalize engine search algorithm
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-13-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current "old" method to find engine worked pretty well for DE2. However,
it doesn't work when TCON TOP is between  mixer (engine) and TCON. TCON
TOP has multiple input ports, but current engine search algorithm
expects only one.

This can be fixed by first looking for output port id and selecting
matching input by subtracting 1 for the next round. This work even if
there is only one input and output.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0afb5a94a414..5dae623968f7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -802,12 +802,14 @@ static int sun4i_tcon_init_regmap(struct device *dev,
  */
 static struct sunxi_engine *
 sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
-				struct device_node *node)
+				struct device_node *node,
+				u32 port_id)
 {
 	struct device_node *port, *ep, *remote;
 	struct sunxi_engine *engine = ERR_PTR(-EINVAL);
+	u32 reg = 0;
 
-	port = of_graph_get_port_by_id(node, 0);
+	port = of_graph_get_port_by_id(node, port_id);
 	if (!port)
 		return ERR_PTR(-EINVAL);
 
@@ -837,8 +839,20 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
 		if (remote == engine->node)
 			goto out_put_remote;
 
+	/*
+	 * According to device tree binding input ports have even id
+	 * number and output ports have odd id. Since component with
+	 * more than one input and one output (TCON TOP) exits, correct
+	 * remote input id has to be calculated by subtracting 1 from
+	 * remote output id. If this for some reason can't be done, 0
+	 * is used as input port id.
+	 */
+	port = of_graph_get_remote_port(ep);
+	if (!of_property_read_u32(port, "reg", &reg) && reg > 0)
+		reg -= 1;
+
 	/* keep looking through upstream ports */
-	engine = sun4i_tcon_find_engine_traverse(drv, remote);
+	engine = sun4i_tcon_find_engine_traverse(drv, remote, reg);
 
 out_put_remote:
 	of_node_put(remote);
@@ -961,7 +975,7 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 
 	/* Fallback to old method by traversing input endpoints */
 	of_node_put(port);
-	return sun4i_tcon_find_engine_traverse(drv, node);
+	return sun4i_tcon_find_engine_traverse(drv, node, 0);
 }
 
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
-- 
2.17.1
