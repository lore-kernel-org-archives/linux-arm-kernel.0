From: marex@denx.de (Marek Vasut)
Date: Mon,  2 Dec 2013 16:39:26 +0100
Subject: [PATCH 1/3] drm: Add LCD display clock polarity flags
Message-ID: <1385998768-23512-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DRM flags for the LCD display clock polarity so the pixelclk-active DT
property can be properly handled by drivers using the DRM API.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpu/drm/drm_modes.c | 5 +++++
 include/uapi/drm/drm_mode.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 85071a1..d1f3bfc 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -537,6 +537,11 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
 	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
 		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		dmode->flags |= DRM_MODE_FLAG_PIXELCLK_PPOL;
+	else if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		dmode->flags |= DRM_MODE_FLAG_PIXELCLK_NPOL;
+
 	drm_mode_set_name(dmode);
 
 	return 0;
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index f104c26..a6169ca 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -73,6 +73,9 @@
 #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM	(7<<14)
 #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF	(8<<14)
 
+/* CRTC LCD clock polarity flags. */
+#define DRM_MODE_FLAG_PIXELCLK_PPOL		(1<<19)
+#define DRM_MODE_FLAG_PIXELCLK_NPOL		(1<<20)
 
 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
-- 
1.8.4.2
