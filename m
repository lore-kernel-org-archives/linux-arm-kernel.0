From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:12 +0200
Subject: [PATCH 12/20] drm/sun4i: Add bridge support
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-13-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our RGB bus can be either connected to a bridge or a panel. While the panel
support was already there, the bridge was not.

Fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c  |  4 +--
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 56 +++++++++++++++++++++++++++-----------
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 48 ++++++++++++++++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 4 files changed, 86 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 257d2b4f3645..1f9e00db747d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -268,8 +268,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
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
index b46d2c15dc95..c3c611b08269 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -161,7 +161,12 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
-	drm_panel_enable(tcon->panel);
+	if (!IS_ERR(tcon->panel))
+		drm_panel_enable(tcon->panel);
+
+	if (!IS_ERR(tcon->bridge))
+		drm_bridge_enable(tcon->bridge);
+
 	sun4i_tcon_channel_enable(tcon, 0);
 }
 
@@ -174,7 +179,12 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 	DRM_DEBUG_DRIVER("Disabling RGB output\n");
 
 	sun4i_tcon_channel_disable(tcon, 0);
-	drm_panel_disable(tcon->panel);
+
+	if (!IS_ERR(tcon->bridge))
+		drm_bridge_disable(tcon->bridge);
+
+	if (!IS_ERR(tcon->panel))
+		drm_panel_disable(tcon->panel);
 }
 
 static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
@@ -216,10 +226,6 @@ int sun4i_rgb_init(struct drm_device *drm)
 	struct sun4i_rgb *rgb;
 	int ret;
 
-	/* If we don't have a panel, there's no point in going on */
-	if (IS_ERR(tcon->panel))
-		return -ENODEV;
-
 	rgb = devm_kzalloc(drm->dev, sizeof(*rgb), GFP_KERNEL);
 	if (!rgb)
 		return -ENOMEM;
@@ -240,19 +246,37 @@ int sun4i_rgb_init(struct drm_device *drm)
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
+	if (!IS_ERR(tcon->bridge)) {
+		rgb->encoder.bridge = tcon->bridge;
+		tcon->bridge->encoder = &rgb->encoder;
 
-	drm_panel_attach(tcon->panel, &rgb->connector);
+		ret = drm_bridge_attach(drm, tcon->bridge);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't attach our bridge\n");
+			goto err_cleanup_connector;
+		}
+	}
 
 	return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eed6a9e8d9a6..4618d98913b4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -432,6 +432,40 @@ static struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
 	return of_drm_find_panel(remote) ?: ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node)
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
@@ -485,8 +519,9 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	}
 
 	tcon->panel = sun4i_tcon_find_panel(dev->of_node);
-	if (IS_ERR(tcon->panel)) {
-		dev_info(dev, "No panel found... RGB output disabled\n");
+	tcon->bridge = sun4i_tcon_find_bridge(dev->of_node);
+	if (IS_ERR(tcon->panel) && IS_ERR(tcon->bridge)) {
+		dev_info(dev, "No panel or bridge found... RGB output disabled\n");
 		return 0;
 	}
 
@@ -515,19 +550,22 @@ static struct component_ops sun4i_tcon_ops = {
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
index 0e0b11db401b..31069027d7fb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -162,6 +162,7 @@ struct sun4i_tcon {
 	/* Platform adjustments */
 	bool				has_mux;
 
+	struct drm_bridge		*bridge;
 	struct drm_panel		*panel;
 };
 
-- 
2.8.2
