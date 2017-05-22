From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 May 2017 17:20:08 +0200
Subject: [PATCH] drm/pl111: add ARM_AMBA dependency
Message-ID: <20170522152058.3346428-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is written in a way to enable compile-testing without CONFIG_ARM_AMBA,
but it just causes needless warnings:

drivers/gpu/drm/pl111/pl111_drv.c:149:26: error: 'pl111_drm_driver' defined but not used [-Werror=unused-variable]
drivers/gpu/drm/pl111/pl111_drv.c:81:12: error: 'pl111_modeset_init' defined but not used [-Werror=unused-function]

This removes the #ifdef instead, and adds a dependency on ARM_AMBA to
only let us build the driver when the base support is enabled.

Unfortunately, this requires removing one redundant 'select ARM_AMBA'
line from mach-s3c64xx to avoid a circular dependency.

It might be good to allow manually enabling ARM_AMBA when COMPILE_TEST
is turned on, but that should be a separate patch and may cause other
build regressions.

Fixes: bed41005e617 ("drm/pl111: Initial drm/kms driver for pl111")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/Kconfig     | 1 -
 drivers/gpu/drm/pl111/Kconfig     | 1 +
 drivers/gpu/drm/pl111/pl111_drv.c | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 459214fa20b4..5ee5ad74a3d6 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -40,7 +40,6 @@ config CPU_S3C6410
 
 config S3C64XX_PL080
 	def_bool DMADEVICES
-	select ARM_AMBA
 	select AMBA_PL08X
 
 config S3C64XX_SETUP_SDHCI
diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index 309f4fd52de7..e2f393fcc4bf 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -2,6 +2,7 @@ config DRM_PL111
 	tristate "DRM Support for PL111 CLCD Controller"
 	depends on DRM
 	depends on ARM || ARM64 || COMPILE_TEST
+	depends on ARM_AMBA
 	depends on COMMON_CLK
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 97095b1aa961..dce382f97f8c 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -179,7 +179,6 @@ static struct drm_driver pl111_drm_driver = {
 #endif
 };
 
-#ifdef CONFIG_ARM_AMBA
 static int pl111_amba_probe(struct amba_device *amba_dev,
 			    const struct amba_id *id)
 {
@@ -262,7 +261,6 @@ static struct amba_driver pl111_amba_driver = {
 };
 
 module_amba_driver(pl111_amba_driver);
-#endif /* CONFIG_ARM_AMBA */
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("ARM Ltd.");
-- 
2.9.0
