From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:46:54 +0530
Subject: [PATCH v9 00/12] Introducing Exynos ChipId driver
References: <CGME20170330131417epcas1p48a7f41b90177294b7918ecf31df130d1@epcas1p4.samsung.com>
Message-ID: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each Exynos SoC has ChipID block which can give information about SoC's
product Id and revision number.

This patch series introduces Exynos Chipid SoC driver. At the same time
it reduces dependency of mach-exynos files from plat-samsung, by removing
soc_is_exynosMMMM and samsung_rev API. Instead of it now we can use
soc_device_match API.

Until now we are using static mapping of Exynos Chipid and using this
static mapping to know about SoC name and revision via soc_is_exynosMMMM
macro. This is quite cumbersome and every time new ARMv7 based Exynos SoC
supports lands in mainline a bunch of such new macros needs to be added.
Quite long back during support of Exynos5260 it has been discussed to
solve this problem.

To solve this issue this patchset replaces use of soc_is_exynosMMMM by
either of_machine_is_compatible or soc_device_match depending upon usecase.

I have tested this patch series on Exynos4210 based Origen board for normal
SMP boot.

Although I submitted this series as a whole of 12 patchsets, following are
dependency details among the patches.

Patch 1/12 to 3/12 can be taken without any dependency on other patches.
Patch 4/12 to 6/12 can be taken witout any dependency on other patches.
Patch 7/12 to 12/12 has dependency on patches 1/12 to 6/12

Revision 8 and it's discussion can be found here:
 - https://www.spinics.net/lists/arm-kernel/msg548384.html

Revision 7 and it's discussion can be found here:
 - https://www.spinics.net/lists/arm-kernel/msg540790.html

Revision 6 and it's discussion can be found here:
 - https://lkml.org/lkml/2016/5/25/101

Revision 5 and it's discussion can be found here:
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310046.html

Revision 4 and it's discussion can be found here:
 - https://lkml.org/lkml/2014/12/3/115

Changes since v8:
 - Reordered patch sequences so that independent patches can be taken
   without any dependency issues among the patches.
 - Broken down patche Patch v8 5/8 into three patches as per suggestion
   from Krzysztof.
 - Addressed concerns raised from Andrzej and Bartlomiej.
 - Fixed mask values for exynos4 based SoCs.
 - Rebased patches on latest krzk/for-next
 - Addressed various comments from Krzysztof 

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
   exynos_chipid_info structure. It will be helpful when we need to provide more
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


Pankaj Dubey (12):
  ARM: EXYNOS: refactor firmware specific routines
  ARM: EXYNOS: remove usage of soc_is_exynosMMMM from pm.c
  ARM: EXYNOS: remove secondary startup initialization from
    smp_prepare_cpus
  soc: samsung: add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM: EXYNOS: introduce soc specific pm ops
  ARM: EXYNOS: move exynos_boot_vector_{addr,flag} ops to
    exynos_s2r_data
  ARM: EXYNOS: introduce exynos_cpu_info struct
  ARM: EXYNOS: move power_{down,up} to per SoC struct exynos_cpu_info
  ARM: EXYNOS: move cpu_restart as a SoC specific hook to
    exynos_cpu_info
  ARM: EXYNOS: refactor of mach-exynos to use chipid information

 arch/arm/mach-exynos/Kconfig                 |   1 +
 arch/arm/mach-exynos/common.h                |  97 -----------
 arch/arm/mach-exynos/exynos.c                |  44 ++---
 arch/arm/mach-exynos/firmware.c              | 114 +++++++++---
 arch/arm/mach-exynos/platsmp.c               | 249 +++++++++++++++++++++------
 arch/arm/mach-exynos/pm.c                    | 200 ++++++++++++++++++---
 arch/arm/plat-samsung/cpu.c                  |  14 --
 arch/arm/plat-samsung/include/plat/cpu.h     |   2 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |   2 -
 arch/arm64/Kconfig.platforms                 |   1 +
 drivers/soc/samsung/Kconfig                  |   5 +
 drivers/soc/samsung/Makefile                 |   1 +
 drivers/soc/samsung/exynos-chipid.c          | 109 ++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h  |   3 +
 14 files changed, 587 insertions(+), 255 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

-- 
2.7.4
