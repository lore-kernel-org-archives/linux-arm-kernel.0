From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:54 +0000
Subject: [PATCH v4 11/23] drm/rockchip: dw-mipi-dsi: prepare panel after phy
 init
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-12-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some panels need to be configured with commands sent over the MIPI link,
which they will do in the prepare hook.  Call this after the PHY has
been initialized so that we are able to send commands to the panel.

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
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 0c66e6eaf44a..53515404d0ca 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -898,12 +898,14 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	dw_mipi_dsi_dphy_timing_config(dsi);
 	dw_mipi_dsi_dphy_interface_config(dsi);
 	dw_mipi_dsi_clear_err(dsi);
-	if (drm_panel_prepare(dsi->panel))
-		dev_err(dsi->dev, "failed to prepare panel\n");
 
 	dw_mipi_dsi_phy_init(dsi);
 	dw_mipi_dsi_wait_for_two_frames(mode);
 
+	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
+	if (drm_panel_prepare(dsi->panel))
+		dev_err(dsi->dev, "failed to prepare panel\n");
+
 	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
 	drm_panel_enable(dsi->panel);
 
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
