From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 May 2017 18:09:31 +0200
Subject: [PATCH v4 06/11] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <288881a7a27fbf9f0ca20ad574314c537b975560.1495900658.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that the total vertical resolution needs to be doubled when
we're not in interlaced. Make sure that is the case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 61e1de77831d..d9791292553e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -229,7 +229,7 @@ EXPORT_SYMBOL(sun4i_tcon0_mode_set);
 void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 			  struct drm_display_mode *mode)
 {
-	unsigned int bp, hsync, vsync;
+	unsigned int bp, hsync, vsync, vtotal;
 	u8 clk_delay;
 	u32 val;
 
@@ -276,12 +276,30 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 		     SUN4I_TCON1_BASIC3_H_TOTAL(mode->crtc_htotal) |
 		     SUN4I_TCON1_BASIC3_H_BACKPORCH(bp));
 
-	/* Set vertical display timings */
 	bp = mode->crtc_vtotal - mode->crtc_vsync_start;
 	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
-			 mode->vtotal, bp);
+			 mode->crtc_vtotal, bp);
+
+	/*
+	 * The vertical resolution needs to be doubled in all
+	 * cases. We could use crtc_vtotal and always multiply by two,
+	 * but that leads to a rounding error in interlace when vtotal
+	 * is odd.
+	 *
+	 * This happens with TV's PAL for example, where vtotal will
+	 * be 625, crtc_vtotal 312, and thus crtc_vtotal * 2 will be
+	 * 624, which apparently confuses the hardware.
+	 *
+	 * To work around this, we will always use vtotal, and
+	 * multiply by two only if we're not in interlace.
+	 */
+	vtotal = mode->vtotal;
+	if (!(mode->flags & DRM_MODE_FLAG_INTERLACE))
+		vtotal = vtotal * 2;
+
+	/* Set vertical display timings */
 	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
-		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
+		     SUN4I_TCON1_BASIC4_V_TOTAL(vtotal) |
 		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
-- 
git-series 0.9.1
