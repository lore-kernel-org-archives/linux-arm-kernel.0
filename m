From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 May 2011 17:49:55 +0100
Subject: [RFC PATCH v3 00/13] Consolidating GIC per-cpu interrupts
Message-ID: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
problems:

- They use a completely separate scheme to handle the interrupts,
  mostly because the PPI concept doesn't really match the kernel view
  of an interrupt.
- Some low-level code gets duplicated, as usual...
- At least one platform (msm) has started implementing its own
  alternative scheme.

The proposed solution is to let the GIC code expose the PPIs as
something that the kernel can manage. Instead of having a single
interrupt number shared on all cores, make the interrupt number be
different on each CPU.

This enables the use of the normal kernel API (request_irq() and
friends) and the elimination of some low level code.

This patch set is based on 2.6.39+ as of May 24th. Tested on PB-11MP,
Pandaboard and SMDK-V310.


>From bogus@does.not.exist.com  Wed May 25 10:48:51 2011
From: bogus@does.not.exist.com ()
Date: Wed, 25 May 2011 14:48:51 -0000
Subject: No subject
Message-ID: <mailman.0.1306342205.12414.linux-arm-kernel@lists.infradead.org>

- More MSM fixes
- Dropped MSM interrupt handler removal, as this requires more discussion,
  and will be addressed in a separate series.
- Moved introduction of percpu_timer_handler to a separate patch


>From bogus@does.not.exist.com  Wed May 25 10:48:51 2011
From: bogus@does.not.exist.com ()
Date: Wed, 25 May 2011 14:48:51 -0000
Subject: No subject
Message-ID: <mailman.1.1306342205.12414.linux-arm-kernel@lists.infradead.org>

- Fix crash while hotpluging a CPU
- Use handle_percpu_irq() instead of handle_fasteoi_irq()
- MSM fixes courtesy of Stephen Boyd
- MSM switched to percpu_timer_handler()
- Remove local timer interrupt accounting
- Restructure patches #1 and #2

Marc Zyngier (13):
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
 arch/arm/kernel/smp_twd.c                         |   17 ++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   70 +----------
 arch/arm/mach-exynos4/localtimer.c                |    3 +-
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-----------
 arch/arm/mach-msm/timer.c                         |   51 ++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-omap2/timer-mpu.c                   |    3 +-
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 arch/arm/mach-shmobile/localtimer.c               |    3 +-
 arch/arm/mach-tegra/localtimer.c                  |    3 +-
 arch/arm/mach-ux500/localtimer.c                  |    3 +-
 arch/arm/plat-versatile/localtimer.c              |    3 +-
 25 files changed, 233 insertions(+), 279 deletions(-)
