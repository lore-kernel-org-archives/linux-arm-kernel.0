From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:15 +0100
Subject: [PATCH v1 00/18] Allow local timers to be registered at runtime
Message-ID: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current local timer implementation assumes that a kernel image
only contains a single local timer implementation by enforcing global
function names. This is one of the many problems to be solve for a
single kernel binary supporting multiple platforms.

This series (based on an earlier one for the A15 timers) implements a
registration interface for local timers, and converts existing ones to
this new interface. It also moves the local timer support out of
smp.c, as other local timer implementations may use local timers even
in UP configurations (A15 being such an exemple).

Patches based on v3.0-rc1 + my previously sent "Consolidating GIC
per-cpu interrupts" series (though the changes are largely
orthogonal). Tested on PB-11MP, Pandaboard, SMDK-V310 and Versatile
Express.

Marc Zyngier (18):
  ARM: Move local timer support out of smp.c
  ARM: local timers: Add runtime registration interface
  ARM: omap2: remove stubbed twd_timer_setup call
  ARM: exynos4: remove stubbed twd_timer_setup call
  ARM: shmobile: remove stubbed twd_timer_setup call
  ARM: tegra: remove stubbed twd_timer_setup call
  ARM: ux500: remove stubbed twd_timer_setup call
  ARM: versatile: remove stubbed twd_timer_setup call
  ARM: remove unused twd_timer_setup stub
  ARM: versatile/vexpress: dynamically register local timer setup
    function
  ARM: msm: dynamically register local timer setup function
  ARM: omap4: dynamically register local timer setup function
  ARM: exynos4: dynamically register local timer setup function
  ARM: shmobile: dynamically register local timer setup function
  ARM: tegra: dynamically register local timer setup function
  ARM: ux500: dynamically register local timer setup function
  ARM: simplify percpu_timer_setup
  ARM: simplify percpu_timer_ack

 arch/arm/Kconfig                                  |    6 +-
 arch/arm/include/asm/localtimer.h                 |   50 +++++---
 arch/arm/include/asm/smp.h                        |    4 +
 arch/arm/include/asm/smp_twd.h                    |   14 ++-
 arch/arm/kernel/Makefile                          |    1 +
 arch/arm/kernel/percpu_timer.c                    |  126 +++++++++++++++++++++
 arch/arm/kernel/smp.c                             |   74 +------------
 arch/arm/kernel/smp_twd.c                         |   21 +++-
 arch/arm/mach-exynos4/Makefile                    |    1 -
 arch/arm/mach-exynos4/localtimer.c                |   27 -----
 arch/arm/mach-exynos4/mct.c                       |   17 +++-
 arch/arm/mach-exynos4/time.c                      |   12 ++
 arch/arm/mach-msm/timer.c                         |   27 +++--
 arch/arm/mach-omap2/Makefile                      |    1 -
 arch/arm/mach-omap2/timer-gp.c                    |   14 ++-
 arch/arm/mach-omap2/timer-mpu.c                   |   40 -------
 arch/arm/mach-realview/realview_eb.c              |    4 +-
 arch/arm/mach-realview/realview_pb11mp.c          |    4 +-
 arch/arm/mach-realview/realview_pbx.c             |    5 +-
 arch/arm/mach-shmobile/Makefile                   |    1 -
 arch/arm/mach-shmobile/localtimer.c               |   27 -----
 arch/arm/mach-shmobile/timer.c                    |   16 +++-
 arch/arm/mach-tegra/Makefile                      |    2 +-
 arch/arm/mach-tegra/localtimer.c                  |   27 -----
 arch/arm/mach-tegra/timer.c                       |   12 ++
 arch/arm/mach-ux500/Makefile                      |    1 -
 arch/arm/mach-ux500/cpu.c                         |   14 +++
 arch/arm/mach-ux500/localtimer.c                  |   30 -----
 arch/arm/mach-vexpress/v2m.c                      |    4 +
 arch/arm/plat-versatile/include/plat/localtimer.h |    6 +
 arch/arm/plat-versatile/localtimer.c              |   11 ++-
 31 files changed, 325 insertions(+), 274 deletions(-)
 create mode 100644 arch/arm/kernel/percpu_timer.c
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 create mode 100644 arch/arm/plat-versatile/include/plat/localtimer.h
