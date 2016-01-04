From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon,  4 Jan 2016 13:54:35 +0100
Subject: [PATCH v8 0/4] ARM SMC Calling Convention interface
Message-ID: <1451912079-29258-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is hopefully the final version of this patch set. Russel, please let
me know if you are OK with this and I'll upload them into your patch
system.

This patch set is based on the Generic TEE subsystem v6 patchset
(https://lwn.net/Articles/662495/) sent out a some time ago. By isolating
the ARM SMC Calling Convention patches that are useful for other purposes
than to support the Generic TEE subsystem some complexity is removed from
that patch set.

This patch set adds a common interface to do an SMC or HVC following ARM
SMC Calling Convention. The interface is implemented for both the arm and
arm64 architectures and updates the PSCI driver to use this interface
instead for firmware communication.

v8:
* Moved HAVE_ARM_SMCCC from arch/Kconfig to drivers/firmware/Kconfig

v7:
* Use shift macros for all fields supplied to ARM_SMCCC_CALL_VAL()
* Move "select HAVE_ARM_SMCCC if CPU_V7" from "select HAVE_ARM_SMCCC if CPU_V7"
* arm: "config ARM_PSCI" now depends on HAVE_ARM_SMCCC instead of CPU_V7

v6:
* Move HAVE_ARM_SMCCC from init/Kconfig

v5:
* Fixes compile errors for Thumb-2 kernels reported by Kevin Hilman
* drivers: psci: replace psci firmware calls
  Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
  Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

v4:
* Rebased on v4.4-rc3 to resolve a PSCI conflict
* drivers: psci: replace psci firmware calls
  Reviewed-by: Mark Rutland <mark.rutland@arm.com>
  Tested-by: Mark Rutland <mark.rutland@arm.com>

v3:
* Moved the export of arm_smccc_{smc,hvc} to armksyms.c for both arm and arm64
* arm: add implementation for arm-smccc
  Reviewed-by: Lars Persson <lars.persson@axis.com>
* arm64: add implementation for arm-smccc
  drivers: psci: replace psci firmware calls
  Acked-by: Will Deacon <will.deacon@arm.com>

v2:
* Added unwinding support in the assembly functions

Thanks,
Jens

Jens Wiklander (4):
  arm/arm64: add arm-smccc
  arm: add implementation for arm-smccc
  arm64: add implementation for arm-smccc
  drivers: psci: replace psci firmware calls

 arch/arm/Kconfig                |   3 +-
 arch/arm/kernel/Makefile        |   3 +-
 arch/arm/kernel/armksyms.c      |   6 +++
 arch/arm/kernel/psci-call.S     |  31 ------------
 arch/arm/kernel/smccc-call.S    |  62 ++++++++++++++++++++++++
 arch/arm64/Kconfig              |   1 +
 arch/arm64/kernel/Makefile      |   4 +-
 arch/arm64/kernel/arm64ksyms.c  |   5 ++
 arch/arm64/kernel/asm-offsets.c |   3 ++
 arch/arm64/kernel/psci-call.S   |  28 -----------
 arch/arm64/kernel/smccc-call.S  |  43 +++++++++++++++++
 drivers/firmware/Kconfig        |   3 ++
 drivers/firmware/psci.c         |  23 ++++++++-
 include/linux/arm-smccc.h       | 104 ++++++++++++++++++++++++++++++++++++++++
 14 files changed, 254 insertions(+), 65 deletions(-)
 delete mode 100644 arch/arm/kernel/psci-call.S
 create mode 100644 arch/arm/kernel/smccc-call.S
 delete mode 100644 arch/arm64/kernel/psci-call.S
 create mode 100644 arch/arm64/kernel/smccc-call.S
 create mode 100644 include/linux/arm-smccc.h

-- 
1.9.1
