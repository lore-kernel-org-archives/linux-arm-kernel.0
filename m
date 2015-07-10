From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 10 Jul 2015 20:19:31 +0100
Subject: [PATCH v3 0/4] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1436552949.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here we are again, and I really hope this is good to merge this time.

Changes since v2[1]:
- Rework to use default domains. Of course, we don't have the requisite
  default domain support in arm/arm64 IOMMU drivers yet, but the grotty
  workarounds now end up corralled into one place outside the base code.
- Fixed the logic around atomic allocation where coherent devices would
  have ended up with non-cacheable buffers.
- Fixed a missing size-alignment which made only whole-page allocations
  succeed.
- Added more documentation, especially around the really confusing bit.

Once again, branch available at [2].

Looking ahead, I have some half-worked-out prototypes for DT-based
IOMMU group allocation - with that and Laurent's probe deferral series,
we should hopefully be able to implement the rest of default domain
support in the IOMMU drivers, and get rid of the hacks. 

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/9946
[2]:git://linux-arm.org/linux-rm iommu/dma

Robin Murphy (4):
  iommu/iova: Avoid over-allocating when size-aligned
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/dma-mapping.h |  15 +-
 arch/arm64/mm/dma-mapping.c          | 447 +++++++++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 536 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c          |   2 +
 drivers/iommu/iova.c                 |  23 +-
 include/linux/dma-iommu.h            |  84 ++++++
 include/linux/iommu.h                |   1 +
 10 files changed, 1092 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
