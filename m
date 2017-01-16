From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:23 +0800
Subject: [PATCH v2 03/11] drm/rockchip/dsi: remove mode_valid function
In-Reply-To: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484561311-494-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI DSI do not need check the validity of resolution, the max
resolution should depend VOP. Hence, remove rk3288_mipi_dsi_mode_valid
here.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 39 ----------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 04fd595..8f8d48a 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -276,8 +276,6 @@ struct dw_mipi_dsi_plat_data {
 	u32 grf_dsi0_mode;
 	u32 grf_dsi0_mode_reg;
 	unsigned int max_data_lanes;
-	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
-					   struct drm_display_mode *mode);
 };
 
 struct dw_mipi_dsi {
@@ -978,23 +976,8 @@ static int dw_mipi_dsi_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(dsi->panel);
 }
 
-static enum drm_mode_status dw_mipi_dsi_mode_valid(
-					struct drm_connector *connector,
-					struct drm_display_mode *mode)
-{
-	struct dw_mipi_dsi *dsi = con_to_dsi(connector);
-
-	enum drm_mode_status mode_status = MODE_OK;
-
-	if (dsi->pdata->mode_valid)
-		mode_status = dsi->pdata->mode_valid(connector, mode);
-
-	return mode_status;
-}
-
 static struct drm_connector_helper_funcs dw_mipi_dsi_connector_helper_funcs = {
 	.get_modes = dw_mipi_dsi_connector_get_modes,
-	.mode_valid = dw_mipi_dsi_mode_valid,
 };
 
 static void dw_mipi_dsi_drm_connector_destroy(struct drm_connector *connector)
@@ -1065,33 +1048,11 @@ static int rockchip_mipi_parse_dt(struct dw_mipi_dsi *dsi)
 	return 0;
 }
 
-static enum drm_mode_status rk3288_mipi_dsi_mode_valid(
-					struct drm_connector *connector,
-					struct drm_display_mode *mode)
-{
-	/*
-	 * The VID_PKT_SIZE field in the DSI_VID_PKT_CFG
-	 * register is 11-bit.
-	 */
-	if (mode->hdisplay > 0x7ff)
-		return MODE_BAD_HVALUE;
-
-	/*
-	 * The V_ACTIVE_LINES field in the DSI_VTIMING_CFG
-	 * register is 11-bit.
-	 */
-	if (mode->vdisplay > 0x7ff)
-		return MODE_BAD_VVALUE;
-
-	return MODE_OK;
-}
-
 static struct dw_mipi_dsi_plat_data rk3288_mipi_dsi_drv_data = {
 	.dsi0_en_bit = RK3288_DSI0_SEL_VOP_LIT,
 	.dsi1_en_bit = RK3288_DSI1_SEL_VOP_LIT,
 	.grf_switch_reg = RK3288_GRF_SOC_CON6,
 	.max_data_lanes = 4,
-	.mode_valid = rk3288_mipi_dsi_mode_valid,
 };
 
 static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
-- 
2.6.3
