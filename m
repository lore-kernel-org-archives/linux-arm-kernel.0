From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:32:59 +0100
Subject: [PATCH 06/11] drm/rockchip: lvds: register a bridge when no panel is
 set
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-7-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On socs using the lvds components it also controls the use of the
general rgb outputs and must thus be configured for things like
external encoders.

Therefore register a drm_bridge in this case, an encoder can attach to.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/video/rockchip-lvds.txt    |   8 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           | 167 ++++++++++++++++++---
 2 files changed, 153 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/rockchip-lvds.txt b/Documentation/devicetree/bindings/video/rockchip-lvds.txt
index 1616d7e..6ab69b4 100644
--- a/Documentation/devicetree/bindings/video/rockchip-lvds.txt
+++ b/Documentation/devicetree/bindings/video/rockchip-lvds.txt
@@ -15,8 +15,6 @@ Required properties:
 - avdd3v3-supply: regulator phandle for 3.3V analog power
 
 - rockchip,grf: phandle to the general register files syscon
-- rockchip,panel: phandle to a panel node as described by
-	Documentation/devicetree/bindings/panel/*
 
 - rockchip,data-mapping: should be "vesa" or "jeida",
 	This describes how the color bits are laid out in the
@@ -28,6 +26,12 @@ Required properties:
 - ports: contain a port node with endpoint definitions as defined in
 	Documentation/devicetree/bindings/media/video-interfaces.txt.
 
+Optional properties:
+- rockchip,panel: phandle to a panel node as described by
+	Documentation/devicetree/bindings/panel/*
+	If no panel reference is set the lvds will act like a
+	bridge for other outbound interfaces.
+
 Example:
 	lvds: lvds at ff96c000 {
 		compatible = "rockchip,rk3288-lvds";
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index a01a3cb..46308fb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -42,6 +42,9 @@
 #define encoder_to_lvds(c) \
 		container_of(c, struct rockchip_lvds, encoder)
 
+#define bridge_to_lvds(c) \
+		container_of(c, struct rockchip_lvds, bridge)
+
 /*
  * @grf_offset: offset inside the grf regmap for setting the rockchip lvds
  */
@@ -67,6 +70,7 @@ struct rockchip_lvds {
 	struct drm_panel *panel;
 	struct drm_connector connector;
 	struct drm_encoder encoder;
+	struct drm_bridge bridge;
 
 	struct mutex suspend_lock;
 	int suspend;
@@ -247,11 +251,10 @@ rockchip_lvds_encoder_mode_fixup(struct drm_encoder *encoder,
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
@@ -346,32 +349,52 @@ static void rockchip_lvds_encoder_mode_set(struct drm_encoder *encoder,
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
@@ -404,6 +427,97 @@ static struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
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
+ * post_disable is alled right after encoder prepare, so do lvds and crtc
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
@@ -525,9 +639,20 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 		lvds->panel = panel;
 	} else {
-		dev_err(&pdev->dev, "no panel node found\n");
-		ret = -EINVAL;
-		goto err_unprepare_pclk;
+		/*
+		 * When no panel is found, register a bridge instead.
+		 * We expect the code handling external encoders to
+		 * connect encoder and bridge.
+		 */
+		lvds->bridge.funcs = &rockchip_lvds_bridge_funcs;
+		lvds->bridge.of_node = dev->of_node;
+		ret = drm_bridge_add(&lvds->bridge);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add bridge %d\n", ret);
+			goto err_unprepare_pclk;
+		}
+
+		return 0;
 	}
 
 	encoder = &lvds->encoder;
@@ -592,6 +717,8 @@ static void rockchip_lvds_unbind(struct device *dev, struct device *master,
 
 		drm_connector_cleanup(&lvds->connector);
 		drm_encoder_cleanup(&lvds->encoder);
+	} else {
+		drm_bridge_remove(&lvds->bridge);
 	}
 
 	clk_unprepare(lvds->pclk);
-- 
2.1.1
