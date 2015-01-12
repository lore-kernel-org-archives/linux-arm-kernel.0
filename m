From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Jan 2015 20:48:52 +0000
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1421086706.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Whilst it's a long way off perfect, this has reached the point of being
functional and stable enough to be useful, so here it is. The core
consists of the meat of the arch/arm implementation modified to remove
the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
allocator instead of the bitmap-based one. For that, this series depends
on my "Genericise the IOVA allocator" series posted earlier[1].

There are plenty of obvious things still to do, including:

 * Domain and group handling is all wrong, but that's a bigger problem.
   For the moment it does more or less the same thing as the arch/arm
   code, which at least works for the one-IOMMU-per-device situation.
 * IOMMU domains and IOVA domains probably want to be better integrated
   with devices and each other, rather than having a proliferation of
   arch-specific structs.
 * The temporary map_sg implementation - I have a 'proper' iommu_map_sg
   based one in progress, but since the simple one works it's not been
   as high a priority.
 * Port arch/arm over to it. I'd guess it might be preferable to merge
   this through arm64 first, though, rather than overcomplicate matters.
 * There may well be scope for streamlining and tidying up the copied
   parts - In general I've simply avoided touching anything I don't
   fully understand.
 * In the same vein, I'm sure lots of it is fairly ARM-specific, so will
   need longer-term work to become truly generic.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/8208

Catalin Marinas (1):
  arm64: Combine coherent and non-coherent swiotlb dma_ops

Robin Murphy (4):
  arm64: implement generic IOMMU configuration
  iommu: implement common IOMMU ops for DMA mapping
  arm64: add IOMMU dma_ops
  arm64: hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/device.h      |   3 +
 arch/arm64/include/asm/dma-mapping.h |  33 +--
 arch/arm64/kernel/setup.c            |   2 +
 arch/arm64/mm/dma-mapping.c          | 435 ++++++++++++++++++++++++++++-----
 include/linux/dma-iommu.h            |  78 ++++++
 lib/Kconfig                          |   8 +
 lib/Makefile                         |   1 +
 lib/dma-iommu.c                      | 455 +++++++++++++++++++++++++++++++++++
 9 files changed, 938 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/dma-iommu.h
 create mode 100644 lib/dma-iommu.c

-- 
1.9.1
