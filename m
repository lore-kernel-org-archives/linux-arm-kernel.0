From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 00:43:46 +0800
Subject: [RFC PATCH 03/11] drm: sun4i: ignore swapped mixer<->tcon connection
 for DE2
In-Reply-To: <20170517164354.16399-1-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
Message-ID: <20170517164354.16399-4-icenowy@aosc.io>
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
 drivers/gpu/drm/sun4i/sun4i_drv.c  | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 39 +++++++++++++++++++++++++++++---------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 1dd1948025d2..29bf1325ded6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -173,6 +173,13 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
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
@@ -249,6 +256,26 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 			}
 		}
 
+		/*
+		 * The second endpoint of the output of a swappable DE2 mixer
+		 * is the TCON after connection swapping.
+		 * Ignore it now, as we now hardcode mixer0->tcon0,
+		 * mixer1->tcon1 connection.
+		 */
+		if (sun4i_drv_node_is_swappable_de2_mixer(node)) {
+			struct of_endpoint endpoint;
+
+			if (of_graph_parse_endpoint(ep, &endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				continue;
+			}
+
+			if (endpoint.id) {
+				DRM_DEBUG_DRIVER("Endpoint is an unused connection for DE2 mixer... skipping\n");
+				continue;
+			}
+		}
+
 		/* Walk down our tree */
 		count += sun4i_drv_add_endpoints(dev, match, remote);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f44a37a5993d..89a215ff2370 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -425,7 +425,8 @@ static int sun4i_tcon_init_regmap(struct device *dev,
  * requested via the get_id function of the engine.
  */
 static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
-						   struct device_node *node)
+						   struct device_node *node,
+						   bool skip_bonus_ep)
 {
 	struct device_node *port, *ep, *remote;
 	struct sunxi_engine *engine;
@@ -439,6 +440,20 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 		if (!remote)
 			continue;
 
+		if (skip_bonus_ep) {
+			struct of_endpoint endpoint;
+
+			if (of_graph_parse_endpoint(ep, &endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				continue;
+			}
+
+			if (endpoint.id) {
+				DRM_DEBUG_DRIVER("Skipping bonus mixer->TCON connection when searching engine\n");
+				continue;
+			}
+		}
+
 		/* does this node match any registered engines? */
 		list_for_each_entry(engine, &drv->engine_list, list) {
 			if (remote == engine->node) {
@@ -449,7 +464,7 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 		}
 
 		/* keep looking through upstream ports */
-		engine = sun4i_tcon_find_engine(drv, remote);
+		engine = sun4i_tcon_find_engine(drv, remote, skip_bonus_ep);
 		if (!IS_ERR(engine)) {
 			of_node_put(remote);
 			of_node_put(port);
@@ -469,21 +484,27 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
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
index d37e1e2ed60e..568dc736238a 100644
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
