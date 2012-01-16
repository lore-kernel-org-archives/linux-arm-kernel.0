From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 13:52:25 +0000
Subject: [PATCH v3 00/15] Runtime registration for local timers
Message-ID: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches series switches the various local timers implementation
(TWD, MCT, MSM timer) to be registered at runtime instead of being
hardwired at compile time. In the process, TWD gets an OF binding that
is used by highbank and imx6q.

Tested on EB11MP, OMAP4, Tegra and Exynos4. Based on Linus' tree as of
some random point today.

Branch also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git local_timers-v3.3-rc0

* From v2:
- Fix __initdata anotations that should have been __cpuinitdata
  (reported by David Brown and Russell King)
- Fix interrupt trigger in DTS file for highbank and imx6q
  (as requested by Rob Herring and Shawn Guo)
- Move warning to twd_local_timer_of_register()
  (as requested by Rob Herring)
- Fix shmobile compilation fix (reported by Magnus Damm)
- Fold local_timer_{setup,stop}() into percpu_timer_{setup,stop}()

* From initial version:

- Moved away from late_time_init, making the code even simpler
- Added a DEFINE_TWD_LOCAL_TIMER() macro to reduce the init cluter
- Updated TWD DT support to have separate nodes for timer and watchdog
- Added support for the new r8a7779 shmobile that suddenly appeared
- Fixed a tiny dts bug on imx6q

Marc Zyngier (15):
  ARM: smp_twd: make local_timer_stop a symbol instead of a #define
  ARM: local timers: introduce a new registration interface
  ARM: smp_twd: add runtime registration support
  ARM: smp_twd: add device tree support
  ARM: OMAP4: convert to twd_local_timer_register() interface
  ARM: plat-versatile: convert to twd_local_timer_register() interface
  ARM: tegra: convert to twd_local_timer_register() interface
  ARM: shmobile: convert to twd_local_timer_register() interface
  ARM: ux500: convert to twd_local_timer_register() interface
  ARM: highbank: convert to twd_local_timer_register() interface
  ARM: imx6q: convert to twd_local_timer_register() interface
  ARM: smp_twd: remove old local timer interface
  ARM: local timers: convert exynos to runtime registration interface
  ARM: local timers: convert MSM to runtime registration interface
  ARM: local timers: make the runtime registration interface mandatory

 Documentation/devicetree/bindings/arm/twd.txt |   48 ++++++++++
 arch/arm/boot/dts/highbank.dts                |    8 +-
 arch/arm/boot/dts/imx6q.dtsi                  |    6 +-
 arch/arm/include/asm/localtimer.h             |   37 ++------
 arch/arm/include/asm/smp_twd.h                |   25 ++++-
 arch/arm/kernel/smp.c                         |   22 ++++-
 arch/arm/kernel/smp_twd.c                     |  123 ++++++++++++++++++++-----
 arch/arm/mach-exynos/mct.c                    |   18 ++--
 arch/arm/mach-highbank/Makefile               |    1 -
 arch/arm/mach-highbank/highbank.c             |    3 +
 arch/arm/mach-highbank/localtimer.c           |   40 --------
 arch/arm/mach-imx/Makefile                    |    1 -
 arch/arm/mach-imx/localtimer.c                |   35 -------
 arch/arm/mach-imx/mach-imx6q.c                |    2 +
 arch/arm/mach-msm/timer.c                     |   79 +++++++++-------
 arch/arm/mach-omap2/Makefile                  |    1 -
 arch/arm/mach-omap2/timer-mpu.c               |   39 --------
 arch/arm/mach-omap2/timer.c                   |   22 ++++-
 arch/arm/mach-realview/realview_eb.c          |   27 ++++-
 arch/arm/mach-realview/realview_pb11mp.c      |   21 ++++-
 arch/arm/mach-realview/realview_pbx.c         |   20 +++-
 arch/arm/mach-shmobile/Makefile               |    1 -
 arch/arm/mach-shmobile/include/mach/common.h  |    2 +
 arch/arm/mach-shmobile/localtimer.c           |   26 -----
 arch/arm/mach-shmobile/platsmp.c              |    1 -
 arch/arm/mach-shmobile/smp-r8a7779.c          |    8 +-
 arch/arm/mach-shmobile/smp-sh73a0.c           |    8 +-
 arch/arm/mach-shmobile/timer.c                |   10 ++
 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/localtimer.c              |   26 -----
 arch/arm/mach-tegra/timer.c                   |   22 ++++-
 arch/arm/mach-ux500/Makefile                  |    1 -
 arch/arm/mach-ux500/cpu.c                     |    1 -
 arch/arm/mach-ux500/localtimer.c              |   29 ------
 arch/arm/mach-ux500/timer.c                   |   32 +++++--
 arch/arm/mach-vexpress/ct-ca9x4.c             |   17 +++-
 arch/arm/plat-versatile/Makefile              |    1 -
 arch/arm/plat-versatile/localtimer.c          |   27 ------
 38 files changed, 407 insertions(+), 385 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
 delete mode 100644 arch/arm/mach-highbank/localtimer.c
 delete mode 100644 arch/arm/mach-imx/localtimer.c
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 delete mode 100644 arch/arm/plat-versatile/localtimer.c

-- 
1.7.7.1
