From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 20 Jan 2017 18:10:48 +0800
Subject: [PATCH v3 2/5] drm/rockchip/dsi: dw-mipi: support RK3399 mipi dsi
In-Reply-To: <1484907051-7159-1-git-send-email-zyw@rock-chips.com>
References: <1484907051-7159-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484907051-7159-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vopb/vopl switch register of RK3399 mipi is different from RK3288,
the default setting for mipi dsi mode is different too, so add a
of_device_id structure to distinguish them, and make sure set the
correct mode before mipi phy init.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---

Changes in v3:
- base on John Keeping's patch series

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 101 ++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 45af890..a93ce97 100644
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
@@ -149,7 +157,6 @@
 #define LPRX_TO_CNT(p)			((p) & 0xffff)
 
 #define DSI_BTA_TO_CNT			0x8c
-
 #define DSI_LPCLK_CTRL			0x94
 #define AUTO_CLKLANE_CTRL		BIT(1)
 #define PHY_TXREQUESTCLKHS		BIT(0)
@@ -215,11 +222,11 @@
 
 #define HSFREQRANGE_SEL(val)	(((val) & 0x3f) << 1)
 
-#define INPUT_DIVIDER(val)	((val - 1) & 0x7f)
+#define INPUT_DIVIDER(val)	(((val) - 1) & 0x7f)
 #define LOW_PROGRAM_EN		0
 #define HIGH_PROGRAM_EN		BIT(7)
-#define LOOP_DIV_LOW_SEL(val)	((val - 1) & 0x1f)
-#define LOOP_DIV_HIGH_SEL(val)	(((val - 1) >> 5) & 0x1f)
+#define LOOP_DIV_LOW_SEL(val)	(((val) - 1) & 0x1f)
+#define LOOP_DIV_HIGH_SEL(val)	((((val) - 1) >> 5) & 0x1f)
 #define PLL_LOOP_DIV_EN		BIT(5)
 #define PLL_INPUT_DIV_EN	BIT(4)
 
@@ -265,6 +272,11 @@ enum {
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
@@ -281,6 +293,7 @@ struct dw_mipi_dsi {
 
 	struct clk *pllref_clk;
 	struct clk *pclk;
+	struct clk *phy_cfg_clk;
 
 	unsigned int lane_mbps; /* per lane */
 	u32 channel;
@@ -356,6 +369,7 @@ static inline struct dw_mipi_dsi *encoder_to_dsi(struct drm_encoder *encoder)
 {
 	return container_of(encoder, struct dw_mipi_dsi, encoder);
 }
+
 static inline void dsi_write(struct dw_mipi_dsi *dsi, u32 reg, u32 val)
 {
 	writel(val, dsi->base + reg);
@@ -367,7 +381,7 @@ static inline u32 dsi_read(struct dw_mipi_dsi *dsi, u32 reg)
 }
 
 static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi *dsi, u8 test_code,
-				 u8 test_data)
+				  u8 test_data)
 {
 	/*
 	 * With the falling edge on TESTCLK, the TESTDIN[7:0] signal content
@@ -426,6 +440,14 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
 
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
@@ -474,22 +496,23 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
 				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
 
-
 	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
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
+	if (!IS_ERR(dsi->phy_cfg_clk))
+		clk_disable_unprepare(dsi->phy_cfg_clk);
 
 	return ret;
 }
@@ -548,7 +571,7 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 
 	if (device->lanes > dsi->pdata->max_data_lanes) {
 		dev_err(dsi->dev, "the number of data lanes(%u) is too many\n",
-				device->lanes);
+			device->lanes);
 		return -EINVAL;
 	}
 
@@ -936,8 +959,8 @@ static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
 }
 
 static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
-					struct drm_display_mode *mode,
-					struct drm_display_mode *adjusted_mode)
+					 struct drm_display_mode *mode,
+					 struct drm_display_mode *adjusted_mode)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 
@@ -965,6 +988,7 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
+	const struct dw_mipi_dsi_plat_data *pdata = dsi->pdata;
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
 
@@ -985,6 +1009,10 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	dw_mipi_dsi_dphy_interface_config(dsi);
 	dw_mipi_dsi_clear_err(dsi);
 
+	if (pdata->grf_dsi0_mode_reg)
+		regmap_write(dsi->grf_regmap, pdata->grf_dsi0_mode_reg,
+			     pdata->grf_dsi0_mode);
+
 	dw_mipi_dsi_phy_init(dsi);
 	dw_mipi_dsi_wait_for_two_frames(dsi);
 
@@ -998,11 +1026,11 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
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
 
@@ -1034,7 +1062,7 @@ dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
-static struct drm_encoder_helper_funcs
+static const struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
 	.enable = dw_mipi_dsi_encoder_enable,
 	.mode_set = dw_mipi_dsi_encoder_mode_set,
@@ -1042,7 +1070,7 @@ dw_mipi_dsi_encoder_helper_funcs = {
 	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
 };
 
-static struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
+static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
@@ -1078,7 +1106,7 @@ static void dw_mipi_dsi_drm_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
-static struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
+static const struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = dw_mipi_dsi_drm_connector_destroy,
@@ -1088,7 +1116,7 @@ static struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
 };
 
 static int dw_mipi_dsi_register(struct drm_device *drm,
-				      struct dw_mipi_dsi *dsi)
+				struct dw_mipi_dsi *dsi)
 {
 	struct drm_encoder *encoder = &dsi->encoder;
 	struct drm_connector *connector = &dsi->connector;
@@ -1109,14 +1137,14 @@ static int dw_mipi_dsi_register(struct drm_device *drm,
 	drm_encoder_helper_add(&dsi->encoder,
 			       &dw_mipi_dsi_encoder_helper_funcs);
 	ret = drm_encoder_init(drm, &dsi->encoder, &dw_mipi_dsi_encoder_funcs,
-			 DRM_MODE_ENCODER_DSI, NULL);
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to initialize encoder with drm\n");
 		return ret;
 	}
 
 	drm_connector_helper_add(connector,
-			&dw_mipi_dsi_connector_helper_funcs);
+				 &dw_mipi_dsi_connector_helper_funcs);
 
 	drm_connector_init(drm, &dsi->connector,
 			   &dw_mipi_dsi_atomic_connector_funcs,
@@ -1162,21 +1190,36 @@ static enum drm_mode_status rk3288_mipi_dsi_mode_valid(
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
 MODULE_DEVICE_TABLE(of, dw_mipi_dsi_dt_ids);
 
 static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
-			     void *data)
+			    void *data)
 {
 	const struct of_device_id *of_id =
 			of_match_device(dw_mipi_dsi_dt_ids, dev);
@@ -1249,6 +1292,10 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 		clk_disable_unprepare(dsi->pclk);
 	}
 
+	dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
+	if (IS_ERR(dsi->phy_cfg_clk))
+		dev_dbg(dev, "have not phy_cfg_clk\n");
+
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
 		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
@@ -1280,7 +1327,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 }
 
 static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
-	void *data)
+			       void *data)
 {
 	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 
-- 
2.6.3
