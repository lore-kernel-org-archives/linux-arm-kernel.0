From: net147@gmail.com (Jonathan Liu)
Date: Sun,  9 Jul 2017 17:43:27 +1000
Subject: [PATCH] drm/sun4i: Implement drm_driver lastclose to restore fbdev
 console
Message-ID: <20170709074327.4953-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drm_driver lastclose callback is called when the last userspace
DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
the fbdev console otherwise the fbdev console will stop working.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index abc7d8fe06b4..c434540d409c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -25,12 +25,20 @@
 #include "sun4i_framebuffer.h"
 #include "sun4i_tcon.h"
 
+static void sun4i_drm_lastclose(struct drm_device *dev)
+{
+	struct sun4i_drv *drv = dev->dev_private;
+
+	drm_fbdev_cma_restore_mode(drv->fbdev);
+}
+
 DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
 
 static struct drm_driver sun4i_drv_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
 
 	/* Generic Operations */
+	.lastclose		= sun4i_drm_lastclose,
 	.fops			= &sun4i_drv_fops,
 	.name			= "sun4i-drm",
 	.desc			= "Allwinner sun4i Display Engine",
-- 
2.13.2
