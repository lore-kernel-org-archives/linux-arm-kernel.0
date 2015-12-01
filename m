From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  1 Dec 2015 16:17:54 +0800
Subject: [PATCH] drm: bridge/dw_hdmi: add atomic API support
In-Reply-To: <1448940953-23604-1-git-send-email-mark.yao@rock-chips.com>
References: <1448940953-23604-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1448957874-381-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fill atomic needed funcs with default atomic helper library.

Rockchip use dw_hdmi, and drm/rockchip will covert to atomic api,
we need dw_hdmi support atomic funcs.

Now another drm driver use dw_hdmi is imx, not yet atomic, so
check DRIVER_ATOMIC at runtime to spilt atomic and not atomic.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/bridge/dw_hdmi.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 56de9f1..dc0bdd4 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -22,6 +22,7 @@
 
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
@@ -1522,6 +1523,17 @@ static struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.force = dw_hdmi_connector_force,
 };
 
+static struct drm_connector_funcs dw_hdmi_atomic_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = dw_hdmi_connector_detect,
+	.destroy = dw_hdmi_connector_destroy,
+	.force = dw_hdmi_connector_force,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
 static struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
 	.get_modes = dw_hdmi_connector_get_modes,
 	.mode_valid = dw_hdmi_connector_mode_valid,
@@ -1645,8 +1657,15 @@ static int dw_hdmi_register(struct drm_device *drm, struct dw_hdmi *hdmi)
 
 	drm_connector_helper_add(&hdmi->connector,
 				 &dw_hdmi_connector_helper_funcs);
-	drm_connector_init(drm, &hdmi->connector, &dw_hdmi_connector_funcs,
-			   DRM_MODE_CONNECTOR_HDMIA);
+
+	if (drm_core_check_feature(drm, DRIVER_ATOMIC))
+		drm_connector_init(drm, &hdmi->connector,
+				   &dw_hdmi_atomic_connector_funcs,
+				   DRM_MODE_CONNECTOR_HDMIA);
+	else
+		drm_connector_init(drm, &hdmi->connector,
+				   &dw_hdmi_connector_funcs,
+				   DRM_MODE_CONNECTOR_HDMIA);
 
 	hdmi->connector.encoder = encoder;
 
-- 
1.7.9.5
