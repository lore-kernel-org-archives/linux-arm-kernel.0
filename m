From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:43 +0200
Subject: [PATCH v3 14/21] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a8d8a93ddbac69e5dddd9c89a147f8cf2ad043a4.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that the total vertical resolution needs to be doubled when
we're not in interlaced. Make sure that is the case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 62e254aedb57..a0f9a8a516c7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -153,7 +153,7 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
 void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 			  struct drm_display_mode *mode)
 {
-	unsigned int bp, hsync, vsync;
+	unsigned int bp, hsync, vsync, vtotal;
 	u8 clk_delay;
 	u32 val = 0;
 
@@ -192,9 +192,26 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
 			 mode->crtc_vtotal, bp);
 
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
 	/* Set vertical display timings */
 	regmap_write(tcon->regs, SUN4I_TCON0_BASIC2_REG,
-		     SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal * 2) |
+		     SUN4I_TCON0_BASIC2_V_TOTAL(vtotal) |
 		     SUN4I_TCON0_BASIC2_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
@@ -279,9 +296,9 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	/* Set vertical display timings */
 	bp = mode->crtc_vtotal - mode->crtc_vsync_start;
 	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
-			 mode->vtotal, bp);
+			 mode->crtc_vtotal, bp);
 	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
-		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
+		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->crtc_vtotal * 2) |
 		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
-- 
git-series 0.9.1
