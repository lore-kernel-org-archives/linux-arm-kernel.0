From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:58 +0900
Subject: [PATCH 5/8] drm/rockchip: Replace custom wait_for_vblanks with helper
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-6-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver uses a custom function to wait for flip to complete
after an atomic commit. It was needed before because of two problems:
 - there is no hardware vblank counter, so the original helper would
   have a race condition with the vblank interrupt,
 - the driver didn't support unreferencing cursor framebuffers
   asynchronously to the commit, which was what the helper expected.
Since both problems have been solved by previous patches, we can now
make the driver use the generic helper and remove custom waiting code.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 -
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 64 +----------------------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 -------
 3 files changed, 1 insertion(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 5c69845..fb6226c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -39,7 +39,6 @@ struct drm_connector;
 struct rockchip_crtc_funcs {
 	int (*enable_vblank)(struct drm_crtc *crtc);
 	void (*disable_vblank)(struct drm_crtc *crtc);
-	void (*wait_for_update)(struct drm_crtc *crtc);
 };
 
 struct rockchip_crtc_state {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 9890ecc..0f6eda0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -174,68 +174,6 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
 		drm_fb_helper_hotplug_event(fb_helper);
 }
 
-static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
-{
-	struct rockchip_drm_private *priv = crtc->dev->dev_private;
-	int pipe = drm_crtc_index(crtc);
-	const struct rockchip_crtc_funcs *crtc_funcs = priv->crtc_funcs[pipe];
-
-	if (crtc_funcs && crtc_funcs->wait_for_update)
-		crtc_funcs->wait_for_update(crtc);
-}
-
-/*
- * We can't use drm_atomic_helper_wait_for_vblanks() because rk3288 and rk3066
- * have hardware counters for neither vblanks nor scanlines, which results in
- * a race where:
- *				| <-- HW vsync irq and reg take effect
- *	       plane_commit --> |
- *	get_vblank and wait --> |
- *				| <-- handle_vblank, vblank->count + 1
- *		 cleanup_fb --> |
- *		iommu crash --> |
- *				| <-- HW vsync irq and reg take effect
- *
- * This function is equivalent but uses rockchip_crtc_wait_for_update() instead
- * of waiting for vblank_count to change.
- */
-static void
-rockchip_atomic_wait_for_complete(struct drm_device *dev, struct drm_atomic_state *old_state)
-{
-	struct drm_crtc_state *old_crtc_state;
-	struct drm_crtc *crtc;
-	int i, ret;
-
-	for_each_crtc_in_state(old_state, crtc, old_crtc_state, i) {
-		/* No one cares about the old state, so abuse it for tracking
-		 * and store whether we hold a vblank reference (and should do a
-		 * vblank wait) in the ->enable boolean.
-		 */
-		old_crtc_state->enable = false;
-
-		if (!crtc->state->active)
-			continue;
-
-		if (!drm_atomic_helper_framebuffer_changed(dev,
-				old_state, crtc))
-			continue;
-
-		ret = drm_crtc_vblank_get(crtc);
-		if (ret != 0)
-			continue;
-
-		old_crtc_state->enable = true;
-	}
-
-	for_each_crtc_in_state(old_state, crtc, old_crtc_state, i) {
-		if (!old_crtc_state->enable)
-			continue;
-
-		rockchip_crtc_wait_for_update(crtc);
-		drm_crtc_vblank_put(crtc);
-	}
-}
-
 static void
 rockchip_atomic_commit_tail(struct drm_atomic_state *state)
 {
@@ -250,7 +188,7 @@ rockchip_atomic_commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_commit_hw_done(state);
 
-	rockchip_atomic_wait_for_complete(dev, state);
+	drm_atomic_helper_wait_for_vblanks(dev, state);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 86829f5..af9ddbe 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -122,7 +122,6 @@ struct vop {
 	struct mutex vsync_mutex;
 	bool vsync_work_pending;
 	struct completion dsp_hold_completion;
-	struct completion wait_update_complete;
 
 	/* protected by dev->event_lock */
 	struct drm_pending_vblank_event *event;
@@ -937,18 +936,9 @@ static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
-static void vop_crtc_wait_for_update(struct drm_crtc *crtc)
-{
-	struct vop *vop = to_vop(crtc);
-
-	reinit_completion(&vop->wait_update_complete);
-	WARN_ON(!wait_for_completion_timeout(&vop->wait_update_complete, 100));
-}
-
 static const struct rockchip_crtc_funcs private_crtc_funcs = {
 	.enable_vblank = vop_crtc_enable_vblank,
 	.disable_vblank = vop_crtc_disable_vblank,
-	.wait_for_update = vop_crtc_wait_for_update,
 };
 
 static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -1255,9 +1245,6 @@ static void vop_handle_vblank(struct vop *vop)
 	}
 	spin_unlock_irqrestore(&drm->event_lock, flags);
 
-	if (!completion_done(&vop->wait_update_complete))
-		complete(&vop->wait_update_complete);
-
 	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
 		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
 }
@@ -1402,7 +1389,6 @@ static int vop_create_crtc(struct vop *vop)
 			   vop_fb_unref_worker);
 
 	init_completion(&vop->dsp_hold_completion);
-	init_completion(&vop->wait_update_complete);
 	init_completion(&vop->line_flag_completion);
 	crtc->port = port;
 	rockchip_register_crtc_funcs(crtc, &private_crtc_funcs);
-- 
2.8.0.rc3.226.g39d4020
