From: net147@gmail.com (Jonathan Liu)
Date: Wed, 21 Sep 2016 23:03:04 +1000
Subject: [PATCH] drm/sun4i: rgb: Enable panel after controller
Message-ID: <20160921130304.3486-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The panel should be enabled after the controller so that the panel
prepare/enable delays are properly taken into account. Similarly, the
panel should be disabled before the controller so that the panel
unprepare/disable delays are properly taken into account.

This is useful for avoiding visual glitches.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index c3ff10f..4e4bea6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -152,15 +152,16 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (!IS_ERR(tcon->panel))
 		drm_panel_prepare(tcon->panel);
-		drm_panel_enable(tcon->panel);
-	}
 
 	/* encoder->bridge can be NULL; drm_bridge_enable checks for it */
 	drm_bridge_enable(encoder->bridge);
 
 	sun4i_tcon_channel_enable(tcon, 0);
+
+	if (!IS_ERR(tcon->panel))
+		drm_panel_enable(tcon->panel);
 }
 
 static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
@@ -171,15 +172,16 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Disabling RGB output\n");
 
+	if (!IS_ERR(tcon->panel))
+		drm_panel_disable(tcon->panel);
+
 	sun4i_tcon_channel_disable(tcon, 0);
 
 	/* encoder->bridge can be NULL; drm_bridge_disable checks for it */
 	drm_bridge_disable(encoder->bridge);
 
-	if (!IS_ERR(tcon->panel)) {
-		drm_panel_disable(tcon->panel);
+	if (!IS_ERR(tcon->panel))
 		drm_panel_unprepare(tcon->panel);
-	}
 }
 
 static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
-- 
2.10.0
