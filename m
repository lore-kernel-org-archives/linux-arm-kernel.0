From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Oct 2016 09:57:05 +0200
Subject: [PATCH v6 1/5] drm/sun4i: rgb: Remove the bridge enable/disable
 functions
In-Reply-To: <cover.2ec28e2292f37131839babc08427ef9f1aece26a.1475740611.git-series.maxime.ripard@free-electrons.com>
References: <cover.2ec28e2292f37131839babc08427ef9f1aece26a.1475740611.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5100ee37c9bbb53f8227bd38f1d3160e507c489d.1475740611.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atomic helpers already call the drm_bridge_enable on our behalf,
there's no need to do it a second time.

Reported-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 6 ------
 1 file changed, 0 insertions(+), 6 deletions(-)

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
git-series 0.8.10
