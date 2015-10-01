From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  1 Oct 2015 09:58:51 +0100
Subject: [PATCH 0/2] Enabling PSCI based idle on ARM 32-bit platforms
Message-ID: <1443689933-28882-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Patch 1 refactors ARM 32-bit generic idle implementation to make it
compliant with ARM64 CPUidle operations, and patches the existing
CPUidle implementation based on the generic CPUidle driver.

Patch 2 moves ARM64 PSCI CPUidle functions implementation to
drivers/firmware so that it can be shared with ARM 32-bit platforms
code. This patch also adds a PSCI entry section on ARM 32-bit systems
so that the PSCI CPUidle back-end can be enabled when the enable-method
corresponds to PSCI.

Patches apply on top of current patch stack to enable PSCI 1.0:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351470.html

Tested on Juno board (ARM64), compile tested only on ARM 32-bit systems.

Lorenzo Pieralisi (2):
  ARM: cpuidle: make cpuidle_ops interfaces ARM64 compliant
  ARM64: kernel: PSCI: move PSCI idle management code to
    drivers/firmware

 arch/arm/include/asm/cpuidle.h |   4 +-
 arch/arm/kernel/cpuidle.c      |   4 +-
 arch/arm64/kernel/psci.c       |  99 +--------------------------------
 drivers/firmware/Makefile      |   2 +-
 drivers/firmware/psci_cpuops.c | 121 +++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/spm.c         |   9 ++-
 include/linux/psci.h           |   3 +
 7 files changed, 138 insertions(+), 104 deletions(-)
 create mode 100644 drivers/firmware/psci_cpuops.c

-- 
2.5.1
