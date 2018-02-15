From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Thu, 15 Feb 2018 18:54:48 +0100
Subject: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
Message-ID: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Differently from other Lcd signals, HSYNC and VSYNC signals
result inverted if their bits are cleared to 0.

Invert their settings of IO_POL register.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3c15cf2..aaf911a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 		     SUN4I_TCON0_BASIC3_H_SYNC(hsync));
 
 	/* Setup the polarity of the various signals */
-	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
 
-	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-- 
2.7.4
