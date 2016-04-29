From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 29 Apr 2016 15:48:54 +0800
Subject: [PATCH v2] drm/rockchip: vop: fix iommu crash with async atomic
Message-ID: <1461916134-24156-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After async atomic_commit callback, drm_atomic_clean_old_fb will
cleanup all old fb, but because async, the old fb may be also on
the vop hardware, dma will access the old fb buffer, clean old
fb will cause iommu page fault.

Fix the problem by reference the fb and unreference it when the fb
actually swap out from vop hardware.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v2:
- fix some format problem.

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 28596e7..8652bb1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -560,6 +560,22 @@ static void vop_plane_destroy(struct drm_plane *plane)
 	drm_plane_cleanup(plane);
 }
 
+static int vop_plane_prepare_fb(struct drm_plane *plane,
+				const struct drm_plane_state *new_state)
+{
+	if (plane->state->fb)
+		drm_framebuffer_reference(plane->state->fb);
+
+	return 0;
+}
+
+static void vop_plane_cleanup_fb(struct drm_plane *plane,
+				 const struct drm_plane_state *old_state)
+{
+	if (old_state->fb)
+		drm_framebuffer_unreference(old_state->fb);
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
