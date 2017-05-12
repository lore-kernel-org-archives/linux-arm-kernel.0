From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 12 May 2017 16:56:27 +0200
Subject: [PATCH v1 1/3] drm/stm: ltdc: Add bridge support
In-Reply-To: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
References: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1494600989-13507-2-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the bridge support, used by DSI host and HDMI/LVDS bridges.

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 82 +++++++++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/stm/ltdc.h |  1 +
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 7b2d63b..b0d1fba 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -858,6 +858,43 @@ static struct drm_encoder *ltdc_rgb_encoder_create(struct drm_device *ddev)
 	return encoder;
 }
 
+static const struct drm_encoder_funcs bridge_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+struct drm_encoder *bridge_encoder_create(struct drm_device *ddev,
+					  struct drm_bridge *bridge)
+{
+	struct drm_encoder *encoder;
+	int ret;
+
+	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
+	if (!encoder)
+		return NULL;
+
+	encoder->possible_crtcs = CRTC_MASK;
+	encoder->possible_clones = 0; /* No cloning support */
+
+	drm_encoder_init(ddev, encoder, &bridge_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
+
+	drm_encoder_helper_add(encoder, NULL);
+
+	/* Link drm_bridge to encoder */
+	bridge->encoder = encoder;
+	encoder->bridge = bridge;
+
+	ret = drm_bridge_attach(encoder, bridge, NULL);
+	if (ret) {
+		drm_encoder_cleanup(encoder);
+		return NULL;
+	}
+
+	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
+
+	return encoder;
+}
+
 /*
  * DRM_CONNECTOR
  */
@@ -967,12 +1004,12 @@ static int ltdc_get_caps(struct drm_device *ddev)
 	return 0;
 }
 
-static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
+static int ltdc_parse_dt(struct drm_device *ddev)
 {
+	struct ltdc_device *ldev = ddev->dev_private;
 	struct device *dev = ddev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *entity, *port = NULL;
-	struct drm_panel *panel = NULL;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -987,19 +1024,36 @@ static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
 
 		port = of_graph_get_remote_port_parent(entity);
 		if (port) {
+			struct drm_bridge *bridge;
+			struct drm_panel *panel;
+
+			bridge = of_drm_find_bridge(port);
 			panel = of_drm_find_panel(port);
-			of_node_put(port);
+			if (!bridge && !panel) {
+				of_node_put(entity);
+				return -EPROBE_DEFER;
+			}
+
+			if (bridge) {
+				if (!ldev->bridge) {
+					ldev->bridge = bridge;
+					DRM_INFO("remote bridge %s\n",
+						 port->full_name);
+				}
+			}
+
 			if (panel) {
-				DRM_DEBUG_DRIVER("remote panel %s\n",
+				if (!ldev->panel) {
+					ldev->panel = panel;
+					DRM_INFO("remote panel %s\n",
 						 port->full_name);
-			} else {
-				DRM_DEBUG_DRIVER("panel missing\n");
-				of_node_put(entity);
+				}
 			}
+			of_node_put(port);
 		}
 	}
 
-	return panel;
+	return 0;
 }
 
 int ltdc_load(struct drm_device *ddev)
@@ -1017,9 +1071,9 @@ int ltdc_load(struct drm_device *ddev)
 
 	DRM_DEBUG_DRIVER("\n");
 
-	ldev->panel = ltdc_get_panel(ddev);
-	if (!ldev->panel)
-		return -EPROBE_DEFER;
+	ret = ltdc_parse_dt(ddev);
+	if (ret)
+		return ret;
 
 	rstc = of_reset_control_get(np, NULL);
 
@@ -1077,6 +1131,12 @@ int ltdc_load(struct drm_device *ddev)
 
 	DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
 
+	if (ldev->bridge) {
+		encoder = bridge_encoder_create(ddev, ldev->bridge);
+		if (!encoder)
+			return -EINVAL;
+	}
+
 	if (ldev->panel) {
 		encoder = ltdc_rgb_encoder_create(ddev);
 		if (!encoder) {
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index 5427ef4..0083cad 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -25,6 +25,7 @@ struct ltdc_device {
 	void __iomem *regs;
 	struct clk *pixel_clk;	/* lcd pixel clock */
 	struct drm_panel *panel;
+	struct drm_bridge *bridge;
 	struct spinlock lock;	/* protecting irq status register */
 	struct ltdc_caps caps;
 	u32 clut[256];		/* color look up table */
-- 
1.9.1
