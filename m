From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:28 +0100
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
Message-ID: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch/arm tree contains several SMP local timer implementations
(smp_twd, Exynos4 mct, and the msm timer, with more to come), and the
word these days is that they should be moved to the driver directory.

Furthermore, the current core implementation makes it impossible to
compile a kernel with several SMP local timer implementations, as the
core code directly calls into the driver code.

This series moves these three drivers to driver/clocksource, with the
following changes:
- They are converted to platform devices, and registered as early devices.
- CPU notifiers are used to start/stop the timers on secondary cores.

Each platform registers an early platform device with the associated
resources (memory, interrupts). At the core level, an early device
probe hook is installed, and binds devices and drivers if
possible. The broadcast timer is always registered by the core code,
and is used by the kernel if no other timer is available.

Small side effect on the mpcode_wdt watchdog driver, who used to share
an include file with smp_twd, and now has a private copy of the
definition of few registers it needs.

It should be relatively easy to move other (non SMP)
timers/clocksources the same way, as it's already been done for
shmobile. Furthermore, it is now straightforward to convert these
platform devices to OF devices, and plug everything into the device
tree.

Patches against next-20110615 + my earlier GIC-PPI series. Tested on
VExpress, PB11MP, Pandaboard, Tegra Harmony and Exynos4 SMDK-v310.

Thomas and Arnd cc-ed on the whole series, as this could be
consolidation material.

As always, comments welcome.

Marc Zyngier (16):
  ARM: local timers: early device probing hooks
  ARM: local timers: add arm_smp_twd driver to driver/clocksource
  ARM: local timers: move realview to LOCAL_TIMER_DEVICES/ARM_SMP_TWD
  ARM: local timers: move vexpress to LOCAL_TIMER_DEVICES/ARM_SMP_TWD
  ARM: local timers: remove localtimer.c from plat-versatile
  ARM: local timers: move Tegra to LOCAL_TIMER_DEVICES/ARM_SMP_TWD
  ARM: local timers: move OMAP4 to LOCAL_TIMER_DEVICES/ARM_SMP_TWD
  ARM: local timers: move shmobile to LOCAL_TIMER_DEVICES/ARM_SMP_TWD
  ARM: local timers: move ux500 to LOCAL_TIMER_DEVICES/ARM_SMP_TWD
  ARM: local timers: add exynos_mct driver to driver/clocksource
  ARM: local timers: move exynos4 to
    LOCAL_TIMER_DEVICES/EXYNOS_MCT/ARM_SMP_TWD
  ARM: watchdog: make mpcore_wdt independant from asm/smp_twd.h
  ARM: local timers: remove smp_twd from arch/arm
  ARM: local timers: add msm_timer driver to driver/clocksource
  ARM: local timers: move msm to LOCAL_TIMER_DEVICES/MSM_TIMER
  ARM: local timers: remove local timer support from arch/arm

 arch/arm/Kconfig                         |   19 +--
 arch/arm/include/asm/localtimer.h        |   58 -----
 arch/arm/include/asm/mach/time.h         |    1 +
 arch/arm/include/asm/smp_twd.h           |   28 ---
 arch/arm/kernel/Makefile                 |    1 -
 arch/arm/kernel/smp.c                    |   70 ++-----
 arch/arm/kernel/smp_twd.c                |  163 --------------
 arch/arm/kernel/time.c                   |   15 ++
 arch/arm/mach-exynos4/Kconfig            |    2 +
 arch/arm/mach-exynos4/Makefile           |    1 -
 arch/arm/mach-exynos4/localtimer.c       |   27 ---
 arch/arm/mach-exynos4/mct.c              |  197 +----------------
 arch/arm/mach-exynos4/time.c             |   33 +++-
 arch/arm/mach-msm/Kconfig                |   10 +
 arch/arm/mach-msm/timer.c                |  290 +------------------------
 arch/arm/mach-omap2/Kconfig              |    3 +-
 arch/arm/mach-omap2/Makefile             |    1 -
 arch/arm/mach-omap2/timer-gp.c           |   40 +++-
 arch/arm/mach-omap2/timer-mpu.c          |   40 ----
 arch/arm/mach-realview/Kconfig           |    8 +
 arch/arm/mach-realview/realview_eb.c     |   31 +++-
 arch/arm/mach-realview/realview_pb11mp.c |   30 +++-
 arch/arm/mach-realview/realview_pbx.c    |   31 +++-
 arch/arm/mach-shmobile/Kconfig           |    2 +
 arch/arm/mach-shmobile/Makefile          |    1 -
 arch/arm/mach-shmobile/localtimer.c      |   27 ---
 arch/arm/mach-shmobile/platsmp.c         |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c    |   21 ++
 arch/arm/mach-shmobile/smp-sh73a0.c      |    6 -
 arch/arm/mach-shmobile/timer.c           |    2 +-
 arch/arm/mach-tegra/Kconfig              |    2 +
 arch/arm/mach-tegra/Makefile             |    2 +-
 arch/arm/mach-tegra/localtimer.c         |   27 ---
 arch/arm/mach-tegra/timer.c              |   32 +++-
 arch/arm/mach-ux500/Kconfig              |    2 +
 arch/arm/mach-ux500/Makefile             |    1 -
 arch/arm/mach-ux500/cpu-db5500.c         |    1 -
 arch/arm/mach-ux500/cpu-db8500.c         |    1 -
 arch/arm/mach-ux500/cpu.c                |   38 +++-
 arch/arm/mach-ux500/localtimer.c         |   30 ---
 arch/arm/mach-vexpress/Kconfig           |    2 +
 arch/arm/mach-vexpress/ct-ca9x4.c        |   30 +++-
 arch/arm/plat-s5p/s5p-time.c             |    1 -
 arch/arm/plat-versatile/Makefile         |    1 -
 arch/arm/plat-versatile/localtimer.c     |   28 ---
 drivers/clocksource/Kconfig              |    6 +
 drivers/clocksource/Makefile             |    3 +
 drivers/clocksource/arm_smp_twd.c        |  265 +++++++++++++++++++++++
 drivers/clocksource/exynos4_mct.c        |  283 ++++++++++++++++++++++++
 drivers/clocksource/msm_timer.c          |  345 ++++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig                 |    2 +-
 drivers/watchdog/mpcore_wdt.c            |    7 +-
 52 files changed, 1239 insertions(+), 1029 deletions(-)
 delete mode 100644 arch/arm/include/asm/localtimer.h
 delete mode 100644 arch/arm/include/asm/smp_twd.h
 delete mode 100644 arch/arm/kernel/smp_twd.c
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 delete mode 100644 arch/arm/plat-versatile/localtimer.c
 create mode 100644 drivers/clocksource/arm_smp_twd.c
 create mode 100644 drivers/clocksource/exynos4_mct.c
 create mode 100644 drivers/clocksource/msm_timer.c
