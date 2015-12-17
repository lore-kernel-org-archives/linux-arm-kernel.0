From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Dec 2015 15:50:06 +0100
Subject: [GIT PULL] clockevents for 4.5
Message-ID: <5672CB9E.7090707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

this pull request is bigger than the other ones. It contains a lot of 
changes and cleanups in order to increase the compilation test coverage.

  - Add cosmetic changes on error and a memory leakage on failure at 
init time for the mediatek timer (Alexey Klimov)

  - Remove the useless dsb() usage in the rockchip timer, the side 
effect is it can compile for the ARM and ARM64 (Caesar Wang)

  - Huge cleanups and fixes for the timers st_lpc, pxa_timer, tango, 
pistachio, mediatek, rockchip, armada-370-xp, meson6, orion, digicolor, 
dw_apb, sun4i, sun5i, tegra2, vt8500, cadence_ttc, asm9260, lpc32xx, 
nomadik_mtu, prcmu, exynos_mct, samsung-pwm and fsl-ftm in order to add 
the COMPILE_TEST option (Daniel Lezcano)

  - Cleanup of the h8300 timers and add the COMPILE_TEST option (Daniel 
Lezcano)

  - Factor out the tango-xtal and the timer_sun5i code by using the 
clocksource_mmio_init (Daniel Lezcano)

  - Fix suspend / resume on the arch_arm_timer (Grygorii Strashko)

  - Implement an ARM delay timer, fix return value and use relaxed io to 
improve performances on the dw_apb_timer (Jisheng Zhang)

  - Improve greatly performances by using writel_relaxed in 
gt_compare_set in the arm_global_timer (Jisheng Zhang)

  - Use the dynamic irq affinity flag on the tegra2 timer (Lucas Stach)

  - Correct pr_err() output format on the lpc32 timer (Vladimir Zapolskiy)

  - Second round of cleanups on the h8300 timers (Yoshinori Sato)

Tested on kernelci.org:
https://kernelci.org/build/dlezcano/kernel/v4.4-rc2-71-gd33f250af4e6/
https://kernelci.org/boot/all/job/dlezcano/kernel/v4.4-rc2-71-gd33f250af4e6/

Thanks !

   -- Daniel


The following changes since commit 82bbe34b3d895fb026b2fc0e7da2e641797bfaed:

   nohz: Clarify magic in tick_nohz_stop_sched_tick() (2015-11-25 
22:37:27 +0100)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git kevin-bot

for you to fetch changes up to d33f250af4e67d449f2c748b861ba99d50955469:

   clocksource/drivers/h8300: Use ioread / iowrite (2015-12-16 17:20:13 
+0100)

----------------------------------------------------------------
Alexey Klimov (3):
       clocksource/drivers/mtk_timer: Add pr_fmt define
       clocksource/drivers/mtk_timer: Fix pr_warn() messages in 
mtk_timer_init
       clocksource/drivers/mtk_timer: Fix memleak in mtk_timer_init()

Caesar Wang (2):
       clocksource/drivers/rockchip: Make the driver more readable
       clocksource/drivers/rockchip: Remove dsb() usage

Daniel Lezcano (49):
       time: Define dummy functions for the generic sched clock
       clocksource/drivers/qcom: Make COMPILE_TEST enabled for ARM 
architecture
       clocksource/drivers/st_lpc: Fix Kconfig dependency
       clocksource/drivers/st_lpc: Add the COMPILE_TEST option
       clocksource/drivers/pxa_timer: Move the Kconfig rule
       clocksource/drivers/pxa_timer: Add the COMPILE_TEST option
       clocksource/drivers/tango: Add COMPILE_TEST option
       clocksource/drivers/pistachio: Add the COMPILE_TEST option
       clocksource/drivers/mediatek: Add the COMPILE_TEST option
       clocksource/drivers/rockchip: Add COMPILE_TEST option
       clocksource/drivers/armada-370-xp: Add the COMPILE_TEST option
       clocksource/drivers/meson6: Add the COMPILE_TEST option
       clocksource/drivers/orion: Add the COMPILE_TEST option
       clocksource/drivers/digicolor: Add the COMPILE_TEST option
       clocksource/drivers/dw_apb: Add the COMPILE_TEST option
       clocksource/drivers/sun4i: Add the COMPILE_TEST option
       clocksource/drivers/sun5i: Add the COMPILE_TEST option
       clocksource/drivers/tegra2: Add the COMPILE_TEST option
       clocksource/drivers/vt8500: Remove unneeded header
       clocksource/drivers/vt8500: Add the COMPILE_TEST option
       clocksource/drivers/cadence_ttc: Add the COMPILE_TEST option
       clocksource/drivers/asm9260: Add the COMPILE_TEST option
       clocksource/drivers/lpc32xx: Add the COMPILE_TEST option
       clocksource/drivers/nomadik_mtu: Add the COMPILE_TEST option
       clocksource/drivers/prcmu: Fix Kconfig and add COMPILE_TEST option
       clocksource/drivers/exynos_mct: Fix Kconfig and add COMPILE_TEST 
option
       clocksource/drivers/samsung-pwm: Add the COMPILE_TEST option
       clocksource/drivers/fsl-ftm: Add the COMPILE_TEST option
       clocksource/drivers/Kconfig: Add missing GENERIC_CLOCKEVENTS 
dependency
       clocksource/drivers/h8300_timer8: Fix compilation error with dev_warn
       clocksource/drivers/h8300_tpu: Remove unused macros
       clocksource/drivers/h8300_tpu: Remove pointless headers for TPU
       clocksource/drivers/h8300_timer8: Remove unused headers
       clocksource/drivers/h8300_timer8: Remove unused macros
       clocksource/drivers/h8300_timer8: Remove PERIODIC and ONESHOT macro
       clocksource/drivers/h8300_timer8: Fix irq return value check
       clocksource/drivers/h8300_timer8: Remove pointless irq re-entrant 
safe code
       clocksource/drivers/h8300_timer8: Remove irq and lock legacy code
       clocksource/drivers/h8300_timer8: Retrieve the clock rate at init 
time
       clocksource/drivers/h8300_timer16: Remove pointless headers
       clocksource/drivers/h8300_timer16: Remove unused macros
       clocksource/drivers/h8300_timer16: Remove unused fields in 
timer16_priv
       clocksource/drivers/h8300_timer16: Fix irq return value check
       clocksource/drivers/h8300_timer16: Remove pointless lock
       clocksource/drivers/timer_sun5i: Replace code by 
clocksource_mmio_init
       clocksource/drivers/h8300_timer8: Separate the Kconfig option 
from the arch
       h8300: Rename ctlr_out/in[bwl] to raw_read/write[bwl]
       clocksource/drivers/h8300: Increase the compilation test coverage
       clocksource/drivers/tango-xtal: Replace code by clocksource_mmio_init

Grygorii Strashko (1):
       clocksource/drivers/arm_global_timer: Fix suspend resume

Jisheng Zhang (6):
       clocksource/drivers/dw_apb_timer_of: Implement ARM delay timer
       clocksource/drivers/dw_apb_timer: Fix apbt_readl return types
       clocksource/drivers/dw_apb_timer: Use {readl|writel}_relaxed in 
critical path
       clocksource/drivers/dw_apb_timer: Inline apbt_readl and apbt_writel
       clockevents/drivers/arm_global_timer: Use writel_relaxed in 
gt_compare_set
       clocksource/drivers/pistachio: Fix wrong calculated clocksource 
read value

Lucas Stach (1):
       clocksource/drivers/tegra: Allow timer irq affinity change

Vladimir Zapolskiy (1):
       clocksource/drivers/lpc32: Correct pr_err() output format

Yoshinori Sato (6):
       clocksource/drivers/h8300: Cleanup startup and remove module code.
       clocksource/drivers/h8300: Change to overflow interrupt
       clocksource/drivers/h8300: Fix timer not overflow case
       clocksource/drivers/h8300: Simplify delta handling
       clocksource/drivers/h8300: Initializer cleanup.
       clocksource/drivers/h8300: Use ioread / iowrite

  arch/arm/Kconfig                       |   3 +++
  arch/arm/mach-exynos/Kconfig           |   1 +
  arch/arm/mach-sti/Kconfig              |   1 +
  arch/arm/mach-ux500/Kconfig            |   1 +
  arch/h8300/Kconfig                     |   1 +
  arch/h8300/include/asm/io.h            |  39 
++++++++++++++++++++--------------
  arch/h8300/kernel/setup.c              |   8 +++----
  drivers/clocksource/Kconfig            | 132 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
  drivers/clocksource/Makefile           |   2 +-
  drivers/clocksource/arm_global_timer.c |  21 +++++++++++++-----
  drivers/clocksource/dw_apb_timer.c     |  46 
+++++++++++++++++++++++++---------------
  drivers/clocksource/dw_apb_timer_of.c  |  16 ++++++++++++++
  drivers/clocksource/h8300_timer16.c    | 222 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------------------------
  drivers/clocksource/h8300_timer8.c     | 264 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------------------------------------------------------------------------------
  drivers/clocksource/h8300_tpu.c        | 159 
++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------
  drivers/clocksource/mtk_timer.c        |  20 ++++++++++--------
  drivers/clocksource/rockchip_timer.c   |  23 +++++++++-----------
  drivers/clocksource/tango_xtal.c       |  18 +++-------------
  drivers/clocksource/tegra20_timer.c    |   3 ++-
  drivers/clocksource/time-lpc32xx.c     |   4 ++--
  drivers/clocksource/time-pistachio.c   |   2 +-
  drivers/clocksource/timer-sun5i.c      |  16 ++------------
  drivers/clocksource/vt8500_timer.c     |   1 -
  drivers/irqchip/irq-renesas-h8300h.c   |   8 +++----
  include/linux/sched_clock.h            |  12 ++++++++---
  25 files changed, 454 insertions(+), 569 deletions(-)

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
