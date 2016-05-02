From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  2 May 2016 12:59:48 +0200
Subject: [PATCH] drm/sun4i: add COMMON_CLK dependency
Message-ID: <1462186805-2211918-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i drm driver uses the clk-provider interfaces, which are not available
when CONFIG_COMMON_CLK is disabled:

drivers/gpu/drm/sun4i/sun4i_dotclock.c:19:16: error: field 'hw' has incomplete type
  struct clk_hw hw;
In file included from ../include/asm-generic/bug.h:13:0,
                 from ../arch/arm/include/asm/bug.h:59,
                 from ../include/linux/bug.h:4,
                 from ../include/linux/io.h:23,
                 from ../include/linux/clk-provider.h:14,
                 from ../drivers/gpu/drm/sun4i/sun4i_dotclock.c:13:
drivers/gpu/drm/sun4i/sun4i_dotclock.c: In function 'hw_to_dclk':
include/linux/kernel.h:831:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
...

This adds a Kconfig dependency to prevent the driver from being enabled
in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
---
 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 99510e64e91a..a4b357db8856 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -1,6 +1,6 @@
 config DRM_SUN4I
 	tristate "DRM Support for Allwinner A10 Display Engine"
-	depends on DRM && ARM
+	depends on DRM && ARM && COMMON_CLK
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
-- 
2.7.0
