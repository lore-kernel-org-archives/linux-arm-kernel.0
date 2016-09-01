From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  1 Sep 2016 14:13:32 +0800
Subject: [PATCH v2] drm/sun4i: Clear encoder->bridge if a bridge is not found
Message-ID: <20160901061332.1803-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KMS helpers (drm_atomic_helper_check_modeset/mode_fixup) pass
encoder->bridge directly to drm_bridge_mode_fixup, which expects a
valid pointer, or NULL (in which case it just returns).

Clear encoder->bridge if a bridge is not found, instead of keeping
the ERR_PTR value.

Since other drm_bridge functions also follow this pattern of checking
for a non-NULL pointer, we can drop the ifs around the calls and just
pass the pointer directly.

Fixes: 894f5a9f4b4a ("drm/sun4i: Add bridge support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2:

  - Add comments stating encoder->bridge can be NULL and drm_bridge_*
    functions check for it.
  - Move clearing of encoder->bridge to if-else block of bridge setup
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index d4e52522ec53..d69847b243af 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -154,8 +154,8 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 	if (!IS_ERR(tcon->panel))
 		drm_panel_enable(tcon->panel);
 
-	if (!IS_ERR(encoder->bridge))
-		drm_bridge_enable(encoder->bridge);
+	/* encoder->bridge can be NULL; drm_bridge_enable checks for it */
+	drm_bridge_enable(encoder->bridge);
 
 	sun4i_tcon_channel_enable(tcon, 0);
 }
@@ -170,8 +170,8 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	sun4i_tcon_channel_disable(tcon, 0);
 
-	if (!IS_ERR(encoder->bridge))
-		drm_bridge_disable(encoder->bridge);
+	/* encoder->bridge can be NULL; drm_bridge_disable checks for it */
+	drm_bridge_disable(encoder->bridge);
 
 	if (!IS_ERR(tcon->panel))
 		drm_panel_disable(tcon->panel);
@@ -274,6 +274,8 @@ int sun4i_rgb_init(struct drm_device *drm)
 			dev_err(drm->dev, "Couldn't attach our bridge\n");
 			goto err_cleanup_connector;
 		}
+	} else {
+		encoder->bridge = NULL;
 	}
 
 	return 0;
-- 
2.9.3
