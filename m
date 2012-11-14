From: pullip.cho@samsung.com (Cho KyongHo)
Date: Wed, 14 Nov 2012 17:50:56 +0900
Subject: [PATCH 0/4] iommu/exynos: Fixes and Enhancements of System MMU driver
 with DT
Message-ID: <002001cdc245$29256160$7b702420$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current exynos-iommu(System MMU) driver does not work autonomously
since it is lack of support for power management of peripheral blocks.
For example, MFC device driver must ensure that its System MMU is disabled
before MFC block is power-down not to invalidate IOTLB in the System MMU
when I/O memory mapping is changed. Because A System MMU is resides in the
same H/W block, access to control registers of System MMU while the H/W
block is turned off must be prohibited.

This set of changes solves the above problem with setting each System MMUs
as the parent of the device which owns the System MMU to recieve the
information when the device is turned off or turned on.

Another big change to the driver is the support for devicetree.
The bindings for System MMU is described in
Documentation/devicetree/bindings/arm/samsung/system-mmu.txt

In addition, this patchset also includes several bug fixes and enhancements
of the current driver.

Patch summary:
[PATCH 1/4] ARM: EXYNOS: remove system mmu initialization from arch/arm/ tree
[PATCH 2/4] ARM: EXYNOS: Add clk_ops for gating clocks of System MMU
[PATCH 3/4] ARM: EXYNOS: add System MMU definition to DT
[PATCH 4/4] iommu/exynos: enhancements of System MMU driver with DT

Diffstats:
 .../devicetree/bindings/arm/samsung/system-mmu.txt |   42 +
 arch/arm/boot/dts/exynos4210.dtsi                  |   96 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |  124 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |  152 ++-
 arch/arm/mach-exynos/Kconfig                       |    5 -
 arch/arm/mach-exynos/Makefile                      |    1 -
 arch/arm/mach-exynos/clock-exynos4.c               |   41 +-
 arch/arm/mach-exynos/clock-exynos4210.c            |    9 +-
 arch/arm/mach-exynos/clock-exynos4212.c            |   23 +-
 arch/arm/mach-exynos/clock-exynos5.c               |   87 +-
 arch/arm/mach-exynos/dev-sysmmu.c                  |  274 ----
 arch/arm/mach-exynos/include/mach/sysmmu.h         |   66 -
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   34 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   30 +
 drivers/iommu/Kconfig                              |   17 +-
 drivers/iommu/Makefile                             |    2 +-
 drivers/iommu/exynos-iommu.c                       | 1420 +++++++++++++++-----
 17 files changed, 1652 insertions(+), 771 deletions(-)
