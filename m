From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 14:13:48 +0200
Subject: [PATCH v4 1/5] drm/sun4i: rgb: Remove the bridge enable/disable
 functions
In-Reply-To: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
References: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
Message-ID: <20160930121352.30184-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atomic helpers already call the drm_bridge_enable on our behalf,
there's no need to do it a second time.

Reported-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 4e4bea6f395c..d198ad7e5323 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -155,9 +155,6 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 	if (!IS_ERR(tcon->panel))
 		drm_panel_prepare(tcon->panel);
 
-	/* encoder->bridge can be NULL; drm_bridge_enable checks for it */
-	drm_bridge_enable(encoder->bridge);
-
 	sun4i_tcon_channel_enable(tcon, 0);
 
 	if (!IS_ERR(tcon->panel))
@@ -177,9 +174,6 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	sun4i_tcon_channel_disable(tcon, 0);
 
-	/* encoder->bridge can be NULL; drm_bridge_disable checks for it */
-	drm_bridge_disable(encoder->bridge);
-
 	if (!IS_ERR(tcon->panel))
 		drm_panel_unprepare(tcon->panel);
 }
-- 
2.9.3
