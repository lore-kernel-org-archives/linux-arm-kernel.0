From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 18 Dec 2012 10:30:56 +0800
Subject: [PATCH V3 0/5] ARM: tegra20: cpuidle: add power-down state
Message-ID: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a "powered-down" state in cpuidle for Tegra20. It requires power
gating both CPU cores. When the CPU1 requests to enter "powered-down"
state, it saves its own state and then enters WFI. When the CPU0 requests
the same state, it attempts to put the CPU1 into reset to prevent it from
waking up. Then power down both CPUs together and turn off the CPU rail.

If the CPU1 be woken up before CPU0 entering powered-down state, then it
needs to restore it's CPU state and waits for next chance.

V3:
* sqash the last 2 patches in previors version to support coupled cpuidle
  directly

V2:
* add a new patch for checking if there is any pending SGI
* if there is a SGI pending for the CPU, then we will abort the
  "powered-down" idle for the both CPUs that already in coupled state

Verified on Seaboard(Tegra20) and Cardhu(Tegra30).

Joseph Lo (5):
  ARM: tegra: add pending SGI checking API
  ARM: tegra20: cpuidle: add powered-down state for secondary CPU
  ARM: tegra20: clocks: add CPU low-power function into
    tegra_cpu_car_ops
  ARM: tegra20: flowctrl: add support for cpu_suspend_enter/exit
  ARM: tegra20: cpuidle: apply coupled cpuidle for powered-down mode

 arch/arm/mach-tegra/Kconfig           |    1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c |  201 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/flowctrl.c        |   38 ++++++-
 arch/arm/mach-tegra/flowctrl.h        |    4 +
 arch/arm/mach-tegra/irq.c             |   15 +++
 arch/arm/mach-tegra/irq.h             |   22 ++++
 arch/arm/mach-tegra/pm.c              |    2 +
 arch/arm/mach-tegra/sleep-tegra20.S   |  200 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S           |   19 +++
 arch/arm/mach-tegra/sleep.h           |   26 +++++
 arch/arm/mach-tegra/tegra20_clocks.c  |   99 ++++++++++++++++
 11 files changed, 617 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-tegra/irq.h
