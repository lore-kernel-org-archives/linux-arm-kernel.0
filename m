From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Jul 2013 17:25:22 +0800
Subject: [PATCH V4 0/4] ARM: tegra114: cpuidle: add power down state
Message-ID: <1374225926-26832-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduce CPU core power down state for CPU idle. When CPU go
into this state, it saves it's context and needs a proper configuration
in flow controller to power gate the CPU when CPU runs into WFI
instruction. And the CPU also needs to set the IRQ as CPU power down idle
wake up event in flow controller.

To prevent race conditions and ensure proper interrupt routing on
Cortex-A15 CPUs when they are power-gated, add a CPU PM notifier
call-back to reprogram the GIC CPU interface on PM entry. The
GIC CPU interface will be reset back to its normal state by
the common GIC CPU PM exit callback when the CPU wakes up.

And the Tegra114 support CPU0 hotplug function in HW physically, but it
needs other software to make it work normally after we add CPU idle power
down mode support. But we don't support that yet, removing them for now.

V4:
* remove the CPU0 hot plug support due to miss of SW support
* postpone to use CPUIDLE_FLAG_TIMER_STOP flag, because it still has some
  issues
V3:
* use CPUIDLE_FLAG_TIMER_STOP flag
V2:
* clean up the CPUidle driver to make it more generic

Joseph Lo (4):
  Revert "ARM: tegra: add cpu_disable for hotplug"
  ARM: tegra114: Reprogram GIC CPU interface to bypass IRQ on CPU PM
    entry
  ARM: tegra114: add low level support for CPU idle powered-down mode
  ARM: tegra114: cpuidle: add powered-down state

 arch/arm/mach-tegra/common.h           |  1 -
 arch/arm/mach-tegra/cpuidle-tegra114.c | 51 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/flowctrl.h         |  2 ++
 arch/arm/mach-tegra/hotplug.c          | 11 --------
 arch/arm/mach-tegra/irq.c              | 40 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/platsmp.c          |  1 -
 arch/arm/mach-tegra/sleep-tegra30.S    |  2 ++
 7 files changed, 94 insertions(+), 14 deletions(-)

-- 
1.8.3.2
