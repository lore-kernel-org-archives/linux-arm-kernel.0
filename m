From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:13 +0800
Subject: [PATCH 5/8] drm/sun4i: tcon: Simplify sun4i_tcon_find_engine_traverse
 for one input
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170908075016.18657-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that sun4i_tcon_find_engine_traverse() usage is restricted to the
single input case, we can remove the for_each_available_child_of_node
loop.

While at it, consolidate all the of_node_put calls into a common exit
path.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 51 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 33c20d2f9fb1..e9ab03f0bf6e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -468,7 +468,7 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
 				struct device_node *node)
 {
 	struct device_node *port, *ep, *remote;
-	struct sunxi_engine *engine;
+	struct sunxi_engine *engine = ERR_PTR(-EINVAL);
 
 	port = of_graph_get_port_by_id(node, 0);
 	if (!port)
@@ -483,35 +483,34 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
 	 *
 	 * Bail out if there are multiple input connections.
 	 */
-	if (of_get_available_child_count(port) != 1) {
-		of_node_put(port);
-		return ERR_PTR(-EINVAL);
-	}
+	if (of_get_available_child_count(port) != 1)
+		goto out_put_port;
 
-	for_each_available_child_of_node(port, ep) {
-		remote = of_graph_get_remote_port_parent(ep);
-		if (!remote)
-			continue;
+	/* Get the first connection without specifying an ID */
+	ep = of_get_next_available_child(port, NULL);
+	if (!ep)
+		goto out_put_port;
 
-		/* does this node match any registered engines? */
-		list_for_each_entry(engine, &drv->engine_list, list) {
-			if (remote == engine->node) {
-				of_node_put(remote);
-				of_node_put(port);
-				return engine;
-			}
-		}
+	remote = of_graph_get_remote_port_parent(ep);
+	if (!remote)
+		goto out_put_ep;
 
-		/* keep looking through upstream ports */
-		engine = sun4i_tcon_find_engine_traverse(drv, remote);
-		if (!IS_ERR(engine)) {
-			of_node_put(remote);
-			of_node_put(port);
-			return engine;
-		}
-	}
+	/* does this node match any registered engines? */
+	list_for_each_entry(engine, &drv->engine_list, list)
+		if (remote == engine->node)
+			goto out_put_remote;
 
-	return ERR_PTR(-EINVAL);
+	/* keep looking through upstream ports */
+	engine = sun4i_tcon_find_engine_traverse(drv, remote);
+
+out_put_remote:
+	of_node_put(remote);
+out_put_ep:
+	of_node_put(ep);
+out_put_port:
+	of_node_put(port);
+
+	return engine;
 }
 
 /*
-- 
2.14.1
