From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 27 Aug 2018 14:10:37 +0300
Subject: [RESEND 1/5] drm/mxsfb: Move axi clk enable/disable to crtc
 enable/disable
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
Message-ID: <58ec6338ada7fd46af99675dc1268d31d2a15464.1535367027.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main axi clk is disabled at the end of mxsfb_crtc_mode_set_nofb and
immediately reenabled in mxsfb_enable_controller.

Avoid this by moving the handling of axi clk one level up to
mxsfb_crtc_enable. Do the same for mxsfb_crtc_disable for symmetry.

This shouldn't have any functional effect.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 0abe77675b76..e4fcbb65b969 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -127,11 +127,10 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	u32 reg;
 
 	if (mxsfb->clk_disp_axi)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
-	mxsfb_enable_axi_clk(mxsfb);
 
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
 
 	/* Enable the SYNC signals first, then the DMA engine */
@@ -157,12 +156,10 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 
 	reg = readl(mxsfb->base + LCDC_VDCTRL4);
 	reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
 
-	mxsfb_disable_axi_clk(mxsfb);
-
 	clk_disable_unprepare(mxsfb->clk);
 	if (mxsfb->clk_disp_axi)
 		clk_disable_unprepare(mxsfb->clk_disp_axi);
 }
 
@@ -206,11 +203,10 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	/*
 	 * It seems, you can't re-program the controller if it is still
 	 * running. This may lead to shifted pictures (FIFO issue?), so
 	 * first stop the controller and drain its FIFOs.
 	 */
-	mxsfb_enable_axi_clk(mxsfb);
 
 	/* Mandatory eLCDIF reset as per the Reference Manual */
 	err = mxsfb_reset_block(mxsfb->base);
 	if (err)
 		return;
@@ -267,23 +263,23 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       SET_VERT_WAIT_CNT(m->crtc_vtotal - m->crtc_vsync_start),
 	       mxsfb->base + LCDC_VDCTRL3);
 
 	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
 	       mxsfb->base + LCDC_VDCTRL4);
-
-	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	mxsfb_enable_axi_clk(mxsfb);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 	mxsfb_enable_controller(mxsfb);
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
 	mxsfb_disable_controller(mxsfb);
+	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *state)
 {
-- 
2.17.1
