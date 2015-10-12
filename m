From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Oct 2015 21:01:02 +0200
Subject: [PATCH v5 0/2]  Fix dma mapping when the cache is coherent
Message-ID: <1444676464-29444-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches fixes the dma mapping functions when the system is
cache coherent. The first one allows to fix an issue we have on Armada
375/38x with the PL310 that's why it is tagged for stable too.

The only change is this version is about keeping the dmac_* function
outside the !is_coherent case. Indeed as pointed by Russell king, we
don't yet support coherency to L1 yet.

Thanks,

Gregory

Changelog
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

 arch/arm/mm/dma-mapping.c | 134 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 37 deletions(-)

-- 
2.1.4
