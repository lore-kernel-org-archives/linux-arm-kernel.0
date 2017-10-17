From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:14 +0200
Subject: [PATCH 07/23] drm/sun4i: tcon: Move out the tcon0 common setup
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <03df3b0c8a1823b39a2ae0b190722f3623e76894.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some channel0 setup has to be done, no matter what the output interface is
(RGB, CPU, LVDS). Move that code into a common function in order to avoid
duplication.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 7ecd4f7c8411..f69bcdf11cb8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -158,15 +158,26 @@ static int sun4i_tcon_get_clk_delay(const struct drm_display_mode *mode,
 	return delay;
 }
 
-static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-				 struct drm_display_mode *mode)
+static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
+					const struct drm_display_mode *mode)
+{
+	/* Configure the dot clock */
+	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+
+	/* Set the resolution */
+	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
+		     SUN4I_TCON0_BASIC0_X(mode->crtc_hdisplay) |
+		     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
+}
+
+static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
+				     const struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
 
-	/* Configure the dot clock */
-	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
@@ -174,11 +185,6 @@ static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 			   SUN4I_TCON0_CTL_CLK_DELAY_MASK,
 			   SUN4I_TCON0_CTL_CLK_DELAY(clk_delay));
 
-	/* Set the resolution */
-	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
-		     SUN4I_TCON0_BASIC0_X(mode->crtc_hdisplay) |
-		     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
-
 	/*
 	 * This is called a backporch in the register documentation,
 	 * but it really is the back porch + hsync
@@ -329,7 +335,7 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 {
 	switch (encoder->encoder_type) {
 	case DRM_MODE_ENCODER_NONE:
-		sun4i_tcon0_mode_set(tcon, mode);
+		sun4i_tcon0_mode_set_rgb(tcon, mode);
 		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_TVDAC:
-- 
git-series 0.9.1
