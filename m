From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue,  1 Mar 2016 18:37:22 +0900
Subject: [GIT PULL] ARM: EXYNOS: SROM driver for v4.6, 2nd try
In-Reply-To: <1456825042-23733-1-git-send-email-k.kozlowski@samsung.com>
References: <1456825042-23733-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456825042-23733-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


After Olof comments, second pull request with movement of SROM code
to separate driver - under drivers/memory/samsung (more are planned for
that directory).

This depends on (included here):
1. tag samsung-dt-srom-4.6: SROM-DT changes, merged already to arm-soc,
2. tag samsung-soc-4.6-2: next/soc changes, sent few days ago, not merged yet.

This may conflict in the future (in linux-next or Linus) around
drivers/memory/Kconfig with iommu tree. Just add all the changes.


The diff at the end contains both samsung-soc-4.6-2 and this stuff.
To make finding changes easier, below you will find difference between
this tag and samsung-soc-4.6-2:

----------------------------------------------------------------
Pankaj Dubey (4):
      dt-bindings: EXYNOS: Add exynos-srom device tree binding
      memory: Add support for Exynos SROM driver
      MAINTAINERS: Add maintainers entry for drivers/memory/samsung
      ARM: EXYNOS: Remove SROM related register settings from mach-exynos

Pavel Fedin (2):
      dt-bindings: EXYNOS: Describe SROMc configuration
      memory: samsung: exynos-srom: Add support for bank configuration
----------------------------------------------------------------


Best regards,
Krzysztof


The following changes since commit d2deef6c61e65d1e0cee40c1d74fa99007da8c84:

  ARM: dts: Add SROM to exynos5410 (2016-01-25 10:32:07 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-srom-4.6-2

for you to fetch changes up to dbdc0c61333e1b0c42c9ea7e97faaaed3ded14a8:

  memory: samsung: exynos-srom: Add support for bank configuration (2016-02-29 13:12:48 +0900)

----------------------------------------------------------------
Topic branch for Samsung soc/drivers update for 4.6.

This moves Samsung SROM controller code from arm/mach-exynos into to
separate driver under drivers/memory/samsung. In the future this driver
will be re-used on ARM64 Exynos platform.

More drivers are planned for drivers/memory/samsung.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: s3c24xx: Avoid warning for inb/outb

Bartlomiej Zolnierkiewicz (2):
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5420
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5422/5800

Geliang Tang (1):
      ARM: plat-samsung: use to_platform_device()

Krzysztof Kozlowski (3):
      drivers: soc: samsung: Enable COMPILE_TEST
      Merge tag 'samsung-dt-srom-4.6' into for-v4.6/drivers-soc-exynos-srom-2
      Merge tag 'samsung-soc-4.6-2' into for-v4.6/drivers-soc-exynos-srom-2

Masahiro Yamada (1):
      ARM: s3c64xx: use "depends on" instead of "if" after prompt

Pankaj Dubey (16):
      ARM: EXYNOS: Remove unused static mapping of CMU for exynos5
      ARM: EXYNOS: Code cleanup in map.h
      ARM: EXYNOS: Correct header comment in Kconfig file
      ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
      ARM: EXYNOS: Split up exynos3250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos4 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5420 SoC specific PMU data
      drivers: soc: Add support for Exynos PMU driver
      MAINTAINERS: Add maintainers entry for drivers/soc/samsung
      ARM: EXYNOS: Cleanup header files inclusion
      ARM: SAMSUNG: Remove unused register offset definition
      dt-bindings: EXYNOS: Add exynos-srom device tree binding
      memory: Add support for Exynos SROM driver
      MAINTAINERS: Add maintainers entry for drivers/memory/samsung
      ARM: EXYNOS: Remove SROM related register settings from mach-exynos

Pavel Fedin (2):
      dt-bindings: EXYNOS: Describe SROMc configuration
      memory: samsung: exynos-srom: Add support for bank configuration

 .../bindings/memory-controllers/exynos-srom.txt    |  81 ++
 MAINTAINERS                                        |   2 +
 arch/arm/mach-exynos/Kconfig                       |   7 +-
 arch/arm/mach-exynos/Makefile                      |   2 +-
 arch/arm/mach-exynos/common.h                      |   1 -
 arch/arm/mach-exynos/exynos.c                      |  34 +-
 arch/arm/mach-exynos/firmware.c                    |   2 -
 arch/arm/mach-exynos/include/mach/map.h            |  17 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |   3 +-
 arch/arm/mach-exynos/pm.c                          |   8 +-
 arch/arm/mach-exynos/pmu.c                         | 967 ---------------------
 arch/arm/mach-exynos/regs-srom.h                   |  53 --
 arch/arm/mach-exynos/s5p-dev-mfc.c                 |   1 -
 arch/arm/mach-exynos/suspend.c                     |  24 +-
 arch/arm/mach-s3c24xx/include/mach/io.h            |   2 +-
 arch/arm/mach-s3c24xx/include/mach/map.h           |  11 -
 arch/arm/mach-s3c64xx/Kconfig                      |   3 +-
 arch/arm/plat-samsung/adc.c                        |   6 +-
 arch/arm/plat-samsung/include/plat/map-s3c.h       |   4 -
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   6 -
 drivers/memory/Kconfig                             |   1 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/samsung/Kconfig                     |  13 +
 drivers/memory/samsung/Makefile                    |   1 +
 drivers/memory/samsung/exynos-srom.c               | 232 +++++
 drivers/memory/samsung/exynos-srom.h               |  51 ++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/samsung/Kconfig                        |  13 +
 drivers/soc/samsung/Makefile                       |   2 +
 drivers/soc/samsung/exynos-pmu.c                   | 141 +++
 drivers/soc/samsung/exynos-pmu.h                   |  44 +
 drivers/soc/samsung/exynos3250-pmu.c               | 175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  | 222 +++++
 drivers/soc/samsung/exynos5250-pmu.c               | 195 +++++
 drivers/soc/samsung/exynos5420-pmu.c               | 280 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |   6 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   6 +-
 39 files changed, 1489 insertions(+), 1132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 create mode 100644 drivers/memory/samsung/Kconfig
 create mode 100644 drivers/memory/samsung/Makefile
 create mode 100644 drivers/memory/samsung/exynos-srom.c
 create mode 100644 drivers/memory/samsung/exynos-srom.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)
