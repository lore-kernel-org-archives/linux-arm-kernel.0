From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:01:11 +0800
Subject: [PATCH v3 4/8] drm/rockchip: Optimization vop mode set
In-Reply-To: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
References: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450321275-31154-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rk3288 vop timing registers is immediately register, when configure
timing on display active time, will cause tearing. use dclk reset is
not a good idea to avoid this tearing. we can avoid tearing by using
standby register.

Vop standby register will take effect at end of current frame, and
go back to work immediately when exit standby.

So we can use standby register to protect this context.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3: None
Changes in v2: None
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   51 ++++++++++++++++++---------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 44f6154..9ace3ae 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1097,10 +1097,40 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 
 	vop_enable(crtc);
 	/*
-	 * disable dclk to stop frame scan, so that we can safe config mode and
-	 * enable iommu.
+	 * If dclk rate is zero, mean that scanout is stop,
+	 * we don't need wait any more.
 	 */
-	clk_disable(vop->dclk);
+	if (clk_get_rate(vop->dclk)) {
+		/*
+		 * Rk3288 vop timing register is immediately, when configure
+		 * display timing on display time, may cause tearing.
+		 *
+		 * Vop standby will take effect at end of current frame,
+		 * if dsp hold valid irq happen, it means standby complete.
+		 *
+		 * mode set:
+		 *    standby and wait complete --> |----
+		 *                                  | display time
+		 *                                  |----
+		 *                                  |---> dsp hold irq
+		 *     configure display timing --> |
+		 *         standby exit             |
+		 *                                  | new frame start.
+		 */
+
+		reinit_completion(&vop->dsp_hold_completion);
+		vop_dsp_hold_valid_irq_enable(vop);
+
+		spin_lock(&vop->reg_lock);
+
+		VOP_CTRL_SET(vop, standby, 1);
+
+		spin_unlock(&vop->reg_lock);
+
+		wait_for_completion(&vop->dsp_hold_completion);
+
+		vop_dsp_hold_valid_irq_disable(vop);
+	}
 
 	switch (vop->connector_type) {
 	case DRM_MODE_CONNECTOR_LVDS:
@@ -1115,7 +1145,6 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	default:
 		DRM_ERROR("unsupport connector_type[%d]\n",
 			  vop->connector_type);
-		goto out;
 	};
 	VOP_CTRL_SET(vop, out_mode, vop->connector_out_mode);
 
@@ -1136,19 +1165,9 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	VOP_CTRL_SET(vop, vact_st_end, val);
 	VOP_CTRL_SET(vop, vpost_st_end, val);
 
-
-	/*
-	 * reset dclk, take all mode config affect, so the clk would run in
-	 * correct frame.
-	 */
-	reset_control_assert(vop->dclk_rst);
-	usleep_range(10, 20);
-	reset_control_deassert(vop->dclk_rst);
-
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
-out:
-	if (clk_enable(vop->dclk) < 0)
-		dev_err(vop->dev, "failed to enable dclk\n");
+
+	VOP_CTRL_SET(vop, standby, 0);
 }
 
 static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
-- 
1.7.9.5
