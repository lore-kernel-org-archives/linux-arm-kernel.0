From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 28 Apr 2017 15:37:47 +0800
Subject: [PATCH v2] drm/rockchip: Set line flag config register in
 vop_crtc_enable
Message-ID: <1493365067-29541-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to set vop config done after update line flag config, it's a
new requirement for chips newer than rk3368.

Since we would only use line flag irq for vact_end, let's move it to
vop_crtc_enable.

v2: Remove unused check and variables.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

Changes in v2:
Remove unused check and variables.

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 14 +++-----------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |  3 +--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     | 20 +++++++++-----------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index d8fa7a9..1bccd82 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -104,26 +104,18 @@ static void analogix_dp_psr_work(struct work_struct *work)
 {
 	struct rockchip_dp_device *dp =
 				container_of(work, typeof(*dp), psr_work);
-	struct drm_crtc *crtc = dp->encoder.crtc;
-	int psr_state = dp->psr_state;
-	int vact_end;
 	int ret;
 	unsigned long flags;
 
-	if (!crtc)
-		return;
-
-	vact_end = crtc->mode.vtotal - crtc->mode.vsync_start + crtc->mode.vdisplay;
-
-	ret = rockchip_drm_wait_line_flag(dp->encoder.crtc, vact_end,
-					  PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
+	ret = rockchip_drm_wait_vact_end(dp->encoder.crtc,
+					 PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
 	if (ret) {
 		dev_err(dp->dev, "line flag interrupt did not arrive\n");
 		return;
 	}
 
 	spin_lock_irqsave(&dp->psr_lock, flags);
-	if (psr_state == EDP_VSC_PSR_STATE_ACTIVE)
+	if (dp->psr_state == EDP_VSC_PSR_STATE_ACTIVE)
 		analogix_dp_enable_psr(dp->dev);
 	else
 		analogix_dp_disable_psr(dp->dev);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index a48fcce..47905fa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -62,8 +62,7 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
-int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
-				unsigned int mstimeout);
+int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3f7a82d..40a5e6e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -468,7 +468,7 @@ static bool vop_line_flag_irq_is_enabled(struct vop *vop)
 	return !!line_flag_irq;
 }
 
-static void vop_line_flag_irq_enable(struct vop *vop, int line_num)
+static void vop_line_flag_irq_enable(struct vop *vop)
 {
 	unsigned long flags;
 
@@ -477,7 +477,6 @@ static void vop_line_flag_irq_enable(struct vop *vop, int line_num)
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
-	VOP_CTRL_SET(vop, line_flag_num[0], line_num);
 	VOP_INTR_SET_TYPE(vop, clear, LINE_FLAG_INTR, 1);
 	VOP_INTR_SET_TYPE(vop, enable, LINE_FLAG_INTR, 1);
 
@@ -981,6 +980,8 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	VOP_CTRL_SET(vop, vact_st_end, val);
 	VOP_CTRL_SET(vop, vpost_st_end, val);
 
+	VOP_CTRL_SET(vop, line_flag_num[0], vact_end);
+
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_CTRL_SET(vop, standby, 0);
@@ -1507,19 +1508,16 @@ static void vop_win_init(struct vop *vop)
 }
 
 /**
- * rockchip_drm_wait_line_flag - acqiure the give line flag event
+ * rockchip_drm_wait_vact_end
  * @crtc: CRTC to enable line flag
- * @line_num: interested line number
  * @mstimeout: millisecond for timeout
  *
- * Driver would hold here until the interested line flag interrupt have
- * happened or timeout to wait.
+ * Wait for vact_end line flag irq or timeout.
  *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
-				unsigned int mstimeout)
+int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
 {
 	struct vop *vop = to_vop(crtc);
 	unsigned long jiffies_left;
@@ -1527,14 +1525,14 @@ int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
 	if (!crtc || !vop->is_enabled)
 		return -ENODEV;
 
-	if (line_num > crtc->mode.vtotal || mstimeout <= 0)
+	if (mstimeout <= 0)
 		return -EINVAL;
 
 	if (vop_line_flag_irq_is_enabled(vop))
 		return -EBUSY;
 
 	reinit_completion(&vop->line_flag_completion);
-	vop_line_flag_irq_enable(vop, line_num);
+	vop_line_flag_irq_enable(vop);
 
 	jiffies_left = wait_for_completion_timeout(&vop->line_flag_completion,
 						   msecs_to_jiffies(mstimeout));
@@ -1547,7 +1545,7 @@ int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
 
 	return 0;
 }
-EXPORT_SYMBOL(rockchip_drm_wait_line_flag);
+EXPORT_SYMBOL(rockchip_drm_wait_vact_end);
 
 static int vop_bind(struct device *dev, struct device *master, void *data)
 {
-- 
2.1.4
