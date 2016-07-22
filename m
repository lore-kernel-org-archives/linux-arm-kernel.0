From: hl@rock-chips.com (Lin Huang)
Date: Fri, 22 Jul 2016 17:07:20 +0800
Subject: [PATCH v3 7/7] drm/rockchip: Add dmc notifier in vop driver
In-Reply-To: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
Message-ID: <1469178440-4668-8-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when in ddr frequency scaling process, vop can not do
enable or disable operate, since dcf will base on vop vblank
time to do frequency scaling and need to get vop irq if there
have vop enabled. So need register to dmc notifier, and we can
get the dmc status.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v3:
- when do vop eanble/disable, dmc will wait until it finish

Changes in v2:
- None

Changes in v1:
- use wait_event instead usleep

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 75 ++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 6255e5b..4220629 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -31,6 +31,8 @@
 #include <linux/reset.h>
 #include <linux/delay.h>
 
+#include <soc/rockchip/rockchip_dmc.h>
+
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_fb.h"
@@ -120,6 +122,11 @@ struct vop {
 
 	const struct vop_data *data;
 
+	struct notifier_block dmc_nb;
+	int dmc_in_process;
+	int vop_switch_status;
+	wait_queue_head_t	wait_dmc_queue;
+	wait_queue_head_t	wait_vop_switch_queue;
 	uint32_t *regsbak;
 	void __iomem *regs;
 
@@ -430,21 +437,56 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
+static int dmc_notify(struct notifier_block *nb, unsigned long event,
+		      void *data)
+{
+	struct vop *vop = container_of(nb, struct vop, dmc_nb);
+
+	if (event == DMCFREQ_ADJUST) {
+
+		/*
+		 * check if vop in enable or disable process,
+		 * if yes, wait until it finish, use 200ms as
+		 * timeout.
+		 */
+		wait_event_timeout(vop->wait_vop_switch_queue,
+			   !vop->vop_switch_status, HZ / 5);
+		vop->dmc_in_process = 1;
+	} else if (event == DMCFREQ_FINISH) {
+		vop->dmc_in_process = 0;
+		wake_up(&vop->wait_dmc_queue);
+	}
+
+	return NOTIFY_OK;
+}
+
 static void vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
 	int ret;
 
+	if (vop->is_enabled)
+		return;
+
+	/*
+	 * if in dmc scaling frequency process, wait until it finish
+	 * use 100ms as timeout time.
+	 */
+	wait_event_timeout(vop->wait_dmc_queue,
+			   !vop->dmc_in_process, HZ / 5);
+
+	vop->vop_switch_status = 1;
+
 	ret = pm_runtime_get_sync(vop->dev);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
-		return;
+		goto err;
 	}
 
 	ret = clk_enable(vop->hclk);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to enable hclk - %d\n", ret);
-		return;
+		goto err;
 	}
 
 	ret = clk_enable(vop->dclk);
@@ -458,7 +500,6 @@ static void vop_enable(struct drm_crtc *crtc)
 		dev_err(vop->dev, "failed to enable aclk - %d\n", ret);
 		goto err_disable_dclk;
 	}
-
 	/*
 	 * Slave iommu shares power, irq and clock with vop.  It was associated
 	 * automatically with this master device via common driver code.
@@ -486,7 +527,9 @@ static void vop_enable(struct drm_crtc *crtc)
 	enable_irq(vop->irq);
 
 	drm_crtc_vblank_on(crtc);
-
+	vop->vop_switch_status = 0;
+	wake_up(&vop->wait_vop_switch_queue);
+	rockchip_dmc_get(&vop->dmc_nb);
 	return;
 
 err_disable_aclk:
@@ -495,6 +538,10 @@ err_disable_dclk:
 	clk_disable(vop->dclk);
 err_disable_hclk:
 	clk_disable(vop->hclk);
+err:
+	vop->vop_switch_status = 0;
+	wake_up(&vop->wait_vop_switch_queue);
+	return;
 }
 
 static void vop_crtc_disable(struct drm_crtc *crtc)
@@ -505,6 +552,15 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	WARN_ON(vop->event);
 
 	/*
+	 * if in dmc scaling frequency process, wait until it finish
+	 * use 100ms as timeout time.
+	 */
+	wait_event_timeout(vop->wait_dmc_queue,
+			   !vop->dmc_in_process, HZ / 5);
+
+	vop->vop_switch_status = 1;
+
+	/*
 	 * We need to make sure that all windows are disabled before we
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
 	 * buffer later.
@@ -517,7 +573,6 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 		VOP_WIN_SET(vop, win, enable, 0);
 		spin_unlock(&vop->reg_lock);
 	}
-
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -548,7 +603,6 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	 * vop standby complete, so iommu detach is safe.
 	 */
 	rockchip_drm_dma_detach_device(vop->drm_dev, vop->dev);
-
 	clk_disable(vop->dclk);
 	clk_disable(vop->aclk);
 	clk_disable(vop->hclk);
@@ -561,6 +615,9 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 
 		crtc->state->event = NULL;
 	}
+	vop->vop_switch_status = 0;
+	wake_up(&vop->wait_vop_switch_queue);
+	rockchip_dmc_put(&vop->dmc_nb);
 }
 
 static void vop_plane_destroy(struct drm_plane *plane)
@@ -1247,6 +1304,7 @@ static int vop_create_crtc(struct vop *vop)
 		goto err_cleanup_crtc;
 	}
 
+	vop->dmc_nb.notifier_call = dmc_notify;
 	init_completion(&vop->dsp_hold_completion);
 	init_completion(&vop->wait_update_complete);
 	crtc->port = port;
@@ -1468,6 +1526,11 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	/* IRQ is initially disabled; it gets enabled in power_on */
 	disable_irq(vop->irq);
 
+	init_waitqueue_head(&vop->wait_vop_switch_queue);
+	vop->vop_switch_status = 0;
+	init_waitqueue_head(&vop->wait_dmc_queue);
+	vop->dmc_in_process = 0;
+
 	ret = vop_create_crtc(vop);
 	if (ret)
 		return ret;
-- 
2.6.6
