From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:35 +0100
Subject: [RFC PATCH 00/23] arm: defconfigs: use kconfig fragments
Message-ID: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This RFC patchset starts convertion of ARM defconfigs to use kconfig
fragments and dynamically generate defconfigs.  The goals of this
work are to:

- remove duplication between defconfigs

- add a possibility to generate board/SoC/SoC-family/Multi specific
  defconfigs in the future (without duplicating defconfigs)


This patchset is only a start of the work for discussion purposes
(I'm not entirely satisfied with the resulting patches):

- the major disadvantage of using kconfig fragments is that it is
  now more difficult to update defconfigs

- split on hardware and system specific defconfig fragments is not
  obvious and requires more thought


Patches description:

- patch 01 adds defconfigs dynamic generation support (based on
  PowerPC code)

- patches 02-21 remove duplication between selected defconfigs
  (without splitting them on hardware and system specific parts)

- patches 22-23 start a conversion of multi_v7_defconfig to be
  dynamically generated and remove duplication between Multi
  defconfig and SoC-family specific defconfigs (only Exynos and
  Tegra defconfigs are converted for RFC purposes, defconfigs
  are splitted on hardware and system specific parts) 

The patchset is against v4.9-rc6 kernel.


FIXMEs:
- add sys_m and sys_m_shared kconfig fragments
- audit hardware/system split
- convert all defconfigs touched by patchset to use:
  * hw_y, hw_y_shared, hw_m, hw_m_shared
  * sys_y, sys_y_shared, sys_m, sys_m_shared
  kconfig fragments
- convert remaining defconfigs


Bartlomiej Zolnierkiewicz (23):
  arm: add kconfig fragments support
  arm: use kconfig fragments for ARCH_ASPEED defconfigs
  arm: update defconfigs for ARCH_KS8695
  arm: use kconfig fragments for ARCH_ASPEED defconfigs
  arm: update defconfigs for ARCH_MMP
  arm: use kconfig fragments for ARCH_ASPEED defconfigs
  arm: update defconfigs for PLAT_SPEAR
  arm: use kconfig fragments for PLAT_SPEAR defconfigs
  arm: update defconfigs for ARCH_W90X900
  arm: use kconfig fragments for ARCH_W90X900 defconfigs
  arm: update mainstone_defconfig
  arm: update lubbock_defconfig
  arm: update pxa255-idp_defconfig
  arm: update lpd270_defconfig
  arm: use kconfig fragments for ARCH_PXA defconfigs (part 1)
  arm: update corgi_defconfig
  arm: update spitz_defconfig
  arm: use kconfig fragments for ARCH_PXA defconfigs (part 2)
  arm: update ezx_defconfig
  arm: imote2_defconfig
  arm: use kconfig fragments for ARCH_PXA defconfigs (part 3)
  arm: use kconfig fragments for exynos_defconfig/multi_v7_defconfig
  arm: use kconfig fragments for tegra_defconfig/multi_v7_defconfig

 arch/arm/Makefile                                  | 107 ++++++
 arch/arm/configs/acs5k.config                      |  32 ++
 arch/arm/configs/acs5k_defconfig                   |  86 -----
 arch/arm/configs/acs5k_tiny.config                 |  24 ++
 arch/arm/configs/acs5k_tiny_defconfig              |  80 ----
 ...{aspeed_g4_defconfig => aspeed_basic_defconfig} |   1 -
 arch/arm/configs/aspeed_g4.config                  |   1 +
 arch/arm/configs/aspeed_g5.config                  |   3 +
 arch/arm/configs/aspeed_g5_defconfig               |  88 -----
 arch/arm/configs/corgi.config                      |  11 +
 arch/arm/configs/dummy_defconfig                   |   1 +
 arch/arm/configs/exynos/hw_m.config                |   2 +
 arch/arm/configs/exynos/hw_m_shared.config         |  18 +
 arch/arm/configs/exynos/hw_y.config                |  93 +++++
 arch/arm/configs/exynos/hw_y_shared.config         |  93 +++++
 arch/arm/configs/exynos/sys_y.config               |  33 ++
 arch/arm/configs/exynos/sys_y_shared.config        |  37 ++
 arch/arm/configs/exynos_defconfig                  | 274 --------------
 arch/arm/configs/ezx.config                        |  39 ++
 arch/arm/configs/ezx_defconfig                     | 418 ---------------------
 arch/arm/configs/imote2.config                     |  17 +
 arch/arm/configs/ks8695.config                     |  21 ++
 .../{ks8695_defconfig => ks8695_basic_defconfig}   |  33 --
 arch/arm/configs/lpd270.config                     |  20 +
 arch/arm/configs/lpd270_defconfig                  |  64 ----
 arch/arm/configs/lubbock.config                    |  11 +
 arch/arm/configs/lubbock_defconfig                 |  56 ---
 arch/arm/configs/mainstone.config                  |  11 +
 arch/arm/configs/mmp2.config                       |  32 ++
 arch/arm/configs/mmp2_defconfig                    |  98 -----
 .../{pxa168_defconfig => mmp_basic_defconfig}      |  27 +-
 ...{multi_v7_defconfig => multi_v7_base_defconfig} | 268 -------------
 arch/arm/configs/nuc910_defconfig                  |  19 +-
 arch/arm/configs/nuc950.config                     |  14 +
 arch/arm/configs/nuc950_defconfig                  |  76 ----
 arch/arm/configs/nuc960.config                     |   5 +
 arch/arm/configs/nuc960_defconfig                  |  66 ----
 arch/arm/configs/pxa168.config                     |   3 +
 arch/arm/configs/pxa255-idp.config                 |  14 +
 arch/arm/configs/pxa255-idp_defconfig              |  58 ---
 arch/arm/configs/pxa910.config                     |   8 +
 arch/arm/configs/pxa910_defconfig                  |  80 ----
 .../{mainstone_defconfig => pxa_basic1_defconfig}  |  21 +-
 .../{corgi_defconfig => pxa_basic2_defconfig}      |  70 +---
 .../{imote2_defconfig => pxa_basic3_defconfig}     | 101 +----
 arch/arm/configs/spear13xx.config                  |  35 ++
 arch/arm/configs/spear13xx_defconfig               | 110 ------
 arch/arm/configs/spear3xx.config                   |  15 +
 arch/arm/configs/spear3xx_defconfig                |  89 -----
 arch/arm/configs/spear6xx.config                   |   5 +
 .../{spear6xx_defconfig => spear_basic_defconfig}  |  13 +-
 arch/arm/configs/spitz.config                      |  10 +
 arch/arm/configs/spitz_defconfig                   | 273 --------------
 arch/arm/configs/tegra/hw_m.config                 |   1 +
 arch/arm/configs/tegra/hw_m_shared.config          |   3 +
 arch/arm/configs/tegra/hw_y.config                 |  48 +++
 arch/arm/configs/tegra/hw_y_shared.config          | 151 ++++++++
 arch/arm/configs/tegra/sys_y.config                |  63 ++++
 arch/arm/configs/tegra/sys_y_shared.config         |  40 ++
 arch/arm/configs/tegra_defconfig                   | 305 ---------------
 60 files changed, 1052 insertions(+), 2743 deletions(-)
 create mode 100644 arch/arm/configs/acs5k.config
 delete mode 100644 arch/arm/configs/acs5k_defconfig
 create mode 100644 arch/arm/configs/acs5k_tiny.config
 delete mode 100644 arch/arm/configs/acs5k_tiny_defconfig
 rename arch/arm/configs/{aspeed_g4_defconfig => aspeed_basic_defconfig} (98%)
 create mode 100644 arch/arm/configs/aspeed_g4.config
 create mode 100644 arch/arm/configs/aspeed_g5.config
 delete mode 100644 arch/arm/configs/aspeed_g5_defconfig
 create mode 100644 arch/arm/configs/corgi.config
 create mode 100644 arch/arm/configs/dummy_defconfig
 create mode 100644 arch/arm/configs/exynos/hw_m.config
 create mode 100644 arch/arm/configs/exynos/hw_m_shared.config
 create mode 100644 arch/arm/configs/exynos/hw_y.config
 create mode 100644 arch/arm/configs/exynos/hw_y_shared.config
 create mode 100644 arch/arm/configs/exynos/sys_y.config
 create mode 100644 arch/arm/configs/exynos/sys_y_shared.config
 delete mode 100644 arch/arm/configs/exynos_defconfig
 create mode 100644 arch/arm/configs/ezx.config
 delete mode 100644 arch/arm/configs/ezx_defconfig
 create mode 100644 arch/arm/configs/imote2.config
 create mode 100644 arch/arm/configs/ks8695.config
 rename arch/arm/configs/{ks8695_defconfig => ks8695_basic_defconfig} (56%)
 create mode 100644 arch/arm/configs/lpd270.config
 delete mode 100644 arch/arm/configs/lpd270_defconfig
 create mode 100644 arch/arm/configs/lubbock.config
 delete mode 100644 arch/arm/configs/lubbock_defconfig
 create mode 100644 arch/arm/configs/mainstone.config
 create mode 100644 arch/arm/configs/mmp2.config
 delete mode 100644 arch/arm/configs/mmp2_defconfig
 rename arch/arm/configs/{pxa168_defconfig => mmp_basic_defconfig} (61%)
 rename arch/arm/configs/{multi_v7_defconfig => multi_v7_base_defconfig} (71%)
 create mode 100644 arch/arm/configs/nuc950.config
 delete mode 100644 arch/arm/configs/nuc950_defconfig
 create mode 100644 arch/arm/configs/nuc960.config
 delete mode 100644 arch/arm/configs/nuc960_defconfig
 create mode 100644 arch/arm/configs/pxa168.config
 create mode 100644 arch/arm/configs/pxa255-idp.config
 delete mode 100644 arch/arm/configs/pxa255-idp_defconfig
 create mode 100644 arch/arm/configs/pxa910.config
 delete mode 100644 arch/arm/configs/pxa910_defconfig
 rename arch/arm/configs/{mainstone_defconfig => pxa_basic1_defconfig} (62%)
 rename arch/arm/configs/{corgi_defconfig => pxa_basic2_defconfig} (83%)
 rename arch/arm/configs/{imote2_defconfig => pxa_basic3_defconfig} (75%)
 create mode 100644 arch/arm/configs/spear13xx.config
 delete mode 100644 arch/arm/configs/spear13xx_defconfig
 create mode 100644 arch/arm/configs/spear3xx.config
 delete mode 100644 arch/arm/configs/spear3xx_defconfig
 create mode 100644 arch/arm/configs/spear6xx.config
 rename arch/arm/configs/{spear6xx_defconfig => spear_basic_defconfig} (87%)
 create mode 100644 arch/arm/configs/spitz.config
 delete mode 100644 arch/arm/configs/spitz_defconfig
 create mode 100644 arch/arm/configs/tegra/hw_m.config
 create mode 100644 arch/arm/configs/tegra/hw_m_shared.config
 create mode 100644 arch/arm/configs/tegra/hw_y.config
 create mode 100644 arch/arm/configs/tegra/hw_y_shared.config
 create mode 100644 arch/arm/configs/tegra/sys_y.config
 create mode 100644 arch/arm/configs/tegra/sys_y_shared.config
 delete mode 100644 arch/arm/configs/tegra_defconfig

-- 
1.9.1
