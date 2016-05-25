From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 25 May 2016 13:28:22 +0530
Subject: [PATCH v6 0/2] Introducing Exynos ChipId driver
Message-ID: <1464163104-8163-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once again I am respinning this quite old patch series to introduce 
Exynos Chipid driver.

This patch series introduces Exynos Chipid platform driver.
Each Exynos SoC has ChipID block which can give information about SoC's
product Id and revision number.
At the same time it reduces dependency of mach-exynos files from plat-samsung,
by removing samsung_rev API, similar API is introduced in chipid driver itself
to get revision number and product id. 

I have tested this patch series on Exynos5880 based Chromebook for
normal system boot and S2R.

Revisiion 5 and it's discussion can be found here
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310046.html
Revision 4 and it's discussion can be found here
 - https://lkml.org/lkml/2014/12/3/115

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

Changes since v1:
 - Added patch to move i2c interrupt re-configuration code from exynos.c
   to i2c driver, as suggested by Arnd.
 - After above patch only user of SYS_I2C_CFG register is pm.c so moving
   save/restore of this register also into i2c driver.
 - Spiltted up exynos4 and exynos5 machine descriptors to get rid from
   soc_is_exynos4/exynos5 kind of macros, as suggested by Arnd.
 - Changed location of chipid driver to "drivers/soc".
 - Added drivers/base/soc.c provided infrastructure to make SoC specific 
   information avaible to user space via sysfs entry, as suggested by Arnd.

Pankaj Dubey (2):
  soc: samsung: add exynos chipid driver support
  ARM: EXYNOS: refactoring of mach-exynos to enable chipid driver

 arch/arm/mach-exynos/Kconfig                 |   1 +
 arch/arm/mach-exynos/common.h                |  53 ++++-----
 arch/arm/mach-exynos/exynos.c                |  49 ++------
 arch/arm/mach-exynos/include/mach/map.h      |   2 -
 arch/arm/mach-exynos/platsmp.c               |   2 +-
 arch/arm/mach-exynos/pm.c                    |   8 +-
 arch/arm/plat-samsung/cpu.c                  |  14 ---
 arch/arm/plat-samsung/include/plat/cpu.h     |   2 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |   1 -
 drivers/soc/samsung/Kconfig                  |   5 +
 drivers/soc/samsung/Makefile                 |   1 +
 drivers/soc/samsung/exynos-chipid.c          | 172 +++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-soc.h       |  51 ++++++++
 13 files changed, 266 insertions(+), 95 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-chipid.c
 create mode 100644 include/linux/soc/samsung/exynos-soc.h

-- 
2.4.5
