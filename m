From: peda@axentia.se (Peter Rosin)
Date: Mon,  9 Apr 2018 12:59:16 +0200
Subject: [PATCH 3/5] drm/atmel-hlcdc: allow overriding the output mode
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
Message-ID: <20180409105918.20792-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This beats the heuristic that the connector is involved in what format
should be output for cases where this fails.

E.g. if there is a bridge that changes format between the encoder and the
connector, or if the encoder and connector provided by the tda998x driver
is in use in which case the connector does not advertize and format at
all.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 ++++++------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 19 +++++++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  8 ++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..9bfff228f893 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -220,12 +220,6 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 	drm_crtc_vblank_on(c);
 }
 
-#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
-#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
-#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
-#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
-#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
-
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -237,6 +231,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
+	if (crtc->dc->force_output_mode) {
+		hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
+		hstate->output_mode = fls(crtc->dc->force_output_mode) - 1;
+		return 0;
+	}
+
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
 		struct drm_display_info *info = &connector->display_info;
 		unsigned int supported_fmts = 0;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c1ea5c36b006..dccd0be548a9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -600,6 +600,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	struct platform_device *pdev = to_platform_device(dev->dev);
 	const struct of_device_id *match;
 	struct atmel_hlcdc_dc *dc;
+	const char *output_mode;
 	int ret;
 
 	match = of_match_node(atmel_hlcdc_of_match, dev->dev->parent->of_node);
@@ -634,6 +635,24 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	pm_runtime_enable(dev->dev);
 
+	ret = of_property_read_string(dev->dev->of_node,
+				      "output-mode", &output_mode);
+	if (!ret) {
+		if (!strcmp(output_mode, "rgb444")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB444_OUTPUT;
+		} else if (!strcmp(output_mode, "rgb565")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB565_OUTPUT;
+		} else if (!strcmp(output_mode, "rgb666")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB666_OUTPUT;
+		} else if (!strcmp(output_mode, "rgb888")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB888_OUTPUT;
+		} else {
+			dev_err(dev->dev, "unknown output-mode\n");
+			ret = -EINVAL;
+			goto err_destroy_wq;
+		}
+	}
+
 	ret = drm_vblank_init(dev, 1);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index ab32d5b268d2..a810171b9353 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -153,6 +153,12 @@
 
 #define ATMEL_HLCDC_MAX_LAYERS			6
 
+#define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
+#define ATMEL_HLCDC_RGB565_OUTPUT		BIT(1)
+#define ATMEL_HLCDC_RGB666_OUTPUT		BIT(2)
+#define ATMEL_HLCDC_RGB888_OUTPUT		BIT(3)
+#define ATMEL_HLCDC_OUTPUT_MODE_MASK		GENMASK(3, 0)
+
 /**
  * Atmel HLCDC Layer registers layout structure
  *
@@ -365,6 +371,7 @@ struct atmel_hlcdc_plane_properties {
  * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
  * @fbdev: framebuffer device attached to the Display Controller
  * @crtc: CRTC provided by the display controller
+ * @force_output_mode: if set, this output mode beats the selection heuristic
  * @planes: instantiated planes
  * @layers: active HLCDC layers
  * @wq: display controller workqueue
@@ -376,6 +383,7 @@ struct atmel_hlcdc_dc {
 	struct dma_pool *dscrpool;
 	struct atmel_hlcdc *hlcdc;
 	struct drm_crtc *crtc;
+	unsigned int force_output_mode;
 	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
 	struct workqueue_struct *wq;
 	struct {
-- 
2.11.0
