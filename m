From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:56 +0900
Subject: [PATCH 3/8] drm/rockchip: Avoid race with vblank count increment
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-4-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since VOP does not have a hardware vblank count register, the ongoing
commit might be racing with a requested vblank interrupt, which would
increment the software vblank counter before the changes being committed
actually happen.

To avoid this, we can extend .atomic_flush(), so after it sets cfg_done
bit, it polls the vblank interrupt bit until it's inactive to make sure
that any old vblank interrupt gets to the handler and then uses
synchronize_irq(vop->irq) to make sure the handler finishes running.

The polling case should happen very rarely, but even if, the total wait
time should be relatively low and in practice almost equal to the vop
hardirq handler running time.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 68988c6..f989440 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
@@ -1063,6 +1064,32 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	rockchip_drm_psr_activate(&vop->crtc);
 }
 
+static bool vop_fs_irq_is_pending(struct vop *vop)
+{
+	return VOP_INTR_GET_TYPE(vop, status, FS_INTR);
+}
+
+static void vop_wait_for_irq_handler(struct vop *vop)
+{
+	bool pending;
+	int ret;
+
+	/*
+	 * Spin until frame start interrupt status bit goes low, which means
+	 * that interrupt handler was invoked and cleared it. The timeout of
+	 * 10 msecs is really too long, but it is just a safety measure if
+	 * something goes really wrong. The wait will only happen in the very
+	 * unlikely case of a vblank happening exactly at the same time and
+	 * shouldn't exceed microseconds range.
+	 */
+	ret = readx_poll_timeout_atomic(vop_fs_irq_is_pending, vop, pending,
+					!pending, 0, 10 * 1000);
+	if (ret)
+		DRM_DEV_ERROR(vop->dev, "VOP vblank IRQ stuck for 10 ms\n");
+
+	synchronize_irq(vop->irq);
+}
+
 static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
@@ -1076,6 +1103,13 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	vop_cfg_done(vop);
 
 	spin_unlock(&vop->reg_lock);
+
+	/*
+	 * There is a (rather unlikely) possiblity that a vblank interrupt
+	 * fired before we set the cfg_done bit. To avoid spuriously
+	 * signalling flip completion we need to wait for it to finish.
+	 */
+	vop_wait_for_irq_handler(vop);
 }
 
 static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
-- 
2.8.0.rc3.226.g39d4020
