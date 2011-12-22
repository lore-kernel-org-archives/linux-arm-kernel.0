From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:30 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
Message-ID: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LOCAL_TIMERS infrastructure has a few limitations:
- It only allows one implementation to be compiled in, hence
  preventing a single kernel image to be booted on hardware with
  different requirements (Tegra and MSM, for example).
- It is only supported on SMP, which is a problem on platforms where
  the local timer can be used on UP platforms (Cortex A15 being one).

The proposal is to convert local timer drivers to be "standalone" (not
relying on the local timer infrastructure) and to use a CPU notifier
to have the timer brought up or down on non-boot CPUs.

The SMP support code can then be simplified to only manage the
boadcast timer, which is always installed, and leave the generic
kernel code to pick the highest priority timer. CONFIG_LOCAL_TIMERS
disappears in the process.

Tested on EB11MP, OMAP4 and Tegra. Based on next-20111222.

>From v1:
- Various bug fixes
- DT support for smp_twd
- Added support for highbank and imx6q

Marc Zyngier (15):
  ARM: local timers: allow smp_twd to be used standalone
  ARM: smp_twd: add device tree support
  ARM: local timers: switch realview to standalone smp_twd
  ARM: local timers: switch vexpress to standalone smp_twd
  ARM: local timers: remove localtimer.c from plat-versatile
  ARM: local timers: switch tegra to standalone smp_twd
  ARM: local timers: switch omap4 to standalone smp_twd
  ARM: local timers: switch shmobile to standalone smp_twd
  ARM: local timers: switch ux500 to standalone smp_twd
  ARM: local timers: switch highbank to standalone smp_twd
  ARM: local timers: switch imx6q to standalone smp_twd
  ARM: smp_twd: remove support for non-standalone version
  ARM: local timers: make MCT timer standalone
  ARM: local timers: make MSM timers standalone
  ARM: local timers: Remove CONFIG_LOCAL_TIMERS support

 Documentation/devicetree/bindings/arm/twd.txt |   29 +++++
 arch/arm/Kconfig                              |   15 +--
 arch/arm/include/asm/localtimer.h             |   57 ---------
 arch/arm/include/asm/smp_twd.h                |   19 +++-
 arch/arm/kernel/smp.c                         |   54 ++-------
 arch/arm/kernel/smp_twd.c                     |  155 +++++++++++++++++++------
 arch/arm/mach-exynos/mct.c                    |   85 ++++++++++----
 arch/arm/mach-highbank/Makefile               |    1 -
 arch/arm/mach-highbank/highbank.c             |   13 ++
 arch/arm/mach-highbank/localtimer.c           |   40 -------
 arch/arm/mach-imx/Makefile                    |    1 -
 arch/arm/mach-imx/localtimer.c                |   35 ------
 arch/arm/mach-imx/mach-imx6q.c                |   12 ++
 arch/arm/mach-msm/timer.c                     |   92 +++++++++++----
 arch/arm/mach-omap2/Kconfig                   |    2 +-
 arch/arm/mach-omap2/Makefile                  |    1 -
 arch/arm/mach-omap2/timer-mpu.c               |   39 ------
 arch/arm/mach-omap2/timer.c                   |   38 +++++-
 arch/arm/mach-realview/Kconfig                |    3 +
 arch/arm/mach-realview/realview_eb.c          |   33 +++++-
 arch/arm/mach-realview/realview_pb11mp.c      |   31 +++++-
 arch/arm/mach-realview/realview_pbx.c         |   30 +++++-
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/Makefile               |    1 -
 arch/arm/mach-shmobile/include/mach/common.h  |    3 +
 arch/arm/mach-shmobile/localtimer.c           |   26 ----
 arch/arm/mach-shmobile/smp-sh73a0.c           |   32 +++++-
 arch/arm/mach-shmobile/timer.c                |   10 ++
 arch/arm/mach-tegra/Kconfig                   |    1 +
 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/localtimer.c              |   26 ----
 arch/arm/mach-tegra/timer.c                   |   34 +++++-
 arch/arm/mach-ux500/Kconfig                   |    1 +
 arch/arm/mach-ux500/Makefile                  |    1 -
 arch/arm/mach-ux500/localtimer.c              |   29 -----
 arch/arm/mach-ux500/timer.c                   |   41 ++++++-
 arch/arm/mach-vexpress/Kconfig                |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c             |   29 ++++-
 arch/arm/plat-versatile/Makefile              |    1 -
 arch/arm/plat-versatile/localtimer.c          |   27 -----
 40 files changed, 591 insertions(+), 460 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
 delete mode 100644 arch/arm/include/asm/localtimer.h
 delete mode 100644 arch/arm/mach-highbank/localtimer.c
 delete mode 100644 arch/arm/mach-imx/localtimer.c
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 delete mode 100644 arch/arm/plat-versatile/localtimer.c

-- 
1.7.7.1
