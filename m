From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 May 2018 16:06:23 +0200
Subject: [PATCH v4 0/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping
Message-ID: <20180530140625.21247-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

An unfortunate interaction between the 32-bit ARM DMA/IOMMU mapping code
and Tegra SMMU driver changes to support IOMMU groups introduced a boot-
time regression on Tegra124. This was caught very late because none of
the standard configurations that are tested on Tegra enable the ARM DMA/
IOMMU mapping code since it is not needed.

The reason for the failure is that the GPU found on Tegra uses a special
bit in physical addresses to determine whether or not a buffer is mapped
through the SMMU. In order to achieve this, the Nouveau driver needs to
explicitly understand which buffers are mapped through the SMMU and
which aren't. Hiding usage of the SMMU behind the DMA API is bound to
fail because the knowledge doesn't exist. Furthermore, the GPU has its
own IOMMU and in most cases doesn't need buffers to be physically or
virtually contiguous. One notable exception is for compressible buffers
which need to be mapped with large pages, which in turn require all the
small pages in a large page to be contiguous. This can be achieved with
an SMMU mapping, though it isn't currently supported in Nouveau. Since
Translating through the SMMU is unnecessary and can have a negative
impact on performance for the common case, so we want to avoid it when
possible.

This series of patches adds a 32-bit ARM specific API that allows a
driver to detach the device from the DMA/IOMMU mapping so that it can
provide its own implementation for dealing with the SMMU. The second
patch makes use of that new API in the Nouveau driver to fix the
regression.

Thierry

Thierry Reding (2):
  ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()
  drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

 arch/arm/mm/dma-mapping.c                          | 12 ++++++------
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.17.0
