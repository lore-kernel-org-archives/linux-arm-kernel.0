From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:41 +0100
Subject: [PATCH v2 7/9] drm: atmel-hlcdc: rework the output code to support
 drm bridges
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current output code only supports connection to drm panels.
First simplify the drm panel code, and then add support for external drm
bridges.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 193 +++++++++++++----------
 2 files changed, 113 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 930d603..b33f19d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -551,7 +551,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 
 	ret = atmel_hlcdc_create_outputs(dev);
 	if (ret) {
-		dev_err(dev->dev, "failed to create panel: %d\n", ret);
+		dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 75237b5..39802c0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -34,11 +34,13 @@
  * @connector: DRM connector
  * @encoder: DRM encoder
  * @dc: pointer to the atmel_hlcdc_dc structure
+ * @panel: panel connected on the RGB output
  */
 struct atmel_hlcdc_rgb_output {
 	struct drm_connector connector;
 	struct drm_encoder encoder;
 	struct atmel_hlcdc_dc *dc;
+	struct drm_panel *panel;
 };
 
 static inline struct atmel_hlcdc_rgb_output *
@@ -54,46 +56,31 @@ drm_encoder_to_atmel_hlcdc_rgb_output(struct drm_encoder *encoder)
 	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
 }
 
-/**
- * Atmel HLCDC Panel device structure
- *
- * This structure is specialization of the slave device structure to
- * interface with drm panels.
- *
- * @base: base slave device fields
- * @panel: drm panel attached to this slave device
- */
-struct atmel_hlcdc_panel {
-	struct atmel_hlcdc_rgb_output base;
-	struct drm_panel *panel;
-};
-
-static inline struct atmel_hlcdc_panel *
-atmel_hlcdc_rgb_output_to_panel(struct atmel_hlcdc_rgb_output *output)
-{
-	return container_of(output, struct atmel_hlcdc_panel, base);
-}
-
-static void atmel_hlcdc_panel_encoder_enable(struct drm_encoder *encoder)
+static void atmel_hlcdc_rgb_encoder_enable(struct drm_encoder *encoder)
 {
 	struct atmel_hlcdc_rgb_output *rgb =
 			drm_encoder_to_atmel_hlcdc_rgb_output(encoder);
-	struct atmel_hlcdc_panel *panel = atmel_hlcdc_rgb_output_to_panel(rgb);
-	drm_panel_enable(panel->panel);
+
+	if (rgb->panel) {
+		drm_panel_prepare(rgb->panel);
+		drm_panel_enable(rgb->panel);
+	}
 }
 
-static void atmel_hlcdc_panel_encoder_disable(struct drm_encoder *encoder)
+static void atmel_hlcdc_rgb_encoder_disable(struct drm_encoder *encoder)
 {
 	struct atmel_hlcdc_rgb_output *rgb =
 			drm_encoder_to_atmel_hlcdc_rgb_output(encoder);
-	struct atmel_hlcdc_panel *panel = atmel_hlcdc_rgb_output_to_panel(rgb);
 
-	drm_panel_disable(panel->panel);
+	if (rgb->panel) {
+		drm_panel_disable(rgb->panel);
+		drm_panel_unprepare(rgb->panel);
+	}
 }
 
 static const struct drm_encoder_helper_funcs atmel_hlcdc_panel_encoder_helper_funcs = {
-	.disable = atmel_hlcdc_panel_encoder_disable,
-	.enable = atmel_hlcdc_panel_encoder_enable,
+	.disable = atmel_hlcdc_rgb_encoder_disable,
+	.enable = atmel_hlcdc_rgb_encoder_enable,
 };
 
 static void atmel_hlcdc_rgb_encoder_destroy(struct drm_encoder *encoder)
@@ -110,9 +97,11 @@ static int atmel_hlcdc_panel_get_modes(struct drm_connector *connector)
 {
 	struct atmel_hlcdc_rgb_output *rgb =
 			drm_connector_to_atmel_hlcdc_rgb_output(connector);
-	struct atmel_hlcdc_panel *panel = atmel_hlcdc_rgb_output_to_panel(rgb);
 
-	return panel->panel->funcs->get_modes(panel->panel);
+	if (rgb->panel)
+		return rgb->panel->funcs->get_modes(rgb->panel);
+
+	return 0;
 }
 
 static int atmel_hlcdc_rgb_mode_valid(struct drm_connector *connector,
@@ -144,7 +133,13 @@ static const struct drm_connector_helper_funcs atmel_hlcdc_panel_connector_helpe
 static enum drm_connector_status
 atmel_hlcdc_panel_connector_detect(struct drm_connector *connector, bool force)
 {
-	return connector_status_connected;
+	struct atmel_hlcdc_rgb_output *rgb =
+			drm_connector_to_atmel_hlcdc_rgb_output(connector);
+
+	if (rgb->panel)
+		return connector_status_connected;
+
+	return connector_status_disconnected;
 }
 
 static void
@@ -152,9 +147,10 @@ atmel_hlcdc_panel_connector_destroy(struct drm_connector *connector)
 {
 	struct atmel_hlcdc_rgb_output *rgb =
 			drm_connector_to_atmel_hlcdc_rgb_output(connector);
-	struct atmel_hlcdc_panel *panel = atmel_hlcdc_rgb_output_to_panel(rgb);
 
-	drm_panel_detach(panel->panel);
+	if (rgb->panel)
+		drm_panel_detach(rgb->panel);
+
 	drm_connector_cleanup(connector);
 }
 
@@ -168,87 +164,122 @@ static const struct drm_connector_funcs atmel_hlcdc_panel_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static int atmel_hlcdc_create_panel_output(struct drm_device *dev,
-					   struct of_endpoint *ep)
+static int atmel_hlcdc_check_endpoint(struct drm_device *dev,
+				      const struct of_endpoint *ep)
 {
-	struct atmel_hlcdc_dc *dc = dev->dev_private;
 	struct device_node *np;
-	struct drm_panel *p = NULL;
-	struct atmel_hlcdc_panel *panel;
-	int ret;
+	void *obj;
 
 	np = of_graph_get_remote_port_parent(ep->local_node);
-	if (!np)
-		return -EINVAL;
 
-	p = of_drm_find_panel(np);
+	obj = of_drm_find_panel(np);
+	if (!obj)
+		obj = of_drm_find_bridge(np);
+
 	of_node_put(np);
 
-	if (!p)
-		return -EPROBE_DEFER;
+	return obj ? 0 : -EPROBE_DEFER;
+}
 
-	panel = devm_kzalloc(dev->dev, sizeof(*panel), GFP_KERNEL);
-	if (!panel)
-		return -EINVAL;
+static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
+				       const struct of_endpoint *ep)
+{
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct atmel_hlcdc_rgb_output *output;
+	struct device_node *np;
+	struct drm_panel *panel;
+	struct drm_bridge *bridge;
+	int ret;
 
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output)
+		return -EINVAL;
 
-	panel->base.dc = dc;
+	output->dc = dc;
 
-	drm_encoder_helper_add(&panel->base.encoder,
+	drm_encoder_helper_add(&output->encoder,
 			       &atmel_hlcdc_panel_encoder_helper_funcs);
-	ret = drm_encoder_init(dev, &panel->base.encoder,
+	ret = drm_encoder_init(dev, &output->encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	panel->base.connector.dpms = DRM_MODE_DPMS_OFF;
-	panel->base.connector.polled = DRM_CONNECTOR_POLL_CONNECT;
-	drm_connector_helper_add(&panel->base.connector,
-				 &atmel_hlcdc_panel_connector_helper_funcs);
-	ret = drm_connector_init(dev, &panel->base.connector,
-				 &atmel_hlcdc_panel_connector_funcs,
-				 DRM_MODE_CONNECTOR_Unknown);
-	if (ret)
-		goto err_encoder_cleanup;
+	output->encoder.possible_crtcs = 0x1;
+
+	np = of_graph_get_remote_port_parent(ep->local_node);
 
-	drm_mode_connector_attach_encoder(&panel->base.connector,
-					  &panel->base.encoder);
-	panel->base.encoder.possible_crtcs = 0x1;
+	ret = -EPROBE_DEFER;
 
-	drm_panel_attach(p, &panel->base.connector);
-	panel->panel = p;
+	panel = of_drm_find_panel(np);
+	if (panel) {
+		of_node_put(np);
+		output->connector.dpms = DRM_MODE_DPMS_OFF;
+		output->connector.polled = DRM_CONNECTOR_POLL_CONNECT;
+		drm_connector_helper_add(&output->connector,
+				&atmel_hlcdc_panel_connector_helper_funcs);
+		ret = drm_connector_init(dev, &output->connector,
+					 &atmel_hlcdc_panel_connector_funcs,
+					 DRM_MODE_CONNECTOR_Unknown);
+		if (ret)
+			goto err_encoder_cleanup;
 
-	return 0;
+		drm_mode_connector_attach_encoder(&output->connector,
+						  &output->encoder);
+
+		ret = drm_panel_attach(panel, &output->connector);
+		if (ret) {
+			drm_connector_cleanup(&output->connector);
+			goto err_encoder_cleanup;
+		}
+
+		output->panel = panel;
+
+		return 0;
+	}
+
+	bridge = of_drm_find_bridge(np);
+	of_node_put(np);
+
+	if (bridge) {
+		output->encoder.bridge = bridge;
+		bridge->encoder = &output->encoder;
+		ret = drm_bridge_attach(dev, bridge);
+		if (!ret)
+			return 0;
+	}
 
 err_encoder_cleanup:
-	drm_encoder_cleanup(&panel->base.encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev)
 {
-	struct device_node *port_np, *np;
+	struct device_node *ep_np = NULL;
 	struct of_endpoint ep;
 	int ret;
 
-	port_np = of_get_child_by_name(dev->dev->of_node, "port");
-	if (!port_np)
-		return -EINVAL;
+	for_each_endpoint_of_node(dev->dev->of_node, ep_np) {
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		if (!ret)
+			ret = atmel_hlcdc_check_endpoint(dev, &ep);
 
-	np = of_get_child_by_name(port_np, "endpoint");
-	of_node_put(port_np);
+		of_node_put(ep_np);
+		if (ret)
+			return ret;
+	}
 
-	if (!np)
-		return -EINVAL;
+	for_each_endpoint_of_node(dev->dev->of_node, ep_np) {
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		if (!ret)
+			ret = atmel_hlcdc_attach_endpoint(dev, &ep);
 
-	ret = of_graph_parse_endpoint(np, &ep);
-	of_node_put(port_np);
+		of_node_put(ep_np);
+		if (ret)
+			return ret;
+	}
 
-	if (ret)
-		return ret;
-
-	/* We currently only support panel output */
-	return atmel_hlcdc_create_panel_output(dev, &ep);
+	return 0;
 }
-- 
2.5.0
