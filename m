From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 25 Jan 2018 16:55:04 +0100
Subject: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
Message-ID: <20180125155504.8611-1-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "adjusted_mode" clock value (ie the real pixel clock) is more
accurate than "mode" clock value (ie the panel/bridge requested
clock value). It offers a better preciseness for timing
computations and allows to reduce the extra dsi bandwidth in
burst mode (from ~20% to ~10-12%, hw platform dependant).

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
Note: This patch replaces "drm/bridge/synopsys: dsi: add optional pixel clock"

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index ed8af32f8e52..b926b62e9e33 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -707,20 +707,20 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
 
 	clk_prepare_enable(dsi->pclk);
 
-	ret = phy_ops->get_lane_mbps(priv_data, mode, dsi->mode_flags,
+	ret = phy_ops->get_lane_mbps(priv_data, adjusted_mode, dsi->mode_flags,
 				     dsi->lanes, dsi->format, &dsi->lane_mbps);
 	if (ret)
 		DRM_DEBUG_DRIVER("Phy get_lane_mbps() failed\n");
 
 	pm_runtime_get_sync(dsi->dev);
 	dw_mipi_dsi_init(dsi);
-	dw_mipi_dsi_dpi_config(dsi, mode);
+	dw_mipi_dsi_dpi_config(dsi, adjusted_mode);
 	dw_mipi_dsi_packet_handler_config(dsi);
 	dw_mipi_dsi_video_mode_config(dsi);
-	dw_mipi_dsi_video_packet_config(dsi, mode);
+	dw_mipi_dsi_video_packet_config(dsi, adjusted_mode);
 	dw_mipi_dsi_command_mode_config(dsi);
-	dw_mipi_dsi_line_timer_config(dsi, mode);
-	dw_mipi_dsi_vertical_timing_config(dsi, mode);
+	dw_mipi_dsi_line_timer_config(dsi, adjusted_mode);
+	dw_mipi_dsi_vertical_timing_config(dsi, adjusted_mode);
 
 	dw_mipi_dsi_dphy_init(dsi);
 	dw_mipi_dsi_dphy_timing_config(dsi);
@@ -734,7 +734,7 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
 
 	dw_mipi_dsi_dphy_enable(dsi);
 
-	dw_mipi_dsi_wait_for_two_frames(mode);
+	dw_mipi_dsi_wait_for_two_frames(adjusted_mode);
 
 	/* Switch to cmd mode for panel-bridge pre_enable & panel prepare */
 	dw_mipi_dsi_set_mode(dsi, 0);
-- 
2.15.1
