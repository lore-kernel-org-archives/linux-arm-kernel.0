From: seanpaul@chromium.org (Sean Paul)
Date: Mon,  6 Mar 2017 15:27:14 -0500
Subject: [PATCH 2/3] drm/rockchip: Fix link error when CONFIG_DRM_ANALOGIX_DP
 undefined
In-Reply-To: <20170306202722.9301-1-seanpaul@chromium.org>
References: <20170306202722.9301-1-seanpaul@chromium.org>
Message-ID: <20170306202722.9301-3-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following link error when CONFIG_DRM_ANALOGIX_DP is not defined:

ERROR: "analogix_dp_start_crc" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
ERROR: "analogix_dp_stop_crc" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

Fixes: 3190e58dafaf ("drm/rockchip: Implement CRC debugfs API")
Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 17ab16c4b922..2151e1cee4b4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -19,7 +19,9 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_flip_work.h>
 #include <drm/drm_plane_helper.h>
+#ifdef CONFIG_DRM_ANALOGIX_DP
 #include <drm/bridge/analogix_dp.h>
+#endif
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1112,6 +1114,7 @@ static void vop_crtc_destroy_state(struct drm_crtc *crtc,
 	kfree(s);
 }
 
+#ifdef CONFIG_DRM_ANALOGIX_DP
 static struct drm_connector *vop_get_edp_connector(struct vop *vop)
 {
 	struct drm_crtc *crtc = &vop->crtc;
@@ -1150,6 +1153,13 @@ static int vop_crtc_set_crc_source(struct drm_crtc *crtc,
 
 	return ret;
 }
+#else
+static int vop_crtc_set_crc_source(struct drm_crtc *crtc,
+				   const char *source_name, size_t *values_cnt)
+{
+	return -ENODEV;
+}
+#endif
 
 static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
-- 
2.12.0.rc1.440.g5b76565f74-goog
