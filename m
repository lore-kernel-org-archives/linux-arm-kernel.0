From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 27 Aug 2018 14:10:38 +0300
Subject: [RESEND 2/5] drm/mxsfb: Fix initial corrupt frame when activating
 display
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
Message-ID: <7ce983379410b6c29a16c9f394b382ec16c16ba9.1535367027.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LCDIF will repeatedly display data from CUR_BUF and set CUR_BUF to
NEXT_BUF when done. Since we are only ever writing to NEXT_BUF the
display will show an initial corrupt frame.

Fix by writing the FB paddr to both CUR_BUF and NEXT_BUF when
activating the CRTC.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 45 +++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index e4fcbb65b969..24b1f0c1432e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -191,10 +191,25 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
 		return ret;
 
 	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
 }
 
+static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_private *mxsfb)
+{
+	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
+	struct drm_gem_cma_object *gem;
+
+	if (!fb)
+		return 0;
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	if (!gem)
+		return 0;
+
+	return gem->paddr;
+}
+
 static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
 	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
 	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
@@ -267,12 +282,22 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       mxsfb->base + LCDC_VDCTRL4);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	dma_addr_t paddr;
+
 	mxsfb_enable_axi_clk(mxsfb);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
+
+	/* Write cur_buf as well to avoid an initial corrupt frame */
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+	}
+
 	mxsfb_enable_controller(mxsfb);
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
@@ -283,16 +308,12 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *state)
 {
 	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
 	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_framebuffer *fb = pipe->plane.state->fb;
 	struct drm_pending_vblank_event *event;
-	struct drm_gem_cma_object *gem;
-
-	if (!crtc)
-		return;
+	dma_addr_t paddr;
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	event = crtc->state->event;
 	if (event) {
 		crtc->state->event = NULL;
@@ -303,14 +324,12 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			drm_crtc_send_vblank_event(crtc, event);
 		}
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	if (!fb)
-		return;
-
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
-
-	mxsfb_enable_axi_clk(mxsfb);
-	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
-	mxsfb_disable_axi_clk(mxsfb);
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		mxsfb_enable_axi_clk(mxsfb);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+		mxsfb_disable_axi_clk(mxsfb);
+	}
 }
-- 
2.17.1
