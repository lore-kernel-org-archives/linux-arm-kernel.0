From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  4 Apr 2016 15:55:34 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending flip
 event v3
Message-ID: <1459778134-30693-1-git-send-email-tomeu.vizoso@collabora.com>
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

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 13 ++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3529f692edb8..37952eefd33d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -69,6 +69,7 @@ int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
 int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int connector_type,
 				  int out_mode);
+bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc);
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 3b8f652698f8..8305bbd2a4d7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -280,7 +280,18 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
 {
 	struct rockchip_drm_private *private = dev->dev_private;
 	struct rockchip_atomic_commit *commit = &private->commit;
-	int ret;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int i, ret;
+
+	if (async) {
+		for_each_crtc_in_state(state, crtc, crtc_state, i) {
+			if (crtc->state->event ||
+			    rockchip_drm_crtc_has_pending_event(crtc)) {
+				return -EBUSY;
+			}
+		}
+	}
 
 	ret = drm_atomic_helper_prepare_planes(dev, state);
 	if (ret)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e2118e62345b..5bcdd8dc7499 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -848,6 +848,11 @@ int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL_GPL(rockchip_drm_crtc_mode_config);
 
+bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc)
+{
+	return to_vop(crtc)->event;
+}
+
 static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
-- 
2.5.5
