From: peda@axentia.se (Peter Rosin)
Date: Sat,  4 Aug 2018 13:14:39 +0200
Subject: [PATCH v7 3/3] drm/atmel-hlcdc: support bus-width (12/16/18/24) in
 endpoint nodes
In-Reply-To: <20180804111439.7455-1-peda@axentia.se>
References: <20180804111439.7455-1-peda@axentia.se>
Message-ID: <20180804111439.7455-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This beats the heuristic that the connector is involved in what format
should be output for cases where this fails.

E.g. if there is a bridge that changes format between the encoder and the
connector, or if some of the RGB pins between the lcd controller and the
encoder are not routed on the PCB.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 70 +++++++++++++++++++++---
 3 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..c38a479ada98 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
+{
+	struct drm_connector *connector = state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_encoder *encoder;
+	unsigned int supported_fmts = 0;
+	int j;
+
+	encoder = state->best_encoder;
+	if (!encoder)
+		encoder = connector->encoder;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB444_1X12:
+		return ATMEL_HLCDC_RGB444_OUTPUT;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return ATMEL_HLCDC_RGB565_OUTPUT;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
-		struct drm_display_info *info = &connector->display_info;
 		unsigned int supported_fmts = 0;
-		int j;
 
 		if (!cstate->crtc)
 			continue;
 
-		for (j = 0; j < info->num_bus_formats; j++) {
-			switch (info->bus_formats[j]) {
-			case MEDIA_BUS_FMT_RGB444_1X12:
-				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB565_1X16:
-				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB666_1X18:
-				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB888_1X24:
-				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
-				break;
-			default:
-				break;
-			}
-		}
+		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
 
 		if (crtc->dc->desc->conflicting_output_formats)
 			output_fmts &= supported_fmts;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 60c937f42114..4cc1e03f0aee 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -441,5 +441,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
 int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
 
 #endif /* DRM_ATMEL_HLCDC_H */
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..f587ae596791 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,33 +27,89 @@
 
 #include "atmel_hlcdc_dc.h"
 
+struct atmel_hlcdc_rgb_output {
+	struct drm_encoder encoder;
+	int bus_fmt;
+};
+
 static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static struct atmel_hlcdc_rgb_output *
+atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
+}
+
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)
+{
+	struct atmel_hlcdc_rgb_output *output;
+
+	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
+
+	return output->bus_fmt;
+}
+
+static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
+{
+	u32 bus_width;
+	int ret;
+
+	ret = of_property_read_u32(ep, "bus-width", &bus_width);
+	if (ret == -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+
+	switch (bus_width) {
+	case 12:
+		return MEDIA_BUS_FMT_RGB444_1X12;
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 {
-	struct drm_encoder *encoder;
+	struct atmel_hlcdc_rgb_output *output;
+	struct device_node *ep;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
 
+	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);
+	if (!ep)
+		return -ENODEV;
+
 	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
 					  &panel, &bridge);
 	if (ret)
 		return ret;
 
-	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output)
 		return -EINVAL;
 
-	ret = drm_encoder_init(dev, encoder,
+	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
+	if (output->bus_fmt < 0) {
+		dev_err(dev->dev, "invalid bus width\n");
+		return -EINVAL;
+	}
+
+	ret = drm_encoder_init(dev, &output->encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	encoder->possible_crtcs = 0x1;
+	output->encoder.possible_crtcs = 0x1;
 
 	if (panel) {
 		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
@@ -62,7 +118,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -70,7 +126,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0
