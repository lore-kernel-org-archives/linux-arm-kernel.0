From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Mon, 2 Jun 2014 15:49:19 +0530
Subject: [PATCH 0/4] arm:dma-mapping Refactoring iommu dma-mapping code
Message-ID: <1401704363-31052-1-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Hi All, 

This patch series is to refractor iommu related common code from
arch/arm/dma-mapping.c to lib/iommu-helper.c based on the various
discussions with the maintainers/experts [1].

Currently the only user of the common lib/iommu-helper code will
be ARM & ARM64 but later various architecture might try to use this
iommu lib helper functions.

Major change of this refactoring starts with bringing out struct dma_iommu_mapping 
*mapping variable from arch/arm/include/asm/device.h to include/linux/device.h
and by moving out complete structure defination of dma_iommu_mapping to
inclue/linux/iommu-helper.h. Link [2] give more details on why this was done,
also this change got approval from Will Daecon [2].

There are 1/2 more function definitions which I can think of moving out, but
those can be done once this patch series is approved as those are not very
big changes.

[1]: https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg03458.html 
[2]: https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg04272.html

Ritesh Harjani (4):
  arm: dma-iommu: Move out dma_iommu_mapping struct
  arm: dma-mapping: Refractor attach/detach dev function calls
  arm: dma-mapping: Refractor iommu_alloc/free funcs
  arm:dma-iommu: Move out complete func defs

 arch/arm/Kconfig                          |  46 +--
 arch/arm/include/asm/device.h             |   9 -
 arch/arm/include/asm/dma-iommu.h          |  16 +-
 arch/arm/mm/dma-mapping.c                 | 566 +++---------------------------
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |  10 +-
 include/linux/device.h                    |   4 +
 include/linux/iommu-helper.h              |  64 ++++
 lib/iommu-helper.c                        | 561 +++++++++++++++++++++++++++++
 8 files changed, 705 insertions(+), 571 deletions(-)

-- 
1.8.1.3
