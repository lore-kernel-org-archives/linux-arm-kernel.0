From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 16 Jul 2015 19:40:11 +0100
Subject: [PATCH v4 0/4] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1437070995.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's a quick repost to address feedback on v3, and a couple of other
tweaks. Changes this round:

- Fix the heinous dma_mask/coherency confusion, which also simplifies
  some prototypes and parameter passing as a bonus.
- Reorder the iommu_map/unmap in alloc/free to prevent any potential
  access the wrong side of clearing/freeing the pages.
- Made the unconditional clearing of allocations a bit more explicit.
- Made the default domain workaround more robust against the possibility
  of an IOMMU driver giving back the same domain for multiple devices.

Robin.

v3: http://thread.gmane.org/gmane.linux.kernel.iommu/10133
Updated branch at: git://linux-arm.org/linux-rm iommu/dma

Robin Murphy (4):
  iommu/iova: Avoid over-allocating when size-aligned
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/dma-mapping.h |  15 +-
 arch/arm64/mm/dma-mapping.c          | 452 +++++++++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 538 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c          |   2 +
 drivers/iommu/iova.c                 |  23 +-
 include/linux/dma-iommu.h            |  84 ++++++
 include/linux/iommu.h                |   1 +
 10 files changed, 1099 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
