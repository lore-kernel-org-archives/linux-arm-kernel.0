From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:01:08 +0800
Subject: [PATCH v3 1/8] drm/rockchip: Use new vblank api drm_crtc_vblank_*
In-Reply-To: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
References: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450321275-31154-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional update, drm_vblank_* is the legacy version of
drm_crtc_vblank_*. and use new api make driver more clean.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   13 +++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |    7 +++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   24 +++++++++++-------------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f22e1e1..cfd9b83 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -64,11 +64,11 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 }
 EXPORT_SYMBOL_GPL(rockchip_drm_dma_detach_device);
 
-int rockchip_register_crtc_funcs(struct drm_device *dev,
-				 const struct rockchip_crtc_funcs *crtc_funcs,
-				 int pipe)
+int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
+				 const struct rockchip_crtc_funcs *crtc_funcs)
 {
-	struct rockchip_drm_private *priv = dev->dev_private;
+	int pipe = drm_crtc_index(crtc);
+	struct rockchip_drm_private *priv = crtc->dev->dev_private;
 
 	if (pipe > ROCKCHIP_MAX_CRTC)
 		return -EINVAL;
@@ -79,9 +79,10 @@ int rockchip_register_crtc_funcs(struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(rockchip_register_crtc_funcs);
 
-void rockchip_unregister_crtc_funcs(struct drm_device *dev, int pipe)
+void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc)
 {
-	struct rockchip_drm_private *priv = dev->dev_private;
+	int pipe = drm_crtc_index(crtc);
+	struct rockchip_drm_private *priv = crtc->dev->dev_private;
 
 	if (pipe > ROCKCHIP_MAX_CRTC)
 		return;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index dc4e5f0..069d6d4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -52,10 +52,9 @@ struct rockchip_drm_private {
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
 };
 
-int rockchip_register_crtc_funcs(struct drm_device *dev,
-				 const struct rockchip_crtc_funcs *crtc_funcs,
-				 int pipe);
-void rockchip_unregister_crtc_funcs(struct drm_device *dev, int pipe);
+int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
+				 const struct rockchip_crtc_funcs *crtc_funcs);
+void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
 int rockchip_drm_encoder_get_mux_id(struct device_node *node,
 				    struct drm_encoder *encoder);
 int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int connector_type,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index dd8e086..f82c7ba 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -119,8 +119,6 @@ struct vop {
 	/* vop dclk reset */
 	struct reset_control *dclk_rst;
 
-	int pipe;
-
 	struct vop_win win[];
 };
 
@@ -692,7 +690,7 @@ static void vop_enable(struct drm_crtc *crtc)
 
 	enable_irq(vop->irq);
 
-	drm_vblank_on(vop->drm_dev, vop->pipe);
+	drm_crtc_vblank_on(crtc);
 
 	return;
 
@@ -711,7 +709,7 @@ static void vop_disable(struct drm_crtc *crtc)
 	if (!vop->is_enabled)
 		return;
 
-	drm_vblank_off(crtc->dev, vop->pipe);
+	drm_crtc_vblank_off(crtc);
 
 	/*
 	 * Vop standby will take effect at end of current frame,
@@ -918,7 +916,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	 */
 	mutex_lock(&vop->vsync_mutex);
 	if (fb != vop_win_last_pending_fb(vop_win)) {
-		ret = drm_vblank_get(plane->dev, vop->pipe);
+		ret = drm_crtc_vblank_get(crtc);
 		if (ret) {
 			DRM_ERROR("failed to get vblank, %d\n", ret);
 			mutex_unlock(&vop->vsync_mutex);
@@ -929,7 +927,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 
 		ret = vop_win_queue_fb(vop_win, fb, yrgb_mst, event);
 		if (ret) {
-			drm_vblank_put(plane->dev, vop->pipe);
+			drm_crtc_vblank_put(crtc);
 			mutex_unlock(&vop->vsync_mutex);
 			return ret;
 		}
@@ -1023,7 +1021,7 @@ static int vop_disable_plane(struct drm_plane *plane)
 
 	vop = to_vop(plane->crtc);
 
-	ret = drm_vblank_get(plane->dev, vop->pipe);
+	ret = drm_crtc_vblank_get(plane->crtc);
 	if (ret) {
 		DRM_ERROR("failed to get vblank, %d\n", ret);
 		return ret;
@@ -1033,7 +1031,7 @@ static int vop_disable_plane(struct drm_plane *plane)
 
 	ret = vop_win_queue_fb(vop_win, NULL, 0, NULL);
 	if (ret) {
-		drm_vblank_put(plane->dev, vop->pipe);
+		drm_crtc_vblank_put(plane->crtc);
 		mutex_unlock(&vop->vsync_mutex);
 		return ret;
 	}
@@ -1295,7 +1293,7 @@ static void vop_win_state_complete(struct vop_win *vop_win,
 	}
 
 	list_del(&state->head);
-	drm_vblank_put(crtc->dev, vop->pipe);
+	drm_crtc_vblank_put(crtc);
 }
 
 static void vop_crtc_destroy(struct drm_crtc *crtc)
@@ -1410,6 +1408,7 @@ done:
 static irqreturn_t vop_isr(int irq, void *data)
 {
 	struct vop *vop = data;
+	struct drm_crtc *crtc = &vop->crtc;
 	uint32_t intr0_reg, active_irqs;
 	unsigned long flags;
 	int ret = IRQ_NONE;
@@ -1438,7 +1437,7 @@ static irqreturn_t vop_isr(int irq, void *data)
 	}
 
 	if (active_irqs & FS_INTR) {
-		drm_handle_vblank(vop->drm_dev, vop->pipe);
+		drm_crtc_handle_vblank(crtc);
 		active_irqs &= ~FS_INTR;
 		ret = (vop->vsync_work_pending) ? IRQ_WAKE_THREAD : IRQ_HANDLED;
 	}
@@ -1531,8 +1530,7 @@ static int vop_create_crtc(struct vop *vop)
 
 	init_completion(&vop->dsp_hold_completion);
 	crtc->port = port;
-	vop->pipe = drm_crtc_index(crtc);
-	rockchip_register_crtc_funcs(drm_dev, &private_crtc_funcs, vop->pipe);
+	rockchip_register_crtc_funcs(crtc, &private_crtc_funcs);
 
 	return 0;
 
@@ -1548,7 +1546,7 @@ static void vop_destroy_crtc(struct vop *vop)
 {
 	struct drm_crtc *crtc = &vop->crtc;
 
-	rockchip_unregister_crtc_funcs(vop->drm_dev, vop->pipe);
+	rockchip_unregister_crtc_funcs(crtc);
 	of_node_put(crtc->port);
 	drm_crtc_cleanup(crtc);
 }
-- 
1.7.9.5
