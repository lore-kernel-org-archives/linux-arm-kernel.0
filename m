From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:08:47 -0800
Subject: [PATCH 00/21] Updates for Tegra support in 2.6.38
Message-ID: <1291590548-7341-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for suspend, idle, and cpufreq
for the Tegra subsystem.

Patches 2 and 3 make changes to the GIC driver that will
likely conflict with Russell's recent changes to GIC
initialization.  Patch 2 adds functions to save and
restore the GIC state during suspend and resume, patch 3
exports the GIC irq chip functions to support custom IRQ
chips that need to update the GIC as well as another
block during IRQ operations.

 arch/arm/common/gic.c                          |  146 ++++-
 arch/arm/include/asm/hardware/gic.h            |   12 +
 arch/arm/mach-tegra/Makefile                   |   12 +-
 arch/arm/mach-tegra/common.c                   |    6 +-
 arch/arm/mach-tegra/cortex-a9.S                |  710 +++++++++++++++++++
 arch/arm/mach-tegra/cpu-tegra.c                |   74 ++-
 arch/arm/mach-tegra/cpuidle.c                  |  711 +++++++++++++++++++
 arch/arm/mach-tegra/dma.c                      |  198 +++---
 arch/arm/mach-tegra/gpio.c                     |   15 +-
 arch/arm/mach-tegra/headsmp-t2.S               |  218 ++++++
 arch/arm/mach-tegra/headsmp.S                  |   61 --
 arch/arm/mach-tegra/hotplug.c                  |  140 ----
 arch/arm/mach-tegra/include/mach/debug-macro.S |   31 +-
 arch/arm/mach-tegra/include/mach/iomap.h       |   69 ++-
 arch/arm/mach-tegra/include/mach/irqs.h        |   14 +-
 arch/arm/mach-tegra/include/mach/legacy_irq.h  |    7 +-
 arch/arm/mach-tegra/include/mach/pinmux-t2.h   |   10 +
 arch/arm/mach-tegra/include/mach/powergate.h   |   40 ++
 arch/arm/mach-tegra/include/mach/suspend.h     |   80 +++
 arch/arm/mach-tegra/include/mach/system.h      |   18 +-
 arch/arm/mach-tegra/include/mach/uncompress.h  |   18 +-
 arch/arm/mach-tegra/irq.c                      |  326 +++++++---
 arch/arm/mach-tegra/legacy_irq.c               |  109 +++-
 arch/arm/mach-tegra/pinmux-t2-tables.c         |   26 +-
 arch/arm/mach-tegra/platsmp.c                  |  130 +++-
 arch/arm/mach-tegra/power-macros.S             |   57 ++
 arch/arm/mach-tegra/power.h                    |   64 ++
 arch/arm/mach-tegra/powergate.c                |  211 ++++++
 arch/arm/mach-tegra/suspend-t2.c               |  413 +++++++++++
 arch/arm/mach-tegra/suspend.c                  |  870 ++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra2_clocks.c            |  264 +++++++-
 arch/arm/mach-tegra/tegra2_save.S              |  413 +++++++++++
 arch/arm/mach-tegra/timer.c                    |  114 +++-
 33 files changed, 5075 insertions(+), 512 deletions(-)
