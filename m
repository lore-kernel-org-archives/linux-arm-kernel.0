From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 18:01:05 -0800
Subject: [PATCH v2 00/28] Updates for Tegra support in 2.6.39
Message-ID: <1295834493-5019-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for suspend, idle, and cpufreq
for the Tegra subsystem.

Patch 2 adds functions to save and restore the GIC state
during suspend and resume, and patch 3 exports the GIC irq 
chip functions to support custom IRQ chips that need to
update the GIC as well as another block during IRQ 
operations.  Patches 2 and 3 depend on patch 1, which fixes
a naming conflict in mach-tegra, so the whole stack will
need to go in through one tree.

 arch/arm/common/gic.c                          |  138 ++++-
 arch/arm/configs/tegra_defconfig               |  123 ++++
 arch/arm/include/asm/hardware/cache-l2x0.h     |    3 +-
 arch/arm/include/asm/hardware/gic.h            |   13 +
 arch/arm/mach-tegra/Makefile                   |   12 +-
 arch/arm/mach-tegra/board.h                    |    6 +
 arch/arm/mach-tegra/common.c                   |   49 ++-
 arch/arm/mach-tegra/cortex-a9.S                |  504 +++++++++++++++
 arch/arm/mach-tegra/cpu-tegra.c                |   75 ++-
 arch/arm/mach-tegra/cpuidle.c                  |  714 ++++++++++++++++++++++
 arch/arm/mach-tegra/dma.c                      |  198 ++++---
 arch/arm/mach-tegra/gpio.c                     |   15 +-
 arch/arm/mach-tegra/headsmp-t2.S               |  216 +++++++
 arch/arm/mach-tegra/headsmp.S                  |   61 --
 arch/arm/mach-tegra/hotplug.c                  |  126 ----
 arch/arm/mach-tegra/include/mach/clk.h         |    2 +
 arch/arm/mach-tegra/include/mach/clkdev.h      |    2 +
 arch/arm/mach-tegra/include/mach/debug-macro.S |   25 +-
 arch/arm/mach-tegra/include/mach/iomap.h       |   69 ++-
 arch/arm/mach-tegra/include/mach/irqs.h        |   14 +-
 arch/arm/mach-tegra/include/mach/legacy_irq.h  |    7 +-
 arch/arm/mach-tegra/include/mach/pinmux-t2.h   |   10 +
 arch/arm/mach-tegra/include/mach/powergate.h   |   40 ++
 arch/arm/mach-tegra/include/mach/suspend.h     |   80 +++
 arch/arm/mach-tegra/include/mach/system.h      |   10 +-
 arch/arm/mach-tegra/include/mach/uncompress.h  |   18 +-
 arch/arm/mach-tegra/irq.c                      |  334 ++++++++---
 arch/arm/mach-tegra/legacy_irq.c               |  109 ++++-
 arch/arm/mach-tegra/pinmux-t2-tables.c         |   26 +-
 arch/arm/mach-tegra/platsmp.c                  |   89 +++-
 arch/arm/mach-tegra/power-macros.S             |   57 ++
 arch/arm/mach-tegra/power.h                    |   64 ++
 arch/arm/mach-tegra/powergate.c                |  212 +++++++
 arch/arm/mach-tegra/suspend-t2.c               |  414 +++++++++++++
 arch/arm/mach-tegra/suspend.c                  |  776 ++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra2_clocks.c            |  264 ++++++++-
 arch/arm/mach-tegra/tegra2_save.S              |  413 +++++++++++++
 arch/arm/mach-tegra/timer.c                    |   96 +++-
 arch/arm/mm/cache-l2x0.c                       |   14 +-
 39 files changed, 4898 insertions(+), 500 deletions(-)
