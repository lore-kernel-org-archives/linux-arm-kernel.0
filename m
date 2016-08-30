From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 30 Aug 2016 20:22:23 +0800
Subject: [PATCH] drm/sun4i: Clear encoder->bridge if a bridge is not found
Message-ID: <20160830122223.21377-1-wens@csie.org>
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
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index d4e52522ec53..ee0795152a33 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -154,8 +154,7 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 	if (!IS_ERR(tcon->panel))
 		drm_panel_enable(tcon->panel);
 
-	if (!IS_ERR(encoder->bridge))
-		drm_bridge_enable(encoder->bridge);
+	drm_bridge_enable(encoder->bridge);
 
 	sun4i_tcon_channel_enable(tcon, 0);
 }
@@ -170,8 +169,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	sun4i_tcon_channel_disable(tcon, 0);
 
-	if (!IS_ERR(encoder->bridge))
-		drm_bridge_disable(encoder->bridge);
+	drm_bridge_disable(encoder->bridge);
 
 	if (!IS_ERR(tcon->panel))
 		drm_panel_disable(tcon->panel);
@@ -230,6 +228,9 @@ int sun4i_rgb_init(struct drm_device *drm)
 		return 0;
 	}
 
+	if (IS_ERR(encoder->bridge))
+		encoder->bridge = NULL;
+
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
@@ -266,7 +267,7 @@ int sun4i_rgb_init(struct drm_device *drm)
 		}
 	}
 
-	if (!IS_ERR(encoder->bridge)) {
+	if (encoder->bridge) {
 		encoder->bridge->encoder = &rgb->encoder;
 
 		ret = drm_bridge_attach(drm, encoder->bridge);
-- 
2.9.3
