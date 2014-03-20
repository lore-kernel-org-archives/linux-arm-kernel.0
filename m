From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 07:36:48 +0900
Subject: [GIT PULL 4/4] Samsung Exynos cleanup/consolidate for v3.15
Message-ID: <532B6D80.9070302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-cleanup

for you to fetch changes up to 602408e3de70d132c115670a366f4c5ae657080c:

   dt-bindings: clock: Move exynos-audss-clk.h to dt-bindings/clock 
(2014-03-21 04:31:30 +0900)

----------------------------------------------------------------
Exynos cleanup for v3.15

- reorganize code for
- add support reserve memory for mfc-v7
- consolidate exynos4 and exynos5 machine codes
- add generic compatible strings for exynos4 and exynos5
- update DT with generic compatible strings
- move clk related dt-binding header file in dt-bindings/clock

----------------------------------------------------------------
Sachin Kamat (6):
       ARM: EXYNOS: Add support to reserve memory for MFC-v7
       ARM: SAMSUNG: Introduce generic Exynos4 and 5 helpers
       ARM: EXYNOS: Consolidate CPU init code
       ARM: EXYNOS: Consolidate exynos4 and exynos5 machine files
       ARM: EXYNOS: Add generic compatible strings
       ARM: dts: Update Exynos DT files with generic compatible strings

Tushar Behera (2):
       ARM: SAMSUNG: Reorganize calls to reserve memory for MFC
       dt-bindings: clock: Move exynos-audss-clk.h to dt-bindings/clock

  arch/arm/boot/dts/exynos4210-origen.dts            |   2 +-
  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   2 +-
  arch/arm/boot/dts/exynos4210-trats.dts             |   2 +-
  arch/arm/boot/dts/exynos4210-universal_c210.dts    |   2 +-
  arch/arm/boot/dts/exynos4210.dtsi                  |   2 +-
  arch/arm/boot/dts/exynos4212.dtsi                  |   2 +-
  arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
  arch/arm/boot/dts/exynos4412-origen.dts            |   2 +-
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   2 +-
  arch/arm/boot/dts/exynos4412-tiny4412.dts          |   2 +-
  arch/arm/boot/dts/exynos4412-trats2.dts            |   2 +-
  arch/arm/boot/dts/exynos4412.dtsi                  |   2 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +-
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +-
  arch/arm/boot/dts/exynos5250-snow.dts              |   2 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |   4 +-
  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +-
  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   2 +-
  arch/arm/boot/dts/exynos5420.dtsi                  |   4 +-
  arch/arm/boot/dts/exynos5440-sd5v1.dts             |   2 +-
  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   2 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
  arch/arm/mach-exynos/Makefile                      |   7 +-
  arch/arm/mach-exynos/common.h                      |   3 +-
  arch/arm/mach-exynos/{common.c => exynos.c}        | 228 
++++++++++-----------
  arch/arm/mach-exynos/mach-exynos4-dt.c             |  59 ------
  arch/arm/mach-exynos/mach-exynos5-dt.c             |  81 --------
  arch/arm/mach-exynos/mfc.h                         |  16 ++
  arch/arm/mach-exynos/regs-pmu.h                    |   1 -
  arch/arm/plat-samsung/include/plat/cpu.h           |   4 +
  arch/arm/plat-samsung/include/plat/mfc.h           |   3 -
  arch/arm/plat-samsung/s5p-dev-mfc.c                |  17 +-
  drivers/clk/samsung/clk-exynos-audss.c             |   2 +-
  .../dt-bindings/{clk => clock}/exynos-audss-clk.h  |   0
  34 files changed, 166 insertions(+), 303 deletions(-)
  rename arch/arm/mach-exynos/{common.c => exynos.c} (71%)
  delete mode 100644 arch/arm/mach-exynos/mach-exynos4-dt.c
  delete mode 100644 arch/arm/mach-exynos/mach-exynos5-dt.c
  create mode 100644 arch/arm/mach-exynos/mfc.h
  rename include/dt-bindings/{clk => clock}/exynos-audss-clk.h (100%)

One more note, following is resolution for merge conflict. Sorry.

diff --cc arch/arm/mach-exynos/exynos.c
index e98ddad,fd3664f..b567361
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@@ -9,40 -9,27 +9,27 @@@
    * published by the Free Software Foundation.
    */

- #include <linux/kernel.h>
- #include <linux/bitops.h>
- #include <linux/interrupt.h>
- #include <linux/irq.h>
- #include <linux/irqchip.h>
+ #include <linux/init.h>
   #include <linux/io.h>
- #include <linux/device.h>
- #include <linux/gpio.h>
- #include <clocksource/samsung_pwm.h>
- #include <linux/sched.h>
- #include <linux/serial_core.h>
  +#include <linux/serial_s3c.h>
+ #include <linux/kernel.h>
   #include <linux/of.h>
- #include <linux/of_fdt.h>
- #include <linux/of_irq.h>
- #include <linux/pm_domain.h>
- #include <linux/export.h>
- #include <linux/irqdomain.h>
   #include <linux/of_address.h>
- #include <linux/irqchip/arm-gic.h>
- #include <linux/irqchip/chained_irq.h>
+ #include <linux/of_fdt.h>
+ #include <linux/of_platform.h>
   #include <linux/platform_device.h>
+ #include <linux/pm_domain.h>

- #include <asm/proc-fns.h>
- #include <asm/exception.h>
+ #include <asm/cacheflush.h>
   #include <asm/hardware/cache-l2x0.h>
+ #include <asm/mach/arch.h>
   #include <asm/mach/map.h>
- #include <asm/mach/irq.h>
- #include <asm/cacheflush.h>
+ #include <asm/memory.h>

   #include <plat/cpu.h>
- #include <plat/pm.h>
  -#include <plat/regs-serial.h>

   #include "common.h"
+ #include "mfc.h"
   #include "regs-pmu.h"

   #define L2_AUX_VAL 0x7C470001
