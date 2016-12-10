From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 18:38:35 +0530
Subject: [PATCH v8 0/8] Introducing Exynos ChipId driver
Message-ID: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each Exynos SoC has ChipID block which can give information about SoC's
product Id and revision number.

This patch series introduces Exynos Chipid SoC driver. At the same time
it reduces dependency of mach-exynos files from plat-samsung, by removing
soc_is_exynosMMMM and samsung_rev API. Instead of it now we can use
soc_device_match API proposed by Arnd and getting discussed in thread [1].

Until now we are using static mapping of Exynos Chipid and using this static
mapping to know about SoC name and revision via soc_is_exynosMMMM macro. This
is quite cumbersome and every time new ARMv7 based Exynos SoC supports lands in
mainline a bunch of such new macros needs to be added. Quite long back during
support of Exynos5260 it has been discussed to solve this problem.

To solve this issue this patchset replaces use of soc_is_exynosMMMM by either
of_machine_is_compatible or soc_device_match depending upon usecase.

I have tested this patch series on Exynos4210 based Origen board for normal SMP
boot.


Although I submitted this series as a whole of 8 patchsets, following are dependency
details among the patches.

Patch 1/8 can be taken without any dependency on other patches.
Patch 2/8 and 3/8 has dependency on 1/8 and can be taken along with 1/8.
Patch 4/8 has no dependency and can be taken without chipid driver patch 1/8.
Patch 5/8 has depency on 1/8
Patch 6/8 has no dependency and can be taken without any other patches.
Patch 7/8 has dependency on 6/8 and 1/8
Patch 8/8 has dependency on rest of patches

[1]: https://patchwork.kernel.org/patch/9361389/

Revision 7 and it's discussion can be found here:
 - https://www.spinics.net/lists/arm-kernel/msg540790.html

Revision 6 and it's discussion can be found here:
 - https://lkml.org/lkml/2016/5/25/101

Revision 5 and it's discussion can be found here:
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310046.html

Revision 4 and it's discussion can be found here:
 - https://lkml.org/lkml/2014/12/3/115

Changes since v7:
 - Added ARM64 based Exynos7 and Exynos5433 support in chipid driver.
 - Removed Exynos4415 support from chipid driver, as exynos4415 has been removed from tree
 - Added patch to enable chipid driver for ARM64 based Exynos platform
 - Addressed review comments from Arnd for firmware.c, platsmp.c and pm.c files/
 - Splitted changes in firmware.c, platsmp.c and pm.c in separate patches 
   for better code review
 - Included suggested code improvement in exynos-chipid.c from Marek Szyprowski

Chances since v6:
 - Removed platform driver from chipid, instead use early_init to register soc_device
 - Removed export functions from exynos chipid driver
 - Replace soc_is_exynosMMMM via either of_machine_is_compatible or soc_device_match in
   files in arm/mach-exynos folder
 - This patchset depends on the following patch series by Geert Uytterhoeven. This series
   includes patch which introduces soc_device_match.
   http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1261739.html
 - Rebased on latest krzk/for-next branch and retested.

Change since v5:
 - Addressed Rob's review comments.
 - Rebased on latest krzk/for-next branch and retested.

Changes since v4:
 - Removed custom sysfs entries as they were not providing any new information
   as pointed out by Arnd.
 - Removed functions exporting product_id and revision, instead we will export
   exynos_chipid_info structure. It will be helpfull when we need to provide more
   fields of chipid outside of chipid, as commented by Yadwinder
 - Converted all funcions as __init. 

Change since v3: 
 - This patch set contains 5/6 and 6/6 patch from v3 series.
 - Made EXYNOS_CHIPID config option non-user selectable,
   as suggested by Tomasz Figa.
 - Made uniform macro for EXYNOS4/5_SOC_MASK as EXYNOS_SOC_MASK as
   suggested by Tomasz Figa.
 - Made local variables static in chipid driver.
 - Added existing SoC's product id's.
 - Added platform driver support.

Changes since v2:
 - Reorganized patches as suggested by Tomasz Figa.
 - Addressed review comments of Tomasz Figa in i2c-s3c2410.c file.

Pankaj Dubey (8):
  soc: samsung: add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM: EXYNOS: refactor firmware specific routines
  ARM: EXYNOS: refactor power management specific routines
  ARM: EXYNOS: remove secondary startup initialization from
    smp_prepare_cpus
  ARM: EXYNOS: refactor smp specific code and routines
  ARM: EXYNOS: refactor of mach-exynos to use chipid information

 arch/arm/mach-exynos/Kconfig                 |   1 +
 arch/arm/mach-exynos/common.h                |  92 ---------
 arch/arm/mach-exynos/exynos.c                |  38 ----
 arch/arm/mach-exynos/firmware.c              | 100 +++++++---
 arch/arm/mach-exynos/include/mach/map.h      |  21 ---
 arch/arm/mach-exynos/platsmp.c               | 267 +++++++++++++++++++++------
 arch/arm/mach-exynos/pm.c                    | 185 ++++++++++++++++---
 arch/arm/plat-samsung/cpu.c                  |  14 --
 arch/arm/plat-samsung/include/plat/cpu.h     |   2 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |   2 -
 arch/arm64/Kconfig.platforms                 |   1 +
 drivers/soc/samsung/Kconfig                  |   5 +
 drivers/soc/samsung/Makefile                 |   1 +
 drivers/soc/samsung/exynos-chipid.c          | 116 ++++++++++++
 14 files changed, 563 insertions(+), 282 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

-- 
2.7.4
