From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:44:02 +0200
Subject: [PATCH 5/8] drm/sun4i: Add encoder type argument to
 sun4i_tcon0_mode_set
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-6-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on the output type, we have to enable/disable some
bits conditionally.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f5e86fe..3d4eb05 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -179,7 +179,7 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
 	struct sun4i_drv *drv = rgb->drv;
 	struct sun4i_tcon *tcon = drv->tcon;
 
-	sun4i_tcon0_mode_set(tcon, mode);
+	sun4i_tcon0_mode_set(tcon, mode, DRM_MODE_ENCODER_DAC);
 
 	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index ea2906f..71d0087 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -124,7 +124,8 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
 }
 
 void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode)
+			  struct drm_display_mode *mode,
+			  int type)
 {
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 166064b..b040e10 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -188,7 +188,8 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 void sun4i_tcon_switch_interlace(struct sun4i_tcon *tcon,
 				 bool enable);
 void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode);
+			  struct drm_display_mode *mode,
+			  int type);
 void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 			  struct drm_display_mode *mode);
 
-- 
2.9.3
