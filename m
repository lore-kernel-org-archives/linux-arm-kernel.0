From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:35 +0100
Subject: [PATCH 9/9] drm/rockchip: dw_hdmi: add dw-hdmi support for the rk3328
In-Reply-To: <20180205143435.4723-1-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
Message-ID: <20180205143435.4723-10-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328 uses an external hdmi phy from Innosilicon which uses
the generic phy framework for access. Add the necessary data
and the compatible for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   1 +
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 106 +++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
index 937bfb472e1d..39143424a474 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
@@ -13,6 +13,7 @@ Required properties:
 
 - compatible: should be one of the following:
 		"rockchip,rk3288-dw-hdmi"
+		"rockchip,rk3328-dw-hdmi"
 		"rockchip,rk3399-dw-hdmi"
 - reg: See dw_hdmi.txt.
 - reg-io-width: See dw_hdmi.txt. Shall be 4.
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 5a62328887d5..30b8f44d0418 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -25,6 +25,24 @@
 
 #define RK3288_GRF_SOC_CON6		0x025C
 #define RK3288_HDMI_LCDC_SEL		BIT(4)
+#define RK3328_GRF_SOC_CON2		0x0408
+
+#define RK3328_HDMI_SDAIN_MSK		BIT(11)
+#define RK3328_HDMI_SCLIN_MSK		BIT(10)
+#define RK3328_HDMI_HPD_IOE		BIT(2)
+#define RK3328_GRF_SOC_CON3		0x040c
+/* need to be unset if hdmi or i2c should control voltage */
+#define RK3328_HDMI_SDA5V_GRF		BIT(15)
+#define RK3328_HDMI_SCL5V_GRF		BIT(14)
+#define RK3328_HDMI_HPD5V_GRF		BIT(13)
+#define RK3328_HDMI_CEC5V_GRF		BIT(12)
+#define RK3328_GRF_SOC_CON4		0x0410
+#define RK3328_HDMI_HPD_SARADC		BIT(13)
+#define RK3328_HDMI_CEC_5V		BIT(11)
+#define RK3328_HDMI_SDA_5V		BIT(10)
+#define RK3328_HDMI_SCL_5V		BIT(9)
+#define RK3328_HDMI_HPD_5V		BIT(8)
+
 #define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_HDMI_LCDC_SEL		BIT(6)
 
@@ -299,6 +317,68 @@ static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_fun
 	.atomic_check = dw_hdmi_rockchip_encoder_atomic_check,
 };
 
+static int dw_hdmi_rockchip_genphy_init(struct dw_hdmi *dw_hdmi, void *data,
+			     struct drm_display_mode *mode)
+{
+	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
+
+	return phy_power_on(hdmi->phy);
+}
+
+static void dw_hdmi_rockchip_genphy_disable(struct dw_hdmi *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
+
+	phy_power_off(hdmi->phy);
+}
+
+static enum drm_connector_status
+dw_hdmi_rk3328_read_hpd(struct dw_hdmi *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
+	enum drm_connector_status status;
+
+	status = dw_hdmi_phy_read_hpd(dw_hdmi, data);
+
+	if (status == connector_status_connected)
+		regmap_write(hdmi->regmap,
+			RK3328_GRF_SOC_CON4,
+			HIWORD_UPDATE(RK3328_HDMI_CEC_5V | RK3328_HDMI_SDA_5V |
+				      RK3328_HDMI_SCL_5V,
+				      RK3328_HDMI_CEC_5V | RK3328_HDMI_SDA_5V |
+				      RK3328_HDMI_SCL_5V));
+	else
+		regmap_write(hdmi->regmap,
+			RK3328_GRF_SOC_CON4,
+			HIWORD_UPDATE(0,
+				      RK3328_HDMI_CEC_5V | RK3328_HDMI_SDA_5V |
+				      RK3328_HDMI_SCL_5V));
+	return status;
+}
+
+static void dw_hdmi_rk3328_setup_hpd(struct dw_hdmi *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
+
+	dw_hdmi_phy_setup_hpd(dw_hdmi, data);
+
+	/* Enable and map pins to 3V grf-controlled io-voltage */
+	regmap_write(hdmi->regmap,
+		RK3328_GRF_SOC_CON4,
+		HIWORD_UPDATE(0, RK3328_HDMI_HPD_SARADC | RK3328_HDMI_CEC_5V |
+				 RK3328_HDMI_SDA_5V | RK3328_HDMI_SCL_5V |
+				 RK3328_HDMI_HPD_5V));
+	regmap_write(hdmi->regmap,
+		RK3328_GRF_SOC_CON3,
+		HIWORD_UPDATE(0, RK3328_HDMI_SDA5V_GRF | RK3328_HDMI_SCL5V_GRF |
+				 RK3328_HDMI_HPD5V_GRF | RK3328_HDMI_CEC5V_GRF));
+	regmap_write(hdmi->regmap,
+		RK3328_GRF_SOC_CON2,
+		HIWORD_UPDATE(RK3328_HDMI_SDAIN_MSK | RK3328_HDMI_SCLIN_MSK,
+			      RK3328_HDMI_SDAIN_MSK | RK3328_HDMI_SCLIN_MSK |
+			      RK3328_HDMI_HPD_IOE));
+}
+
 static struct rockchip_hdmi_chip_data rk3288_chip_data = {
 	.lcdsel_grf_reg = RK3288_GRF_SOC_CON6,
 	.lcdsel_big = HIWORD_UPDATE(0, RK3288_HDMI_LCDC_SEL),
@@ -313,6 +393,29 @@ static const struct dw_hdmi_plat_data rk3288_hdmi_drv_data = {
 	.phy_data = &rk3288_chip_data,
 };
 
+static const struct dw_hdmi_phy_ops rk3328_hdmi_phy_ops = {
+	.init		= dw_hdmi_rockchip_genphy_init,
+	.disable	= dw_hdmi_rockchip_genphy_disable,
+	.read_hpd	= dw_hdmi_rk3328_read_hpd,
+	.update_hpd	= dw_hdmi_phy_update_hpd,
+	.setup_hpd	= dw_hdmi_rk3328_setup_hpd,
+};
+
+static struct rockchip_hdmi_chip_data rk3328_chip_data = {
+	.lcdsel_grf_reg = -1,
+};
+
+static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
+	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.mpll_cfg = rockchip_mpll_cfg,
+	.cur_ctr = rockchip_cur_ctr,
+	.phy_config = rockchip_phy_config,
+	.phy_data = &rk3328_chip_data,
+	.phy_ops = &rk3328_hdmi_phy_ops,
+	.phy_name = "inno_dw_hdmi_phy2",
+	.phy_force_type = DW_HDMI_PHY_VENDOR_PHY,
+};
+
 static struct rockchip_hdmi_chip_data rk3399_chip_data = {
 	.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
 	.lcdsel_big = HIWORD_UPDATE(0, RK3399_HDMI_LCDC_SEL),
@@ -331,6 +434,9 @@ static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3288-dw-hdmi",
 	  .data = &rk3288_hdmi_drv_data
 	},
+	{ .compatible = "rockchip,rk3328-dw-hdmi",
+	  .data = &rk3328_hdmi_drv_data
+	},
 	{ .compatible = "rockchip,rk3399-dw-hdmi",
 	  .data = &rk3399_hdmi_drv_data
 	},
-- 
2.15.1
