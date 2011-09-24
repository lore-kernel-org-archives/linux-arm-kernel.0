From: pullip.cho@samsung.com (KyongHo Cho)
Date: Sat, 24 Sep 2011 09:38:42 +0900
Subject: [PATCH 0/4] iommu/exynos: Add IOMMU and Enhance System MMU for Exynos4
Message-ID: <1316824726-20695-1-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The first 2 patches are the revolutionary change to the device definition
of System MMU for Exynos4 SoCs:
 - System MMU ID is removed and a device and its dedicated System MMU are
   bound during the machine initialization.
 - Only the System MMU platform devices that are bound to their master
   devices are initialized. If a System MMU is not initialized, it is no
   longer available.
 - Clock gating of System MMU with clkdev.
 - Moved System MMU driver to the IOMMU's dedicated directory,
   drivers/iommu.

The last 2 patches introduce new IOMMU API implementation for Exynos4
System MMU. They implements all IOMMU API including Ohad's latest
suggestion about MMU fault handling and Joerg's suggestion about
bus_type.

Diffstat:

arch/arm/mach-exynos4/Kconfig               |    2 -
arch/arm/mach-exynos4/clock.c               |   43 +-
arch/arm/mach-exynos4/dev-sysmmu.c          |  281 +++-------
arch/arm/mach-exynos4/include/mach/irqs.h   |    1 -
arch/arm/mach-exynos4/include/mach/map.h    |    1 -
arch/arm/mach-exynos4/include/mach/sysmmu.h |   96 ++--
arch/arm/mach-exynos4/mach-armlex4210.c     |   24 +-
arch/arm/mach-exynos4/mach-smdkv310.c       |   28 +-
arch/arm/plat-s5p/Kconfig                   |    8 -
arch/arm/plat-s5p/Makefile                  |    1 -
arch/arm/plat-s5p/include/plat/sysmmu.h     |   95 ---
arch/arm/plat-s5p/sysmmu.c                  |  312 ----------
drivers/iommu/Kconfig                       |   14 +
drivers/iommu/Makefile                      |    1 +
drivers/iommu/exynos_iommu.c                |  859 +++++++++++++++++++++++++++
15 files changed, 1084 insertions(+), 682 deletions(-)
