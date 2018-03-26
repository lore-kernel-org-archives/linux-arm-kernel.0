From: peda@axentia.se (Peter Rosin)
Date: Mon, 26 Mar 2018 23:24:47 +0200
Subject: [PATCH v2 5/5] drm/atmel-hlcdc: take bridges into account when
 selecting output format
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
Message-ID: <20180326212447.7380-6-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bridges may affect the required bus output format of the encoder, in
which case it may be wrong to use the output format of the panel or
connector as is. So, examine if any of the intermediate bridges needs
specific bus formats (if there are intermediate bridges).

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 49 ++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..920eb16c0213 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,45 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+/* We know that our connectors will only ever have one encoder. Find it. */
+static struct drm_encoder *atmel_hlcdc_encoder(struct drm_connector *connector)
+{
+	struct drm_encoder *encoder;
+	int i;
+
+	for (i = 0; i < DRM_CONNECTOR_MAX_ENCODER; i++) {
+		if (!connector->encoder_ids[i])
+			break;
+
+		encoder = drm_encoder_find(connector->dev, NULL,
+					   connector->encoder_ids[i]);
+		if (encoder)
+			return encoder;
+	}
+
+	return NULL;
+}
+
+static int atmel_hlcdc_output_formats(struct drm_connector *connector,
+				      const u32 **bus_formats)
+{
+	struct drm_encoder *encoder = atmel_hlcdc_encoder(connector);
+	int num_bus_formats;
+
+	if (!encoder)
+		return 0;
+
+	if (encoder->bridge) {
+		num_bus_formats = drm_bridge_input_formats(encoder->bridge,
+							   bus_formats);
+		if (num_bus_formats)
+			return num_bus_formats;
+	}
+
+	*bus_formats = connector->display_info.bus_formats;
+	return connector->display_info.num_bus_formats;
+}
+
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -238,15 +277,19 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
-		struct drm_display_info *info = &connector->display_info;
+		int num_bus_formats;
+		const u32 *bus_formats;
 		unsigned int supported_fmts = 0;
 		int j;
 
+		num_bus_formats = atmel_hlcdc_output_formats(connector,
+							     &bus_formats);
+
 		if (!cstate->crtc)
 			continue;
 
-		for (j = 0; j < info->num_bus_formats; j++) {
-			switch (info->bus_formats[j]) {
+		for (j = 0; j < num_bus_formats; j++) {
+			switch (bus_formats[j]) {
 			case MEDIA_BUS_FMT_RGB444_1X12:
 				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
 				break;
-- 
2.11.0
