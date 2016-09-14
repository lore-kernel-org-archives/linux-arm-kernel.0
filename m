From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:59 +0900
Subject: [PATCH 6/8] drm/rockchip: Do not enable vblank without event
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-7-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally we needed to enable vblank for any atomic commit to kick the
PSR machine, but that was changed and we no longer need to do so from
a vblank interrupt. Let's return to original behavior of enabling
vblank only if it is really necessary.

This essentially reverts commit 5b6804034ae9 ("drm/rockchip: Enable
vblank without event").

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index af9ddbe..bb7a865 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -116,7 +116,6 @@ struct vop {
 	struct device *dev;
 	struct drm_device *drm_dev;
 	bool is_enabled;
-	bool vblank_active;
 
 	/* mutex vsync_ work */
 	struct mutex vsync_mutex;
@@ -1135,11 +1134,10 @@ static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
 	rockchip_drm_psr_flush(crtc);
 
 	spin_lock_irq(&crtc->dev->event_lock);
-	vop->vblank_active = true;
-	WARN_ON(drm_crtc_vblank_get(crtc) != 0);
-	WARN_ON(vop->event);
-
 	if (crtc->state->event) {
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+		WARN_ON(vop->event);
+
 		vop->event = crtc->state->event;
 		crtc->state->event = NULL;
 	}
@@ -1236,12 +1234,8 @@ static void vop_handle_vblank(struct vop *vop)
 	spin_lock_irqsave(&drm->event_lock, flags);
 	if (vop->event) {
 		drm_crtc_send_vblank_event(crtc, vop->event);
-		vop->event = NULL;
-
-	}
-	if (vop->vblank_active) {
-		vop->vblank_active = false;
 		drm_crtc_vblank_put(crtc);
+		vop->event = NULL;
 	}
 	spin_unlock_irqrestore(&drm->event_lock, flags);
 
@@ -1518,7 +1512,6 @@ static int vop_initial(struct vop *vop)
 	clk_disable(vop->aclk);
 
 	vop->is_enabled = false;
-	vop->vblank_active = false;
 
 	return 0;
 
-- 
2.8.0.rc3.226.g39d4020
