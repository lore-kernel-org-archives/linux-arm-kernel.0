From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 30 May 2013 19:19:39 +0800
Subject: [PATCH 0/3] ARM: tegra114: cpuidle: add power down state
Message-ID: <1369912782-30663-1-git-send-email-josephl@nvidia.com>
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

Joseph Lo (3):
  ARM: tegra114: Reprogram GIC CPU interface to bypass IRQ on CPU PM
    entry
  ARM: tegra114: add low level support for CPU idle powered-down mode
  ARM: tegra114: cpuidle: add powered-down state

 arch/arm/mach-tegra/cpuidle-tegra114.c | 62 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/flowctrl.h         |  2 ++
 arch/arm/mach-tegra/irq.c              | 40 ++++++++++++++++++++++
 arch/arm/mach-tegra/sleep-tegra30.S    |  2 ++
 4 files changed, 105 insertions(+), 1 deletion(-)

-- 
1.8.3
