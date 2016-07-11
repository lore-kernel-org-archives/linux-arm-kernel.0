From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 11 Jul 2016 19:05:46 +0800
Subject: [PATCH v1 4/6] drm/rockchip: dw_hdmi: add RK3399 HDMI support
In-Reply-To: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
References: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1468235146-29575-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3399 and RK3288 shared the same HDMI IP controller, only some light
difference with GRF configure.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 .../devicetree/bindings/display/bridge/dw_hdmi.txt |  1 +
 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  3 +-
 drivers/gpu/drm/bridge/dw-hdmi.c                   |  2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 45 ++++++++++++++++++----
 include/drm/bridge/dw_hdmi.h                       |  6 +++
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt b/Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt
index dc1452f..f50d4d5 100644
--- a/Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt
@@ -6,6 +6,7 @@ Required properties:
    * "fsl,imx6q-hdmi"
    * "fsl,imx6dl-hdmi"
    * "rockchip,rk3288-dw-hdmi"
+   * "rockchip,rk3399-dw-hdmi"
 - reg: Physical base address and length of the controller's registers.
 - interrupts: The HDMI interrupt number
 - clocks, clock-names : must have the phandles to the HDMI iahb and isfr clocks,
diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
index 668091f..4e573d2 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
@@ -2,7 +2,8 @@ Rockchip specific extensions to the Synopsys Designware HDMI
 ================================
 
 Required properties:
-- compatible: "rockchip,rk3288-dw-hdmi";
+- compatible: "rockchip,rk3288-dw-hdmi",
+	      "rockchip,rk3399-dw-hdmi";
 - reg: Physical base address and length of the controller's registers.
 - clocks: phandle to hdmi iahb and isfr clocks.
 - clock-names: should be "iahb" "isfr"
diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index 70b1f7d..29f855a 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -833,7 +833,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 	dw_hdmi_phy_gen2_txpwron(hdmi, 1);
 	dw_hdmi_phy_gen2_pddq(hdmi, 0);
 
-	if (hdmi->dev_type == RK3288_HDMI)
+	if (is_rockchip(hdmi->dev_type))
 		dw_hdmi_phy_enable_spare(hdmi, 1);
 
 	/*Wait for PHY PLL lock */
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 8cb9ed2..329099b 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -21,13 +21,18 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
 
-#define GRF_SOC_CON6                    0x025c
-#define HDMI_SEL_VOP_LIT                (1 << 4)
+#define RK3288_GRF_SOC_CON6		0x025C
+#define RK3288_HDMI_LCDC_SEL		BIT(4)
+#define RK3399_GRF_SOC_CON20		0x6250
+#define RK3399_HDMI_LCDC_SEL		BIT(6)
+
+#define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
 
 struct rockchip_hdmi {
 	struct device *dev;
 	struct regmap *regmap;
 	struct drm_encoder encoder;
+	enum dw_hdmi_devtype dev_type;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -194,16 +199,30 @@ static void dw_hdmi_rockchip_encoder_mode_set(struct drm_encoder *encoder,
 static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 {
 	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
+	u32 lcdsel_grf_reg, lcdsel_mask;
 	u32 val;
 	int mux;
 
+	switch (hdmi->dev_type) {
+	case RK3288_HDMI:
+		lcdsel_grf_reg = RK3288_GRF_SOC_CON6;
+		lcdsel_mask = RK3288_HDMI_LCDC_SEL;
+		break;
+	case RK3399_HDMI:
+		lcdsel_grf_reg = RK3399_GRF_SOC_CON20;
+		lcdsel_mask = RK3399_HDMI_LCDC_SEL;
+		break;
+	default:
+		return;
+	};
+
 	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
 	if (mux)
-		val = HDMI_SEL_VOP_LIT | (HDMI_SEL_VOP_LIT << 16);
+		val = HIWORD_UPDATE(lcdsel_mask, lcdsel_mask);
 	else
-		val = HDMI_SEL_VOP_LIT << 16;
+		val = HIWORD_UPDATE(0, lcdsel_mask);
 
-	regmap_write(hdmi->regmap, GRF_SOC_CON6, val);
+	regmap_write(hdmi->regmap, lcdsel_grf_reg, val);
 	dev_dbg(hdmi->dev, "vop %s output to hdmi\n",
 		(mux) ? "LIT" : "BIG");
 }
@@ -229,7 +248,7 @@ static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_fun
 	.atomic_check = dw_hdmi_rockchip_encoder_atomic_check,
 };
 
-static const struct dw_hdmi_plat_data rockchip_hdmi_drv_data = {
+static const struct dw_hdmi_plat_data rk3288_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rockchip_mode_valid,
 	.mpll_cfg   = rockchip_mpll_cfg,
 	.cur_ctr    = rockchip_cur_ctr,
@@ -237,9 +256,20 @@ static const struct dw_hdmi_plat_data rockchip_hdmi_drv_data = {
 	.dev_type   = RK3288_HDMI,
 };
 
+static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
+	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.mpll_cfg   = rockchip_mpll_cfg,
+	.cur_ctr    = rockchip_cur_ctr,
+	.phy_config = rockchip_phy_config,
+	.dev_type   = RK3399_HDMI,
+};
+
 static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3288-dw-hdmi",
-	  .data = &rockchip_hdmi_drv_data
+	  .data = &rk3288_hdmi_drv_data
+	},
+	{ .compatible = "rockchip,rk3399-dw-hdmi",
+	  .data = &rk3399_hdmi_drv_data
 	},
 	{},
 };
@@ -268,6 +298,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
 	plat_data = match->data;
 	hdmi->dev = &pdev->dev;
+	hdmi->dev_type = plat_data->dev_type;
 	encoder = &hdmi->encoder;
 
 	irq = platform_get_irq(pdev, 0);
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index bae79f3..26c06d5 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -25,6 +25,7 @@ enum dw_hdmi_devtype {
 	IMX6Q_HDMI,
 	IMX6DL_HDMI,
 	RK3288_HDMI,
+	RK3399_HDMI,
 };
 
 struct dw_hdmi_mpll_config {
@@ -56,6 +57,11 @@ struct dw_hdmi_plat_data {
 					   struct drm_display_mode *mode);
 };
 
+static inline bool is_rockchip(enum dw_hdmi_devtype dev_type)
+{
+	return dev_type == RK3288_HDMI || dev_type == RK3399_HDMI;
+}
+
 void dw_hdmi_unbind(struct device *dev, struct device *master, void *data);
 int dw_hdmi_bind(struct device *dev, struct device *master,
 		 void *data, struct drm_encoder *encoder,
-- 
1.9.1
