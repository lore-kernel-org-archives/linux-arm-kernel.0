From: john@metanate.com (John Keeping)
Date: Fri, 11 Mar 2016 17:21:17 +0000
Subject: [PATCH] drm/rockchip: cancel pending vblanks on close
Message-ID: <1457716877-427-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When closing the DRM device while a vblank is pending, we access
file_priv after it has been free'd, which gives:

  Unable to handle kernel NULL pointer dereference at virtual address 00000000
  ...
  PC is at __list_add+0x5c/0xe8
  LR is at send_vblank_event+0x54/0x1f0
  ...
  [<c02952e8>] (__list_add) from [<c031a7b4>] (send_vblank_event+0x54/0x1f0)
  [<c031a760>] (send_vblank_event) from [<c031a9c0>] (drm_send_vblank_event+0x70/0x78)
  [<c031a950>] (drm_send_vblank_event) from [<c031a9f8>] (drm_crtc_send_vblank_event+0x30/0x34)
  [<c031a9c8>] (drm_crtc_send_vblank_event) from [<c0339ad8>] (vop_isr+0x224/0x28c)
  [<c03398b4>] (vop_isr) from [<c0081780>] (handle_irq_event_percpu+0x12c/0x3e4)

This can be triggered somewhat reliably with:

	modetest -M rockchip -v -s ...

Add a preclose hook to the driver so that we can discard any pending
vblank events when the device is closed.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 20 ++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index a0d51cc..1c8a9be 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -251,6 +251,27 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
 	return 0;
 }
 
+static void rockchip_drm_crtc_cancel_pending_vblank(struct drm_crtc *crtc,
+						    struct drm_file *file_priv)
+{
+	struct rockchip_drm_private *priv = crtc->dev->dev_private;
+	int pipe = drm_crtc_index(crtc);
+
+	if (pipe < ROCKCHIP_MAX_CRTC &&
+	    priv->crtc_funcs[pipe] &&
+	    priv->crtc_funcs[pipe]->cancel_pending_vblank)
+		priv->crtc_funcs[pipe]->cancel_pending_vblank(crtc, file_priv);
+}
+
+static void rockchip_drm_preclose(struct drm_device *dev,
+				  struct drm_file *file_priv)
+{
+	struct drm_crtc *crtc;
+
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head)
+		rockchip_drm_crtc_cancel_pending_vblank(crtc, file_priv);
+}
+
 void rockchip_drm_lastclose(struct drm_device *dev)
 {
 	struct rockchip_drm_private *priv = dev->dev_private;
@@ -281,6 +302,7 @@ static struct drm_driver rockchip_drm_driver = {
 				  DRIVER_PRIME | DRIVER_ATOMIC,
 	.load			= rockchip_drm_load,
 	.unload			= rockchip_drm_unload,
+	.preclose		= rockchip_drm_preclose,
 	.lastclose		= rockchip_drm_lastclose,
 	.get_vblank_counter	= drm_vblank_no_hw_counter,
 	.enable_vblank		= rockchip_drm_crtc_enable_vblank,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index bb8b076..2b41dd4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -40,6 +40,7 @@ struct rockchip_crtc_funcs {
 	int (*enable_vblank)(struct drm_crtc *crtc);
 	void (*disable_vblank)(struct drm_crtc *crtc);
 	void (*wait_for_update)(struct drm_crtc *crtc);
+	void (*cancel_pending_vblank)(struct drm_crtc *crtc, struct drm_file *file_priv);
 };
 
 struct rockchip_atomic_commit {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 8a5ac57..53dfe21 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -875,10 +875,30 @@ static void vop_crtc_wait_for_update(struct drm_crtc *crtc)
 	WARN_ON(!wait_for_completion_timeout(&vop->wait_update_complete, 100));
 }
 
+static void vop_crtc_cancel_pending_vblank(struct drm_crtc *crtc,
+					   struct drm_file *file_priv)
+{
+	struct drm_device *drm = crtc->dev;
+	struct vop *vop = to_vop(crtc);
+	struct drm_pending_vblank_event *e;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drm->event_lock, flags);
+	e = vop->event;
+	if (e && e->base.file_priv == file_priv) {
+		vop->event = NULL;
+
+		e->base.destroy(&e->base);
+		file_priv->event_space += sizeof(e->event);
+	}
+	spin_unlock_irqrestore(&drm->event_lock, flags);
+}
+
 static const struct rockchip_crtc_funcs private_crtc_funcs = {
 	.enable_vblank = vop_crtc_enable_vblank,
 	.disable_vblank = vop_crtc_disable_vblank,
 	.wait_for_update = vop_crtc_wait_for_update,
+	.cancel_pending_vblank = vop_crtc_cancel_pending_vblank,
 };
 
 static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
-- 
2.7.0.226.gfe986fe
