From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:25:01 +0100
Subject: [PATCH v2 29/43] drm/sun4i: Make pitch even for GEM dumb alloc as per
 hardware constraint
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-30-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our hardware requires the pitch to be an even number when using YUV
formats with the frontend. Implement a driver-specific callback for GEM
dumb allocation that sets the pitch accordingly.

Since only the bpp is passed (and not the format), we cannot really
distinguish if this alignment is really required. Since it doesn't hurt
to align the pitch anyway, always do it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index ef773d36baf0..ccdeae6299eb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -28,6 +28,16 @@
 #include "sun4i_tcon.h"
 #include "sun8i_tcon_top.h"
 
+static int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
+				     struct drm_device *drm,
+				     struct drm_mode_create_dumb *args)
+{
+	/* The hardware only allows even pitches for YUV buffers. */
+	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), 2);
+
+	return drm_gem_cma_dumb_create_internal(file_priv, drm, args);
+}
+
 DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
 
 static struct drm_driver sun4i_drv_driver = {
@@ -42,7 +52,7 @@ static struct drm_driver sun4i_drv_driver = {
 	.minor			= 0,
 
 	/* GEM Operations */
-	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_create		= drm_sun4i_gem_dumb_create,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
 
-- 
2.19.1
