From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jul 2011 17:57:24 +0100
Subject: [RFC PATCH v9 0/4] Consolidating GIC per-cpu interrupts
Message-ID: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>
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

As the previous solution which tried to map PPIs to normal interrupts
has been proved to be buggy, I've opted to a much simpler scheme
(based on Russell's input).

The proposed solution is to handle the interrupt using the same path
as SPIs, with a common handler for all PPIs. Each PPI can be requested
using gic_request_ppi(), similar to request_irq(). The local timer
code is updated to reflect these changes.

Patches against next-20110721, tested on PB11MP. As this patch series
is quite different from the previous one, I've dropped all previous
acks from platform maintainers.

Marc Zyngier (4):
  ARM: gic: consolidate PPI handling
  ARM: gic: Add PPI registration interface
  ARM: local timers: drop local_timer_ack()
  ARM: gic: add compute_irqnr macro for exynos4

 arch/arm/common/gic.c                             |  150 +++++++++++++++++++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   22 +---
 arch/arm/include/asm/hardware/gic.h               |    5 +-
 arch/arm/include/asm/localtimer.h                 |   14 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +-----
 arch/arm/kernel/smp_twd.c                         |   32 +++--
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   61 +--------
 arch/arm/mach-exynos4/mct.c                       |    6 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
 arch/arm/mach-msm/timer.c                         |   52 +++----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 19 files changed, 208 insertions(+), 291 deletions(-)
