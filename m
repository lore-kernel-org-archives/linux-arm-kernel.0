From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2011 20:08:09 +0100
Subject: [RFC PATCH 00/12] Consolidating GIC per-cpu interrupts
Message-ID: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current GIC per-cpu interrupt (aka PPIs) suffers from a number of
problems:

- It uses a completely separate scheme to handle the interrupts,
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

This patch set is based on 2.6.39-rc4, and depends on Will Deacon's
GIC fasteoi patches. Tested on VExpress, PB-11MP, Pandaboard and
SMDK-S5PV310.

Marc Zyngier (12):
  ARM: gic: add per-cpu interrupt multiplexer
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
 arch/arm/common/gic.c                             |  144 ++++++++++++++++++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   31 ++---
 arch/arm/include/asm/hardware/gic.h               |   12 ++-
 arch/arm/include/asm/localtimer.h                 |    7 +-
 arch/arm/kernel/irq.c                             |    8 +-
 arch/arm/kernel/smp.c                             |    9 +-
 arch/arm/kernel/smp_twd.c                         |   15 ++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   70 +---------
 arch/arm/mach-exynos4/localtimer.c                |    3 +-
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
 arch/arm/mach-msm/timer.c                         |   38 +++---
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-omap2/timer-mpu.c                   |    3 +-
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 arch/arm/mach-shmobile/localtimer.c               |    3 +-
 arch/arm/mach-tegra/localtimer.c                  |    3 +-
 arch/arm/mach-ux500/localtimer.c                  |    3 +-
 arch/arm/plat-versatile/localtimer.c              |    3 +-
 22 files changed, 223 insertions(+), 235 deletions(-)
