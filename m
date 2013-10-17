From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:01 +0200
Subject: [Patch v2][ 03/37] drm: Add the lacking DRM_MODE_FLAG_* for matching
 the DISPLAY_FLAGS_*
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that fix, drivers using the drm_display_mode_from_videomode
  function will not be able to get certain information because
  some DISPLAY_FLAGS_* have no corresponding DRM_MODE_FLAG_*.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel at linuxdriverproject.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/gpu/drm/drm_modes.c |    9 +++++++++
 include/uapi/drm/drm_mode.h |    4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index b073315..353aaae 100644
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
index bafe612..13843c7 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -66,6 +66,10 @@
 #define DRM_MODE_FLAG_3D_L_DEPTH_GFX_GFX_DEPTH	(1<<19)
 #define DRM_MODE_FLAG_3D_TOP_AND_BOTTOM		(1<<20)
 #define DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF	(1<<21)
+#define DRM_MODE_FLAG_PDATEN			(1<<22)
+#define DRM_MODE_FLAG_NDATEN			(1<<23)
+#define DRM_MODE_FLAG_PPIXDATEDGE		(1<<24)
+#define DRM_MODE_FLAG_NPIXDATEDGE		(1<<25)
 
 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
-- 
1.7.9.5
