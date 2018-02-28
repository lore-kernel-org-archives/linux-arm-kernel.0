From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 13:51:58 +0100
Subject: [PATCH] drm/sun4i: init dclk_min_div & dclk_max_div inside encoder
 init functions
Message-ID: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_dclk_round_rate is called before sun4i_tcon_mode_set,
so it finds dclk_min_div and dclk_max_div set to 0 and fails
adding crtc.

Move dclk_min_div and dclk_max_div to encoders init functions.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index be3f14d..6e1abd6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -123,6 +123,10 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		return 0;
 	}
 
+	/* Init min and max clock divisor according to LVDS encoder */
+	tcon->dclk_min_div = 7;
+	tcon->dclk_max_div = 7;
+
 	drm_encoder_helper_add(&lvds->encoder,
 			       &sun4i_lvds_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 832f8f9..75ab3e5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -187,6 +187,10 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		return 0;
 	}
 
+	/* Init min and max clock divisor according to RGB encoder */
+	tcon->dclk_min_div = 6;
+	tcon->dclk_max_div = 127;
+
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e7c5e3c..ce89fd4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -277,8 +277,6 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 reg, val = 0;
 
-	tcon->dclk_min_div = 7;
-	tcon->dclk_max_div = 7;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
@@ -348,8 +346,6 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 val = 0;
 
-	tcon->dclk_min_div = 6;
-	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
-- 
2.7.4
