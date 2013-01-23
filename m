From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Jan 2013 17:59:30 +0000
Subject: [PATCH 0/4] Preparatory GIC patches for arm64 support
Message-ID: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches are primarily aimed at reducing the irq-gic.c dependency
on arch/arm and allow it to be used with arch/arm64. The last patch
removes the explicit gic_secondary_init() call from the ARM platform
code.

We still have a non-generic asm/smp_plat.h include for cpu_logical_map()
but I couldn't find a better place to move it (asm/cpu.h isn't generic
either, though more widely used than smp_plat.h).

The patches are based on linux-next as they require Rob's GIC irqhip
move.

Catalin


Catalin Marinas (4):
  arm: Move the set_handle_irq and handle_arch_irq declarations to
    asm/irq.h
  arm: Move chained_irq_(enter|exit) to a generic file
  irqchip: gic: Call handle_bad_irq() directly
  irqchip: gic: Perform the gic_secondary_init() call via CPU notifier

 arch/arm/include/asm/irq.h              |  5 ++++
 arch/arm/include/asm/mach/irq.h         | 36 -----------------------
 arch/arm/mach-at91/gpio.c               |  3 +-
 arch/arm/mach-exynos/common.c           |  1 +
 arch/arm/mach-exynos/platsmp.c          |  8 -----
 arch/arm/mach-highbank/platsmp.c        |  7 -----
 arch/arm/mach-imx/platsmp.c             | 12 --------
 arch/arm/mach-msm/platsmp.c             |  8 -----
 arch/arm/mach-omap2/omap-smp.c          |  7 -----
 arch/arm/mach-shmobile/smp-emev2.c      |  7 -----
 arch/arm/mach-shmobile/smp-r8a7779.c    |  7 -----
 arch/arm/mach-shmobile/smp-sh73a0.c     |  7 -----
 arch/arm/mach-socfpga/platsmp.c         | 12 --------
 arch/arm/mach-spear13xx/platsmp.c       |  8 -----
 arch/arm/mach-tegra/platsmp.c           |  8 -----
 arch/arm/mach-ux500/platsmp.c           |  8 -----
 arch/arm/plat-samsung/irq-vic-timer.c   |  3 +-
 arch/arm/plat-samsung/s5p-irq-gpioint.c |  3 +-
 arch/arm/plat-versatile/platsmp.c       |  8 -----
 drivers/irqchip/irq-gic.c               | 32 ++++++++++++++------
 drivers/irqchip/irq-vic.c               |  2 +-
 include/linux/irqchip/arm-gic.h         |  1 -
 include/linux/irqchip/chained_irq.h     | 52 +++++++++++++++++++++++++++++++++
 23 files changed, 85 insertions(+), 160 deletions(-)
 create mode 100644 include/linux/irqchip/chained_irq.h
