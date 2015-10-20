From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 20 Oct 2015 14:45:31 +0530
Subject: [PATCH v5 0/8] Add support for Exynos SROM Controller driver
Message-ID: <1445332540-12814-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
  Documentation: dt-bindings: add exynos-srom binding information
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
2.4.5
