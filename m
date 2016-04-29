From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 29 Apr 2016 11:57:06 +0800
Subject: [PATCH] drm/rockchip: vop: fix iommu crash with async atomic
Message-ID: <1461902226-19773-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Async atomic_commit callback, drm_atomic_clean_old_fb will
clean all old fb, but because async, the old fb may be also on
the vop hardware, dma will access the old fb buffer, clean old
fb will cause iommu page fault.

Reference the fb and unreference it when the fb actuall swap out
from vop hardware.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 28596e7..38c4de9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -560,6 +560,22 @@ static void vop_plane_destroy(struct drm_plane *plane)
 	drm_plane_cleanup(plane);
 }
 
+static int vop_plane_prepare_fb(struct drm_plane *plane,
+                                const struct drm_plane_state *new_state)
+{
+       if (plane->state->fb)
+               drm_framebuffer_reference(plane->state->fb);
+
+       return 0;
+}
+
+static void vop_plane_cleanup_fb(struct drm_plane *plane,
+                                 const struct drm_plane_state *old_state)
+{
+       if (old_state->fb)
+               drm_framebuffer_unreference(old_state->fb);
+}
+
 static int vop_plane_atomic_check(struct drm_plane *plane,
 			   struct drm_plane_state *state)
 {
@@ -756,6 +772,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 }
 
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
+	.prepare_fb = vop_plane_prepare_fb,
+	.cleanup_fb = vop_plane_cleanup_fb,
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
-- 
1.9.1
