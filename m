From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 31 Jul 2017 17:49:37 +0800
Subject: [PATCH 1/6] drm/rockchip: vop: no need wait vblank on crtc enable
In-Reply-To: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1501494577-6884-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since atomic framework, crtc enable and disable are in pairs,
no need to wait vblank.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 36 -----------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1d42049..0bfd563 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -893,42 +893,6 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
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
-		VOP_REG_SET(vop, common, standby, 1);
-
-		spin_unlock(&vop->reg_lock);
-
-		wait_for_completion(&vop->dsp_hold_completion);
-
-		vop_dsp_hold_valid_irq_disable(vop);
-	}
-
 	pin_pol = BIT(DCLK_INVERT);
 	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC) ?
 		   BIT(HSYNC_POSITIVE) : 0;
-- 
1.9.1
