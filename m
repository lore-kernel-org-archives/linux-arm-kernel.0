From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  6 Nov 2017 14:58:43 +0100
Subject: [PATCH] drm/rockchip: add CONFIG_OF dependency for lvds
Message-ID: <20171106135852.1355487-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build-testing on randconfig kernels revealed a dependency in the
newly added lvds sub-driver:

drivers/gpu/drm/rockchip/rockchip_lvds.c: In function 'rockchip_lvds_bind':
drivers/gpu/drm/rockchip/rockchip_lvds.c:380:24: error: 'struct drm_bridge' has no member named 'of_node'
   remote = lvds->bridge->of_node;

We could work around that in the code, adding a Kconfig dependency
seems easier.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 3c70c6224bd2..0ccc76217ee4 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -60,7 +60,7 @@ config ROCKCHIP_INNO_HDMI
 config ROCKCHIP_LVDS
 	bool "Rockchip LVDS support"
 	depends on DRM_ROCKCHIP
-	depends on PINCTRL
+	depends on PINCTRL && OF
 	help
 	  Choose this option to enable support for Rockchip LVDS controllers.
 	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
-- 
2.9.0
