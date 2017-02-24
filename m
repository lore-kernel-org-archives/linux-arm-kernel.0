From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:44 +0000
Subject: [PATCH v4 01/23] drm/rockchip: dw-mipi-dsi: don't configure hardware
 in mode_set for MIPI
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-2-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With atomic modesetting the hardware will be powered off when the
mode_set function is called.  We should configure the hardware in the
enable function, which is the atomic version of "commit" so let's use
the enable hook rather than commit while we're at it.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Squash together with the commit to s/commit/enable/
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 49 +++++++++++++++-------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index d9aa382bb629..bbd992299f73 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -819,34 +819,8 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
 					struct drm_display_mode *adjusted_mode)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
-	int ret;
 
 	dsi->mode = adjusted_mode;
-
-	ret = dw_mipi_dsi_get_lane_bps(dsi);
-	if (ret < 0)
-		return;
-
-	if (clk_prepare_enable(dsi->pclk)) {
-		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
-		return;
-	}
-
-	dw_mipi_dsi_init(dsi);
-	dw_mipi_dsi_dpi_config(dsi, mode);
-	dw_mipi_dsi_packet_handler_config(dsi);
-	dw_mipi_dsi_video_mode_config(dsi);
-	dw_mipi_dsi_video_packet_config(dsi, mode);
-	dw_mipi_dsi_command_mode_config(dsi);
-	dw_mipi_dsi_line_timer_config(dsi);
-	dw_mipi_dsi_vertical_timing_config(dsi);
-	dw_mipi_dsi_dphy_timing_config(dsi);
-	dw_mipi_dsi_dphy_interface_config(dsi);
-	dw_mipi_dsi_clear_err(dsi);
-	if (drm_panel_prepare(dsi->panel))
-		dev_err(dsi->dev, "failed to prepare panel\n");
-
-	clk_disable_unprepare(dsi->pclk);
 }
 
 static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
@@ -875,17 +849,36 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 	clk_disable_unprepare(dsi->pclk);
 }
 
-static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
+static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
+	int ret;
+
+	ret = dw_mipi_dsi_get_lane_bps(dsi);
+	if (ret < 0)
+		return;
 
 	if (clk_prepare_enable(dsi->pclk)) {
 		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
 		return;
 	}
 
+	dw_mipi_dsi_init(dsi);
+	dw_mipi_dsi_dpi_config(dsi, dsi->mode);
+	dw_mipi_dsi_packet_handler_config(dsi);
+	dw_mipi_dsi_video_mode_config(dsi);
+	dw_mipi_dsi_video_packet_config(dsi, dsi->mode);
+	dw_mipi_dsi_command_mode_config(dsi);
+	dw_mipi_dsi_line_timer_config(dsi);
+	dw_mipi_dsi_vertical_timing_config(dsi);
+	dw_mipi_dsi_dphy_timing_config(dsi);
+	dw_mipi_dsi_dphy_interface_config(dsi);
+	dw_mipi_dsi_clear_err(dsi);
+	if (drm_panel_prepare(dsi->panel))
+		dev_err(dsi->dev, "failed to prepare panel\n");
+
 	dw_mipi_dsi_phy_init(dsi);
 	dw_mipi_dsi_wait_for_two_frames(dsi);
 
@@ -933,7 +926,7 @@ dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 
 static struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
-	.commit = dw_mipi_dsi_encoder_commit,
+	.enable = dw_mipi_dsi_encoder_enable,
 	.mode_set = dw_mipi_dsi_encoder_mode_set,
 	.disable = dw_mipi_dsi_encoder_disable,
 	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
