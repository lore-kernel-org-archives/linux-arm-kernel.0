From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  1 Oct 2015 20:13:57 +0100
Subject: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1443718557.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's the latest, and hopefully last, revision of the initial arm64
IOMMU dma_ops support.

There are a couple of dependencies still currently in -next and the
intel-iommu tree[0]: "iommu: iova: Move iova cache management to the
iova library" is necessary for the rename of iova_cache_get(), and
"iommu/iova: Avoid over-allocating when size-aligned" will be needed
with some IOMMU drivers to prevent unmapping errors.

Changes from v5[1]:
- Change __iommu_dma_unmap() from BUG to WARN when things go wrong, and
  prevent a NULL dereference on double-free.
- Fix iommu_dma_map_sg() to ensure segments can never inadvertently end
  mapped across a segment boundary. As a result, we have to lose the
  segment-merging optimisation from before (I might revisit that if
  there's some evidence it's really worthwhile, though).
- Cleaned up the platform device workarounds for config order and
  default domains, and removed the other hacks. Demanding that the IOMMU
  drivers assign groups, and support IOMMU_DOMAIN_DMA via the methods
  provided, keeps things bearable, and the behaviour should now be
  consistent across all cases.

As a bonus, whilst the underlying of_iommu_configure() code only supports
platform devices at the moment, I can also say that this has now been
tested to work for PCI devices too, via some horrible hacks on a Juno r1.

Thanks,
Robin.

[0]:http://thread.gmane.org/gmane.linux.kernel.iommu/11033
[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/10439

Robin Murphy (3):
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/dma-mapping.h |  15 +-
 arch/arm64/mm/dma-mapping.c          | 457 ++++++++++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 524 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |  85 ++++++
 include/linux/iommu.h                |   1 +
 8 files changed, 1083 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
