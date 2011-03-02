From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:06 +0000
Subject: [RFC PATCH 00/20] A15 architected timer support
Message-ID: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the architected (or generic) timers
that appear in the Cortex A15. The specification is part of the
ARMv7-AR LPA Virtualization Extensions, available from (free
registration required):

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0406b_virtualization_extns/index.html

They provide physical and virtual timers/counters (the later being
under control of the hypervisor). The code provides a clock source
(using the physical counter) and a sched_clock implementation (using
the virtual counter, so the local scheduling is not affected by having
multiple VMs scheduled in and out of the CPU by the hypervisor).

Modifications are relatively invasive:

- The timer interrupt is on IRQ 29 or 30, depending on whether the
  kernel is running in secure or normal mode. As it is not possible to
  distinguish between the two modes in a reliable way, we have to
  check if we're running on an A15 or not (the feature register may be
  virtualized, and thus potentially expensive to access).
- Local timer is also used in an UP configuration, so the local timer
  code is isolated from SMP support.
- A registration interface is introduced to allow a platform to pick
  its preferred implementation (architected timers, twd, msm local
  timers...). This causes some code churn in the platform specific
  code as the registration mechanism takes place at runtime instead of
  having a link time selection (local_timer_setup).
- Broadcast timers become the fallback in case no local timers are
  available.
- Allow the kernel to have multiple sched_clock() implementations
  compiled in, and extend the existing API to register one at
  runtime.

On the (emulated) Versatile Express platform, the A15 is running
without the SP804 that is usually used across the whole Versatile
range. The same binary kernel also runs on the Cortex A5 tile using
TWD and SP804 (both patch sets to be posted shortly).

Patches #1, 9, 10 and 11 carry the core modifications. All the others
are platform support changes and various cleanups. This patch set
depends on Will Deacon's multi-tile patch. Tested on next-20110302.

Any comments are welcome.

Marc Zyngier (20):
  ARM: architected timers: move local timer support to percpu_timer.c
  ARM: omap2: remove stubbed twd_timer_setup call
  ARM: exynos4: remove stubbed twd_timer_setup call
  ARM: shmobile: remove stubbed twd_timer_setup call
  ARM: tegra: remove stubbed twd_timer_setup call
  ARM: ux500: remove stubbed twd_timer_setup call
  ARM: versatile: remove stubbed twd_timer_setup call
  ARM: remove unused twd_timer_setup stub
  ARM: architected timers: add A15 architected timers
  ARM: Platform dependent sched_clock() override
  ARM: architected timers: Add A15 specific sched_clock implementation
  ARM: versatile/vexpress: rework timer support
  ARM: msm: dynamically register local timer setup function
  ARM: omap4: dynamically register local timer setup function
  ARM: exynos4: dynamically register local timer setup function
  ARM: shmobile: dynamically register local timer setup function
  ARM: tegra: dynamically register local timer setup function
  ARM: ux500: dynamically register local timer setup function
  ARM: simplify percpu_timer_setup
  ARM: simplify percpu_timer_ack

 arch/arm/Kconfig                                  |   20 ++-
 arch/arm/include/asm/arch_timer.h                 |   13 +
 arch/arm/include/asm/entry-macro-multi.S          |    2 +-
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   18 ++
 arch/arm/include/asm/localtimer.h                 |   61 +++--
 arch/arm/include/asm/sched_clock.h                |   41 +++-
 arch/arm/include/asm/smp.h                        |    7 +-
 arch/arm/include/asm/smp_twd.h                    |   14 +-
 arch/arm/kernel/Makefile                          |    2 +
 arch/arm/kernel/arch_timer.c                      |  253 +++++++++++++++++++++
 arch/arm/kernel/irq.c                             |    1 +
 arch/arm/kernel/percpu_timer.c                    |  141 ++++++++++++
 arch/arm/kernel/sched_clock.c                     |   23 ++-
 arch/arm/kernel/smp.c                             |   92 +-------
 arch/arm/kernel/smp_twd.c                         |   21 ++-
 arch/arm/mach-exynos4/Makefile                    |    1 -
 arch/arm/mach-exynos4/localtimer.c                |   26 --
 arch/arm/mach-exynos4/time.c                      |   10 +
 arch/arm/mach-msm/timer.c                         |   22 ++-
 arch/arm/mach-omap2/Makefile                      |    1 -
 arch/arm/mach-omap2/timer-gp.c                    |   12 +-
 arch/arm/mach-omap2/timer-mpu.c                   |   39 ----
 arch/arm/mach-realview/realview_eb.c              |    4 +-
 arch/arm/mach-realview/realview_pb11mp.c          |    4 +-
 arch/arm/mach-realview/realview_pbx.c             |    5 +-
 arch/arm/mach-shmobile/Makefile                   |    1 -
 arch/arm/mach-shmobile/localtimer.c               |   26 --
 arch/arm/mach-shmobile/timer.c                    |   12 +
 arch/arm/mach-tegra/Makefile                      |    2 +-
 arch/arm/mach-tegra/localtimer.c                  |   26 --
 arch/arm/mach-tegra/timer.c                       |   10 +
 arch/arm/mach-ux500/Makefile                      |    1 -
 arch/arm/mach-ux500/cpu.c                         |   12 +
 arch/arm/mach-ux500/localtimer.c                  |   29 ---
 arch/arm/mach-vexpress/v2m.c                      |   29 +++-
 arch/arm/plat-versatile/include/plat/localtimer.h |    9 +
 arch/arm/plat-versatile/localtimer.c              |   11 +-
 arch/arm/plat-versatile/sched-clock.c             |    7 +-
 38 files changed, 711 insertions(+), 297 deletions(-)
 create mode 100644 arch/arm/include/asm/arch_timer.h
 create mode 100644 arch/arm/kernel/arch_timer.c
 create mode 100644 arch/arm/kernel/percpu_timer.c
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 create mode 100644 arch/arm/plat-versatile/include/plat/localtimer.h
