From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  7 Jan 2016 16:57:53 +0800
Subject: [RFC PATCH v2 1/4] drm: dw-hdmi: make it easy to recovery the
 platform data for platform driver
In-Reply-To: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
References: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1452157073-18576-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2: None

 drivers/gpu/drm/imx/dw_hdmi-imx.c           | 7 ++++---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index 063825f..0968610 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -26,6 +26,7 @@ struct imx_hdmi {
 	struct device *dev;
 	struct drm_encoder encoder;
 	struct regmap *regmap;
+	struct dw_hdmi_plat_data plat_data;
 };
 
 static const struct dw_hdmi_mpll_config imx_mpll_cfg[] = {
@@ -204,7 +205,6 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
 			    void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	const struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
@@ -221,7 +221,7 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	match = of_match_node(dw_hdmi_imx_dt_ids, pdev->dev.of_node);
-	plat_data = match->data;
+	hdmi->plat_data = *(const struct dw_hdmi_plat_data *)match->data;
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
@@ -253,7 +253,8 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_imx_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
+	return dw_hdmi_bind(dev, master, data, encoder, iores, irq,
+			    &hdmi->plat_data);
 }
 
 static void dw_hdmi_imx_unbind(struct device *dev, struct device *master,
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index c65ce8c..d5816b3 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -28,6 +28,7 @@ struct rockchip_hdmi {
 	struct device *dev;
 	struct regmap *regmap;
 	struct drm_encoder encoder;
+	struct dw_hdmi_plat_data plat_data;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -242,7 +243,6 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	const struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
@@ -259,7 +259,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
-	plat_data = match->data;
+	hdmi->plat_data = *(const struct dw_hdmi_plat_data *)match->data;
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
@@ -293,7 +293,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
+	return dw_hdmi_bind(dev, master, data, encoder, iores, irq,
+			    &hdmi->plat_data);
 }
 
 static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
-- 
2.1.2
