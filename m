From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:55 +0000
Subject: [PATCH v4 12/23] drm/rockchip: dw-mipi-dsi: allow commands in
 panel_disable
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-13-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Panel drivers may want to sent commands during the disable function, for
example MIPI_DCS_SET_DISPLAY_OFF before the video signal ends.  In order
to send commands we need to write to registers, so pclk must be enabled.

While changing this, remove the unnecessary code after the panel
unprepare call which seems to be a workaround for a specific panel and
thus belongs in the panel driver.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 53515404d0ca..4201a2143295 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -848,24 +848,16 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 
-	drm_panel_disable(dsi->panel);
-
 	if (clk_prepare_enable(dsi->pclk)) {
 		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
 		return;
 	}
 
+	drm_panel_disable(dsi->panel);
+
 	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
 	drm_panel_unprepare(dsi->panel);
-	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
 
-	/*
-	 * This is necessary to make sure the peripheral will be driven
-	 * normally when the display is enabled again later.
-	 */
-	msleep(120);
-
-	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
 	dw_mipi_dsi_disable(dsi);
 	clk_disable_unprepare(dsi->pclk);
 }
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
