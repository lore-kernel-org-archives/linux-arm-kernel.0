From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Feb 2016 09:34:03 +0900
Subject: [GIT PULL 4/7] ARM: EXYNOS: mach/soc changes for v4.6
In-Reply-To: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455496446-23779-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

This pulls previous tags (early DT changes, movement of SROM/PMU
to drivers/soc) and contains other interesting stuff. Description
along with a tag.

Kind regards,
Krzysztof


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.6

for you to fetch changes up to f6e4621b33f5eab73510c587023910a4566c2611:

  ARM: EXYNOS: Use generic cpufreq driver for Exynos5422/5800 (2016-01-28 19:31:31 +0900)

----------------------------------------------------------------
Samsung Exynos improvements for v4.6:
1. Split out Exynos SROM controller from arm/mach-exynos
   to drivers/soc/samsung. It allows re-using of SROM controller
   driver on ARM64 platform.
   This depends on DT changes.
2. Add banking configuration to Exynos SROM controller.
   This allows usage of SMSC9115 Ethernet chip on SMDK5410 (Exynos5410)
   directly connected to SROM controller.
3. Split out Exynos PMU driver implementation from arm/mach-exynos
   to the drivers/soc/samsung which will allow re-use of it on ARM64.
4. Use generic DT cpufreq driver on Exynos542x/5800.
5. Minor cleanups.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5420
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5422/5800

Geliang Tang (1):
      ARM: plat-samsung: use to_platform_device()

Krzysztof Kozlowski (2):
      Merge tag 'samsung-dt-srom-4.6' into for-v4.6/drivers-soc-exynos-srom-pmu
      Merge tag 'samsung-drivers-soc-srom-pmu-4.6' into next/soc

Masahiro Yamada (1):
      ARM: s3c64xx: use "depends on" instead of "if" after prompt

Pankaj Dubey (14):
      ARM: dts: Add SROM device node for exynos4
      ARM: dts: Add SROM device node for exynos5
      ARM: EXYNOS: Remove unused static mapping of CMU for exynos5
      ARM: EXYNOS: Code cleanup in map.h
      dt-bindings: EXYNOS: Add exynos-srom device tree binding
      drivers: soc: Add support for exynos SROM driver
      MAINTAINERS: Add maintainers entry for drivers/soc/samsung
      ARM: EXYNOS: Remove SROM related register settings from mach-exynos
      ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
      ARM: EXYNOS: Split up exynos3250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos4 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5420 SoC specific PMU data
      drivers: soc: Add support for Exynos PMU driver

Pavel Fedin (3):
      ARM: dts: Add SROM to exynos5410
      dt-bindings: EXYNOS: Describe SROMc configuration
      drivers: soc: exynos-srom: Add support for bank configuration

 .../bindings/arm/samsung/exynos-srom.txt           |  81 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   5 +
 arch/arm/boot/dts/exynos5.dtsi                     |   5 +
 arch/arm/boot/dts/exynos5410.dtsi                  |   5 +
 arch/arm/mach-exynos/Kconfig                       |   3 +
 arch/arm/mach-exynos/Makefile                      |   2 +-
 arch/arm/mach-exynos/exynos.c                      |  30 +-
 arch/arm/mach-exynos/include/mach/map.h            |   8 -
 arch/arm/mach-exynos/mcpm-exynos.c                 |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |   2 +-
 arch/arm/mach-exynos/pm.c                          |   4 +-
 arch/arm/mach-exynos/pmu.c                         | 967 ---------------------
 arch/arm/mach-exynos/regs-srom.h                   |  53 --
 arch/arm/mach-exynos/suspend.c                     |  24 +-
 arch/arm/mach-s3c64xx/Kconfig                      |   3 +-
 arch/arm/plat-samsung/adc.c                        |   6 +-
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/samsung/Kconfig                        |  17 +
 drivers/soc/samsung/Makefile                       |   3 +
 drivers/soc/samsung/exynos-pmu.c                   | 141 +++
 drivers/soc/samsung/exynos-pmu.h                   |  44 +
 drivers/soc/samsung/exynos-srom.c                  | 232 +++++
 drivers/soc/samsung/exynos-srom.h                  |  51 ++
 drivers/soc/samsung/exynos3250-pmu.c               | 175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  | 222 +++++
 drivers/soc/samsung/exynos5250-pmu.c               | 195 +++++
 drivers/soc/samsung/exynos5420-pmu.c               | 280 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |   6 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   6 +-
 32 files changed, 1486 insertions(+), 1090 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos-srom.c
 create mode 100644 drivers/soc/samsung/exynos-srom.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)
