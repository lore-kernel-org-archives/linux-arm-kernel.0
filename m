From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 23 Apr 2011 20:54:39 -0000
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource based
	sched_clock
Message-ID: <20110423205036.795894921@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of ARM sched_clocks is using the timekeeping clocksource as the
sched_clock. Only versatile uses a different clock for it, but there
is no real reason why it can't use the clocksource as well.

The core timekeeping code makes already sure that we don't wrap the
timekeeper and we can base a sched_clock easily on that.

It uses the read function of the clocksource and keeps track of time
independent of the timekeeping code as the ARM sched_clock
implementation does. It also uses it's own sequence counter so
sched_clock is not dependent on xtime_lock. The update sequence is
just adding offsets once in a while and runs from do_timer() which
also makes sure that only one core tries to update it.

Only lightly tested on orion. Please give it a go.

Another 650 lines gone :)

Thanks,

	tglx
---
 arch/arm/include/asm/sched_clock.h                     |  120 ----------------
 arch/arm/kernel/sched_clock.c                          |   74 ----------
 arch/arm/plat-versatile/include/plat/sched_clock.h     |    6 
 arch/arm/plat-versatile/sched-clock.c                  |   58 -------
 linux-2.6-tip/arch/arm/Kconfig                         |   15 --
 linux-2.6-tip/arch/arm/common/timer-sp.c               |    4 
 linux-2.6-tip/arch/arm/kernel/Makefile                 |    1 
 linux-2.6-tip/arch/arm/kernel/time.c                   |    4 
 linux-2.6-tip/arch/arm/mach-davinci/time.c             |   30 ----
 linux-2.6-tip/arch/arm/mach-integrator/integrator_cp.c |    5 
 linux-2.6-tip/arch/arm/mach-ixp4xx/common.c            |   22 --
 linux-2.6-tip/arch/arm/mach-mmp/time.c                 |   19 --
 linux-2.6-tip/arch/arm/mach-omap1/time.c               |   62 --------
 linux-2.6-tip/arch/arm/mach-omap2/timer-gp.c           |   17 --
 linux-2.6-tip/arch/arm/mach-pxa/time.c                 |   31 ----
 linux-2.6-tip/arch/arm/mach-realview/core.c            |    3 
 linux-2.6-tip/arch/arm/mach-sa1100/time.c              |   35 ----
 linux-2.6-tip/arch/arm/mach-tegra/timer.c              |   29 ---
 linux-2.6-tip/arch/arm/mach-u300/timer.c               |   29 ---
 linux-2.6-tip/arch/arm/mach-versatile/core.c           |    3 
 linux-2.6-tip/arch/arm/mach-vexpress/v2m.c             |    3 
 linux-2.6-tip/arch/arm/plat-iop/time.c                 |   22 --
 linux-2.6-tip/arch/arm/plat-mxc/time.c                 |   28 ---
 linux-2.6-tip/arch/arm/plat-nomadik/Kconfig            |    1 
 linux-2.6-tip/arch/arm/plat-nomadik/timer.c            |   45 ------
 linux-2.6-tip/arch/arm/plat-omap/counter_32k.c         |   71 ---------
 linux-2.6-tip/arch/arm/plat-omap/dmtimer.c             |    4 
 linux-2.6-tip/arch/arm/plat-omap/include/plat/common.h |    1 
 linux-2.6-tip/arch/arm/plat-orion/time.c               |   37 -----
 linux-2.6-tip/arch/arm/plat-s5p/s5p-time.c             |   67 ---------
 linux-2.6-tip/arch/arm/plat-versatile/Kconfig          |    4 
 linux-2.6-tip/arch/arm/plat-versatile/Makefile         |    1 
 linux-2.6-tip/include/linux/clocksource.h              |    1 
 linux-2.6-tip/include/linux/sched.h                    |    1 
 linux-2.6-tip/kernel/sched_clock.c                     |   12 -
 linux-2.6-tip/kernel/time/Kconfig                      |    4 
 linux-2.6-tip/kernel/time/timekeeping.c                |  125 +++++++++++++++++
 37 files changed, 173 insertions(+), 821 deletions(-)
