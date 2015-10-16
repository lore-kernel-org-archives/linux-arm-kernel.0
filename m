From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 16 Oct 2015 17:02:57 +0100
Subject: [PATCH v3 0/2] Enabling PSCI based idle on ARM 32-bit platforms
Message-ID: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is v3 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376418.html

v2->v3

- Removed additional PSCI file, merged functions in psci.c
- Added missing static scope to ARM psci_cpuidle_ops
- Applied review tags

v1->v2:

- Refactored patch 1 to remove cpu parameter from cpuidle_ops
  suspend hook
- Refactored psci_cpu_init_idle to stub out dt parsing function and
  make it usable on both ARM/ARM64 with no additional changes
- Updated ARM cpuidle_ops to new interfaces

PSCI firmware provides a kernel API that, through a standard interface,
allows to manage power states transitions in a seamless manner for
ARM and ARM64 systems.

Current PSCI code that initializes CPUidle states on PSCI based
systems lives in arch/arm64 directory but it is not ARM64 specific
and can be shared with ARM 32-bit systems so that the generic
ARM CPUidle driver can leverage the common PSCI interface.

This patch series moves PSCI CPUidle management code to
drivers/firmware directory so that ARM and ARM64 architecture
can actually share the code.

It is made up of two patches:

Patch 1 refactors ARM 32-bit generic idle implementation to remove
the cpu parameter from the cpuidle_ops suspend hook, in preparation
for a common PSCI implementation for ARM/ARM64 PSCI idle.

Patch 2 moves ARM64 PSCI CPUidle functions implementation to
drivers/firmware so that it can be shared with ARM 32-bit platforms
code. This patch also adds a PSCI entry section on ARM 32-bit systems
so that the PSCI CPUidle back-end can be enabled when the enable-method
corresponds to PSCI.

Patches apply on top of current patch stack to enable PSCI 1.0:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/firmware/psci-1.0

Tested on Juno board (ARM64), compile tested only on ARM 32-bit systems.

Lorenzo Pieralisi (2):
  ARM: cpuidle: remove cpu parameter from the cpuidle_ops suspend hook
  ARM64: kernel: PSCI: move PSCI idle management code to
    drivers/firmware

 arch/arm/include/asm/cpuidle.h |   2 +-
 arch/arm/kernel/cpuidle.c      |   2 +-
 arch/arm64/kernel/psci.c       |  99 +---------------------------------
 drivers/firmware/psci.c        | 119 +++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/spm.c         |  10 ++--
 include/linux/psci.h           |   3 ++
 6 files changed, 131 insertions(+), 104 deletions(-)

-- 
2.5.1
