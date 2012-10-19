From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Oct 2012 16:48:39 +0800
Subject: [PATCH V2 0/7] ARM: tegra30: cpuidle: add LP2 support
Message-ID: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU idle LP2 is a power gating idle mode for Tegra30. It supports the
secondary CPUs (i.e., CPU1-CPU3) to go into LP2 dynamically. When any of
the secondary CPUs go into LP2, it can be power gated alone. There is a
limitation on CPU0. The CPU0 can go into LP2 only when all secondary CPUs
are already in LP2. After CPU0 is in LP2, the CPU rail can be turned off.

Verified on Seaboard(Tegra20) and Cardhu(Tegra30).

This patch set should depend on these two patches:
d8be3dc ARM: tegra: rename the file of "sleep-tXX" to "sleep-tegraXX"
01b176e ARM: tegra30: clocks: add AHB and APB clocks

Previous work can be found at:
V1:
http://www.mail-archive.com/linux-tegra at vger.kernel.org/msg06319.html

Joseph Lo (7):
  ARM: tegra: cpuidle: separate cpuidle driver for different chips
  ARM: tegra: cpuidle: add LP2 resume function
  ARM: tegra30: cpuidle: add LP2 driver for secondary CPUs
  ARM: tegra30: common: enable csite clock
  ARM: tegra30: clocks: add CPU low-power function into
    tegra_cpu_car_ops
  ARM: tegra30: flowctrl: add cpu_suspend_exter/exit function
  ARM: tegra30: cpuidle: add LP2 driver for CPU0

 arch/arm/mach-tegra/Makefile                       |    7 +
 arch/arm/mach-tegra/common.c                       |    1 +
 .../mach-tegra/{cpuidle.c => cpuidle-tegra20.c}    |    7 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c              |  185 ++++++++++++++++
 arch/arm/mach-tegra/cpuidle.c                      |   47 ++---
 arch/arm/mach-tegra/cpuidle.h                      |   32 +++
 arch/arm/mach-tegra/flowctrl.c                     |   47 ++++
 arch/arm/mach-tegra/flowctrl.h                     |    8 +
 arch/arm/mach-tegra/headsmp.S                      |   58 +++++
 arch/arm/mach-tegra/pm.c                           |  220 ++++++++++++++++++++
 arch/arm/mach-tegra/pm.h                           |   33 +++
 arch/arm/mach-tegra/reset.c                        |    6 +
 arch/arm/mach-tegra/reset.h                        |    9 +
 arch/arm/mach-tegra/sleep-tegra30.S                |   67 ++++++
 arch/arm/mach-tegra/sleep.S                        |   71 +++++++
 arch/arm/mach-tegra/sleep.h                        |    5 +
 arch/arm/mach-tegra/tegra30_clocks.c               |  107 ++++++++++
 arch/arm/mach-tegra/tegra_cpu_car.h                |   37 ++++
 18 files changed, 908 insertions(+), 39 deletions(-)
 copy arch/arm/mach-tegra/{cpuidle.c => cpuidle-tegra20.c} (91%)
 create mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 create mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 arch/arm/mach-tegra/pm.c
 create mode 100644 arch/arm/mach-tegra/pm.h
