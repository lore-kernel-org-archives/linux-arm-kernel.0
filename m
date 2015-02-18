From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 17:09:25 +0100
Subject: drm: bridge: ps8622 and ptn3460 depend on gpiolib
Message-ID: <19803561.otRxsE7o5u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ptn3460 driver recently started usign the gpiod interface
which is only available on platforms that come with GPIOLIB
support, resulting in a compile-time error:

drivers/gpu/drm/bridge/ps8622.c: In function 'ps8622_pre_enable':
drivers/gpu/drm/bridge/ps8622.c:368:2: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
  gpiod_set_value(ps8622->gpio_rst, 0);
  ^
drivers/gpu/drm/bridge/ps8622.c: In function 'ps8622_probe':
drivers/gpu/drm/bridge/ps8622.c:584:2: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
  ps8622->gpio_slp = devm_gpiod_get(dev, "sleep");
  ^

Similarly, the newly added ps8622 driver started out with the same
problem.

This patch adds explicit Kconfig dependencies to avoid trying to
build invalid configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f1336e6afb ("drm/bridge: Add I2C based driver for ps8622/ps8625 bridge")
Fixes: af478d8823 ("drm/bridge: ptn3460: use gpiod interface")

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index acef3223772c..8f068a0e86a5 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -7,6 +7,7 @@ config DRM_PTN3460
 	tristate "PTN3460 DP/LVDS bridge"
 	depends on DRM
 	depends on OF
+	depends on GPIOLIB
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	---help---
@@ -16,6 +17,7 @@ config DRM_PS8622
 	tristate "Parade eDP/LVDS bridge"
 	depends on DRM
 	depends on OF
+	depends on GPIOLIB
 	select DRM_PANEL
 	select DRM_KMS_HELPER
 	select BACKLIGHT_LCD_SUPPORT
