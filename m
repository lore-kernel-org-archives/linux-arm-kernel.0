From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  2 May 2016 13:00:26 +0200
Subject: [PATCH] drm/fsl-dcu: add COMMON_CLK dependency
Message-ID: <1462186839-2224021-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl dcu now uses the clk-provider interfaces, which are not available
when CONFIG_COMMON_CLK is disabled:

drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c: In function 'fsl_dcu_drm_probe':
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:362:20: error: implicit declaration of function '__clk_get_name' [-Werror=implicit-function-declaration]
  pix_clk_in_name = __clk_get_name(pix_clk_in);

This adds a Kconfig dependency to prevent the driver from being enabled
in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2d701449bce1 ("drm/fsl-dcu: use common clock framework for pixel clock divider")
---
 drivers/gpu/drm/fsl-dcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index c78cf3f605d0..b9c714de6e40 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -1,6 +1,6 @@
 config DRM_FSL_DCU
 	tristate "DRM Support for Freescale DCU"
-	depends on DRM && OF && ARM
+	depends on DRM && OF && ARM && COMMON_CLK
 	select BACKLIGHT_CLASS_DEVICE
 	select BACKLIGHT_LCD_SUPPORT
 	select DRM_KMS_HELPER
-- 
2.7.0
