From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:54 +0900
Subject: [PATCH 1/8] drm/rockchip: Clear interrupt status bits before enabling
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-2-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable register only masks the raw status bits to signal CPU
interrupt only for enabled interrupts. The status bits are activated
regardless of the enable register. This means that we might have an old
interrupt event queued, which we are not interested in. To avoid getting
a spurious interrupt signalled, we have to clear the old bit before we
update the enable register.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 209167b..7e811cf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -414,6 +414,7 @@ static void vop_dsp_hold_valid_irq_enable(struct vop *vop)
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
+	VOP_INTR_SET_TYPE(vop, clear, DSP_HOLD_VALID_INTR, 1);
 	VOP_INTR_SET_TYPE(vop, enable, DSP_HOLD_VALID_INTR, 1);
 
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
@@ -479,6 +480,7 @@ static void vop_line_flag_irq_enable(struct vop *vop, int line_num)
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
 	VOP_CTRL_SET(vop, line_flag_num[0], line_num);
+	VOP_INTR_SET_TYPE(vop, clear, LINE_FLAG_INTR, 1);
 	VOP_INTR_SET_TYPE(vop, enable, LINE_FLAG_INTR, 1);
 
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
@@ -921,6 +923,7 @@ static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
+	VOP_INTR_SET_TYPE(vop, clear, FS_INTR, 1);
 	VOP_INTR_SET_TYPE(vop, enable, FS_INTR, 1);
 
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
-- 
2.8.0.rc3.226.g39d4020
