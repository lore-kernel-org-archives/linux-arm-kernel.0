From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 11:18:15 +0200
Subject: [PATCH 4/4] drm/nouveau: tegra: Use dma_iommu_detach_device()
In-Reply-To: <20180425091815.16264-1-thierry.reding@gmail.com>
References: <20180425091815.16264-1-thierry.reding@gmail.com>
Message-ID: <20180425091815.16264-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Use the new dma_iommu_detach_device() function to replace the open-coded
equivalent.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../drm/nouveau/nvkm/engine/device/tegra.c    | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 23428a7056e9..c0a7f3839cbb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -20,10 +20,6 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-#include <asm/dma-iommu.h>
-#endif
-
 #include <core/tegra.h>
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 #include "priv.h"
@@ -110,19 +106,8 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 	unsigned long pgsize_bitmap;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-	if (dev->archdata.mapping) {
-		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-
-		arm_iommu_release_mapping(mapping);
-		arm_iommu_detach_device(dev);
-
-		if (dev->archdata.dma_coherent)
-			set_dma_ops(dev, &arm_coherent_dma_ops);
-		else
-			set_dma_ops(dev, &arm_dma_ops);
-	}
-#endif
+	/* make sure we can use the IOMMU exclusively */
+	dma_iommu_detach_device(dev);
 
 	if (!tdev->func->iommu_bit)
 		return;
-- 
2.17.0
