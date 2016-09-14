From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:55:00 +0900
Subject: [PATCH 7/8] drm/rockchip: Always signal event in next vblank after
 cfg_done
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-8-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the driver send the pending vblank event in next vblank
following the commit, relying on vblank signalling improvements done in
previous patches. This gives us vblank events that always represent the
real moment of changes hitting on the screen (which was the case only
for complete FB changes before) and lets us remove the manual window
update check.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 54 ++++++-----------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index bb7a865..cacdffb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -105,10 +105,6 @@ struct vop_win {
 	struct drm_plane base;
 	const struct vop_win_data *data;
 	struct vop *vop;
-
-	/* protected by dev->event_lock */
-	bool enable;
-	dma_addr_t yrgb_mst;
 };
 
 struct vop {
@@ -716,11 +712,6 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 	if (!old_state->crtc)
 		return;
 
-	spin_lock_irq(&plane->dev->event_lock);
-	vop_win->enable = false;
-	vop_win->yrgb_mst = 0;
-	spin_unlock_irq(&plane->dev->event_lock);
-
 	spin_lock(&vop->reg_lock);
 
 	VOP_WIN_SET(vop, win, enable, 0);
@@ -784,11 +775,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	offset += (src->y1 >> 16) * fb->pitches[0];
 	vop_plane_state->yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
 
-	spin_lock_irq(&plane->dev->event_lock);
-	vop_win->enable = true;
-	vop_win->yrgb_mst = vop_plane_state->yrgb_mst;
-	spin_unlock_irq(&plane->dev->event_lock);
-
 	spin_lock(&vop->reg_lock);
 
 	VOP_WIN_SET(vop, win, format, vop_plane_state->format);
@@ -1112,6 +1098,16 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	 */
 	vop_wait_for_irq_handler(vop);
 
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (crtc->state->event) {
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+		WARN_ON(vop->event);
+
+		vop->event = crtc->state->event;
+		crtc->state->event = NULL;
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+
 	for_each_plane_in_state(old_state, plane, old_plane_state, i) {
 		if (!old_plane_state->fb)
 			continue;
@@ -1129,19 +1125,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
-	struct vop *vop = to_vop(crtc);
-
 	rockchip_drm_psr_flush(crtc);
-
-	spin_lock_irq(&crtc->dev->event_lock);
-	if (crtc->state->event) {
-		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
-		WARN_ON(vop->event);
-
-		vop->event = crtc->state->event;
-		crtc->state->event = NULL;
-	}
-	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
@@ -1207,29 +1191,11 @@ static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
 	drm_framebuffer_unreference(fb);
 }
 
-static bool vop_win_pending_is_complete(struct vop_win *vop_win)
-{
-	dma_addr_t yrgb_mst;
-
-	if (!vop_win->enable)
-		return VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0;
-
-	yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win->data);
-
-	return yrgb_mst == vop_win->yrgb_mst;
-}
-
 static void vop_handle_vblank(struct vop *vop)
 {
 	struct drm_device *drm = vop->drm_dev;
 	struct drm_crtc *crtc = &vop->crtc;
 	unsigned long flags;
-	int i;
-
-	for (i = 0; i < vop->data->win_size; i++) {
-		if (!vop_win_pending_is_complete(&vop->win[i]))
-			return;
-	}
 
 	spin_lock_irqsave(&drm->event_lock, flags);
 	if (vop->event) {
-- 
2.8.0.rc3.226.g39d4020
