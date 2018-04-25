From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 11:18:12 +0200
Subject: [PATCH 1/4] drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping
Message-ID: <20180425091815.16264-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Depending on the kernel configuration, early ARM architecture setup code
may have attached the GPU to a DMA/IOMMU mapping that transparently uses
the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
backed buffers (a special bit in the GPU's MMU page tables indicates the
memory path to take: via the SMMU or directly to the memory controller).
Transparently backing DMA memory with an IOMMU prevents Nouveau from
properly handling such memory accesses and causes memory access faults.

As a side-note: buffers other than those allocated in instance memory
don't need to be physically contiguous from the GPU's perspective since
the GPU can map them into contiguous buffers using its own MMU. Mapping
these buffers through the IOMMU is unnecessary and will even lead to
performance degradation because of the additional translation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
I had already sent this out independently to fix a regression that was
introduced in v4.16, but then Christoph pointed out that it should've
been sent to a wider audience and should use a core API rather than
calling into architecture code directly.

I've added it to this series for easier reference and to show the need
for the new API.

 .../drm/nouveau/nvkm/engine/device/tegra.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 78597da6313a..23428a7056e9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -19,6 +19,11 @@
  * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  * DEALINGS IN THE SOFTWARE.
  */
+
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#endif
+
 #include <core/tegra.h>
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 #include "priv.h"
@@ -105,6 +110,20 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 	unsigned long pgsize_bitmap;
 	int ret;
 
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+	if (dev->archdata.mapping) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+		arm_iommu_release_mapping(mapping);
+		arm_iommu_detach_device(dev);
+
+		if (dev->archdata.dma_coherent)
+			set_dma_ops(dev, &arm_coherent_dma_ops);
+		else
+			set_dma_ops(dev, &arm_dma_ops);
+	}
+#endif
+
 	if (!tdev->func->iommu_bit)
 		return;
 
-- 
2.17.0
