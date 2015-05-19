From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 14:53:26 +0200
Subject: [PATCH] drm/nouveau/platform: add IOMMU dependency
Message-ID: <2918377.0irYYn09PU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added iommu code in the nouveau driver fails to build
when the IOMMU support is disabled:

drivers/gpu/drm/nouveau/nouveau_platform.c: In function 'nouveau_platform_probe_iommu':
drivers/gpu/drm/nouveau/nouveau_platform.c:113:41: error: 'const struct iommu_ops' has no mem

To avoid the build error, this now adds an explicit dependency on the
IOMMU implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 58fd9375c2c5 ("drm/nouveau/platform: probe IOMMU if present")

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 5ab13e7939db..18dfa4af60ea 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -28,6 +28,7 @@ config DRM_NOUVEAU
 config NOUVEAU_PLATFORM_DRIVER
 	bool "Nouveau (NVIDIA) SoC GPUs"
 	depends on DRM_NOUVEAU && ARCH_TEGRA
+	depends on IOMMU
 	default y
 	help
 	  Support for Nouveau platform driver, used for SoC GPUs as found
