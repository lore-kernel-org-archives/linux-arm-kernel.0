From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 20 Apr 2016 15:00:56 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending flip
 event v4
Message-ID: <1461157257-15964-1-git-send-email-tomeu.vizoso@collabora.com>
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

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 19 ++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  6 ++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 00d17d71aa4c..02ed8b78c939 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -70,6 +70,7 @@ int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
 int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int connector_type,
 				  int out_mode);
+bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc);
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 3b8f652698f8..45cdc2859364 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -280,7 +280,24 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
 {
 	struct rockchip_drm_private *private = dev->dev_private;
 	struct rockchip_atomic_commit *commit = &private->commit;
-	int ret;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	unsigned long flags;
+	int i, ret;
+
+	if (async) {
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
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a619f120f801..82e6f145f7a2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -850,6 +850,12 @@ int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL_GPL(rockchip_drm_crtc_mode_config);
 
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
