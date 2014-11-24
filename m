From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 24 Nov 2014 14:17:45 +0530
Subject: [PATCH v6 0/2] Remove i2c sys_cfg register configuration from
 mach-exynos
Message-ID: <1416818867-29156-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is removing i2c sys_cfg register configuration settings from
mach-exynos. All such configuration can be done into i2c driver.
So added new property to hold phandle of SYSREG into i2c device nodes.
This will help in removing static mapping of SYS registers.

This series is based on latest kgene/for-next. 

This patch series requires following change in i2c driver which has been separated
from this patch series and posted separately here [1]

https://patchwork.kernel.org/patch/5363981/

Revision V5 of these patches can related discussion can be found here.

http://www.spinics.net/lists/linux-samsung-soc/msg39326.html

This patch and patch [1] has been tested on kgene/for-next for S2R on Exynos5250 based
SMDK5250 board and it's working well.


Changes since v5:
 - Rebased on latest kgene/for-next (SHA-ID: 4059421c38d24f2f7e06778c8ee6da4ca9abb4b7)
 - Separated changes in i2c-s3c2410.c file and posted as separate patch.

Changes since v4:
 - Rebased on latest kgene/for-next (SHA-ID: 7552917ad948acad6c689d49604f93f725145173)
 - Addressed Wolfram Sang's review comments.

Change since v3:
 - Rebased on latest kgene/for-next (SHA-ID: 2b5fa1d5dabb9af8f2da4f380bea8684f9b96f59)
 - This series consist of only two patches from v3 [1] (v3[1/6] and v3[2/6]).
 - Addressed Tomasz Figa and Wolfram Sang's comments.
 - Updated i2c DT binding information.

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
  i2c: s3c2410: add Sysreg phandle to i2c device nodes
  ARM: EXYNOS: Remove i2c sys configuration related code

 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 ++
 arch/arm/boot/dts/exynos5420.dtsi                  |    4 ++
 arch/arm/mach-exynos/exynos.c                      |   39 +-------------------
 arch/arm/mach-exynos/include/mach/map.h            |    3 --
 arch/arm/mach-exynos/pm.c                          |    3 +-
 arch/arm/mach-exynos/regs-sys.h                    |   22 -----------
 arch/arm/mach-exynos/suspend.c                     |    7 ----
 8 files changed, 13 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/regs-sys.h

-- 
1.7.9.5
