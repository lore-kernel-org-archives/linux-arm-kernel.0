From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:13 +0100
Subject: [PATCH 03/26] drm/rockchip: dw-mipi-dsi: don't configure hardware in
 mode_set for MIPI
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-4-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With atomic modesetting the hardware will be powered off when the
mode_set function is called.  We should configure the hardware in the
commit function (or even the enable function, but switching from commit
to enable is left for a future patch).

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 40 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index fa90bb615fd0..5925a185ed76 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -822,32 +822,8 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
 					struct drm_display_mode *adjusted_mode)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
-	int ret;
-
-	ret = dw_mipi_dsi_get_lane_bps(dsi, adjusted_mode);
-	if (ret < 0)
-		return;
-
-	if (clk_prepare_enable(dsi->pclk)) {
-		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
-		return;
-	}
 
-	dw_mipi_dsi_init(dsi);
-	dw_mipi_dsi_dpi_config(dsi);
-	dw_mipi_dsi_packet_handler_config(dsi);
-	dw_mipi_dsi_video_mode_config(dsi);
-	dw_mipi_dsi_video_packet_config(dsi);
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
+	dw_mipi_dsi_get_lane_bps(dsi, adjusted_mode);
 }
 
 static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
@@ -887,6 +863,20 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 		return;
 	}
 
+	dw_mipi_dsi_init(dsi);
+	dw_mipi_dsi_dpi_config(dsi);
+	dw_mipi_dsi_packet_handler_config(dsi);
+	dw_mipi_dsi_video_mode_config(dsi);
+	dw_mipi_dsi_video_packet_config(dsi);
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
 
-- 
2.10.0.278.g4f427b1.dirty
