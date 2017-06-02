From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 2 Jun 2017 16:37:10 +0200
Subject: [PATCH v3 1/6] drm/stm: ltdc: Add panel-bridge support
In-Reply-To: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1496414235-20098-2-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the panel-bridge support for both panels & bridges (used by DSI host &
HDMI/LVDS bridges).

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/Kconfig |   2 +-
 drivers/gpu/drm/stm/ltdc.c  | 208 +++++++-------------------------------------
 drivers/gpu/drm/stm/ltdc.h  |   2 +-
 3 files changed, 35 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
index 2c4817f..4b88223 100644
--- a/drivers/gpu/drm/stm/Kconfig
+++ b/drivers/gpu/drm/stm/Kconfig
@@ -4,7 +4,7 @@ config DRM_STM
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
-	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
 	select FB_PROVIDE_GET_FB_UNMAPPED_AREA
 	default y
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 700cc08..a962a09 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -21,7 +21,7 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_plane_helper.h>
 
 #include <video/videomode.h>
@@ -269,11 +269,6 @@ static inline struct ltdc_device *encoder_to_ltdc(struct drm_encoder *enc)
 	return (struct ltdc_device *)enc->dev->dev_private;
 }
 
-static inline struct ltdc_device *connector_to_ltdc(struct drm_connector *con)
-{
-	return (struct ltdc_device *)con->dev->dev_private;
-}
-
 static inline enum ltdc_pix_fmt to_ltdc_pixelformat(u32 drm_fmt)
 {
 	enum ltdc_pix_fmt pf;
@@ -813,130 +808,37 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
  * DRM_ENCODER
  */
 
-static void ltdc_rgb_encoder_enable(struct drm_encoder *encoder)
-{
-	struct ltdc_device *ldev = encoder_to_ltdc(encoder);
-
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_panel_prepare(ldev->panel);
-	drm_panel_enable(ldev->panel);
-}
-
-static void ltdc_rgb_encoder_disable(struct drm_encoder *encoder)
-{
-	struct ltdc_device *ldev = encoder_to_ltdc(encoder);
-
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_panel_disable(ldev->panel);
-	drm_panel_unprepare(ldev->panel);
-}
-
-static const struct drm_encoder_helper_funcs ltdc_rgb_encoder_helper_funcs = {
-	.enable = ltdc_rgb_encoder_enable,
-	.disable = ltdc_rgb_encoder_disable,
-};
-
-static const struct drm_encoder_funcs ltdc_rgb_encoder_funcs = {
+static const struct drm_encoder_funcs ltdc_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
-static struct drm_encoder *ltdc_rgb_encoder_create(struct drm_device *ddev)
+static int ltdc_encoder_init(struct drm_device *ddev)
 {
+	struct ltdc_device *ldev = ddev->dev_private;
 	struct drm_encoder *encoder;
+	int ret;
 
 	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
 	if (!encoder)
-		return NULL;
+		return -ENOMEM;
 
 	encoder->possible_crtcs = CRTC_MASK;
 	encoder->possible_clones = 0; /* No cloning support */
 
-	drm_encoder_init(ddev, encoder, &ltdc_rgb_encoder_funcs,
+	drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
 			 DRM_MODE_ENCODER_DPI, NULL);
 
-	drm_encoder_helper_add(encoder, &ltdc_rgb_encoder_helper_funcs);
-
-	DRM_DEBUG_DRIVER("RGB encoder:%d created\n", encoder->base.id);
-
-	return encoder;
-}
-
-/*
- * DRM_CONNECTOR
- */
-
-static int ltdc_rgb_connector_get_modes(struct drm_connector *connector)
-{
-	struct drm_device *ddev = connector->dev;
-	struct ltdc_device *ldev = ddev->dev_private;
-	int ret = 0;
-
-	DRM_DEBUG_DRIVER("\n");
-
-	if (ldev->panel)
-		ret = drm_panel_get_modes(ldev->panel);
-
-	return ret < 0 ? 0 : ret;
-}
-
-static struct drm_connector_helper_funcs ltdc_rgb_connector_helper_funcs = {
-	.get_modes = ltdc_rgb_connector_get_modes,
-};
-
-static enum drm_connector_status
-ltdc_rgb_connector_detect(struct drm_connector *connector, bool force)
-{
-	struct ltdc_device *ldev = connector_to_ltdc(connector);
-
-	return ldev->panel ? connector_status_connected :
-	       connector_status_disconnected;
-}
-
-static void ltdc_rgb_connector_destroy(struct drm_connector *connector)
-{
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_connector_unregister(connector);
-	drm_connector_cleanup(connector);
-}
-
-static const struct drm_connector_funcs ltdc_rgb_connector_funcs = {
-	.dpms = drm_atomic_helper_connector_dpms,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.detect = ltdc_rgb_connector_detect,
-	.destroy = ltdc_rgb_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
-struct drm_connector *ltdc_rgb_connector_create(struct drm_device *ddev)
-{
-	struct drm_connector *connector;
-	int err;
-
-	connector = devm_kzalloc(ddev->dev, sizeof(*connector), GFP_KERNEL);
-	if (!connector) {
-		DRM_ERROR("Failed to allocate connector\n");
-		return NULL;
-	}
-
-	connector->polled = DRM_CONNECTOR_POLL_HPD;
+	drm_encoder_helper_add(encoder, NULL);
 
-	err = drm_connector_init(ddev, connector, &ltdc_rgb_connector_funcs,
-				 DRM_MODE_CONNECTOR_DPI);
-	if (err) {
-		DRM_ERROR("Failed to initialize connector\n");
-		return NULL;
+	ret = drm_bridge_attach(encoder, ldev->bridge, NULL);
+	if (ret) {
+		drm_encoder_cleanup(encoder);
+		return -EINVAL;
 	}
 
-	drm_connector_helper_add(connector, &ltdc_rgb_connector_helper_funcs);
-
-	DRM_DEBUG_DRIVER("RGB connector:%d created\n", connector->base.id);
+	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
 
-	return connector;
+	return 0;
 }
 
 static int ltdc_get_caps(struct drm_device *ddev)
@@ -972,49 +874,14 @@ static int ltdc_get_caps(struct drm_device *ddev)
 	return 0;
 }
 
-static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
-{
-	struct device *dev = ddev->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *entity, *port = NULL;
-	struct drm_panel *panel = NULL;
-
-	DRM_DEBUG_DRIVER("\n");
-
-	/*
-	 * Parse ltdc node to get remote port and find RGB panel / HDMI slave
-	 * If a dsi or a bridge (hdmi, lvds...) is connected to ltdc,
-	 * a remote port & RGB panel will not be found.
-	 */
-	for_each_endpoint_of_node(np, entity) {
-		if (!of_device_is_available(entity))
-			continue;
-
-		port = of_graph_get_remote_port_parent(entity);
-		if (port) {
-			panel = of_drm_find_panel(port);
-			of_node_put(port);
-			if (panel) {
-				DRM_DEBUG_DRIVER("remote panel %s\n",
-						 port->full_name);
-			} else {
-				DRM_DEBUG_DRIVER("panel missing\n");
-				of_node_put(entity);
-			}
-		}
-	}
-
-	return panel;
-}
-
 int ltdc_load(struct drm_device *ddev)
 {
 	struct platform_device *pdev = to_platform_device(ddev->dev);
 	struct ltdc_device *ldev = ddev->dev_private;
 	struct device *dev = ddev->dev;
 	struct device_node *np = dev->of_node;
-	struct drm_encoder *encoder;
-	struct drm_connector *connector = NULL;
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
 	struct drm_crtc *crtc;
 	struct reset_control *rstc;
 	struct resource res;
@@ -1022,9 +889,9 @@ int ltdc_load(struct drm_device *ddev)
 
 	DRM_DEBUG_DRIVER("\n");
 
-	ldev->panel = ltdc_get_panel(ddev);
-	if (!ldev->panel)
-		return -EPROBE_DEFER;
+	ret = drm_of_find_panel_or_bridge(np, 0, 0, &panel, &bridge);
+	if (ret)
+		return ret;
 
 	rstc = of_reset_control_get(np, NULL);
 
@@ -1082,28 +949,20 @@ int ltdc_load(struct drm_device *ddev)
 
 	DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
 
-	if (ldev->panel) {
-		encoder = ltdc_rgb_encoder_create(ddev);
-		if (!encoder) {
-			DRM_ERROR("Failed to create RGB encoder\n");
-			ret = -EINVAL;
-			goto err;
+	if (panel) {
+		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DPI);
+		if (IS_ERR(bridge)) {
+			DRM_ERROR("Failed to create panel-bridge\n");
+			return PTR_ERR(bridge);
 		}
+	}
 
-		connector = ltdc_rgb_connector_create(ddev);
-		if (!connector) {
-			DRM_ERROR("Failed to create RGB connector\n");
-			ret = -EINVAL;
-			goto err;
-		}
+	ldev->bridge = bridge;
 
-		ret = drm_mode_connector_attach_encoder(connector, encoder);
-		if (ret) {
-			DRM_ERROR("Failed to attach connector to encoder\n");
-			goto err;
-		}
-
-		drm_panel_attach(ldev->panel, connector);
+	ret = ltdc_encoder_init(ddev);
+	if (ret) {
+		DRM_ERROR("Failed to init encoder\n");
+		goto err;
 	}
 
 	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
@@ -1129,9 +988,9 @@ int ltdc_load(struct drm_device *ddev)
 	ddev->irq_enabled = 1;
 
 	return 0;
+
 err:
-	if (ldev->panel)
-		drm_panel_detach(ldev->panel);
+	drm_panel_bridge_remove(bridge);
 
 	clk_disable_unprepare(ldev->pixel_clk);
 
@@ -1146,8 +1005,7 @@ void ltdc_unload(struct drm_device *ddev)
 
 	drm_vblank_cleanup(ddev);
 
-	if (ldev->panel)
-		drm_panel_detach(ldev->panel);
+	drm_panel_bridge_remove(ldev->bridge);
 
 	clk_disable_unprepare(ldev->pixel_clk);
 }
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index d7a9c73..d78cb0d 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -24,7 +24,7 @@ struct ltdc_device {
 	struct drm_fbdev_cma *fbdev;
 	void __iomem *regs;
 	struct clk *pixel_clk;	/* lcd pixel clock */
-	struct drm_panel *panel;
+	struct drm_bridge *bridge;
 	struct mutex err_lock;	/* protecting error_status */
 	struct ltdc_caps caps;
 	u32 clut[256];		/* color look up table */
-- 
1.9.1
