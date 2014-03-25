From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 12:06:46 +0100
Subject: [PATCH] drm/bridge: PTN3460 needs DRM_KMS_HELPER
Message-ID: <17602160.PV0AMDU1du@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added PTN3460 device driver uses interfaces that
are provided by the KMS helper infrastructure, so we should
explicitly select that to avoid this linker error:

ERROR: "drm_helper_probe_single_connector_modes" [drivers/gpu/drm/bridge/ptn3460.ko] undefined!
ERROR: "drm_helper_connector_dpms" [drivers/gpu/drm/bridge/ptn3460.ko] undefined!

We have to drop the I2C dependency to avoid a circular dependency
chain, but that's ok because DRM already selects I2C.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this today doing randconfig builds on linux-next.

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f8db069..884923f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -1,4 +1,5 @@
 config DRM_PTN3460
 	tristate "PTN3460 DP/LVDS bridge"
-	depends on DRM && I2C
+	depends on DRM
+	select DRM_KMS_HELPER
 	---help---
