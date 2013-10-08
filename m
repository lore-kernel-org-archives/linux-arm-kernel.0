From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue,  8 Oct 2013 16:09:17 +0530
Subject: [PATCH] SHMOBILE: DRM: Fix backlight_device register and unregister
 undefined errors.
Message-ID: <1381228757-23144-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a BACKLIGHT_CLASS_DEVICE dependency to configure the
DRM_SHMOBILE. Without this patch, build system can lead to build failure.
This was observed during randconfig testing, in which DRM_SHMOBILE was
enabled w/o BACKLIGHT_CLASS_DEVICE being enabled. Following was the error:

 Building modules, stage 2.
  MODPOST 516 modules
ERROR: "backlight_device_register" [drivers/gpu/drm/shmobile/shmob-drm.ko] undefined!
ERROR: "backlight_device_unregister" [drivers/gpu/drm/shmobile/shmob-drm.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/gpu/drm/shmobile/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
index ca498d1..eaf822e 100644
--- a/drivers/gpu/drm/shmobile/Kconfig
+++ b/drivers/gpu/drm/shmobile/Kconfig
@@ -1,6 +1,6 @@
 config DRM_SHMOBILE
 	tristate "DRM Support for SH Mobile"
-	depends on DRM && (ARM || SUPERH)
+	depends on DRM && (ARM || SUPERH) && BACKLIGHT_CLASS_DEVICE
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
-- 
1.7.9.5
