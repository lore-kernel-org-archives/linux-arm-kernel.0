From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 07 Jan 2015 11:01:22 +0530
Subject: [PATCH v2 0/6] samsung: pmu: split up SoC specific PMU data
Message-ID: <1420608688-10459-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a part of continuation work from following series
[1] and [2].

1: exynos: Move pmu driver to driver/soc folder and add exynos7 support
   http://www.spinics.net/lists/linux-samsung-soc/msg39797.html from Amit Daniel Kacchap
2: soc: samsung: pmu: split up SoC specific PMU data
   https://lkml.org/lkml/2014/11/30/175 from me

As there were concerns ([3] and [4]) for moving PMU implementation into
"drivers/soc/samsung/" and using it for ARM64 samsung SoCs

3: https://lkml.org/lkml/2014/11/24/322 from Bartlomiej Zolnierkiewicz
4: http://www.spinics.net/lists/linux-samsung-soc/msg39809.html from Kukjin Kim

To address these concerns I posted patch [5] and splitted up SoC specific PMU
configuration data from exynos-pmu driver, since all changes had been
in single patch, size of patch was too large and it failed to appear on
samsung and arm-linux mailing list, but somehow it appeared on LKML.

5: soc: samsung: pmu: split up SoC specific PMU data
   https://lkml.org/lkml/2014/11/30/175

Here is second attempt for the same, in this series I am splitting up SoC specific
PMU configuration data into mach-exynos folder itself, before moving all of them
under drivers/soc/samsung/. Also instead of making all changes in single patch it has been
broken into SoC specific patches to avoid large size of patch. With this approach there will
not be unwanted big churns just after adding exynos-pmu under drivers/soc/samsung.

All these patches are just refactoring to keep minimal changes while moving
exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can be added
on top of it, in such a manner that for ARM64 build, ARM related SoC's PMU will not
get compiled and thus unnecessary increasing kernel image size.

I have tested it for normal system booting on Exynos3250 and SMDK5250 boards.
I have verified S2R on SMDK5250 after these patches and it's working fine.

These patches have been prepared on top of Kukjin Kim's for-next
having SHA-ID as 1eeec807bf644a0e691026b2fd and on top of my following accepted patch [6],
to avoid conflict in future.

6: ARM: EXYNOS: Remove i2c sys configuration related code
     http://www.spinics.net/lists/linux-samsung-soc/msg40671.html


Amit Daniel Kachhap (1):
  ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"

Pankaj Dubey (5):
  ARCH: EXYNOS: split up exynos3250 SoC specific PMU data
  ARCH: EXYNOS: split up exynos4 SoC specific PMU data
  ARCH: EXYNOS: split up exynos5250 SoC specific PMU data
  ARCH: EXYNOS: split up exynos5420 SoC specific PMU data
  drivers: soc: Add support for Exynos PMU driver

 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/Makefile                      |    2 +-
 arch/arm/mach-exynos/exynos.c                      |    2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    4 +-
 arch/arm/mach-exynos/pmu.c                         | 1005 --------------------
 arch/arm/mach-exynos/suspend.c                     |    4 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/samsung/Kconfig                        |   20 +
 drivers/soc/samsung/Makefile                       |    4 +
 drivers/soc/samsung/exynos-pmu.c                   |  148 +++
 drivers/soc/samsung/exynos-pmu.h                   |   52 +
 drivers/soc/samsung/exynos3250-pmu.c               |  175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  |  223 +++++
 drivers/soc/samsung/exynos5250-pmu.c               |  196 ++++
 drivers/soc/samsung/exynos5420-pmu.c               |  297 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |    0
 .../linux/soc/samsung/exynos-regs-pmu.h            |    0
 20 files changed, 1126 insertions(+), 1013 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (100%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (100%)

-- 
2.2.0
