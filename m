From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Dec 2011 17:39:50 +0100
Subject: [PATCH 0/8 v4] ARM: DMA-mapping framework redesign
Message-ID: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is another update on my attempt on DMA-mapping framework redesign
for ARM architecture. It includes a few minor changes since last
version. We have focused mainly on IOMMU mapper, keeping the DMA-mapping
redesign patches almost unchanged.

All patches have been now rebased onto v3.2-rc4 kernel + IOMMU/next
branch to include latest changes from IOMMU kernel tree.

This series also contains support for mapping with pages larger than
4KiB using new, extended IOMMU API. This code has been provided by
Andrzej Pietrasiewicz.

All the code has been tested on Samsung Exynos4 'UniversalC210' board
with IOMMU driver posted by KyongHo Cho.

GIT tree will all the patches (including some Samsung Exynos4 stuff):
http://git.infradead.org/users/kmpark/linux-samsung/shortlog/refs/heads/3.2-rc4-dma-v5-samsung
git://git.infradead.org/users/kmpark/linux-samsung 3.2-rc4-dma-v5-samsung

History:

Initial version of the DMA-mapping redesign patches:
http://www.spinics.net/lists/linux-mm/msg21241.html

Second version of the patches:
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000571.html
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000577.html

Third version of the patches:
http://www.spinics.net/lists/linux-mm/msg25490.html

TODO:
- start the discussion about chaning alloc_coherent into alloc_attrs in
dma_map_ops structure.
- start the discussion about dma_mmap function
- provide documentation for the new dma attributes

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (8):
  ARM: dma-mapping: remove offset parameter to prepare for generic
    dma_ops
  ARM: dma-mapping: use asm-generic/dma-mapping-common.h
  ARM: dma-mapping: implement dma sg methods on top of any generic dma
    ops
  ARM: dma-mapping: move all dma bounce code to separate dma ops
    structure
  ARM: dma-mapping: remove redundant code and cleanup
  common: dma-mapping: change alloc/free_coherent method to more
    generic alloc/free_attrs
  ARM: dma-mapping: use alloc, mmap, free from dma_ops
  ARM: initial proof-of-concept IOMMU mapper for DMA-mapping

 arch/arm/Kconfig                   |    9 +
 arch/arm/common/dmabounce.c        |   78 +++-
 arch/arm/include/asm/device.h      |    4 +
 arch/arm/include/asm/dma-iommu.h   |   36 ++
 arch/arm/include/asm/dma-mapping.h |  404 +++++------------
 arch/arm/mm/dma-mapping.c          |  899 ++++++++++++++++++++++++++++++------
 arch/arm/mm/vmregion.h             |    2 +-
 include/linux/dma-attrs.h          |    1 +
 include/linux/dma-mapping.h        |   13 +-
 9 files changed, 994 insertions(+), 452 deletions(-)
 create mode 100644 arch/arm/include/asm/dma-iommu.h

-- 
1.7.1.569.g6f426
