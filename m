From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:26 -0500
Subject: [PATCH 11/41] drm/rockchip: add mutex vop lock
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-12-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

Add a lock to vop to avoid disabling the crtc while waiting for a line
flag while enabling psr. If we disable in the middle of waiting for the
line flag, we'll end up timing out or worse.

Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1c1e8535ad28..aa5c528c59fc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -130,6 +130,7 @@ struct vop {
 	spinlock_t reg_lock;
 	/* lock vop irq reg */
 	spinlock_t irq_lock;
+	struct mutex vop_lock;
 
 	unsigned int irq;
 
@@ -568,6 +569,7 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 
 	WARN_ON(vop->event);
 
+	mutex_lock(&vop->vop_lock);
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
@@ -619,6 +621,7 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	clk_disable(vop->aclk);
 	clk_disable(vop->hclk);
 	pm_runtime_put(vop->dev);
+	mutex_unlock(&vop->vop_lock);
 
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
@@ -885,10 +888,13 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	uint32_t pin_pol, val;
 	int ret;
 
+	mutex_lock(&vop->vop_lock);
+
 	WARN_ON(vop->event);
 
 	ret = vop_enable(crtc);
 	if (ret) {
+		mutex_unlock(&vop->vop_lock);
 		DRM_DEV_ERROR(vop->dev, "Failed to enable vop (%d)\n", ret);
 		return;
 	}
@@ -979,6 +985,7 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_CTRL_SET(vop, standby, 0);
+	mutex_unlock(&vop->vop_lock);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
@@ -1506,15 +1513,22 @@ int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
 {
 	struct vop *vop = to_vop(crtc);
 	unsigned long jiffies_left;
+	int ret = 0;
 
 	if (!crtc || !vop->is_enabled)
 		return -ENODEV;
 
-	if (line_num > crtc->mode.vtotal || mstimeout <= 0)
-		return -EINVAL;
+	mutex_lock(&vop->vop_lock);
+
+	if (line_num > crtc->mode.vtotal || mstimeout <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (vop_line_flag_irq_is_enabled(vop))
-		return -EBUSY;
+	if (vop_line_flag_irq_is_enabled(vop)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	reinit_completion(&vop->line_flag_completion);
 	vop_line_flag_irq_enable(vop, line_num);
@@ -1525,10 +1539,13 @@ int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
 
 	if (jiffies_left == 0) {
 		dev_err(vop->dev, "Timeout waiting for IRQ\n");
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto out;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&vop->vop_lock);
+	return ret;
 }
 EXPORT_SYMBOL(rockchip_drm_wait_line_flag);
 
@@ -1584,6 +1601,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	spin_lock_init(&vop->reg_lock);
 	spin_lock_init(&vop->irq_lock);
+	mutex_init(&vop->vop_lock);
 
 	ret = devm_request_irq(dev, vop->irq, vop_isr,
 			       IRQF_SHARED, dev_name(dev), vop);
-- 
2.12.0.246.ga2ecc84866-goog
