From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:45 +0000
Subject: [PATCH v4 02/23] drm/rockchip: dw-mipi-dsi: pass mode in where needed
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-3-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This shows that we only use the mode from the enable function and
prepares us to remove the "mode" field and the mode_set hook in the next
commit.

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
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 41 ++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index bbd992299f73..cdbd25087e83 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -330,11 +330,11 @@ static int max_mbps_to_testdin(unsigned int max_mbps)
  * The controller should generate 2 frames before
  * preparing the peripheral.
  */
-static void dw_mipi_dsi_wait_for_two_frames(struct dw_mipi_dsi *dsi)
+static void dw_mipi_dsi_wait_for_two_frames(struct drm_display_mode *mode)
 {
 	int refresh, two_frames;
 
-	refresh = drm_mode_vrefresh(dsi->mode);
+	refresh = drm_mode_vrefresh(mode);
 	two_frames = DIV_ROUND_UP(MSEC_PER_SEC, refresh) * 2;
 	msleep(two_frames);
 }
@@ -459,7 +459,8 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	return ret;
 }
 
-static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
+static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
+				    struct drm_display_mode *mode)
 {
 	unsigned int i, pre;
 	unsigned long mpclk, pllref, tmp;
@@ -474,7 +475,7 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
 		return bpp;
 	}
 
-	mpclk = DIV_ROUND_UP(dsi->mode->clock, MSEC_PER_SEC);
+	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
 		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
 		tmp = mpclk * (bpp / dsi->lanes) * 10 / 9;
@@ -742,43 +743,44 @@ static void dw_mipi_dsi_command_mode_config(struct dw_mipi_dsi *dsi)
 
 /* Get lane byte clock cycles. */
 static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
+					   struct drm_display_mode *mode,
 					   u32 hcomponent)
 {
 	u32 frac, lbcc;
 
 	lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
 
-	frac = lbcc % dsi->mode->clock;
-	lbcc = lbcc / dsi->mode->clock;
+	frac = lbcc % mode->clock;
+	lbcc = lbcc / mode->clock;
 	if (frac)
 		lbcc++;
 
 	return lbcc;
 }
 
-static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi)
+static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi,
+					  struct drm_display_mode *mode)
 {
 	u32 htotal, hsa, hbp, lbcc;
-	struct drm_display_mode *mode = dsi->mode;
 
 	htotal = mode->htotal;
 	hsa = mode->hsync_end - mode->hsync_start;
 	hbp = mode->htotal - mode->hsync_end;
 
-	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, htotal);
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, htotal);
 	dsi_write(dsi, DSI_VID_HLINE_TIME, lbcc);
 
-	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, hsa);
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hsa);
 	dsi_write(dsi, DSI_VID_HSA_TIME, lbcc);
 
-	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, hbp);
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hbp);
 	dsi_write(dsi, DSI_VID_HBP_TIME, lbcc);
 }
 
-static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi)
+static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
+					       struct drm_display_mode *mode)
 {
 	u32 vactive, vsa, vfp, vbp;
-	struct drm_display_mode *mode = dsi->mode;
 
 	vactive = mode->vdisplay;
 	vsa = mode->vsync_end - mode->vsync_start;
@@ -852,11 +854,12 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
+	struct drm_display_mode *mode = dsi->mode;
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
 	int ret;
 
-	ret = dw_mipi_dsi_get_lane_bps(dsi);
+	ret = dw_mipi_dsi_get_lane_bps(dsi, mode);
 	if (ret < 0)
 		return;
 
@@ -866,13 +869,13 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	}
 
 	dw_mipi_dsi_init(dsi);
-	dw_mipi_dsi_dpi_config(dsi, dsi->mode);
+	dw_mipi_dsi_dpi_config(dsi, mode);
 	dw_mipi_dsi_packet_handler_config(dsi);
 	dw_mipi_dsi_video_mode_config(dsi);
-	dw_mipi_dsi_video_packet_config(dsi, dsi->mode);
+	dw_mipi_dsi_video_packet_config(dsi, mode);
 	dw_mipi_dsi_command_mode_config(dsi);
-	dw_mipi_dsi_line_timer_config(dsi);
-	dw_mipi_dsi_vertical_timing_config(dsi);
+	dw_mipi_dsi_line_timer_config(dsi, mode);
+	dw_mipi_dsi_vertical_timing_config(dsi, mode);
 	dw_mipi_dsi_dphy_timing_config(dsi);
 	dw_mipi_dsi_dphy_interface_config(dsi);
 	dw_mipi_dsi_clear_err(dsi);
@@ -880,7 +883,7 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 		dev_err(dsi->dev, "failed to prepare panel\n");
 
 	dw_mipi_dsi_phy_init(dsi);
-	dw_mipi_dsi_wait_for_two_frames(dsi);
+	dw_mipi_dsi_wait_for_two_frames(mode);
 
 	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
 	drm_panel_enable(dsi->panel);
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
