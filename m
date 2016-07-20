From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Jul 2016 11:58:53 +0200
Subject: [PATCH v2 3/7] drm/sun4i: Add bridge support
In-Reply-To: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
References: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
Message-ID: <20160720095857.12297-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our RGB bus can be either connected to a bridge or a panel. While the panel
support was already there, the bridge was not.

Fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c  |  4 +--
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 58 +++++++++++++++++++++++++++++---------
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 43 ++++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 4 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 4dc543e1db10..db5ab4d50bd6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -258,8 +258,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		}
 
 		/*
-		 * If the node is our TCON, the first port is used for our
-		 * panel, and will not be part of the
+		 * If the node is our TCON, the first port is used for
+		 * panel or bridges, and will not be part of the
 		 * component framework.
 		 */
 		if (sun4i_drv_node_is_tcon(node)) {
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index d32f08f9ce5f..d4e52522ec53 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -151,7 +151,12 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
-	drm_panel_enable(tcon->panel);
+	if (!IS_ERR(tcon->panel))
+		drm_panel_enable(tcon->panel);
+
+	if (!IS_ERR(encoder->bridge))
+		drm_bridge_enable(encoder->bridge);
+
 	sun4i_tcon_channel_enable(tcon, 0);
 }
 
@@ -164,7 +169,12 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 	DRM_DEBUG_DRIVER("Disabling RGB output\n");
 
 	sun4i_tcon_channel_disable(tcon, 0);
-	drm_panel_disable(tcon->panel);
+
+	if (!IS_ERR(encoder->bridge))
+		drm_bridge_disable(encoder->bridge);
+
+	if (!IS_ERR(tcon->panel))
+		drm_panel_disable(tcon->panel);
 }
 
 static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
@@ -203,6 +213,7 @@ int sun4i_rgb_init(struct drm_device *drm)
 {
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon = drv->tcon;
+	struct drm_encoder *encoder;
 	struct sun4i_rgb *rgb;
 	int ret;
 
@@ -210,10 +221,12 @@ int sun4i_rgb_init(struct drm_device *drm)
 	if (!rgb)
 		return -ENOMEM;
 	rgb->drv = drv;
+	encoder = &rgb->encoder;
 
 	tcon->panel = sun4i_tcon_find_panel(tcon->dev->of_node);
-	if (IS_ERR(tcon->panel)) {
-		dev_info(drm->dev, "No panel found... RGB output disabled\n");
+	encoder->bridge = sun4i_tcon_find_bridge(tcon->dev->of_node);
+	if (IS_ERR(tcon->panel) && IS_ERR(encoder->bridge)) {
+		dev_info(drm->dev, "No panel or bridge found... RGB output disabled\n");
 		return 0;
 	}
 
@@ -232,19 +245,36 @@ int sun4i_rgb_init(struct drm_device *drm)
 	/* The RGB encoder can only work with the TCON channel 0 */
 	rgb->encoder.possible_crtcs = BIT(0);
 
-	drm_connector_helper_add(&rgb->connector,
-				 &sun4i_rgb_con_helper_funcs);
-	ret = drm_connector_init(drm, &rgb->connector,
-				 &sun4i_rgb_con_funcs,
-				 DRM_MODE_CONNECTOR_Unknown);
-	if (ret) {
-		dev_err(drm->dev, "Couldn't initialise the rgb connector\n");
-		goto err_cleanup_connector;
+	if (!IS_ERR(tcon->panel)) {
+		drm_connector_helper_add(&rgb->connector,
+					 &sun4i_rgb_con_helper_funcs);
+		ret = drm_connector_init(drm, &rgb->connector,
+					 &sun4i_rgb_con_funcs,
+					 DRM_MODE_CONNECTOR_Unknown);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't initialise the rgb connector\n");
+			goto err_cleanup_connector;
+		}
+
+		drm_mode_connector_attach_encoder(&rgb->connector,
+						  &rgb->encoder);
+
+		ret = drm_panel_attach(tcon->panel, &rgb->connector);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't attach our panel\n");
+			goto err_cleanup_connector;
+		}
 	}
 
-	drm_mode_connector_attach_encoder(&rgb->connector, &rgb->encoder);
+	if (!IS_ERR(encoder->bridge)) {
+		encoder->bridge->encoder = &rgb->encoder;
 
-	drm_panel_attach(tcon->panel, &rgb->connector);
+		ret = drm_bridge_attach(drm, encoder->bridge);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't attach our bridge\n");
+			goto err_cleanup_connector;
+		}
+	}
 
 	return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index d2f7489d29a5..2145ecf2cf5d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -432,6 +432,40 @@ struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
 	return of_drm_find_panel(remote) ?: ERR_PTR(-EPROBE_DEFER);
 }
 
+struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node)
+{
+	struct device_node *port, *remote, *child;
+	struct device_node *end_node = NULL;
+
+	/* Inputs are listed first, then outputs */
+	port = of_graph_get_port_by_id(node, 1);
+
+	/*
+	 * Our first output is the RGB interface where the panel will
+	 * be connected.
+	 */
+	for_each_child_of_node(port, child) {
+		u32 reg;
+
+		of_property_read_u32(child, "reg", &reg);
+		if (reg == 0)
+			end_node = child;
+	}
+
+	if (!end_node) {
+		DRM_DEBUG_DRIVER("Missing bridge endpoint\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	remote = of_graph_get_remote_port_parent(end_node);
+	if (!remote) {
+		DRM_DEBUG_DRIVER("Enable to parse remote node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return of_drm_find_bridge(remote) ?: ERR_PTR(-EPROBE_DEFER);
+}
+
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -514,19 +548,22 @@ static struct component_ops sun4i_tcon_ops = {
 static int sun4i_tcon_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct drm_bridge *bridge;
 	struct drm_panel *panel;
 
 	/*
-	 * The panel is not ready.
+	 * Neither the bridge or the panel is ready.
 	 * Defer the probe.
 	 */
 	panel = sun4i_tcon_find_panel(node);
+	bridge = sun4i_tcon_find_bridge(node);
 
 	/*
 	 * If we don't have a panel endpoint, just go on
 	 */
-	if (PTR_ERR(panel) == -EPROBE_DEFER) {
-		DRM_DEBUG_DRIVER("Still waiting for our panel. Deferring...\n");
+	if ((PTR_ERR(panel) == -EPROBE_DEFER) &&
+	    (PTR_ERR(bridge) == -EPROBE_DEFER)) {
+		DRM_DEBUG_DRIVER("Still waiting for our panel/bridge. Deferring...\n");
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 4f81d86ee5a4..100bfa093277 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -166,6 +166,7 @@ struct sun4i_tcon {
 	struct drm_panel		*panel;
 };
 
+struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
 /* Global Control */
-- 
2.9.0
