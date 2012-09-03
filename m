From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 03 Sep 2012 13:00:24 +0200
Subject: [GIT PULL] DMA-mapping fixes for v3.6
Message-ID: <1346670024-504-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling another set of fixes for ARM dma-mapping
subsystem. Commit e9da6e9905e6 replaced custom consistent buffer
remapping code with generic vmalloc areas. It however introduced some
regressions caused by limited support for allocations in atomic context.
This series contains fixes for those regressions. For some subplatforms
the default, pre-allocated pool for atomic allocations turned out to be
too small, so a function for setting its size has been added. Another
set of patches adds support for atomic allocations to IOMMU-aware
DMA-mapping implementation. The last part of this pull request contains
two fixes for Contiguous Memory Allocator, which relax too strict
requirements.

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

   fixes-for-3.6

for you to fetch changes up to 479ed93a4b98eef03fd8260f7ddc00019221c450:

  ARM: dma-mapping: IOMMU allocates pages from atomic_pool with GFP_ATOMIC (2012-08-28 21:01:07 +0200)

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center

----------------------------------------------------------------
Patch summary:

Hiroshi Doyu (4):
      ARM: dma-mapping: atomic_pool with struct page **pages
      ARM: dma-mapping: Refactor out to introduce __in_atomic_pool
      ARM: dma-mapping: Introduce __atomic_get_pages() for __iommu_get_pages()
      ARM: dma-mapping: IOMMU allocates pages from atomic_pool with GFP_ATOMIC

Marek Szyprowski (5):
      mm: cma: fix alignment requirements for contiguous regions
      ARM: relax conditions required for enabling Contiguous Memory Allocator
      ARM: DMA-Mapping: add function for setting coherent pool size from platform code
      ARM: DMA-Mapping: print warning when atomic coherent allocation fails
      ARM: Kirkwood: increase atomic coherent pool size

 arch/arm/Kconfig                   |    2 +-
 arch/arm/include/asm/dma-mapping.h |    7 ++
 arch/arm/mach-kirkwood/common.c    |    7 ++
 arch/arm/mm/dma-mapping.c          |  114 ++++++++++++++++++++++++++++++++---
 drivers/base/dma-contiguous.c      |    2 +-
 5 files changed, 120 insertions(+), 12 deletions(-)
