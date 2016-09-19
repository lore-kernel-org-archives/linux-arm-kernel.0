From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:22 +0100
Subject: [PATCH 12/26] drm/rockchip: dw-mipi-dsi: prepare panel after phy init
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-13-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some panels need to be configured with commands sent over the MIPI link,
which they will do in the prepare hook.  Call this after the PHY has
been initialized so that we are able to send commands to the panel.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4c945cc4d31a..9ff1cac5ef63 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -901,12 +901,14 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	dw_mipi_dsi_dphy_timing_config(dsi);
 	dw_mipi_dsi_dphy_interface_config(dsi);
 	dw_mipi_dsi_clear_err(dsi);
-	if (drm_panel_prepare(dsi->panel))
-		dev_err(dsi->dev, "failed to prepare panel\n");
 
 	dw_mipi_dsi_phy_init(dsi);
 	dw_mipi_dsi_wait_for_two_frames(dsi);
 
+	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
+	if (drm_panel_prepare(dsi->panel))
+		dev_err(dsi->dev, "failed to prepare panel\n");
+
 	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
 	drm_panel_enable(dsi->panel);
 
-- 
2.10.0.278.g4f427b1.dirty
