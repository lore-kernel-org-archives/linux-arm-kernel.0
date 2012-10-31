From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Oct 2012 09:58:32 -0500
Subject: [PATCH v2 0/5] Move GIC and VIC to drivers/irqchip
Message-ID: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

I think I had this action from San Francisco Linaro Connect. Well, better
late than never... Now we need to move GIC for use by arm64.

This series builds on Thomas Petazzoni's series adding a common irqchip
init function[1] and moves the ARM GIC and VIC irqchip code to
drivers/irqchip. More work for arm64 is still needed to fix asm header
dependencies.

v2 (add patches 1 and 2):
- Move GIC register definitions to gic.c and remove dependency on
  asm/hardware/gic.h
- Remove direct platform dependency on gic_raise_softirq. This isn't
  strictly needed before moving to drivers/irqchip, but is needed
  for arm64.

Rob

[1] http://www.spinics.net/lists/arm-kernel/msg203687.html

Rob Herring (5):
  ARM: gic: move register definitions into .c file
  ARM: gic: remove direct use of gic_raise_softirq
  irqchip: Move ARM GIC to drivers/irqchip
  irqchip: Move ARM VIC to drivers/irqchip
  ARM: highbank: use common irqchip_init

 arch/arm/common/Kconfig                            |   23 -------
 arch/arm/common/Makefile                           |    2 -
 arch/arm/include/asm/hardware/gic.h                |   19 ------
 arch/arm/include/asm/smp.h                         |    1 +
 arch/arm/kernel/smp.c                              |    5 ++
 arch/arm/mach-exynos/platsmp.c                     |    4 +-
 arch/arm/mach-highbank/highbank.c                  |    8 +--
 arch/arm/mach-highbank/platsmp.c                   |    4 +-
 arch/arm/mach-imx/platsmp.c                        |    2 -
 arch/arm/mach-msm/platsmp.c                        |    4 +-
 arch/arm/mach-omap2/omap-smp.c                     |    4 +-
 arch/arm/mach-realview/platsmp.c                   |    2 -
 arch/arm/mach-shmobile/platsmp.c                   |    2 -
 arch/arm/mach-shmobile/smp-emev2.c                 |    2 +-
 arch/arm/mach-spear13xx/platsmp.c                  |    2 -
 arch/arm/mach-tegra/platsmp.c                      |    2 -
 arch/arm/mach-ux500/platsmp.c                      |    2 -
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    2 -
 arch/arm/mach-vexpress/platsmp.c                   |    2 -
 arch/arm/plat-versatile/platsmp.c                  |    2 +-
 drivers/irqchip/Kconfig                            |   23 +++++++
 drivers/irqchip/Makefile                           |    2 +
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |   66 +++++++++++++-------
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |    0
 drivers/irqchip/irqchip.c                          |   24 +++++++
 drivers/irqchip/irqchip.h                          |    2 +
 26 files changed, 109 insertions(+), 102 deletions(-)
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (96%)
 rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (100%)

-- 
1.7.10.4
