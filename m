From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  2 Dec 2015 10:47:02 +0100
Subject: [PATCH v4 0/4] ARM SMC Calling Convention interface
Message-ID: <1449049626-13991-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set is based on the Generic TEE subsystem v6 patchset
(https://lwn.net/Articles/662495/) sent out a few weeks ago. By isolating
the ARM SMC Calling Convention patches that are useful for other purposes
than to support the Generic TEE subsystem some complexity is removed from
that patch set.

This patch set adds a common interface to do an SMC or HVC following ARM
SMC Calling Convention. The interface is implemented for both the arm and
arm64 architectures and updates the PSCI driver to use this interface
instead for firmware communication.

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

 arch/arm/Kconfig                |  1 +
 arch/arm/kernel/Makefile        |  3 +-
 arch/arm/kernel/armksyms.c      |  6 +++
 arch/arm/kernel/psci-call.S     | 31 -------------
 arch/arm/kernel/smccc-call.S    | 50 +++++++++++++++++++++
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/Makefile      |  4 +-
 arch/arm64/kernel/arm64ksyms.c  |  5 +++
 arch/arm64/kernel/asm-offsets.c |  3 ++
 arch/arm64/kernel/psci-call.S   | 28 ------------
 arch/arm64/kernel/smccc-call.S  | 43 ++++++++++++++++++
 drivers/firmware/psci.c         | 23 +++++++++-
 include/linux/arm-smccc.h       | 98 +++++++++++++++++++++++++++++++++++++++++
 init/Kconfig                    |  3 ++
 14 files changed, 235 insertions(+), 64 deletions(-)
 delete mode 100644 arch/arm/kernel/psci-call.S
 create mode 100644 arch/arm/kernel/smccc-call.S
 delete mode 100644 arch/arm64/kernel/psci-call.S
 create mode 100644 arch/arm64/kernel/smccc-call.S
 create mode 100644 include/linux/arm-smccc.h

-- 
1.9.1
