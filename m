From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 May 2018 10:03:45 +0200
Subject: [PATCH v3 2/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping
In-Reply-To: <20180530080345.2353-1-thierry.reding@gmail.com>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
Message-ID: <20180530080345.2353-3-thierry.reding@gmail.com>
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
performance degradation because of the additional translation. One
exception to this are compressible buffers which need large pages. In
order to enable these large pages, multiple small pages will have to be
combined into one large (I/O virtually contiguous) mapping via the
IOMMU. However, that is a topic outside the scope of this fix and isn't
currently supported. An implementation will want to explicitly create
these large pages in the Nouveau driver, so detaching from a DMA/IOMMU
mapping would still be required.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- clarify the use of IOMMU mapping for compressible buffers
- squash multiple patches into this

 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 78597da6313a..d0538af1b967 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -105,6 +105,11 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 	unsigned long pgsize_bitmap;
 	int ret;
 
+#if IS_ENABLED(CONFIG_ARM)
+	/* make sure we can use the IOMMU exclusively */
+	arm_dma_iommu_detach_device(dev);
+#endif
+
 	if (!tdev->func->iommu_bit)
 		return;
 
-- 
2.17.0
