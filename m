From: satendra.t@samsung.com (Satendra Singh Thakur)
Date: Fri,  4 May 2018 13:53:25 +0530
Subject: [PATCH v1 09/13] drm/kms/mode/sun4i-tv: using helper func
 drm_display_mode_from_videomode for calculating timing parameters
In-Reply-To: <20180503110216.63bg3kw7cwppqbzx@flea>
References: <20180503110216.63bg3kw7cwppqbzx@flea>
 <CGME20180504082405epcas5p212d6a9fbb2a0baac4166cb5b68616055@epcas5p2.samsung.com>
Message-ID: <1525422205-2915-1-git-send-email-satendra.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid duplicate logic for horizonal/vertical sync_start/end
helper func drm_display_mode_from_videomode is used

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Acked-by: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---

 v1: Added acked-by fields

 drivers/gpu/drm/sun4i/sun4i_tv.c | 67 +++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index b070d52..7ffa930 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
+#include <video/videomode.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
@@ -147,16 +148,7 @@ struct tv_mode {
 	u16		front_porch;
 	u16		line_number;
 	u16		vblank_level;
-
-	u32		hdisplay;
-	u16		hfront_porch;
-	u16		hsync_len;
-	u16		hback_porch;
-
-	u32		vdisplay;
-	u16		vfront_porch;
-	u16		vsync_len;
-	u16		vback_porch;
+	struct videomode vm;
 
 	bool		yc_en;
 	bool		dac3_en;
@@ -223,16 +215,16 @@ static const struct tv_mode tv_modes[] = {
 		.back_porch	= 118,
 		.front_porch	= 32,
 		.line_number	= 525,
-
-		.hdisplay	= 720,
-		.hfront_porch	= 18,
-		.hsync_len	= 2,
-		.hback_porch	= 118,
-
-		.vdisplay	= 480,
-		.vfront_porch	= 26,
-		.vsync_len	= 2,
-		.vback_porch	= 17,
+		.vm = {
+			.hactive	= 720,
+			.hfront_porch	= 18,
+			.hsync_len	= 2,
+			.hback_porch	= 118,
+			.vactive	= 480,
+			.vfront_porch	= 26,
+			.vsync_len	= 2,
+			.vback_porch	= 17,
+		},
 
 		.vblank_level	= 240,
 
@@ -249,16 +241,16 @@ static const struct tv_mode tv_modes[] = {
 		.back_porch	= 138,
 		.front_porch	= 24,
 		.line_number	= 625,
-
-		.hdisplay	= 720,
-		.hfront_porch	= 3,
-		.hsync_len	= 2,
-		.hback_porch	= 139,
-
-		.vdisplay	= 576,
-		.vfront_porch	= 28,
-		.vsync_len	= 2,
-		.vback_porch	= 19,
+		.vm = {
+			.hactive	= 720,
+			.hfront_porch	= 3,
+			.hsync_len	= 2,
+			.hback_porch	= 139,
+			.vactive	= 576,
+			.vfront_porch	= 28,
+			.vsync_len	= 2,
+			.vback_porch	= 19,
+		},
 
 		.vblank_level	= 252,
 
@@ -311,9 +303,9 @@ static const struct tv_mode *sun4i_tv_find_tv_by_mode(const struct drm_display_m
 
 		DRM_DEBUG_DRIVER("Comparing mode %s vs %s (X: %d vs %d)",
 				 mode->name, tv_mode->name,
-				 mode->vdisplay, tv_mode->vdisplay);
+				 mode->vdisplay, tv_mode->vm.vactive);
 
-		if (mode->vdisplay == tv_mode->vdisplay)
+		if (mode->vdisplay == tv_mode->vm.vactive)
 			return tv_mode;
 	}
 
@@ -325,19 +317,10 @@ static void sun4i_tv_mode_to_drm_mode(const struct tv_mode *tv_mode,
 {
 	DRM_DEBUG_DRIVER("Creating mode %s\n", mode->name);
 
+	drm_display_mode_from_videomode(&tv_mode->vm, mode);
 	mode->type = DRM_MODE_TYPE_DRIVER;
 	mode->clock = 13500;
 	mode->flags = DRM_MODE_FLAG_INTERLACE;
-
-	mode->hdisplay = tv_mode->hdisplay;
-	mode->hsync_start = mode->hdisplay + tv_mode->hfront_porch;
-	mode->hsync_end = mode->hsync_start + tv_mode->hsync_len;
-	mode->htotal = mode->hsync_end  + tv_mode->hback_porch;
-
-	mode->vdisplay = tv_mode->vdisplay;
-	mode->vsync_start = mode->vdisplay + tv_mode->vfront_porch;
-	mode->vsync_end = mode->vsync_start + tv_mode->vsync_len;
-	mode->vtotal = mode->vsync_end  + tv_mode->vback_porch;
 }
 
 static void sun4i_tv_disable(struct drm_encoder *encoder)
-- 
2.7.4
