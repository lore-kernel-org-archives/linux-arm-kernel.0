From: net147@gmail.com (Jonathan Liu)
Date: Mon, 26 Sep 2016 20:21:45 +1000
Subject: [PATCH][v2] drm/sun4i: rgb: Enable panel after controller
Message-ID: <20160926102146.19129-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The panel should be enabled after the controller so that we do not have
visual glitches on the panel while the controller is setup. Similarly,
the panel should be disabled before the controller.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
Changes in v2:
 - Changed the commit message to be clearer

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
