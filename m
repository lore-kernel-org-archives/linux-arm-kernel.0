From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 15 Nov 2011 13:58:50 +0900
Subject: [PATCH v6 0/2] iommu/exynos: Add IOMMU and Enhance System MMU driver
 for Samsung Exynos
Message-ID: <1321333132-17662-1-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Patch Summary:
[PATCH v6 1/2] ARM: EXYNOS: Change System MMU platform device definitions
[PATCH v6 2/2] iommu/exynos: Add iommu driver for Exynos Platforms

The first patche enhances System MMU platform device definition:
 - Removed System MMU for MDMA0 in TOP block because it is not
   used. Use MDMA2 in LCD block.
 - Removed System MMU ID. Instead, a System MMU is bound to a device
   that the System MMU is dedicated during machin initialization.
   If a device driver wants to handle System MMU, it must bind its
   device with System MMU with sysmmu_set_owner().
 - clkdev

The last patch implements IOMMU API:
 - System MMU device driver is removed from arch/arm/plat-s5p
   to move it to driver/iommu directory.
 - Implements IOMMU API and System MMU driver that is moved from
   arch/arm/plat-s5p.
 - Implements fault handling that is suggested by Ohad.
 - Used bus_set_iommu instead of register_iommu that is suggested
   by Joerg.
 - Implements iommu_commit().

Changes since v5:
- Relation between device and a domain become n:1 (Joerg's comment)
- Implements iommu_commit().

Changes since v4:
- exynos_iommu_unmap()returns unmapped size in page order
  (Ohad Ben-Cohen's comment)
- Fixed typo error of resource names
- Fixed missing #include<mach/sysmmu.h>
  in arch/arm/mach-exynos4/mach-armlex4210.c

Changes since v3:
- Used DEFINE_RES_MEM and DEFINE_RES_IRQ macros
  to define resources of System MMU (Russell King's comment)
- Fixed removal of CONFIG_S5P_SLEEP definition
  (Sylwester Nawrocki's comment)

Changes since v2:
- Add lock for System MMU private data.
  And fixes the following problems pointed by Joerg Rodel:
- Fix wrong argument to kmalloc() and get_free_pages()
- Merged patches into 2 due to bisectability

Changes since v1:
Fixes of the following problems pointed by Russell King.:
 - Missing unlocking a spinlock in exynos_iommu_attach_dev().
 - atomic_t -> int in sysmmu_drvdata.activations
 - sysmmu_platdata -> sysmmu_drvdata
 - Change in error messages in irq handler
 - Removed casting in format of error message
 - omap_iommu_ops -> exynos_iommu_ops in the last patch

Diffstat:
 arch/arm/mach-exynos/Kconfig                      |    2 +
 arch/arm/mach-exynos/clock-exynos4210.c           |   16 +
 arch/arm/mach-exynos/clock.c                      |   55 +-
 arch/arm/mach-exynos/dev-sysmmu.c                 |  272 ++-----
 arch/arm/mach-exynos/include/mach/dev-sysmmu.h    |   61 ++
 arch/arm/mach-exynos/include/mach/exynos4-clock.h |    1 +
 arch/arm/mach-exynos/include/mach/map.h           |    3 +-
 arch/arm/mach-exynos/include/mach/regs-sysmmu.h   |   26 +-
 arch/arm/mach-exynos/include/mach/sysmmu.h        |   46 -
 arch/arm/mach-exynos/mach-armlex4210.c            |    1 -
 arch/arm/mach-exynos/mach-nuri.c                  |   40 +
 arch/arm/mach-exynos/mach-origen.c                |   42 +
 arch/arm/mach-exynos/mach-smdk4x12.c              |    9 +
 arch/arm/mach-exynos/mach-smdkv310.c              |   43 +-
 arch/arm/mach-exynos/mach-universal_c210.c        |   42 +
 arch/arm/plat-s5p/Kconfig                         |    8 -
 arch/arm/plat-s5p/Makefile                        |    1 -
 arch/arm/plat-s5p/sysmmu.c                        |  312 -------
 arch/arm/plat-samsung/include/plat/devs.h         |    1 -
 arch/arm/plat-samsung/include/plat/sysmmu.h       |   95 --
 drivers/iommu/Kconfig                             |   12 +
 drivers/iommu/Makefile                            |    1 +
 drivers/iommu/exynos-iommu.c                      | 1035 +++++++++++++++++++++
 drivers/iommu/iommu.c                             |    4 +-
 24 files changed, 1406 insertions(+), 722 deletions(-)
