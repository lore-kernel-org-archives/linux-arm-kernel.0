From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 13 Jun 2014 14:06:16 +0100
Subject: [PATCH v3 2/2] drm/panel: make DRM_PANEL_LD9040 depend on SPI
Message-ID: <E1WvRBQ-0007wk-8e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than DRM_PANEL_LD9040 selecting SPI, which then results in an
increase in the probability of Kconf reporting circular dependencies
(we're one "select" away from that right now), make this depend on
SPI instead.  This is akin to having some driver select DRM.

Having some drivers depend on a subsystem, and other drivers select a
subsystem is a recipe for circular dependencies, and there's really no
need for it.

The potential circular dependency (which can be caused today by the
addition of selecting DRM_PANEL from DRM_IMX_LDB) is:

  symbol DMADEVICES is selected by SAMSUNG_DMADEV
  symbol SAMSUNG_DMADEV is selected by S3C64XX_PL080
  symbol S3C64XX_PL080 is selected by SPI_S3C64XX
  symbol SPI_S3C64XX depends on SPI
  symbol SPI is selected by DRM_PANEL_LD9040
  symbol DRM_PANEL_LD9040 depends on DRM_PANEL
  symbol DRM_PANEL is selected by DRM_IMX_LDB
  symbol DRM_IMX_LDB depends on MFD_SYSCON
  symbol MFD_SYSCON is selected by POWER_RESET_KEYSTONE
  symbol POWER_RESET_KEYSTONE depends on POWER_SUPPLY
  symbol POWER_SUPPLY is selected by HID_SONY
  symbol HID_SONY depends on NEW_LEDS
  symbol NEW_LEDS is selected by BACKLIGHT_ADP8860
  symbol BACKLIGHT_ADP8860 depends on BACKLIGHT_CLASS_DEVICE
  symbol BACKLIGHT_CLASS_DEVICE is selected by FB_MX3
  symbol FB_MX3 depends on MX3_IPU
  symbol MX3_IPU depends on DMADEVICES

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/panel/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d83958d39f43..bee9f72b3a93 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -18,8 +18,7 @@ config DRM_PANEL_SIMPLE
 
 config DRM_PANEL_LD9040
 	tristate "LD9040 RGB/SPI panel"
-	depends on OF
-	select SPI
+	depends on OF && SPI
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_S6E8AA0
-- 
1.8.3.1
