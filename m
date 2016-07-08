From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:04:56 +0800
Subject: [PATCH 2/7] DRM: mipi: support rk3399 mipi dsi
In-Reply-To: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1467968701-15620-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vopb/vopl switch register of rk3399 mipi is different from rk3288,
the default setting for mipi dsi mode is different too, so add a
of_device_id structure to distinguish them, and make sure set the
correct mode before mipi phy init.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 70 ++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index dedc65b..100da01 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -28,9 +28,17 @@
 
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
@@ -147,7 +155,6 @@
 #define LPRX_TO_CNT(p)			((p) & 0xffff)
 
 #define DSI_BTA_TO_CNT			0x8c
-
 #define DSI_LPCLK_CTRL			0x94
 #define AUTO_CLKLANE_CTRL		BIT(1)
 #define PHY_TXREQUESTCLKHS		BIT(0)
@@ -263,6 +270,11 @@ enum {
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
@@ -279,6 +291,7 @@ struct dw_mipi_dsi {
 
 	struct clk *pllref_clk;
 	struct clk *pclk;
+	struct clk *phy_cfg_clk;
 
 	unsigned int lane_mbps; /* per lane */
 	u32 channel;
@@ -400,6 +413,14 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 
 	dsi_write(dsi, DSI_PWR_UP, POWERUP);
 
+	if (!IS_ERR(dsi->phy_cfg_clk)) {
+		ret = clk_prepare_enable(dsi->phy_cfg_clk);
+		if (ret) {
+			dev_err(dsi->dev, "Failed to enable phy_cfg_clk\n");
+			return ret;
+		}
+	}
+
 	dw_mipi_dsi_phy_write(dsi, 0x10, BYPASS_VCO_RANGE |
 					 VCO_RANGE_CON_SEL(vco) |
 					 VCO_IN_CAP_CON_LOW |
@@ -444,17 +465,19 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(dsi->dev, "failed to wait for phy lock state\n");
-		return ret;
+		goto phy_init_end;
 	}
 
 	ret = readx_poll_timeout(readl, dsi->base + DSI_PHY_STATUS,
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
+	if (!IS_ERR(dsi->phy_cfg_clk))
+		clk_disable_unprepare(dsi->phy_cfg_clk);
 
 	return ret;
 }
@@ -878,6 +901,7 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
+	const struct dw_mipi_dsi_plat_data *pdata = dsi->pdata;
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
 
@@ -886,6 +910,10 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 		return;
 	}
 
+	if (pdata->grf_dsi0_mode_reg)
+		regmap_write(dsi->grf_regmap, pdata->grf_dsi0_mode_reg,
+			     pdata->grf_dsi0_mode);
+
 	dw_mipi_dsi_phy_init(dsi);
 	dw_mipi_dsi_wait_for_two_frames(dsi);
 
@@ -895,11 +923,11 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
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
 
@@ -1075,6 +1103,19 @@ static enum drm_mode_status rk3288_mipi_dsi_mode_valid(
 }
 
 static struct dw_mipi_dsi_plat_data rk3288_mipi_dsi_drv_data = {
+	.dsi0_en_bit = RK3288_DSI0_SEL_VOP_LIT,
+	.dsi1_en_bit = RK3288_DSI1_SEL_VOP_LIT,
+	.grf_switch_reg = RK3288_GRF_SOC_CON6,
+	.max_data_lanes = 4,
+	.mode_valid = rk3288_mipi_dsi_mode_valid,
+};
+
+static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
+	.dsi0_en_bit = RK3399_DSI0_SEL_VOP_LIT,
+	.dsi1_en_bit = RK3399_DSI1_SEL_VOP_LIT,
+	.grf_switch_reg = RK3399_GRF_SOC_CON19,
+	.grf_dsi0_mode = RK3399_GRF_DSI_MODE,
+	.grf_dsi0_mode_reg = RK3399_GRF_SOC_CON22,
 	.max_data_lanes = 4,
 	.mode_valid = rk3288_mipi_dsi_mode_valid,
 };
@@ -1083,6 +1124,9 @@ static const struct of_device_id dw_mipi_dsi_dt_ids[] = {
 	{
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_mipi_dsi_drv_data,
+	}, {
+	 .compatible = "rockchip,rk3399-mipi-dsi",
+	 .data = &rk3399_mipi_dsi_drv_data,
 	},
 	{ /* sentinel */ }
 };
@@ -1133,6 +1177,10 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
+	if (IS_ERR(dsi->phy_cfg_clk))
+		dev_dbg(dev, "have not phy_cfg_clk\n");
+
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
 		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
-- 
2.6.3
