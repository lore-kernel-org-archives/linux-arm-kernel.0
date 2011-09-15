From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Sep 2011 17:52:28 +0100
Subject: [RFC PATCH 0/3] genirq: handling GIC per-cpu interrupts
Message-ID: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
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

The proposed solution is to handle the PPIs using the same path as
SPIs. A new core API is added to deal with per-cpu interrupts in a
less awkward way. The local timer code is updated to reflect these
changes.

The core API changes are based on an initial patch by Thomas Gleixner.

Tested on ARM Versatile Express (Cortex A5 and A15), ARM RealView
PB11MP, OMAP4 (Panda) and Tegra (Harmony). Patch series against
next-20110831.

Marc Zyngier (3):
  genirq: add support for per-cpu dev_id interrupts
  ARM: gic: consolidate PPI handling
  ARM: gic, local timers: use the request_percpu_irq() interface

 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   38 +++-
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   19 +--
 arch/arm/include/asm/hardware/gic.h               |    1 -
 arch/arm/include/asm/localtimer.h                 |   19 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +---
 arch/arm/kernel/smp_twd.c                         |   47 +++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |    6 +-
 arch/arm/mach-exynos4/mct.c                       |    5 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 -
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-------
 arch/arm/mach-msm/timer.c                         |   69 ++++---
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 include/linux/interrupt.h                         |   40 +++-
 include/linux/irq.h                               |   25 +++-
 include/linux/irqdesc.h                           |    3 +
 kernel/irq/Kconfig                                |    4 +
 kernel/irq/chip.c                                 |   58 ++++++
 kernel/irq/internals.h                            |    2 +
 kernel/irq/manage.c                               |  209 ++++++++++++++++++++-
 kernel/irq/settings.h                             |    7 +
 28 files changed, 461 insertions(+), 249 deletions(-)
