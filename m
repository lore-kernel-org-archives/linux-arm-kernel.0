From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:46 +0000
Subject: [PATCH v4 03/23] drm/rockchip: dw-mipi-dsi: remove mode_set hook
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-4-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed since we can access the mode via the CRTC from the
enable hook.  Also remove the "mode" field that is no longer used.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Add Chris' Reviewed-by
New in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index cdbd25087e83..bd92e58b64f3 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -286,7 +286,6 @@ struct dw_mipi_dsi {
 	u32 format;
 	u16 input_div;
 	u16 feedback_div;
-	struct drm_display_mode *mode;
 
 	const struct dw_mipi_dsi_plat_data *pdata;
 };
@@ -816,15 +815,6 @@ static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_INT_MSK1, 0);
 }
 
-static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
-					struct drm_display_mode *mode,
-					struct drm_display_mode *adjusted_mode)
-{
-	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
-
-	dsi->mode = adjusted_mode;
-}
-
 static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
@@ -854,7 +844,7 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
-	struct drm_display_mode *mode = dsi->mode;
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
 	int ret;
@@ -930,7 +920,6 @@ dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 static struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
 	.enable = dw_mipi_dsi_encoder_enable,
-	.mode_set = dw_mipi_dsi_encoder_mode_set,
 	.disable = dw_mipi_dsi_encoder_disable,
 	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
 };
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
