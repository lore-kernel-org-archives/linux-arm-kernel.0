From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 9 Jul 2015 16:31:22 +0800
Subject: [PATCH v3 0/3] arm: kernel: implement cpuidle_ops with psci backend
Message-ID: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend.
For arm64, it works. But for arm, we miss cpuidle_ops, these patches try to
address this issue.

Has been tested on Marvell Berlin SoCs. These patches are rebased on the Mark
Rutland's latest psci unification work and Lorenzo Pieralisi's psci related
work[1].

[PATCH 1/3] move psci's cpu_suspend handling to generic code as suggested
	    by Lorenzo.
[PATCH 2/3] try to refine the cpuidle_ops member's parameters.
[PATCH 3/3] implement cpuidle_ops with psci finally.

Since V2:
 - rebased on Lorenzo Pieralisi's new PSCI patch series
 - refine cpuidle_ops member functions' parameters
 - mark psci_power_state_is_valid and psci_power_state_loses_context as static
   as suggested by Lorenzo

Since v1:
 - add a new file psci_cpuidle.c to implment cpuidle_ops

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355098.html


Jisheng Zhang (3):
  firmware: psci: move cpu_suspend handling to generic code
  ARM: cpuidle: refine cpuidle_ops member's parameters.
  arm: kernel: implement cpuidle_ops with psci backend

 arch/arm/include/asm/cpuidle.h |  6 +--
 arch/arm/kernel/Makefile       |  1 +
 arch/arm/kernel/cpuidle.c      |  8 ++--
 arch/arm/kernel/psci_cpuidle.c | 19 ++++++++
 arch/arm64/kernel/psci.c       | 95 ----------------------------------------
 drivers/firmware/psci.c        | 99 +++++++++++++++++++++++++++++++++++++++++-
 drivers/soc/qcom/spm.c         | 17 +++++---
 include/linux/psci.h           |  4 +-
 8 files changed, 138 insertions(+), 111 deletions(-)
 create mode 100644 arch/arm/kernel/psci_cpuidle.c

-- 
2.1.4
