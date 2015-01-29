From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:16:38 +0100
Subject: [PATCH] drm: shmobile: fix Kconfig dependencies
Message-ID: <101632463.PMlAvjKhba@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shmobile drm driver selects BACKLIGHT_CLASS_DEVICE
as of 0a5a5499ad88 "drm: shmobile: Add dependency on
BACKLIGHT_CLASS_DEVICE", but that option in turn depends
on BACKLIGHT_LCD_SUPPORT, so we actually have to select
both, or alternatively use 'depends on BACKLIGHT_CLASS_DEVICE'.

Further, the driver uses FB_SH_MOBILE_MERAM if that is
enabled, but this breaks if MERAM is a module while
the DRM driver is built-in. To solve this, add a dependency
on "FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM", which forces
DRM_SHMOBILE to be a module if FB_SH_MOBILE_MERAM set to 'm'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
index a50fe0eeaa0d..8d17d00ddb4b 100644
--- a/drivers/gpu/drm/shmobile/Kconfig
+++ b/drivers/gpu/drm/shmobile/Kconfig
@@ -2,7 +2,9 @@ config DRM_SHMOBILE
 	tristate "DRM Support for SH Mobile"
 	depends on DRM && ARM
 	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
 	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	select DRM_KMS_CMA_HELPER
