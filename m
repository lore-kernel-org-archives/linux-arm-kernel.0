From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 29 Oct 2012 18:28:14 +0800
Subject: [PATCH V3 0/7] ARM: tegra30: cpuidle: add a powered-down state
Message-ID: <1351506501-600-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a "powered-down" state for cpuidle. It's a power gating idle
mode. It supports the secondary CPUs (i.e., CPU1-CPU3) to go into
powered-down state independently. When any of the secondary CPUs go into
this state, it can be power gated alone. There is a limitation on CPU0.
The CPU0 can go into powered-down state only when all secondary CPU is
offline. After CPU0 is in powered-down state, the CPU rail can be turned
off.

All CPUs entering powered-down state is not working. The CPU0 enters this
state only when secondary CPU is offline. This can be coverd by CPUquiet
and cluster switching mechanism.

We also remove the ambiguous name of LP2 in the cpuidle state.

Verified on Seaboard(Tegra20) and Cardhu(Tegra30).

This patch set should depend on these patches:
ARM: tegra: rename the file of "sleep-tXX" to "sleep-tegraXX"
ARM: tegra30: clocks: add AHB and APB clocks
ARM: tegra: dt: add L2 cache controller
ARM: tegra: common: using OF api for L2 cache init

Major changes:
V3:
* fix a potential issue that will cause CPU be corrupted
* rename the LP2 state to powered-down state
V2:
* refine L1 cache maintenance function

Previous work can be found at:
V2:
http://www.mail-archive.com/linux-tegra at vger.kernel.org/msg06478.html
V1:
http://www.mail-archive.com/linux-tegra at vger.kernel.org/msg06319.html

Joseph Lo (7):
  ARM: tegra: cpuidle: separate cpuidle driver for different chips
  ARM: tegra: cpuidle: add CPU resume function
  ARM: tegra30: cpuidle: add powered-down state for secondary CPUs
  ARM: tegra30: common: enable csite clock
  ARM: tegra30: clocks: add CPU low-power function into
    tegra_cpu_car_ops
  ARM: tegra30: flowctrl: add cpu_suspend_exter/exit function
  ARM: tegra30: cpuidle: add powered-down state for CPU0

 arch/arm/mach-tegra/Makefile                       |    7 +
 arch/arm/mach-tegra/common.c                       |    1 +
 .../mach-tegra/{cpuidle.c => cpuidle-tegra20.c}    |    7 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c              |  188 +++++++++++++++++
 arch/arm/mach-tegra/cpuidle.c                      |   47 ++---
 arch/arm/mach-tegra/cpuidle.h                      |   32 +++
 arch/arm/mach-tegra/flowctrl.c                     |   47 +++++
 arch/arm/mach-tegra/flowctrl.h                     |    8 +
 arch/arm/mach-tegra/headsmp.S                      |   58 +++++
 arch/arm/mach-tegra/pm.c                           |  219 ++++++++++++++++++++
 arch/arm/mach-tegra/pm.h                           |   33 +++
 arch/arm/mach-tegra/reset.c                        |    6 +
 arch/arm/mach-tegra/reset.h                        |    9 +
 arch/arm/mach-tegra/sleep-tegra30.S                |   66 ++++++
 arch/arm/mach-tegra/sleep.S                        |   71 +++++++
 arch/arm/mach-tegra/sleep.h                        |    5 +
 arch/arm/mach-tegra/tegra30_clocks.c               |  107 ++++++++++
 arch/arm/mach-tegra/tegra_cpu_car.h                |   37 ++++
 18 files changed, 909 insertions(+), 39 deletions(-)
 copy arch/arm/mach-tegra/{cpuidle.c => cpuidle-tegra20.c} (91%)
 create mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 create mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 arch/arm/mach-tegra/pm.c
 create mode 100644 arch/arm/mach-tegra/pm.h
