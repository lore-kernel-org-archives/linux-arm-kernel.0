From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 26 Oct 2015 18:25:36 +0530
Subject: [PATCH v3 0/7] samsung: pmu: split up SoC specific PMU data
Message-ID: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a part of continuation work from following series
[1] and [2].

1: exynos: Move pmu driver to driver/soc folder and add exynos7 support
   http://www.spinics.net/lists/linux-samsung-soc/msg39797.html from Amit Daniel Kacchap
2: soc: samsung: pmu: split up SoC specific PMU data
   https://lkml.org/lkml/2015/1/7/12 from me

Here is another attempt for the same, in this series I am splitting up SoC
specific PMU configuration data into mach-exynos folder itself, before moving
all of them under drivers/soc/samsung/. Also instead of making all changes in
single patch it has been broken into SoC specific patches to avoid large size
of patch. With this approach there will not be unwanted big churns just after
adding exynos-pmu under drivers/soc/samsung.

All these patches are just refactoring to keep minimal changes while moving
exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can be added
on top of it, in such a manner that for ARM64 build, ARM related SoC's PMU will not
get compiled and thus unnecessary increasing kernel image size.

I have tested on Peach-Pi (Exynos5880) based chromebook for boot
and S2R functionality.

These patches have been prepared on top of Kukjin Kim's for-next

Changes since v2:
 - Removed Amit's Samsung id as it's no more valid.
 - Rebased on latest kgene tree.
 - Removed redundant code from regs-pmu.h


Pankaj Dubey (7):
  ARM: EXYNOS: removing redundant code from regs-pmu.h
  ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
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
 arch/arm/mach-exynos/pmu.c                         | 1004 --------------------
 arch/arm/mach-exynos/suspend.c                     |    4 +-
 drivers/soc/samsung/Kconfig                        |    4 +
 drivers/soc/samsung/Makefile                       |    4 +
 drivers/soc/samsung/exynos-pmu.c                   |  168 ++++
 drivers/soc/samsung/exynos-pmu.h                   |   52 +
 drivers/soc/samsung/exynos3250-pmu.c               |  175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  |  223 +++++
 drivers/soc/samsung/exynos5250-pmu.c               |  196 ++++
 drivers/soc/samsung/exynos5420-pmu.c               |  280 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |    2 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   17 +-
 18 files changed, 1116 insertions(+), 1026 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (90%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (98%)

-- 
2.4.5
