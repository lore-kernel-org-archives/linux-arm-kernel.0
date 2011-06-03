From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:15:44 +0100
Subject: [PATCH v6 00/14] Consolidating GIC per-cpu interrupts
Message-ID: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
problems:

- They use a completely separate scheme to handle the interrupts,
  mostly because the PPI concept doesn't really match the kernel view
  of an interrupt.
- PPIs can only be used by the timer code, unless we add more low-level
  assembly code.
- The local timer code can only be used by devices generating PPIs,
  and not SPIs.
- At least one platform (msm) has started implementing its own
  alternative scheme.
- Some low-level code gets duplicated, as usual...

The proposed solution is to let the GIC code expose the PPIs as
something that the kernel can manage. Instead of having a single
interrupt number shared on all cores, make the interrupt number be
different on each CPU.

This enables the use of the normal kernel API (request_irq() and
friends) and the elimination of some low level code. On the other
side, it causes quite a bit of churn in the timer code.

This patch set is based on 3.0-rc1. Tested on PB-11MP, Pandaboard
and SMDK-V310.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.0.1307110543.24103.linux-arm-kernel@lists.infradead.org>

- Update Exynos4 MCT to use the local timer infrastructure, now that
  it doesn't depend on PPIs anymore. Untested, as the board I have
  doesn't implement MCT (EVT0 syndrome).


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.1.1307110543.24103.linux-arm-kernel@lists.infradead.org>

- Fix arch/arm/common/Kconfig indentation
- Fix MSM warning when building UP.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.2.1307110543.24103.linux-arm-kernel@lists.infradead.org>

- Fix yet another CPU_HOTPLUG problem: instead of calling free_irq()
  on timer halt, just disable the interrupt. On timer restart, detect
  that the interrupt has been requested already and just enable the
  interrupt back. This avoid doing a request_irq() with preemption
  disabled, which triggers an ugly warning. Reported by Stephen Boyd.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.3.1307110543.24103.linux-arm-kernel@lists.infradead.org>

- More MSM fixes
- Dropped MSM interrupt handler removal, as this requires more discussion,
  and will be addressed in a separate series.
- Moved introduction of percpu_timer_handler to a separate patch


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.4.1307110543.24103.linux-arm-kernel@lists.infradead.org>

- Fix crash while hotpluging a CPU
- Use handle_percpu_irq() instead of handle_fasteoi_irq()
- MSM fixes courtesy of Stephen Boyd
- MSM switched to percpu_timer_handler()
- Remove local timer interrupt accounting
- Restructure patches #1 and #2

Marc Zyngier (14):
  ARM: gic: add per-cpu interrupt multiplexer
  ARM: smp: add interrupt handler for local timers
  ARM: smp_twd: add support for remapped PPI interrupts
  ARM: omap4: use remapped PPI interrupts for local timer
  ARM: versatile: use remapped PPI interrupts for local timer
  ARM: shmobile: use remapped PPI interrupts for local timer
  ARM: ux500: use remapped PPI interrupts for local timer
  ARM: tegra: use remapped PPI interrupts for local timer
  ARM: msm: use remapped PPI interrupts for local timer
  ARM: exynos4: use remapped PPI interrupts for local timer
  ARM: gic: remove previous local timer interrupt handling
  ARM: gic: add compute_irqnr macro for exynos4
  ARM: SMP: automatically select ARM_GIC_VPPI
  ARM: exynos4: switch MCT to the full local timer infrastructure

 arch/arm/Kconfig                                  |    1 +
 arch/arm/common/Kconfig                           |    5 +
 arch/arm/common/gic.c                             |  143 +++++++++++++++++=
++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   31 ++---
 arch/arm/include/asm/hardware/gic.h               |   12 ++-
 arch/arm/include/asm/localtimer.h                 |    7 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/kernel/irq.c                             |   11 +-
 arch/arm/kernel/smp.c                             |   27 +---
 arch/arm/kernel/smp_twd.c                         |   25 +++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   70 +----------
 arch/arm/mach-exynos4/localtimer.c                |    3 +-
 arch/arm/mach-exynos4/mct.c                       |   68 ++++------
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-----------
 arch/arm/mach-msm/timer.c                         |   59 +++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-omap2/timer-mpu.c                   |    3 +-
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 arch/arm/mach-shmobile/localtimer.c               |    3 +-
 arch/arm/mach-tegra/localtimer.c                  |    3 +-
 arch/arm/mach-ux500/localtimer.c                  |    3 +-
 arch/arm/plat-versatile/localtimer.c              |    3 +-
 26 files changed, 275 insertions(+), 321 deletions(-)
