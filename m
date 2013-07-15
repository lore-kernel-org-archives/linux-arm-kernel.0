From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:57:00 +0200
Subject: [PATCH 15/22] drm: Add the lacking DRM_MODE_FLAG_* for matching the
 DISPLAY_FLAGS_*
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-16-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that fix, drivers using the drm_display_mode_from_videomode
  function will not be able to get certain information because
  some DISPLAY_FLAGS_* have no corresponding DRM_MODE_FLAG_*.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/gpu/drm/drm_modes.c |    9 +++++++++
 include/uapi/drm/drm_mode.h |   32 ++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index a6729bf..443bb94 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -537,6 +537,15 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
 	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
 		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
+	if (vm->flags & DISPLAY_FLAGS_DE_LOW)
+		dmode->flags |= DRM_MODE_FLAG_NDATEN;
+	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
+		dmode->flags |= DRM_MODE_FLAG_PDATEN;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		dmode->flags |= DRM_MODE_FLAG_PPIXDATEDGE;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		dmode->flags |= DRM_MODE_FLAG_NPIXDATEDGE;
+
 	drm_mode_set_name(dmode);
 
 	return 0;
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 53db7ce..5ec85f9 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -44,20 +44,24 @@
 
 /* Video mode flags */
 /* bit compatible with the xorg definitions. */
-#define DRM_MODE_FLAG_PHSYNC	(1<<0)
-#define DRM_MODE_FLAG_NHSYNC	(1<<1)
-#define DRM_MODE_FLAG_PVSYNC	(1<<2)
-#define DRM_MODE_FLAG_NVSYNC	(1<<3)
-#define DRM_MODE_FLAG_INTERLACE	(1<<4)
-#define DRM_MODE_FLAG_DBLSCAN	(1<<5)
-#define DRM_MODE_FLAG_CSYNC	(1<<6)
-#define DRM_MODE_FLAG_PCSYNC	(1<<7)
-#define DRM_MODE_FLAG_NCSYNC	(1<<8)
-#define DRM_MODE_FLAG_HSKEW	(1<<9) /* hskew provided */
-#define DRM_MODE_FLAG_BCAST	(1<<10)
-#define DRM_MODE_FLAG_PIXMUX	(1<<11)
-#define DRM_MODE_FLAG_DBLCLK	(1<<12)
-#define DRM_MODE_FLAG_CLKDIV2	(1<<13)
+#define DRM_MODE_FLAG_PHSYNC		(1<<0)
+#define DRM_MODE_FLAG_NHSYNC		(1<<1)
+#define DRM_MODE_FLAG_PVSYNC		(1<<2)
+#define DRM_MODE_FLAG_NVSYNC		(1<<3)
+#define DRM_MODE_FLAG_INTERLACE		(1<<4)
+#define DRM_MODE_FLAG_DBLSCAN		(1<<5)
+#define DRM_MODE_FLAG_CSYNC		(1<<6)
+#define DRM_MODE_FLAG_PCSYNC		(1<<7)
+#define DRM_MODE_FLAG_NCSYNC		(1<<8)
+#define DRM_MODE_FLAG_HSKEW		(1<<9) /* hskew provided */
+#define DRM_MODE_FLAG_BCAST		(1<<10)
+#define DRM_MODE_FLAG_PIXMUX		(1<<11)
+#define DRM_MODE_FLAG_DBLCLK		(1<<12)
+#define DRM_MODE_FLAG_CLKDIV2		(1<<13)
+#define DRM_MODE_FLAG_PDATEN		(1<<14)
+#define DRM_MODE_FLAG_NDATEN		(1<<15)
+#define DRM_MODE_FLAG_PPIXDATEDGE	(1<<16)
+#define DRM_MODE_FLAG_NPIXDATEDGE	(1<<17)
 
 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
-- 
1.7.9.5
