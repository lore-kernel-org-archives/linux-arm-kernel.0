From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 31 Jul 2015 18:18:26 +0100
Subject: [PATCH v5 0/3] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1438362603.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's an update following Catalin's feedback on v4[1].

Changes this round:
- Rebased onto linux-next
  - IOVA alignment fix applied already
  - iommu_iova_cache_init() is now iova_cache_get()
- Tidied up iommu_dma_alloc()
  - Simplified pgprot handling
  - Removed redundant memset
  - Skip coherent page-flushing in a simpler way
- Spotted a bug in iommu_dma_init_domain() where the checks for
  reinitialising an existing domain were backwards.

If it is going to be down to me to tackle all the driver fixes and
conversion of arch/arm dma_ops, I'd still much rather have this
code merged first as a stable base to work with (and un-block arm64
in the meantime). Have we decided yet whether this should go via the
IOMMU tree or the arm64 tree?

Thanks,
Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/10181

Robin Murphy (3):
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/dma-mapping.h |  15 +-
 arch/arm64/mm/dma-mapping.c          | 449 +++++++++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 534 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |  84 ++++++
 include/linux/iommu.h                |   1 +
 8 files changed, 1084 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
