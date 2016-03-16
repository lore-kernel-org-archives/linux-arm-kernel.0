From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:38 +0100
Subject: [PATCH v2 4/9] drm: atmel-hlcdc: remove leftovers from atomic mode
 setting migration
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->dpms field is no longer used and can be removed.
The same goes for the dummy ->mode_fixup() implementation which always
returns true.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 49494e9..2255dc9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -44,13 +44,11 @@ enum atmel_hlcdc_connector_rgb_mode {
  * @connector: DRM connector
  * @encoder: DRM encoder
  * @dc: pointer to the atmel_hlcdc_dc structure
- * @dpms: current DPMS mode
  */
 struct atmel_hlcdc_rgb_output {
 	struct drm_connector connector;
 	struct drm_encoder encoder;
 	struct atmel_hlcdc_dc *dc;
-	int dpms;
 };
 
 static inline struct atmel_hlcdc_rgb_output *
@@ -104,14 +102,6 @@ static void atmel_hlcdc_panel_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_disable(panel->panel);
 }
 
-static bool
-atmel_hlcdc_panel_encoder_mode_fixup(struct drm_encoder *encoder,
-				     const struct drm_display_mode *mode,
-				     struct drm_display_mode *adjusted)
-{
-	return true;
-}
-
 static void
 atmel_hlcdc_rgb_encoder_mode_set(struct drm_encoder *encoder,
 				 struct drm_display_mode *mode,
@@ -147,7 +137,6 @@ atmel_hlcdc_rgb_encoder_mode_set(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs atmel_hlcdc_panel_encoder_helper_funcs = {
-	.mode_fixup = atmel_hlcdc_panel_encoder_mode_fixup,
 	.mode_set = atmel_hlcdc_rgb_encoder_mode_set,
 	.disable = atmel_hlcdc_panel_encoder_disable,
 	.enable = atmel_hlcdc_panel_encoder_enable,
@@ -248,7 +237,6 @@ static int atmel_hlcdc_create_panel_output(struct drm_device *dev,
 	if (!panel)
 		return -EINVAL;
 
-	panel->base.dpms = DRM_MODE_DPMS_OFF;
 
 	panel->base.dc = dc;
 
-- 
2.5.0
