From: hl@rock-chips.com (Lin Huang)
Date: Wed,  1 Jun 2016 17:35:39 +0800
Subject: [RFC PATCH 4/4] drm/rockchip: Add dmc notifier in vop driver
In-Reply-To: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
Message-ID: <1464773739-18152-5-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when in ddr frequency scaling process, vop can not do
enable or disable operate, since dcf will base on vop vblank
time to do frequency scaling and need to get vop irq if there
have vop enabled. So need register to dmc notifier, and we can
get the dmc status.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 51 +++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1c4d5b5..7ee0cd0 100644
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
@@ -116,6 +118,9 @@ struct vop {
 
 	const struct vop_data *data;
 
+	struct notifier_block dmc_nb;
+	int dmc_in_process;
+
 	uint32_t *regsbak;
 	void __iomem *regs;
 
@@ -426,14 +431,41 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
+static int dmc_notify(struct notifier_block *nb, unsigned long event,
+		      void *data)
+{
+	struct vop *vop = container_of(nb, struct vop, dmc_nb);
+
+	if (event == DMCFREQ_ADJUST)
+		vop->dmc_in_process = 1;
+	else if (event == DMCFREQ_FINISH)
+		vop->dmc_in_process = 0;
+
+	return NOTIFY_OK;
+}
+
 static void vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
 	int ret;
+	int timeout_count = 500;
+	int timeout_loop = 0;
 
 	if (vop->is_enabled)
 		return;
 
+	/*
+	 * if in dmc scaling frequency process, wait until it finish
+	 * use 100ms as timeout time.
+	 */
+	while (timeout_loop < timeout_count) {
+		if (vop->dmc_in_process == 0)
+			break;
+
+		timeout_loop++;
+		usleep_range(150, 200);
+	}
+
 	ret = pm_runtime_get_sync(vop->dev);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
@@ -485,6 +517,7 @@ static void vop_enable(struct drm_crtc *crtc)
 	enable_irq(vop->irq);
 
 	drm_crtc_vblank_on(crtc);
+	rockchip_dmc_get(&vop->dmc_nb);
 
 	return;
 
@@ -500,11 +533,25 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
 	int i;
+	int timeout_count = 500;
+	int timeout_loop = 0;
 
 	if (!vop->is_enabled)
 		return;
 
 	/*
+	 * if in dmc scaling frequency process, wait until it finish
+	 * use 100ms as timeout time.
+	 */
+	while (timeout_loop < timeout_count) {
+		if (vop->dmc_in_process == 0)
+			break;
+
+		timeout_loop++;
+		usleep_range(150, 200);
+	}
+
+	/*
 	 * We need to make sure that all windows are disabled before we
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
 	 * buffer later.
@@ -517,7 +564,7 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 		VOP_WIN_SET(vop, win, enable, 0);
 		spin_unlock(&vop->reg_lock);
 	}
-
+	rockchip_dmc_put(&vop->dmc_nb);
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -1243,7 +1290,7 @@ static int vop_create_crtc(struct vop *vop)
 		ret = -ENOENT;
 		goto err_cleanup_crtc;
 	}
-
+	vop->dmc_nb.notifier_call = dmc_notify;
 	init_completion(&vop->dsp_hold_completion);
 	init_completion(&vop->wait_update_complete);
 	crtc->port = port;
-- 
1.9.1
