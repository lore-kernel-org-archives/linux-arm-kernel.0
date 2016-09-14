From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:57 +0900
Subject: [PATCH 4/8] drm/rockchip: Unreference framebuffers from flip work
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-5-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver waits for vblank and then unreferences old
framebuffers from atomic commit code path. This is however breaking the
legacy cursor API, which requires the updates to be fully asynchronous.
Instead of just adding a special case for cursor, we can have actually
smaller amount of code to unreference any changed framebuffer from a
flip work.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f989440..86829f5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_flip_work.h>
 #include <drm/drm_plane_helper.h>
 
 #include <linux/kernel.h>
@@ -89,6 +90,10 @@
 #define to_vop_win(x) container_of(x, struct vop_win, base)
 #define to_vop_plane_state(x) container_of(x, struct vop_plane_state, base)
 
+enum vop_pending {
+	VOP_PENDING_FB_UNREF,
+};
+
 struct vop_plane_state {
 	struct drm_plane_state base;
 	int format;
@@ -122,6 +127,9 @@ struct vop {
 	/* protected by dev->event_lock */
 	struct drm_pending_vblank_event *event;
 
+	struct drm_flip_work fb_unref_work;
+	unsigned long pending;
+
 	struct completion line_flag_completion;
 
 	const struct vop_data *data;
@@ -1093,7 +1101,11 @@ static void vop_wait_for_irq_handler(struct vop *vop)
 static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
+	struct drm_atomic_state *old_state = old_crtc_state->state;
+	struct drm_plane_state *old_plane_state;
 	struct vop *vop = to_vop(crtc);
+	struct drm_plane *plane;
+	int i;
 
 	if (WARN_ON(!vop->is_enabled))
 		return;
@@ -1110,6 +1122,19 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	 * signalling flip completion we need to wait for it to finish.
 	 */
 	vop_wait_for_irq_handler(vop);
+
+	for_each_plane_in_state(old_state, plane, old_plane_state, i) {
+		if (!old_plane_state->fb)
+			continue;
+
+		if (old_plane_state->fb == plane->state->fb)
+			continue;
+
+		drm_framebuffer_reference(old_plane_state->fb);
+		drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
+		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+	}
 }
 
 static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -1185,6 +1210,15 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.atomic_destroy_state = vop_crtc_destroy_state,
 };
 
+static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
+{
+	struct vop *vop = container_of(work, struct vop, fb_unref_work);
+	struct drm_framebuffer *fb = val;
+
+	drm_crtc_vblank_put(&vop->crtc);
+	drm_framebuffer_unreference(fb);
+}
+
 static bool vop_win_pending_is_complete(struct vop_win *vop_win)
 {
 	dma_addr_t yrgb_mst;
@@ -1223,6 +1257,9 @@ static void vop_handle_vblank(struct vop *vop)
 
 	if (!completion_done(&vop->wait_update_complete))
 		complete(&vop->wait_update_complete);
+
+	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
+		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
 }
 
 static irqreturn_t vop_isr(int irq, void *data)
@@ -1361,6 +1398,9 @@ static int vop_create_crtc(struct vop *vop)
 		goto err_cleanup_crtc;
 	}
 
+	drm_flip_work_init(&vop->fb_unref_work, "fb_unref",
+			   vop_fb_unref_worker);
+
 	init_completion(&vop->dsp_hold_completion);
 	init_completion(&vop->wait_update_complete);
 	init_completion(&vop->line_flag_completion);
@@ -1404,6 +1444,7 @@ static void vop_destroy_crtc(struct vop *vop)
 	 * references the CRTC.
 	 */
 	drm_crtc_cleanup(crtc);
+	drm_flip_work_cleanup(&vop->fb_unref_work);
 }
 
 static int vop_initial(struct vop *vop)
-- 
2.8.0.rc3.226.g39d4020
