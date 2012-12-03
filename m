From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 3 Dec 2012 11:00:02 +0800
Subject: [PATCH 0/5] ARM: tegra20: cpuidle: add power-down state
Message-ID: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a "powered-down" state in cpuidle for Tegra20. It requires power
gating both CPU cores. When the CPU1 requests to enter "powered-down"
state, it saves its own state and then enters WFI. When the CPU0 requests
the same state, it attempts to put the CPU1 into reset to prevent it from
waking up. Then power down both CPUs together and turn off the CPU rail.

If the CPU1 be woken up before CPU0 entering powered-down state, then it
needs to restore it's CPU state and waits for next chance.

Please note.
We also fix the potensial deadlock issue for coupled cpuidle framework.
("cpuidle: coupled: fix the potensial race condition and deadlock")
Before the patch be applied, please don't merge the last patch that apply
coupled cpuidle for "powered-down" cpuidle driver.

Verified on Seaboard(Tegra20) and Cardhu(Tegra30).

Joseph Lo (5):
  ARM: tegra20: cpuidle: add powered-down state for secondary CPU
  ARM: tegra20: clocks: add CPU low-power function into
    tegra_cpu_car_ops
  ARM: tegra20: flowctrl: add support for cpu_suspend_enter/exit
  ARM: tegra20: cpuidle: add powered-down state for CPU0
  ARM: tegra20: cpuidle: apply coupled cpuidle for powered-down mode

 arch/arm/mach-tegra/Kconfig           |    1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c |  206 +++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/flowctrl.c        |   38 +++++-
 arch/arm/mach-tegra/flowctrl.h        |    4 +
 arch/arm/mach-tegra/pm.c              |    2 +
 arch/arm/mach-tegra/sleep-tegra20.S   |  198 +++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S           |   19 +++
 arch/arm/mach-tegra/sleep.h           |   26 ++++
 arch/arm/mach-tegra/tegra20_clocks.c  |  102 ++++++++++++++++
 9 files changed, 591 insertions(+), 5 deletions(-)
