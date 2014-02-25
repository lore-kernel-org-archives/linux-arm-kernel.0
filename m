From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 25 Feb 2014 13:42:19 +0100
Subject: [PATCH 0/2] arm: dma-mapping: add dynamic resize of IOVA bitmap
Message-ID: <1393332141-17781-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset is a continuation of the work started by Andreas Herrmann
to add support for dynamically resized bitmaps for IOMMU based
DMA-mapping implementation for ARM architecture. Some more discussion
and rationale has been discussed in the following thread:
http://www.spinics.net/lists/arm-kernel/msg303732.html

The first patch adds support for on-demand extending IO address space
bitmap. It is based on the original work by Andreas Herrmann, but I
decided to drop arm_iommu_create_mapping() api change part. The second
patch removes the 'order' hack, which was used to reduce the size of a
bitmap. The first patch solved the problem of too large io address space
bitmaps, so the 'order' hack is no longer needed. The parameters of the
arm_iommu_create_mapping() function can be then simplified by dropping
'order' parameter without any functional change of the whole subsystem.
This parameter was already a bit misunderstood, so the overall result is
also a little improvement of the API.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

Andreas Herrmann (1):
  arm: dma-mapping: Add support to extend DMA IOMMU mappings

Marek Szyprowski (1):
  arm: dma-mapping: remove order parameter from
    arm_iommu_create_mapping()

 arch/arm/include/asm/dma-iommu.h          |   12 ++-
 arch/arm/mm/dma-mapping.c                 |  144 +++++++++++++++++++++++------
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |    2 -
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.h |    1 -
 drivers/iommu/shmobile-iommu.c            |    2 +-
 6 files changed, 124 insertions(+), 43 deletions(-)

-- 
1.7.9.5
