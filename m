From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:40 +0100
Subject: [PATCH v2 6/9] drm: atmel-hlcdc: move output mode selection in CRTC
 implementation
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support multiple outputs we need to move the output mode
selection to the CRTC object, so that the output validity check can be
done against the drm_atomic_state.

If the connectors selected by a specific mode setting are requiring
incompatible bus format the atomic operation is aborted (->atomic_check()
returns -EINVAL).

In order to implement that, we need to define our own CRTC state and
overload default ->reset(), ->atomic_duplicate_state() and
->atomic_destroy_state() functions.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 140 ++++++++++++++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     |   3 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |   3 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c |  46 --------
 4 files changed, 142 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 9863291..12ec204 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -32,6 +32,23 @@
 #include "atmel_hlcdc_dc.h"
 
 /**
+ * Atmel HLCDC CRTC state structure
+ *
+ * @base: base CRTC state
+ * @output_mode: RGBXXX output mode
+ */
+struct atmel_hlcdc_crtc_state {
+	struct drm_crtc_state base;
+	unsigned int output_mode;
+};
+
+static inline struct atmel_hlcdc_crtc_state *
+drm_crtc_state_to_atmel_hlcdc_crtc_state(struct drm_crtc_state *state)
+{
+	return container_of(state, struct atmel_hlcdc_crtc_state, base);
+}
+
+/**
  * Atmel HLCDC CRTC structure
  *
  * @base: base DRM CRTC structure
@@ -59,6 +76,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
 	struct regmap *regmap = crtc->dc->hlcdc->regmap;
 	struct drm_display_mode *adj = &c->state->adjusted_mode;
+	struct atmel_hlcdc_crtc_state *state;
 	unsigned long mode_rate;
 	struct videomode vm;
 	unsigned long prate;
@@ -112,12 +130,15 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
 		cfg |= ATMEL_HLCDC_HSPOL;
 
+	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
+	cfg |= state->output_mode << 8;
+
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
 			   ATMEL_HLCDC_HSPOL | ATMEL_HLCDC_VSPOL |
 			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
 			   ATMEL_HLCDC_DISPPOL | ATMEL_HLCDC_DISPDLY |
 			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
-			   ATMEL_HLCDC_GUARDTIME_MASK,
+			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
 			   cfg);
 }
 
@@ -228,14 +249,78 @@ void atmel_hlcdc_crtc_resume(struct drm_crtc *c)
 	}
 }
 
+#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
+#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
+#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
+#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
+#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
+
+static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
+{
+	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
+	struct atmel_hlcdc_crtc_state *hstate;
+	struct drm_connector_state *cstate;
+	struct drm_connector *connector;
+	struct atmel_hlcdc_crtc *crtc;
+	int i;
+
+	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
+
+	for_each_connector_in_state(state->state, connector, cstate, i) {
+		struct drm_display_info *info = &connector->display_info;
+		unsigned int supported_fmts = 0;
+		int j;
+
+		if (!cstate->crtc)
+			continue;
+
+		for (j = 0; j < info->num_bus_formats; j++) {
+			switch (info->bus_formats[j]) {
+			case MEDIA_BUS_FMT_RGB444_1X12:
+				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB565_1X16:
+				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X18:
+				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB888_1X24:
+				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (crtc->dc->desc->conflicting_output_formats)
+			output_fmts &= supported_fmts;
+		else
+			output_fmts |= supported_fmts;
+	}
+
+	if (!output_fmts)
+		return -EINVAL;
+
+	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
+	hstate->output_mode = fls(output_fmts) - 1;
+
+	return 0;
+}
+
 static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
 					 struct drm_crtc_state *s)
 {
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
+	int ret;
 
 	if (atmel_hlcdc_dc_mode_valid(crtc->dc, &s->adjusted_mode) != MODE_OK)
 		return -EINVAL;
 
+	ret = atmel_hlcdc_crtc_select_output_mode(s);
+	if (ret)
+		return ret;
+
 	return atmel_hlcdc_plane_prepare_disc_area(s);
 }
 
@@ -300,13 +385,60 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c)
 	atmel_hlcdc_crtc_finish_page_flip(drm_crtc_to_atmel_hlcdc_crtc(c));
 }
 
+void atmel_hlcdc_crtc_reset(struct drm_crtc *crtc)
+{
+	struct atmel_hlcdc_crtc_state *state;
+
+	if (crtc->state && crtc->state->mode_blob)
+		drm_property_unreference_blob(crtc->state->mode_blob);
+
+	if (crtc->state) {
+		state = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
+		kfree(state);
+	}
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state) {
+		crtc->state = &state->base;
+		crtc->state->crtc = crtc;
+	}
+}
+
+static struct drm_crtc_state *
+atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
+{
+	struct atmel_hlcdc_crtc_state *state, *cur;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (state)
+		__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
+
+	cur = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
+	state->output_mode = cur->output_mode;
+
+	return &state->base;
+}
+
+static void atmel_hlcdc_crtc_destroy_state(struct drm_crtc *crtc,
+					   struct drm_crtc_state *s)
+{
+	struct atmel_hlcdc_crtc_state *state;
+
+	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(s);
+	__drm_atomic_helper_crtc_destroy_state(crtc, s);
+	kfree(state);
+}
+
 static const struct drm_crtc_funcs atmel_hlcdc_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = atmel_hlcdc_crtc_destroy,
-	.reset = drm_atomic_helper_crtc_reset,
-	.atomic_duplicate_state =  drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.reset = atmel_hlcdc_crtc_reset,
+	.atomic_duplicate_state =  atmel_hlcdc_crtc_duplicate_state,
+	.atomic_destroy_state = atmel_hlcdc_crtc_destroy_state,
 };
 
 int atmel_hlcdc_crtc_create(struct drm_device *dev)
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 70006a3..930d603 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -53,6 +53,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9n12 = {
 	.max_spw = 0x3f,
 	.max_vpw = 0x3f,
 	.max_hpw = 0xff,
+	.conflicting_output_formats = true,
 	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9n12_layers),
 	.layers = atmel_hlcdc_at91sam9n12_layers,
 };
@@ -140,6 +141,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9x5 = {
 	.max_spw = 0x3f,
 	.max_vpw = 0x3f,
 	.max_hpw = 0xff,
+	.conflicting_output_formats = true,
 	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9x5_layers),
 	.layers = atmel_hlcdc_at91sam9x5_layers,
 };
@@ -246,6 +248,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d3 = {
 	.max_spw = 0x3f,
 	.max_vpw = 0x3f,
 	.max_hpw = 0x1ff,
+	.conflicting_output_formats = true,
 	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d3_layers),
 	.layers = atmel_hlcdc_sama5d3_layers,
 };
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 23521ba..302c958 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -53,6 +53,8 @@
  * @max_spw: maximum vertical/horizontal pulse width
  * @max_vpw: maximum vertical back/front porch width
  * @max_hpw: maximum horizontal back/front porch width
+ * @conflicting_output_formats: true if RGBXXX output formats conflict with
+ *				each other.
  * @layers: a layer description table describing available layers
  * @nlayers: layer description table size
  */
@@ -64,6 +66,7 @@ struct atmel_hlcdc_dc_desc {
 	int max_spw;
 	int max_vpw;
 	int max_hpw;
+	bool conflicting_output_formats;
 	const struct atmel_hlcdc_layer_desc *layers;
 	int nlayers;
 };
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 2255dc9..75237b5 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,16 +27,6 @@
 #include "atmel_hlcdc_dc.h"
 
 /**
- * Atmel HLCDC RGB output mode
- */
-enum atmel_hlcdc_connector_rgb_mode {
-	ATMEL_HLCDC_CONNECTOR_RGB444,
-	ATMEL_HLCDC_CONNECTOR_RGB565,
-	ATMEL_HLCDC_CONNECTOR_RGB666,
-	ATMEL_HLCDC_CONNECTOR_RGB888,
-};
-
-/**
  * Atmel HLCDC RGB connector structure
  *
  * This structure stores RGB slave device information.
@@ -89,7 +79,6 @@ static void atmel_hlcdc_panel_encoder_enable(struct drm_encoder *encoder)
 	struct atmel_hlcdc_rgb_output *rgb =
 			drm_encoder_to_atmel_hlcdc_rgb_output(encoder);
 	struct atmel_hlcdc_panel *panel = atmel_hlcdc_rgb_output_to_panel(rgb);
-
 	drm_panel_enable(panel->panel);
 }
 
@@ -102,42 +91,7 @@ static void atmel_hlcdc_panel_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_disable(panel->panel);
 }
 
-static void
-atmel_hlcdc_rgb_encoder_mode_set(struct drm_encoder *encoder,
-				 struct drm_display_mode *mode,
-				 struct drm_display_mode *adjusted)
-{
-	struct atmel_hlcdc_rgb_output *rgb =
-			drm_encoder_to_atmel_hlcdc_rgb_output(encoder);
-	struct drm_display_info *info = &rgb->connector.display_info;
-	unsigned int cfg;
-
-	cfg = 0;
-
-	if (info->num_bus_formats) {
-		switch (info->bus_formats[0]) {
-		case MEDIA_BUS_FMT_RGB565_1X16:
-			cfg |= ATMEL_HLCDC_CONNECTOR_RGB565 << 8;
-			break;
-		case MEDIA_BUS_FMT_RGB666_1X18:
-			cfg |= ATMEL_HLCDC_CONNECTOR_RGB666 << 8;
-			break;
-		case MEDIA_BUS_FMT_RGB888_1X24:
-			cfg |= ATMEL_HLCDC_CONNECTOR_RGB888 << 8;
-			break;
-		case MEDIA_BUS_FMT_RGB444_1X12:
-		default:
-			break;
-		}
-	}
-
-	regmap_update_bits(rgb->dc->hlcdc->regmap, ATMEL_HLCDC_CFG(5),
-			   ATMEL_HLCDC_MODE_MASK,
-			   cfg);
-}
-
 static const struct drm_encoder_helper_funcs atmel_hlcdc_panel_encoder_helper_funcs = {
-	.mode_set = atmel_hlcdc_rgb_encoder_mode_set,
 	.disable = atmel_hlcdc_panel_encoder_disable,
 	.enable = atmel_hlcdc_panel_encoder_enable,
 };
-- 
2.5.0
