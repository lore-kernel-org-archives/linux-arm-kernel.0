From: net147@gmail.com (Jonathan Liu)
Date: Tue, 30 Aug 2016 16:55:00 +1000
Subject: [PATCH] drm/sun4i: rgb: add missing calls to drm_panel_{prepare,
 unprepare}
Message-ID: <20160830065500.31847-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the enable-gpios property of a simple panel in device tree is set,
the GPIO is not toggled on/off because of missing calls to
drm_panel_prepare and drm_panel_unprepare.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f5bbac6..d6943e9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -151,6 +151,7 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
+	drm_panel_prepare(tcon->panel);
 	drm_panel_enable(tcon->panel);
 	sun4i_tcon_channel_enable(tcon, 0);
 }
@@ -165,6 +166,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	sun4i_tcon_channel_disable(tcon, 0);
 	drm_panel_disable(tcon->panel);
+	drm_panel_unprepare(tcon->panel);
 }
 
 static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
-- 
2.9.3
