From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Mar 2017 09:56:28 +0100
Subject: [PATCH 9/15] drm/sun4i: tcon: Pass the encoder to the mode set
 functions
In-Reply-To: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <e7791e7b68ed5c05d1d84c590f920c3d0cb7fb3a.1488876832.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mode set function need some changes based on which encoder is being
used. Make sure we can differentiate between our encoders by passing the
encoder structure asking for the mode set.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_tv.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 1147451eb993..1d4a59a44d04 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -173,7 +173,7 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
 	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
 	struct sun4i_tcon *tcon = rgb->tcon;
 
-	sun4i_tcon0_mode_set(tcon, mode);
+	sun4i_tcon0_mode_set(tcon, encoder, mode);
 
 	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 7461ae107e54..d2335f109601 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -127,7 +127,7 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
 	return delay;
 }
 
-void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
+void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
 			  struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
@@ -200,7 +200,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 }
 EXPORT_SYMBOL(sun4i_tcon0_mode_set);
 
-void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
+void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
 			  struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f636343a935d..95b7e76eb1f8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -190,9 +190,9 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 /* Mode Related Controls */
 void sun4i_tcon_switch_interlace(struct sun4i_tcon *tcon,
 				 bool enable);
-void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
+void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
 			  struct drm_display_mode *mode);
-void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
+void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
 			  struct drm_display_mode *mode);
 
 #endif /* __SUN4I_TCON_H__ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 32ed5fdf0c4d..2d36df092a6a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -389,7 +389,7 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	struct sun4i_tcon *tcon = drv->tcon;
 	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
 
-	sun4i_tcon1_mode_set(tcon, mode);
+	sun4i_tcon1_mode_set(tcon, encoder, mode);
 
 	/* Enable and map the DAC to the output */
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
-- 
git-series 0.8.11
