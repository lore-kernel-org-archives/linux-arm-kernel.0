From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:59 +0200
Subject: [PATCH 14/22] staging: imx-drm: use of_get_display_timings.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-15-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment on top of of_get_drm_display_mode says:
 * This function is expensive and should only be used, if only one mode is to be
 * read from DT. To get multiple modes start with of_get_display_timings and
 * work with that instead.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/staging/imx-drm/parallel-display.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index cea9f14..fee9b10 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -23,6 +23,8 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <linux/videodev2.h>
+#include <video/videomode.h>
+#include <video/of_display_timing.h>
 
 #include "imx-drm.h"
 
@@ -74,11 +76,23 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 
 	if (np) {
 		struct drm_display_mode *mode = drm_mode_create(connector->dev);
-		of_get_drm_display_mode(np, &imxpd->mode, 0);
-		drm_mode_copy(mode, &imxpd->mode);
-		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
-		drm_mode_probed_add(connector, mode);
-		num_modes++;
+		struct display_timings *timings;
+		struct videomode vm;
+		int np_num_mode;
+
+		timings = of_get_display_timings(np);
+		for (np_num_mode = 0; np_num_mode < timings->num_timings;
+			np_num_mode++, num_modes++) {
+			if (videomode_from_timings(timings, &vm, np_num_mode))
+				break;
+			drm_display_mode_from_videomode(&vm, mode);
+			mode->type = DRM_MODE_TYPE_DRIVER;
+			if (timings->native_mode == np_num_mode)
+				mode->type |= DRM_MODE_TYPE_PREFERRED;
+
+			drm_mode_set_name(mode);
+			drm_mode_probed_add(connector, mode);
+		}
 	}
 
 	return num_modes;
-- 
1.7.9.5
