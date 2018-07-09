From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon,  9 Jul 2018 14:19:54 +0200
Subject: [PATCH 0/2] CMA: remove unsupported gfp mask parameter
References: <CGME20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c@eucas1p2.samsung.com>
Message-ID: <20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c~-sqSan6292733527335eucas1p2-@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

The CMA related functions cma_alloc() and dma_alloc_from_contiguous()
have gfp mask parameter, but sadly they only support __GFP_NOWARN flag.
This gave their users a misleading feeling that any standard memory
allocation flags are supported, what resulted in the security issue when
caller have set __GFP_ZERO flag and expected the buffer to be cleared.

This patchset changes gfp_mask parameter to a simple boolean no_warn
argument, which covers all the underlaying code supports.

This patchset is a result of the following discussion:
https://patchwork.kernel.org/patch/10461919/

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (2):
  mm/cma: remove unsupported gfp_mask parameter from cma_alloc()
  dma: remove unsupported gfp_mask parameter from
    dma_alloc_from_contiguous()

 arch/arm/mm/dma-mapping.c                  | 5 +++--
 arch/arm64/mm/dma-mapping.c                | 4 ++--
 arch/powerpc/kvm/book3s_hv_builtin.c       | 2 +-
 arch/xtensa/kernel/pci-dma.c               | 2 +-
 drivers/iommu/amd_iommu.c                  | 2 +-
 drivers/iommu/intel-iommu.c                | 3 ++-
 drivers/s390/char/vmcp.c                   | 2 +-
 drivers/staging/android/ion/ion_cma_heap.c | 2 +-
 include/linux/cma.h                        | 2 +-
 include/linux/dma-contiguous.h             | 4 ++--
 kernel/dma/contiguous.c                    | 6 +++---
 kernel/dma/direct.c                        | 3 ++-
 mm/cma.c                                   | 8 ++++----
 mm/cma_debug.c                             | 2 +-
 14 files changed, 25 insertions(+), 22 deletions(-)

-- 
2.17.1
