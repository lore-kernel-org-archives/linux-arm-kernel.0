From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 24 May 2016 09:27:37 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending flip
 event v5
In-Reply-To: <1464074761-5194-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1464074761-5194-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1464074857-5515-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
updated is requested and there is an earlier updated pending".

v2: Use the status of the workqueue instead of vop->event, and don't add
a superfluous wait on the workqueue.

v3: Drop work_busy, as there's a sizeable delay when the worker
finishes, which introduces a race in which the client has already
received the last flip event but the next page flip ioctl will still
return -EBUSY because work_busy returns outdated information.

v4: Hold dev->event_lock while checking the VOP's event field as
suggested by Daniel Stone.

v5: Only block if there's outstanding work if it's a blocking call.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 25 ++++++++++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  6 ++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 56f43a364c7f..0b46617decd9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -76,6 +76,7 @@ void rockchip_drm_atomic_work(struct work_struct *work);
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 				 const struct rockchip_crtc_funcs *crtc_funcs);
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
+bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc);
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 755cfdba61cd..e9531353b8d2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -279,15 +279,34 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
 {
 	struct rockchip_drm_private *private = dev->dev_private;
 	struct rockchip_atomic_commit *commit = &private->commit;
-	int ret;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	unsigned long flags;
+	int i, ret;
+
+	if (nonblock) {
+		for_each_crtc_in_state(state, crtc, crtc_state, i) {
+			spin_lock_irqsave(&dev->event_lock, flags);
+
+			if (crtc->state->event ||
+			    rockchip_drm_crtc_has_pending_event(crtc)) {
+				spin_unlock_irqrestore(&dev->event_lock, flags);
+				return -EBUSY;
+			}
+
+			spin_unlock_irqrestore(&dev->event_lock, flags);
+		}
+	}
 
 	ret = drm_atomic_helper_prepare_planes(dev, state);
 	if (ret)
 		return ret;
 
-	/* serialize outstanding nonblocking commits */
 	mutex_lock(&commit->lock);
-	flush_work(&commit->work);
+
+	/* serialize outstanding nonblocking commits */
+	if (!nonblock)
+		flush_work(&commit->work);
 
 	drm_atomic_helper_swap_state(dev, state);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1c4d5b5a70a2..3f980f52c640 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -836,6 +836,12 @@ static const struct drm_plane_funcs vop_plane_funcs = {
 	.atomic_destroy_state = vop_atomic_plane_destroy_state,
 };
 
+bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc)
+{
+	assert_spin_locked(&crtc->dev->event_lock);
+	return to_vop(crtc)->event;
+}
+
 static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
-- 
2.5.5
