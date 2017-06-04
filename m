From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 00:01:41 +0800
Subject: [PATCH v2 03/11] drm: sun4i: ignore swapped mixer<->tcon connection
 for DE2
In-Reply-To: <20170604160149.30230-1-icenowy@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
Message-ID: <20170604160149.30230-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoC's DE2 has two mixers. Defaultly the mixer0 is connected to
tcon0 and mixer1 is connected to tcon1; however by setting a bit
the connection can be swapped.

As we now hardcode the default connection, ignore the bonus endpoint for
the mixer's output and the TCON's input, as they stands for the swapped
connection.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Change to use new endpoint reg definition.

 drivers/gpu/drm/sun4i/sun4i_drv.c  | 45 ++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 61 ++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 3 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index f19100c91c2b..775eee82d8a9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -178,6 +178,13 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend");
 }
 
+static bool sun4i_drv_node_is_swappable_de2_mixer(struct device_node *node)
+{
+	/* The V3s has only one mixer-tcon pair, so it's not listed here. */
+	return of_device_is_compatible(node, "allwinner,sun8i-h3-de2-mixer0") ||
+		of_device_is_compatible(node, "allwinner,sun8i-h3-de2-mixer1");
+}
+
 static bool sun4i_drv_node_is_tcon(struct device_node *node)
 {
 	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
@@ -261,6 +268,44 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 			}
 		}
 
+		/*
+		 * The second endpoint of the output of a swappable DE2 mixer
+		 * is the TCON after connection swapping.
+		 * Ignore it now, as we now hardcode mixer0->tcon0,
+		 * mixer1->tcon1 connection.
+		 */
+		if (sun4i_drv_node_is_swappable_de2_mixer(node)) {
+			struct device_node *remote_ep_node;
+			struct of_endpoint local_endpoint, remote_endpoint;
+
+			remote_ep_node = of_graph_get_remote_endpoint(ep);
+			if (!remote_ep_node) {
+				DRM_DEBUG_DRIVER("Couldn't get remote endpoint\n");
+				continue;
+			}
+
+			if (of_graph_parse_endpoint(ep, &local_endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse local endpoint\n");
+				of_node_put(remote_ep_node);
+				continue;
+			}
+
+			if (of_graph_parse_endpoint(remote_ep_node,
+						    &remote_endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse remote endpoint\n");
+				of_node_put(remote_ep_node);
+				continue;
+			}
+
+			if (local_endpoint.id != remote_endpoint.id) {
+				DRM_DEBUG_DRIVER("Endpoint is an unused connection for DE2 mixer... skipping\n");
+				of_node_put(remote_ep_node);
+				continue;
+			}
+
+			of_node_put(remote_ep_node);
+		}
+
 		/* Walk down our tree */
 		count += sun4i_drv_add_endpoints(dev, match, remote);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index d9791292553e..568cea0e5f8f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -464,7 +464,8 @@ static int sun4i_tcon_init_regmap(struct device *dev,
  * requested via the get_id function of the engine.
  */
 static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
-						   struct device_node *node)
+						   struct device_node *node,
+						   bool skip_bonus_ep)
 {
 	struct device_node *port, *ep, *remote;
 	struct sunxi_engine *engine;
@@ -478,6 +479,42 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 		if (!remote)
 			continue;
 
+		if (skip_bonus_ep) {
+			struct device_node *remote_ep_node;
+			struct of_endpoint local_endpoint, remote_endpoint;
+
+			remote_ep_node = of_graph_get_remote_endpoint(ep);
+			if (!remote_ep_node) {
+				DRM_DEBUG_DRIVER("Couldn't get remote endpoint\n");
+				of_node_put(remote);
+				continue;
+			}
+
+			if (of_graph_parse_endpoint(ep, &local_endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse local endpoint\n");
+				of_node_put(remote);
+				of_node_put(remote_ep_node);
+				continue;
+			}
+
+			if (of_graph_parse_endpoint(remote_ep_node,
+						    &remote_endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse remote endpoint\n");
+				of_node_put(remote);
+				of_node_put(remote_ep_node);
+				continue;
+			}
+
+			if (local_endpoint.id != remote_endpoint.id) {
+				DRM_DEBUG_DRIVER("Skipping bonus mixer->TCON connection when searching engine\n");
+				of_node_put(remote);
+				of_node_put(remote_ep_node);
+				continue;
+			}
+
+			of_node_put(remote_ep_node);
+		}
+
 		/* does this node match any registered engines? */
 		list_for_each_entry(engine, &drv->engine_list, list) {
 			if (remote == engine->node) {
@@ -488,7 +525,7 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 		}
 
 		/* keep looking through upstream ports */
-		engine = sun4i_tcon_find_engine(drv, remote);
+		engine = sun4i_tcon_find_engine(drv, remote, skip_bonus_ep);
 		if (!IS_ERR(engine)) {
 			of_node_put(remote);
 			of_node_put(port);
@@ -508,21 +545,27 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	struct sun4i_tcon *tcon;
 	int ret;
 
-	engine = sun4i_tcon_find_engine(drv, dev->of_node);
-	if (IS_ERR(engine)) {
-		dev_err(dev, "Couldn't find matching engine\n");
-		return -EPROBE_DEFER;
-	}
-
 	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
 	if (!tcon)
 		return -ENOMEM;
 	dev_set_drvdata(dev, tcon);
 	tcon->drm = drm;
 	tcon->dev = dev;
-	tcon->id = engine->id;
 	tcon->quirks = of_device_get_match_data(dev);
 
+	/*
+	 * As we keep the connection between DE2 mixer and TCON not swapped,
+	 * skip the bonus endpoints (which stand for swapped connection)
+	 * when finding the correspoing engine.
+	 */
+	engine = sun4i_tcon_find_engine(drv, dev->of_node,
+					tcon->quirks->swappable_input);
+	if (IS_ERR(engine)) {
+		dev_err(dev, "Couldn't find matching engine\n");
+		return -EPROBE_DEFER;
+	}
+	tcon->id = engine->id;
+
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
 	if (IS_ERR(tcon->lcd_rst)) {
 		dev_err(dev, "Couldn't get our reset line\n");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index e3c50ecdcd04..c3e01c06e9a0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -146,6 +146,8 @@
 struct sun4i_tcon_quirks {
 	bool	has_unknown_mux; /* sun5i has undocumented mux */
 	bool	has_channel_1;	/* a33 does not have channel 1 */
+	/* Some DE2 can swap the mixer<->TCON connection */
+	bool	swappable_input;
 };
 
 struct sun4i_tcon {
-- 
2.12.2
