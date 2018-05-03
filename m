From: satendra.t@samsung.com (Satendra Singh Thakur)
Date: Thu,  3 May 2018 14:06:00 +0530
Subject: [PATCH 01/13] drm/kms/mode/atmel-hlcdc: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
References: <cover.1525087679.git.satendra.t@samsung.com>
 <CGME20180503083608epcas5p4c9cda0f0b42af8232691baa7cbde96c9@epcas5p4.samsung.com>
Message-ID: <b9ad5cb3c236c149b14df031d0a50226ee1fbff7.1525087679.git.satendra.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid duplicate logic for the same:
There is a function in drm-core to calculate display timing parameters:
horizontal front porch, back porch, sync length,
vertical front porch, back porch, sync length and
clock in Hz.
However, some drivers are still calculating these parameters themselves.
Therefore, there is a duplication of the code.
This patch series replaces this redundant code with the function
drm_display_mode_to_videomode.
This removes nearly 100 redundant lines from the related drivers.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c1ea5c3..3dfeef0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 
 #include "atmel_hlcdc_dc.h"
+#include <video/videomode.h>
 
 #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
 
@@ -393,27 +394,24 @@ enum drm_mode_status
 atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
 			  const struct drm_display_mode *mode)
 {
-	int vfront_porch = mode->vsync_start - mode->vdisplay;
-	int vback_porch = mode->vtotal - mode->vsync_end;
-	int vsync_len = mode->vsync_end - mode->vsync_start;
-	int hfront_porch = mode->hsync_start - mode->hdisplay;
-	int hback_porch = mode->htotal - mode->hsync_end;
-	int hsync_len = mode->hsync_end - mode->hsync_start;
-
-	if (hsync_len > dc->desc->max_spw + 1 || hsync_len < 1)
+	struct videomode vm;
+
+	drm_display_mode_to_videomode(mode, &vm);
+
+	if (vm.hsync_len > dc->desc->max_spw + 1 || vm.hsync_len < 1)
 		return MODE_HSYNC;
 
-	if (vsync_len > dc->desc->max_spw + 1 || vsync_len < 1)
+	if (vm.vsync_len > dc->desc->max_spw + 1 || vm.vsync_len < 1)
 		return MODE_VSYNC;
 
-	if (hfront_porch > dc->desc->max_hpw + 1 || hfront_porch < 1 ||
-	    hback_porch > dc->desc->max_hpw + 1 || hback_porch < 1 ||
-	    mode->hdisplay < 1)
+	if (vm.hfront_porch > dc->desc->max_hpw + 1 || vm.hfront_porch < 1 ||
+	    vm.hback_porch > dc->desc->max_hpw + 1 || vm.hback_porch < 1 ||
+	    vm.hactive < 1)
 		return MODE_H_ILLEGAL;
 
-	if (vfront_porch > dc->desc->max_vpw + 1 || vfront_porch < 1 ||
-	    vback_porch > dc->desc->max_vpw || vback_porch < 0 ||
-	    mode->vdisplay < 1)
+	if (vm.vfront_porch > dc->desc->max_vpw + 1 || vm.vfront_porch < 1 ||
+	    vm.vback_porch > dc->desc->max_vpw || vm.vback_porch < 0 ||
+	    vm.vactive < 1)
 		return MODE_V_ILLEGAL;
 
 	return MODE_OK;
-- 
2.7.4
