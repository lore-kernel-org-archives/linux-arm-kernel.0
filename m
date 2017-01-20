From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 20 Jan 2017 18:10:49 +0800
Subject: [PATCH v3 3/5] drm/rockchip/dsi: remove mode_valid function
In-Reply-To: <1484907051-7159-1-git-send-email-zyw@rock-chips.com>
References: <1484907051-7159-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484907051-7159-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI DSI do not need check the validity of resolution, the max
resolution should depend VOP. Hence, remove rk3288_mipi_dsi_mode_valid
here.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v3: None

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 39 ----------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index a93ce97..6f0e252 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -278,8 +278,6 @@ struct dw_mipi_dsi_plat_data {
 	u32 grf_dsi0_mode;
 	u32 grf_dsi0_mode_reg;
 	unsigned int max_data_lanes;
-	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
-					   struct drm_display_mode *mode);
 };
 
 struct dw_mipi_dsi {
@@ -1081,23 +1079,8 @@ static int dw_mipi_dsi_connector_get_modes(struct drm_connector *connector)
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
@@ -1168,33 +1151,11 @@ static int rockchip_mipi_parse_dt(struct dw_mipi_dsi *dsi)
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
