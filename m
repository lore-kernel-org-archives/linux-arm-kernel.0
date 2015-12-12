From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 12 Dec 2015 13:13:54 +0530
Subject: [RESEND PATCH v5 0/8] Add support for Exynos SROM Controller driver
Message-ID: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THIS IS A RESEND OF ONCE MERGED INTO kgene/for-next AND LOST PATCHES

Series v5 got merged in kgene/for-next but due to last moment change before pull
these patches were not accepted during 4.3 merge window.After that kgene/for-next
got rebased over 4.4-rc1 these patches got dropped into another branch and till
date not included to for-next.

Since then due to minor change in "drivers/soc/", patches are not getting applied
cleanly so rebasing on current for-next and resending all these with fix in memory
mapping included.


This patch set adds support for Exynos SROM controller DT based driver.
Currently SROM register sets are used only during S2R, so driver
basically added for taking care of S2R. It will help us in removing
static mapping from exynos.c and other extra code handline during S2R.

This patch set also updated exynos4 and exynos5 dtsi files for with device
node for srom, and added binding documentation for the same.

First two patches are some minor cleanup in mach-exynos.

Patchset v1 was posted here[1]
[1]: https://lkml.org/lkml/2015/4/29/98
Patchset v2 was posted here[2]
[2]: https://lkml.org/lkml/2015/8/24/125
Patchset v3 was posted here[3]
[3]: https://lkml.org/lkml/2015/10/13/392
Patchset v3 was posted here[4]
[4]: https://lkml.org/lkml/2015/10/19/278

This patchset, I have tested on Peach-Pi (Exynos5880) based chromebook for boot
and S2R functionality.


Changes since v5:
 - Rebased and resolved conflicts on lastest for-next.
 - Included fix in memory mapping size in exynos4/exynos5 dtsi files.

Change since v4:
 - Removed unnedded NULL assignments from exynos_srom_remove function.
 - Added PM depency for selecting CONFIG_EXYNOS_SROM.
Changes since v3:
 - Rebased to lastet kgene tree.
 - Added platform data support, instead of using global variables for srom base
 - Addressed review comments from LABBE Corentin

Changes since v2:
 - Rebased to latest kgene tree.
 - Addressed review comments from Krzysztof Kozlowski.
 - Add new patch for MAINTAINER list update.
 - Reordered patch sequence for avoiding git bisect issues.

Changes since v1:
 - Rebased to latest kgene tree.
 - Addressed review comments from Krzysztof Kozlowski.
 - Add two new patches for minor cleanup in exynos.c and map.h

Pankaj Dubey (8):
  ARM: EXYNOS: remove unused static mapping of CMU for exynos5
  ARM: EXYNOS: code cleanup in map.h
  dt-bindings: add exynos-srom device tree binding
  ARM: dts: add SROM device node for exynos4
  ARM: dts: add SROM device node for exynos5
  drivers: soc: add support for exynos SROM driver
  MAINTAINERS: add maintainers entry for drivers/soc/samsung
  ARM: EXYNOS: Remove SROM related register settings from mach-exynos

 .../bindings/arm/samsung/exynos-srom.txt           |  12 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   5 +
 arch/arm/boot/dts/exynos5.dtsi                     |   5 +
 arch/arm/mach-exynos/Kconfig                       |   2 +
 arch/arm/mach-exynos/exynos.c                      |  22 ---
 arch/arm/mach-exynos/include/mach/map.h            |   8 -
 arch/arm/mach-exynos/regs-srom.h                   |  53 -------
 arch/arm/mach-exynos/suspend.c                     |  20 +--
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/samsung/Kconfig                        |  13 ++
 drivers/soc/samsung/Makefile                       |   1 +
 drivers/soc/samsung/exynos-srom.c                  | 175 +++++++++++++++++++++
 drivers/soc/samsung/exynos-srom.h                  |  51 ++++++
 16 files changed, 269 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-srom.c
 create mode 100644 drivers/soc/samsung/exynos-srom.h

-- 
1.9.1
