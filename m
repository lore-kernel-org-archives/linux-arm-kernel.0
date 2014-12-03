From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 03 Dec 2014 13:47:36 +0530
Subject: [PATCH v4 0/2] Introducing Exynos ChipId driver
Message-ID: <1417594658-2931-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduces Exynos Chipid platform driver.
Each Exynos SoC has ChipID block which can give information about SoC's
product Id and revision number.
At the same time it reduces dependency of mach-exynos files from plat-samsung,
by removing samsung_rev API, similar API is introduced in chipid driver itself
to get revision number and product id. 

This patch series is based on Kukjin Kim's for-next having SHA_ID:
9db7d78aca2c7fbc19a26ce2ef01c805dc010c72

It can also be cleanly applied on latest (next-20141201) linux-next.

This has been tested against both tree on Exynos3250 and Exynos5250 (SMDK) board.

Revision 3 and it's discussion can be found here
 - https://lkml.org/lkml/2014/5/10/31
 - https://lkml.org/lkml/2014/6/10/270
 - https://lkml.org/lkml/2014/5/11/16

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

 arch/arm/mach-exynos/Kconfig                 |    2 +
 arch/arm/mach-exynos/common.h                |   46 ++----
 arch/arm/mach-exynos/exynos.c                |   77 ++++-----
 arch/arm/mach-exynos/include/mach/map.h      |    2 -
 arch/arm/mach-exynos/platsmp.c               |    2 +-
 arch/arm/mach-exynos/pm.c                    |    8 +-
 arch/arm/plat-samsung/cpu.c                  |   14 --
 arch/arm/plat-samsung/include/plat/cpu.h     |    2 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |    1 -
 drivers/soc/Kconfig                          |    1 +
 drivers/soc/Makefile                         |    1 +
 drivers/soc/samsung/Kconfig                  |   14 ++
 drivers/soc/samsung/Makefile                 |    1 +
 drivers/soc/samsung/exynos-chipid.c          |  218 ++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-soc.h       |   53 +++++++
 15 files changed, 338 insertions(+), 104 deletions(-)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-chipid.c
 create mode 100644 include/linux/soc/samsung/exynos-soc.h

-- 
1.7.9.5
