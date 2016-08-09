From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  9 Aug 2016 12:51:36 +0200
Subject: [PATCH v1 5/5] drm/rockchip: Implement CRC debugfs API
In-Reply-To: <1470739896-11088-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1470739896-11088-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1470739896-11088-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the .set_crc_source() callback and call the DP helpers
accordingly to start and stop CRC capture.

This is only done if this CRTC is currently using the eDP connector.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 91305eb7d312..25f2e7b72982 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -18,6 +18,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/bridge/analogix_dp.h>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1084,6 +1085,52 @@ static void vop_crtc_destroy_state(struct drm_crtc *crtc,
 	kfree(s);
 }
 
+static struct drm_connector *vop_get_edp_connector(struct vop *vop)
+{
+	struct drm_crtc *crtc = &vop->crtc;
+	struct drm_connector *connector;
+
+	mutex_lock(&crtc->dev->mode_config.mutex);
+	drm_for_each_connector(connector, crtc->dev)
+		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+			mutex_unlock(&crtc->dev->mode_config.mutex);
+			return connector;
+		}
+	mutex_unlock(&crtc->dev->mode_config.mutex);
+
+	return NULL;
+}
+
+static int vop_crtc_set_crc_source(struct drm_crtc *crtc,
+				   const char *source_name, size_t *values_cnt)
+{
+	struct vop *vop = to_vop(crtc);
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
+	struct drm_connector *connector;
+	int ret;
+
+	connector = vop_get_edp_connector(vop);
+	if (!connector)
+		return -EINVAL;
+
+	*values_cnt = 3;
+
+	if (source_name &&
+	    strcmp(source_name, "auto") == 0) {
+
+		if (s->output_type != DRM_MODE_CONNECTOR_eDP)
+			return -EINVAL;
+
+		ret = analogix_dp_start_crc(connector);
+	} else if (!source_name)
+
+		ret = analogix_dp_stop_crc(connector);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
@@ -1091,6 +1138,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.reset = vop_crtc_reset,
 	.atomic_duplicate_state = vop_crtc_duplicate_state,
 	.atomic_destroy_state = vop_crtc_destroy_state,
+	.set_crc_source = vop_crtc_set_crc_source,
 };
 
 static bool vop_win_pending_is_complete(struct vop_win *vop_win)
-- 
2.7.4
