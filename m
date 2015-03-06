From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Mar 2015 11:34:46 +0000
Subject: [PATCH 0/2] Kill off pgsize_bitmap field from struct iommu_ops
Message-ID: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These patches move the pgsize_bitmap field out of iommu_ops and into
the iommu_domain structure, as there are systems containing multiple
instances of a given IOMMU (e.g. the ARM SMMU) with different page size
support on the individual devices.

Once that's done, we can get back to treating the iommu_ops as constant,
since they just contain function pointers.

Comments welcome,

Will

--->8

Robin Murphy (1):
  iommu: of: enforce const-ness of struct iommu_ops

Will Deacon (1):
  iommu: move pgsize_bitmap from struct iommu_ops to struct iommu_domain

 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  6 +++---
 arch/arm64/include/asm/dma-mapping.h |  3 ++-
 drivers/iommu/amd_iommu.c            |  2 +-
 drivers/iommu/arm-smmu.c             | 12 +++++-------
 drivers/iommu/exynos-iommu.c         |  3 ++-
 drivers/iommu/intel-iommu.c          |  2 +-
 drivers/iommu/iommu.c                | 16 ++++++++--------
 drivers/iommu/ipmmu-vmsa.c           |  2 +-
 drivers/iommu/msm_iommu.c            |  3 ++-
 drivers/iommu/of_iommu.c             | 12 ++++++------
 drivers/iommu/omap-iommu.c           |  3 ++-
 drivers/iommu/rockchip-iommu.c       |  2 +-
 drivers/iommu/shmobile-iommu.c       |  2 +-
 drivers/iommu/tegra-gart.c           |  2 +-
 drivers/iommu/tegra-smmu.c           |  3 +--
 drivers/of/platform.c                |  2 +-
 drivers/vfio/vfio_iommu_type1.c      |  2 +-
 include/linux/dma-mapping.h          |  2 +-
 include/linux/iommu.h                |  6 +-----
 include/linux/of_iommu.h             |  8 ++++----
 21 files changed, 46 insertions(+), 49 deletions(-)

-- 
2.1.4
