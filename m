From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:42 +0200
Subject: [PATCH RFC v2 08/12] drm/rockchip: lvds: register a bridge when no
 panel is set
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-9-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On socs using the lvds components it also controls the use of the
general rgb outputs and must thus be configured for things like
external encoders.

Therefore register a drm_bridge in this case and try to find
the encoder in the output port.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 255 ++++++++++++++++++++++++++++---
 1 file changed, 233 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 657609e..5ffd70a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -43,6 +43,9 @@
 #define encoder_to_lvds(c) \
 		container_of(c, struct rockchip_lvds, encoder)
 
+#define bridge_to_lvds(c) \
+		container_of(c, struct rockchip_lvds, bridge)
+
 /*
  * @grf_offset: offset inside the grf regmap for setting the rockchip lvds
  */
@@ -68,6 +71,8 @@ struct rockchip_lvds {
 	struct drm_panel *panel;
 	struct drm_connector connector;
 	struct drm_encoder encoder;
+	struct drm_bridge bridge;
+	struct drm_encoder *ext_encoder;
 
 	struct mutex suspend_lock;
 	int suspend;
@@ -248,11 +253,10 @@ rockchip_lvds_encoder_mode_fixup(struct drm_encoder *encoder,
 	return true;
 }
 
-static void rockchip_lvds_encoder_mode_set(struct drm_encoder *encoder,
-					  struct drm_display_mode *mode,
-					  struct drm_display_mode *adjusted)
+static void rockchip_lvds_mode_set(struct rockchip_lvds *lvds,
+				   struct drm_display_mode *mode,
+				   struct drm_display_mode *adjusted)
 {
-	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
 	u32 h_bp = mode->htotal - mode->hsync_start;
 	u8 pin_hsync = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 1 : 0;
 	u8 pin_dclk = (mode->flags & DRM_MODE_FLAG_PCSYNC) ? 1 : 0;
@@ -347,32 +351,52 @@ static void rockchip_lvds_encoder_mode_set(struct drm_encoder *encoder,
 	dsb();
 }
 
-static void rockchip_lvds_encoder_prepare(struct drm_encoder *encoder)
+static void rockchip_lvds_encoder_mode_set(struct drm_encoder *encoder,
+					   struct drm_display_mode *mode,
+					   struct drm_display_mode *adjusted)
+{
+	rockchip_lvds_mode_set(encoder_to_lvds(encoder), mode, adjusted);
+}
+
+static int rockchip_lvds_set_vop_source(struct rockchip_lvds *lvds,
+					struct drm_encoder *encoder)
 {
-	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
 	u32 val;
 	int ret;
 
-	ret = rockchip_drm_crtc_mode_config(encoder->crtc,
-						lvds->connector.connector_type,
-						ROCKCHIP_OUT_MODE_P888);
-	if (ret < 0) {
-		dev_err(lvds->dev, "Could not set crtc mode config: %d\n", ret);
-		return;
-	}
-
 	ret = rockchip_drm_encoder_get_mux_id(lvds->dev->of_node, encoder);
 	if (ret < 0)
-		return;
+		return ret;
 
 	if (ret)
 		val = RK3288_LVDS_SOC_CON6_SEL_VOP_LIT |
 		      (RK3288_LVDS_SOC_CON6_SEL_VOP_LIT << 16);
 	else
 		val = RK3288_LVDS_SOC_CON6_SEL_VOP_LIT << 16;
+
 	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con6, val);
-	if (ret != 0) {
-		dev_err(lvds->dev, "Could not write to GRF: %d\n", ret);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void rockchip_lvds_encoder_prepare(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	int ret;
+
+	ret = rockchip_drm_crtc_mode_config(encoder->crtc,
+						lvds->connector.connector_type,
+						ROCKCHIP_OUT_MODE_P888);
+	if (ret < 0) {
+		dev_err(lvds->dev, "Could not set crtc mode config: %d\n", ret);
+		return;
+	}
+
+	ret = rockchip_lvds_set_vop_source(lvds, encoder);
+	if (ret < 0) {
+		dev_err(lvds->dev, "Could not set vop source: %d\n", ret);
 		return;
 	}
 }
@@ -405,6 +429,97 @@ static struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
 	.destroy = rockchip_lvds_encoder_destroy,
 };
 
+static void rockchip_lvds_bridge_mode_set(struct drm_bridge *bridge,
+					  struct drm_display_mode *mode,
+					  struct drm_display_mode *adjusted)
+{
+	rockchip_lvds_mode_set(bridge_to_lvds(bridge), mode, adjusted);
+}
+
+static void rockchip_lvds_bridge_pre_enable(struct drm_bridge *bridge)
+{
+}
+
+/*
+ * post_disable is called right after encoder prepare, so do lvds and crtc
+ * mode config here.
+ */
+static void rockchip_lvds_bridge_post_disable(struct drm_bridge *bridge)
+{
+	struct rockchip_lvds *lvds = bridge_to_lvds(bridge);
+	struct drm_connector *connector;
+	int ret, connector_type = DRM_MODE_CONNECTOR_Unknown;
+
+	if (!bridge->encoder->crtc)
+		return;
+
+	list_for_each_entry(connector, &bridge->dev->mode_config.connector_list,
+			head) {
+		if (connector->encoder == bridge->encoder)
+			connector_type = connector->connector_type;
+	}
+
+	ret = rockchip_drm_crtc_mode_config(bridge->encoder->crtc,
+						connector_type,
+						ROCKCHIP_OUT_MODE_P888);
+	if (ret < 0) {
+		dev_err(lvds->dev, "Could not set crtc mode config: %d\n", ret);
+		return;
+	}
+
+	ret = rockchip_lvds_set_vop_source(lvds, bridge->encoder);
+	if (ret < 0) {
+		dev_err(lvds->dev, "Could not set vop source: %d\n", ret);
+		return;
+	}
+}
+
+static void rockchip_lvds_bridge_enable(struct drm_bridge *bridge)
+{
+	struct rockchip_lvds *lvds = bridge_to_lvds(bridge);
+	int ret;
+
+	mutex_lock(&lvds->suspend_lock);
+
+	if (!lvds->suspend)
+		goto out;
+
+	ret = rockchip_lvds_poweron(lvds);
+	if (ret < 0) {
+		dev_err(lvds->dev, "could not enable lvds\n");
+		goto out;
+	}
+
+	lvds->suspend = false;
+
+out:
+	mutex_unlock(&lvds->suspend_lock);
+}
+
+static void rockchip_lvds_bridge_disable(struct drm_bridge *bridge)
+{
+	struct rockchip_lvds *lvds = bridge_to_lvds(bridge);
+
+	mutex_lock(&lvds->suspend_lock);
+
+	if (lvds->suspend)
+		goto out;
+
+	rockchip_lvds_poweroff(lvds);
+	lvds->suspend = true;
+
+out:
+	mutex_unlock(&lvds->suspend_lock);
+}
+
+static struct drm_bridge_funcs rockchip_lvds_bridge_funcs = {
+	.mode_set = rockchip_lvds_bridge_mode_set,
+	.enable = rockchip_lvds_bridge_enable,
+	.disable = rockchip_lvds_bridge_disable,
+	.pre_enable = rockchip_lvds_bridge_pre_enable,
+	.post_disable = rockchip_lvds_bridge_post_disable,
+};
+
 static struct rockchip_lvds_soc_data rk3288_lvds_data = {
 	.grf_soc_con6 = 0x025c,
 	.grf_soc_con7 = 0x0260,
@@ -430,6 +545,35 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	lvds->drm_dev = drm_dev;
 
+	if (!lvds->panel) {
+		struct drm_bridge *bridge = &lvds->bridge;
+
+		if (!lvds->ext_encoder->of_node)
+			return -ENODEV;
+
+		ret = component_bind_all(dev, drm_dev);
+		if (ret < 0)
+			return ret;
+
+		/**
+		 * Override any possible crtcs set by the encoder itself,
+		 * as they are connected to the lvds instead.
+		 */
+		encoder = of_drm_find_encoder(lvds->ext_encoder->of_node);
+		encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
+								dev->of_node);
+
+		encoder->bridge = bridge;
+		bridge->encoder = encoder;
+		ret = drm_bridge_attach(drm_dev, bridge);
+		if (ret < 0) {
+			component_unbind_all(dev, drm_dev);
+			return ret;
+		}
+
+		return 0;
+	}
+
 	encoder = &lvds->encoder;
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dev->of_node);
@@ -482,6 +626,7 @@ static void rockchip_lvds_unbind(struct device *dev, struct device *master,
 				void *data)
 {
 	struct rockchip_lvds *lvds = dev_get_drvdata(dev);
+	struct drm_device *drm_dev = data;
 
 	if (lvds->panel) {
 		rockchip_lvds_encoder_dpms(&lvds->encoder, DRM_MODE_DPMS_OFF);
@@ -490,6 +635,8 @@ static void rockchip_lvds_unbind(struct device *dev, struct device *master,
 
 		drm_connector_cleanup(&lvds->connector);
 		drm_encoder_cleanup(&lvds->encoder);
+	} else {
+		component_unbind_all(dev, drm_dev);
 	}
 }
 static const struct component_ops rockchip_lvds_component_ops = {
@@ -497,6 +644,26 @@ static const struct component_ops rockchip_lvds_component_ops = {
 	.unbind = rockchip_lvds_unbind,
 };
 
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int rockchip_lvds_master_bind(struct device *dev)
+{
+	return 0;
+}
+
+static void rockchip_lvds_master_unbind(struct device *dev)
+{
+	/* do nothing */
+}
+
+static const struct component_master_ops rockchip_lvds_master_ops = {
+	.bind = rockchip_lvds_master_bind,
+	.unbind = rockchip_lvds_master_unbind,
+};
+
 static int rockchip_lvds_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -596,18 +763,58 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
 
 	if (!output_node) {
 		dev_err(&pdev->dev, "no output defined\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unprepare_pclk;
 	}
 
 	lvds->panel = of_drm_find_panel(output_node);
-	of_node_put(output_node);
 	if (!lvds->panel) {
-		dev_err(&pdev->dev, "panel not found\n");
-		return -EPROBE_DEFER;
+		struct drm_encoder *encoder;
+		struct component_match *match = NULL;
+
+		/* Try to find an encoder in the output node */
+		encoder = of_drm_find_encoder(output_node);
+		if (!encoder) {
+			dev_err(&pdev->dev, "neither panel nor encoder found\n");
+			of_node_put(output_node);
+			ret = -EPROBE_DEFER;
+			goto err_unprepare_pclk;
+		}
+
+		lvds->ext_encoder = encoder;
+
+		component_match_add(dev, &match, compare_of, output_node);
+		of_node_put(output_node);
+
+		lvds->bridge.funcs = &rockchip_lvds_bridge_funcs;
+		lvds->bridge.of_node = dev->of_node;
+		ret = drm_bridge_add(&lvds->bridge);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add bridge %d\n", ret);
+			goto err_unprepare_pclk;
+		}
+
+		ret = component_master_add_with_match(dev,
+						      &rockchip_lvds_master_ops,
+						      match);
+		if (ret < 0)
+			goto err_bridge_remove;
+	} else {
+		of_node_put(output_node);
 	}
 
-	return component_add(&pdev->dev, &rockchip_lvds_component_ops);
+	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
+	if (ret < 0)
+		goto err_master_remove;
+
+	return 0;
 
+err_master_remove:
+	if (!lvds->panel)
+		component_master_del(&pdev->dev, &rockchip_lvds_master_ops);
+err_bridge_remove:
+	if (!lvds->panel)
+		drm_bridge_remove(&lvds->bridge);
 err_unprepare_pclk:
 	clk_unprepare(lvds->pclk);
 	return ret;
@@ -618,6 +825,10 @@ static int rockchip_lvds_remove(struct platform_device *pdev)
 	struct rockchip_lvds *lvds = dev_get_drvdata(&pdev->dev);
 
 	component_del(&pdev->dev, &rockchip_lvds_component_ops);
+	if (!lvds->panel) {
+		component_master_del(&pdev->dev, &rockchip_lvds_master_ops);
+		drm_bridge_remove(&lvds->bridge);
+	}
 
 	clk_unprepare(lvds->pclk);
 
-- 
2.1.4
