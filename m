From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:11 +0100
Subject: [PATCH 01/26] drm/rockchip: dw-mipi-dsi: use mode from display state
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-2-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to keep a pointer to the mode around since we know it
will be present in the connector state.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index ca22e5ee89ca..a87037556f5c 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -286,7 +286,6 @@ struct dw_mipi_dsi {
 	u32 format;
 	u16 input_div;
 	u16 feedback_div;
-	struct drm_display_mode *mode;
 
 	const struct dw_mipi_dsi_plat_data *pdata;
 };
@@ -332,9 +331,10 @@ static int max_mbps_to_testdin(unsigned int max_mbps)
  */
 static void dw_mipi_dsi_wait_for_two_frames(struct dw_mipi_dsi *dsi)
 {
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 	int refresh, two_frames;
 
-	refresh = drm_mode_vrefresh(dsi->mode);
+	refresh = drm_mode_vrefresh(mode);
 	two_frames = DIV_ROUND_UP(MSEC_PER_SEC, refresh) * 2;
 	msleep(two_frames);
 }
@@ -461,6 +461,7 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 
 static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
 {
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 	unsigned int i, pre;
 	unsigned long mpclk, pllref, tmp;
 	unsigned int m = 1, n = 1, target_mbps = 1000;
@@ -474,7 +475,7 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
 		return bpp;
 	}
 
-	mpclk = DIV_ROUND_UP(dsi->mode->clock, MSEC_PER_SEC);
+	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
 		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
 		tmp = mpclk * (bpp / dsi->lanes) * 10 / 9;
@@ -689,9 +690,9 @@ static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 }
 
-static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
-				   struct drm_display_mode *mode)
+static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi)
 {
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 	u32 val = 0, color = 0;
 
 	switch (dsi->format) {
@@ -726,9 +727,10 @@ static void dw_mipi_dsi_packet_handler_config(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_PCKHDL_CFG, EN_CRC_RX | EN_ECC_RX | EN_BTA);
 }
 
-static void dw_mipi_dsi_video_packet_config(struct dw_mipi_dsi *dsi,
-					    struct drm_display_mode *mode)
+static void dw_mipi_dsi_video_packet_config(struct dw_mipi_dsi *dsi)
 {
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
+
 	dsi_write(dsi, DSI_VID_PKT_SIZE, VID_PKT_SIZE(mode->hdisplay));
 }
 
@@ -744,12 +746,13 @@ static void dw_mipi_dsi_command_mode_config(struct dw_mipi_dsi *dsi)
 static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
 					   u32 hcomponent)
 {
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 	u32 frac, lbcc;
 
 	lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
 
-	frac = lbcc % dsi->mode->clock;
-	lbcc = lbcc / dsi->mode->clock;
+	frac = lbcc % mode->clock;
+	lbcc = lbcc / mode->clock;
 	if (frac)
 		lbcc++;
 
@@ -759,7 +762,7 @@ static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
 static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi)
 {
 	u32 htotal, hsa, hbp, lbcc;
-	struct drm_display_mode *mode = dsi->mode;
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 
 	htotal = mode->htotal;
 	hsa = mode->hsync_end - mode->hsync_start;
@@ -778,7 +781,7 @@ static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi)
 static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi)
 {
 	u32 vactive, vsa, vfp, vbp;
-	struct drm_display_mode *mode = dsi->mode;
+	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 
 	vactive = mode->vdisplay;
 	vsa = mode->vsync_end - mode->vsync_start;
@@ -821,8 +824,6 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	int ret;
 
-	dsi->mode = adjusted_mode;
-
 	ret = dw_mipi_dsi_get_lane_bps(dsi);
 	if (ret < 0)
 		return;
@@ -833,10 +834,10 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
 	}
 
 	dw_mipi_dsi_init(dsi);
-	dw_mipi_dsi_dpi_config(dsi, mode);
+	dw_mipi_dsi_dpi_config(dsi);
 	dw_mipi_dsi_packet_handler_config(dsi);
 	dw_mipi_dsi_video_mode_config(dsi);
-	dw_mipi_dsi_video_packet_config(dsi, mode);
+	dw_mipi_dsi_video_packet_config(dsi);
 	dw_mipi_dsi_command_mode_config(dsi);
 	dw_mipi_dsi_line_timer_config(dsi);
 	dw_mipi_dsi_vertical_timing_config(dsi);
-- 
2.10.0.278.g4f427b1.dirty
