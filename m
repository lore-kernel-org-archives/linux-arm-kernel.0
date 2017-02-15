From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 15 Feb 2017 12:22:00 +0800
Subject: [PATCH v7 2/7] drm/rockchip/dsi: dw-mipi: support RK3399 mipi dsi
In-Reply-To: <1487132525-24933-1-git-send-email-zyw@rock-chips.com>
References: <1487132525-24933-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1487132525-24933-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vopb/vopl switch register of RK3399 mipi is different from RK3288,
the default setting for mipi dsi mode is different too, so add a
of_device_id structure to distinguish them, and make sure set the
correct mode before mipi phy init.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>

---

Changes in v6:
- no need check phy_cfg_clk before enable/disable

Changes in v5:
- check the error of phy_cfg_clk in dw_mipi_dsi_bind

Changes in v4:
- remove the unrelated change

Changes in v3:
- base on John Keeping's patch series

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 72 +++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index cc58ada..4e74681 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -29,9 +29,17 @@
 
 #define DRIVER_NAME    "dw-mipi-dsi"
 
-#define GRF_SOC_CON6                    0x025c
-#define DSI0_SEL_VOP_LIT                (1 << 6)
-#define DSI1_SEL_VOP_LIT                (1 << 9)
+#define RK3288_GRF_SOC_CON6		0x025c
+#define RK3288_DSI0_SEL_VOP_LIT		BIT(6)
+#define RK3288_DSI1_SEL_VOP_LIT		BIT(9)
+
+#define RK3399_GRF_SOC_CON19		0x6250
+#define RK3399_DSI0_SEL_VOP_LIT		BIT(0)
+#define RK3399_DSI1_SEL_VOP_LIT		BIT(4)
+
+/* disable turnrequest, turndisable, forcetxstopmode, forcerxmode */
+#define RK3399_GRF_SOC_CON22		0x6258
+#define RK3399_GRF_DSI_MODE		0xffff0000
 
 #define DSI_VERSION			0x00
 #define DSI_PWR_UP			0x04
@@ -265,6 +273,11 @@ enum {
 };
 
 struct dw_mipi_dsi_plat_data {
+	u32 dsi0_en_bit;
+	u32 dsi1_en_bit;
+	u32 grf_switch_reg;
+	u32 grf_dsi0_mode;
+	u32 grf_dsi0_mode_reg;
 	unsigned int max_data_lanes;
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   struct drm_display_mode *mode);
@@ -281,6 +294,7 @@ struct dw_mipi_dsi {
 
 	struct clk *pllref_clk;
 	struct clk *pclk;
+	struct clk *phy_cfg_clk;
 
 	unsigned int lane_mbps; /* per lane */
 	u32 channel;
@@ -425,6 +439,12 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
 
+	ret = clk_prepare_enable(dsi->phy_cfg_clk);
+	if (ret) {
+		dev_err(dsi->dev, "Failed to enable phy_cfg_clk\n");
+		return ret;
+	}
+
 	dw_mipi_dsi_phy_write(dsi, 0x10, BYPASS_VCO_RANGE |
 					 VCO_RANGE_CON_SEL(vco) |
 					 VCO_IN_CAP_CON_LOW |
@@ -481,17 +501,18 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(dsi->dev, "failed to wait for phy lock state\n");
-		return ret;
+		goto phy_init_end;
 	}
 
 	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
 				 val, val & STOP_STATE_CLK_LANE, 1000,
 				 PHY_STATUS_TIMEOUT_US);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dsi->dev,
 			"failed to wait for phy clk lane stop state\n");
-		return ret;
-	}
+
+phy_init_end:
+	clk_disable_unprepare(dsi->phy_cfg_clk);
 
 	return ret;
 }
@@ -960,6 +981,7 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
+	const struct dw_mipi_dsi_plat_data *pdata = dsi->pdata;
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
 	int ret;
@@ -985,6 +1007,10 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	dw_mipi_dsi_dphy_interface_config(dsi);
 	dw_mipi_dsi_clear_err(dsi);
 
+	if (pdata->grf_dsi0_mode_reg)
+		regmap_write(dsi->grf_regmap, pdata->grf_dsi0_mode_reg,
+			     pdata->grf_dsi0_mode);
+
 	dw_mipi_dsi_phy_init(dsi);
 	dw_mipi_dsi_wait_for_two_frames(mode);
 
@@ -998,11 +1024,11 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	clk_disable_unprepare(dsi->pclk);
 
 	if (mux)
-		val = DSI0_SEL_VOP_LIT | (DSI0_SEL_VOP_LIT << 16);
+		val = pdata->dsi0_en_bit | (pdata->dsi0_en_bit << 16);
 	else
-		val = DSI0_SEL_VOP_LIT << 16;
+		val = pdata->dsi0_en_bit << 16;
 
-	regmap_write(dsi->grf_regmap, GRF_SOC_CON6, val);
+	regmap_write(dsi->grf_regmap, pdata->grf_switch_reg, val);
 	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
 }
 
@@ -1161,14 +1187,29 @@ static enum drm_mode_status rk3288_mipi_dsi_mode_valid(
 }
 
 static struct dw_mipi_dsi_plat_data rk3288_mipi_dsi_drv_data = {
+	.dsi0_en_bit = RK3288_DSI0_SEL_VOP_LIT,
+	.dsi1_en_bit = RK3288_DSI1_SEL_VOP_LIT,
+	.grf_switch_reg = RK3288_GRF_SOC_CON6,
 	.max_data_lanes = 4,
 	.mode_valid = rk3288_mipi_dsi_mode_valid,
 };
 
+static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
+	.dsi0_en_bit = RK3399_DSI0_SEL_VOP_LIT,
+	.dsi1_en_bit = RK3399_DSI1_SEL_VOP_LIT,
+	.grf_switch_reg = RK3399_GRF_SOC_CON19,
+	.grf_dsi0_mode = RK3399_GRF_DSI_MODE,
+	.grf_dsi0_mode_reg = RK3399_GRF_SOC_CON22,
+	.max_data_lanes = 4,
+};
+
 static const struct of_device_id dw_mipi_dsi_dt_ids[] = {
 	{
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_mipi_dsi_drv_data,
+	}, {
+	 .compatible = "rockchip,rk3399-mipi-dsi",
+	 .data = &rk3399_mipi_dsi_drv_data,
 	},
 	{ /* sentinel */ }
 };
@@ -1248,6 +1289,17 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 		clk_disable_unprepare(dsi->pclk);
 	}
 
+	dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
+	if (IS_ERR(dsi->phy_cfg_clk)) {
+		ret = PTR_ERR(dsi->phy_cfg_clk);
+		if (ret != -ENOENT) {
+			dev_err(dev, "Unable to get phy_cfg_clk: %d\n", ret);
+			return ret;
+		}
+		dsi->phy_cfg_clk = NULL;
+		dev_dbg(dev, "have not phy_cfg_clk\n");
+	}
+
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
 		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
-- 
2.6.3
