From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri,  3 Mar 2017 14:39:36 +0100
Subject: [PATCH v6 4/4] drm/rockchip: Implement CRC debugfs API
In-Reply-To: <20170303133936.14964-1-tomeu.vizoso@collabora.com>
References: <20170303133936.14964-1-tomeu.vizoso@collabora.com>
Message-ID: <20170303133936.14964-5-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the .set_crc_source() callback and call the DP helpers
accordingly to start and stop CRC capture.

This is only done if this CRTC is currently using the eDP connector.

v3: Remove superfluous check on rockchip_crtc_state->output_type

v6: Remove superfluous variable

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 94d7b7327ff7..17ab16c4b922 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -19,6 +19,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_flip_work.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/bridge/analogix_dp.h>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1111,6 +1112,45 @@ static void vop_crtc_destroy_state(struct drm_crtc *crtc,
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
+	struct drm_connector *connector;
+	int ret;
+
+	connector = vop_get_edp_connector(vop);
+	if (!connector)
+		return -EINVAL;
+
+	*values_cnt = 3;
+
+	if (source_name && strcmp(source_name, "auto") == 0)
+		ret = analogix_dp_start_crc(connector);
+	else if (!source_name)
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
@@ -1120,6 +1160,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.atomic_destroy_state = vop_crtc_destroy_state,
 	.enable_vblank = vop_crtc_enable_vblank,
 	.disable_vblank = vop_crtc_disable_vblank,
+	.set_crc_source = vop_crtc_set_crc_source,
 };
 
 static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
-- 
2.9.3
