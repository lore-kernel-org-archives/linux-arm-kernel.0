From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2012 13:08:39 +0000
Subject: [PATCH 00/15] Runtime registration for local timers
Message-ID: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches series switches the various local timers implementation
(TWD, MCT, MSM timer) to be registered at runtime instead of being
hardwired at compile time. In the process, TWD gets an OF binding that
is used by highbank and imx6q.

Tested on EB11MP, OMAP4, Tegra and Exynos4. Based on next-20120110.

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

 Documentation/devicetree/bindings/arm/twd.txt |   29 ++++++
 arch/arm/include/asm/localtimer.h             |   37 ++-------
 arch/arm/include/asm/smp_twd.h                |   10 ++-
 arch/arm/kernel/smp.c                         |   29 ++++++-
 arch/arm/kernel/smp_twd.c                     |  114 ++++++++++++++++++++-----
 arch/arm/mach-exynos/mct.c                    |   18 ++--
 arch/arm/mach-highbank/Makefile               |    1 -
 arch/arm/mach-highbank/highbank.c             |   12 +++
 arch/arm/mach-highbank/localtimer.c           |   40 ---------
 arch/arm/mach-imx/Makefile                    |    1 -
 arch/arm/mach-imx/localtimer.c                |   35 --------
 arch/arm/mach-imx/mach-imx6q.c                |   11 +++
 arch/arm/mach-msm/timer.c                     |   79 ++++++++++--------
 arch/arm/mach-omap2/Makefile                  |    1 -
 arch/arm/mach-omap2/timer-mpu.c               |   39 ---------
 arch/arm/mach-omap2/timer.c                   |   33 ++++++-
 arch/arm/mach-realview/realview_eb.c          |   34 +++++++-
 arch/arm/mach-realview/realview_pb11mp.c      |   32 ++++++-
 arch/arm/mach-realview/realview_pbx.c         |   31 ++++++-
 arch/arm/mach-shmobile/Makefile               |    1 -
 arch/arm/mach-shmobile/include/mach/common.h  |    2 +
 arch/arm/mach-shmobile/localtimer.c           |   26 ------
 arch/arm/mach-shmobile/platsmp.c              |    1 -
 arch/arm/mach-shmobile/smp-sh73a0.c           |   32 ++++++-
 arch/arm/mach-shmobile/timer.c                |   10 ++
 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/localtimer.c              |   26 ------
 arch/arm/mach-tegra/timer.c                   |   34 ++++++-
 arch/arm/mach-ux500/Makefile                  |    1 -
 arch/arm/mach-ux500/cpu.c                     |    1 -
 arch/arm/mach-ux500/localtimer.c              |   29 ------
 arch/arm/mach-ux500/timer.c                   |   39 +++++++--
 arch/arm/mach-vexpress/ct-ca9x4.c             |   30 ++++++-
 arch/arm/plat-versatile/Makefile              |    1 -
 arch/arm/plat-versatile/localtimer.c          |   27 ------
 35 files changed, 480 insertions(+), 368 deletions(-)
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
