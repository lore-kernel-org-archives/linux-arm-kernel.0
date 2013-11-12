From: denis@eukrea.com (Denis Carikli)
Date: Tue, 12 Nov 2013 17:49:18 +0100
Subject: [PATCHv3 1/8] drm: Add the lacking DRM_MODE_FLAG_* for matching the
 DISPLAY_FLAGS_*
Message-ID: <1384274965-30549-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that fix, drivers using the drm_display_mode_from_videomode
  function will not be able to get certain information because
  some DISPLAY_FLAGS_* have no corresponding DRM_MODE_FLAG_*.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel at linuxdriverproject.org
Cc: Matt Sealey <neko@bakuhatsu.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Ville Syrjala <syrjala@sci.fi>
Cc: dri-devel at lists.freedesktop.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v3:
- Added some interested people in the Cc list.
- Removed a duplicated Cc.
- Changed the flags names to match the one in DISPLAY_FLAGS.
- Moved the flags out of the userspace headers.
- Updated the rest of the code accordingly.
---
 drivers/gpu/drm/drm_modes.c |    9 +++++++++
 include/drm/drm_mode.h      |   34 ++++++++++++++++++++++++++++++++++
 include/uapi/drm/drm_mode.h |    4 ++--
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 include/drm/drm_mode.h

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index fc2adb6..586c12f 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -537,6 +537,15 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
 	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
 		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
+	if (vm->flags & DISPLAY_FLAGS_DE_LOW)
+		dmode->flags |= DRM_MODE_FLAG_DE_LOW;
+	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
+		dmode->flags |= DRM_MODE_FLAG_DE_HIGH;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		dmode->flags |= DRM_MODE_FLAG_PIXDATA_POSEDGE;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		dmode->flags |= DRM_MODE_FLAG_PIXDATA_NEGEDGE;
+
 	drm_mode_set_name(dmode);
 
 	return 0;
diff --git a/include/drm/drm_mode.h b/include/drm/drm_mode.h
new file mode 100644
index 0000000..07e5259
--- /dev/null
+++ b/include/drm/drm_mode.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef _DRM_MODE_H
+#define _DRM_MODE_H
+
+#include <uapi/drm/drm_mode.h>
+
+/* DISPLAY_FLAGS DRM counterpart */
+#define DRM_MODE_FLAG_DE_HIGH			(1<<22)
+#define DRM_MODE_FLAG_DE_LOW			(1<<23)
+#define DRM_MODE_FLAG_PIXDATA_POSEDGE		(1<<24)
+#define DRM_MODE_FLAG_PIXDATA_NEGEDGE		(1<<25)
+
+#endif
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 28acbaf..5681897 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -24,8 +24,8 @@
  * IN THE SOFTWARE.
  */
 
-#ifndef _DRM_MODE_H
-#define _DRM_MODE_H
+#ifndef _UAPI_DRM_MODE_H
+#define _UAPI_DRM_MODE_H
 
 #include <linux/types.h>
 
-- 
1.7.9.5
