From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Apr 2016 17:31:08 +0200
Subject: [PATCH v8 0/2]  Fix dma mapping when the cache is coherent
Message-ID: <1460475070-29058-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches fixes the dma mapping functions when the system is
cache coherent. The first one allows to fix an issue we have on Armada
375/38x with the PL310 that's why it is tagged for stable too.

Thanks,

Gregory

PS: the mailing list was missing in the recipient list of the v7. It
was a mistake and I realized it only now. If needed I can repost it
with the few exchange we had with Russell King.


Changelog
v7 -> v8:
 - Use a flag instead of a boolean for checking the coherency. It
   improve the readability of the code. Suggested by Russell King.
 - Consider that when coherency is set, it's for both L1 and L2 caches
 - Use the arm_dma_alloc_args struct to pass the coherency status when
   possible. Suggested by Rabin Vincent
 - Remove the Tested-by flag from Marcin because of the modifications
   around the L1 cache management in this series.

v6 -> v7:
 - Renamed is coherent by l2_coherent as suggested by Russell

v5 -> v6:
 - Rebased on v4.6-rc1

v4 -> v5
 - Keep the dmac_* function outside the !is_coherent case.

v3 -> v4:
 - Rebased on v4.3-rc1
 - Fix conflict with commit "21caf3a765b0 ARM: 8398/1: arm DMA: Fix
   allocation from CMA for coherent DMA"

v2 -> v3:

 - Fix comments in patch 1 as suggested by Catalin.
 - Fix build issues in patch 2 (by using the multi_v7_defconfig +
   CONFIG_ROCKCHIP_IOMMU).
 - Add the arm_coherent_iommu_mmap_attrs function.


Gregory CLEMENT (2):
  ARM: dma-mapping: Don't use outer_flush_range when the L2C is coherent
  ARM: dma-mapping: Fix the coherent case when iommu is used

 arch/arm/mm/dma-mapping.c | 144 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 105 insertions(+), 39 deletions(-)

-- 
2.5.0
