From: pullip.cho@samsung.com (KyongHo Cho)
Date: Wed, 12 Oct 2011 17:07:37 +0900
Subject: [PATCH v4 0/2] iommu/exynos: Add IOMMU and Enhance System MMU driver
	for Exynos4
Message-ID: <000101cc88b6$013d1ef0$03b75cd0$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

This is the firth try of submitting patches about IOMMU/System MMU

Patch Summary:
[PATCH v4 1/2] ARM: EXYNOS4: Change System MMU device definition
[PATCH v4 2/2] iommu/exynos: Add iommu driver for Exynos Platforms

The first patche enhances System MMU platform device definition:
 - Removed System MMU for MDMA0 in LCD block because it is not
   used. Use MDMA2 in TOP block.
 - Removed System MMU ID. Instead a System MMU is bound to a device
   That the System MMU is dedicated during machin initialization.
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
 - omap_iommu_ops -> exynos_iommu_ops in the last patch.

Diffstat:

 arch/arm/mach-exynos4/Kconfig               |    2 -
 arch/arm/mach-exynos4/clock.c               |   43 +-
 arch/arm/mach-exynos4/dev-sysmmu.c          |  260 ++------
 arch/arm/mach-exynos4/include/mach/irqs.h   |    1 -
 arch/arm/mach-exynos4/include/mach/map.h    |    1 -
 arch/arm/mach-exynos4/include/mach/sysmmu.h |   85 ++-
 arch/arm/mach-exynos4/mach-armlex4210.c     |   24 +-
 arch/arm/mach-exynos4/mach-smdkv310.c       |   28 +-
 arch/arm/plat-s5p/Kconfig                   |    8 -
 arch/arm/plat-s5p/Makefile                  |    1 -
 arch/arm/plat-s5p/sysmmu.c                  |  312 ---------
 arch/arm/plat-samsung/include/plat/sysmmu.h |   95 ---
 drivers/iommu/Kconfig                       |   14 +
 drivers/iommu/Makefile                      |    1 +
 drivers/iommu/exynos_iommu.c                |  962
+++++++++++++++++++++++++++
 15 files changed, 1153 insertions(+), 684 deletions(-)
