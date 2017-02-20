From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 20 Feb 2017 16:28:52 +0800
Subject: [PATCH] drm/rockchip: vop: no need wait vblank on crtc enable
Message-ID: <1487579332-8578-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since atomic framework, crtc enable and disable are in pairs,
no need to wait vblank.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 36 -----------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 76c79ac..8dab2af 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -900,42 +900,6 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		return;
 	}
 
-	/*
-	 * If dclk rate is zero, mean that scanout is stop,
-	 * we don't need wait any more.
-	 */
-	if (clk_get_rate(vop->dclk)) {
-		/*
-		 * Rk3288 vop timing register is immediately, when configure
-		 * display timing on display time, may cause tearing.
-		 *
-		 * Vop standby will take effect at end of current frame,
-		 * if dsp hold valid irq happen, it means standby complete.
-		 *
-		 * mode set:
-		 *    standby and wait complete --> |----
-		 *                                  | display time
-		 *                                  |----
-		 *                                  |---> dsp hold irq
-		 *     configure display timing --> |
-		 *         standby exit             |
-		 *                                  | new frame start.
-		 */
-
-		reinit_completion(&vop->dsp_hold_completion);
-		vop_dsp_hold_valid_irq_enable(vop);
-
-		spin_lock(&vop->reg_lock);
-
-		VOP_CTRL_SET(vop, standby, 1);
-
-		spin_unlock(&vop->reg_lock);
-
-		wait_for_completion(&vop->dsp_hold_completion);
-
-		vop_dsp_hold_valid_irq_disable(vop);
-	}
-
 	pin_pol = BIT(DCLK_INVERT);
 	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ?
 		   0 : BIT(HSYNC_POSITIVE);
-- 
1.9.1
