From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 14:52:18 +0100
Subject: [PATCHv3 00/12] arm/arm64: Unify PSCI client support
Message-ID: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
the FW invocation and probing out to a common location in drivers/firmware.
As part of this, the remaining edge cases for PSCI 0.2 (Trusted OSs rejecting
CPU_OFF) are accounted for, making both 32-bit adn 64-bit clients more robust.

This results in a reasonable saving in terms of lines of code, and will allow
for PSCI 1.0 support to be unified form the beginning, avoiding further
duplication.

The series is based on the arm64 for-next/cpu-init branch [3] due to conflicts
with that series.

Since v1 [1]:
* Fix build when PSCI isn't selected
* Don't indirect migrate_info_up_cpu
* Fix ver to u32 in psci_get_version

Since v2: [2]:
* Rebase atop of Lorenzo's cpu init cleanup series [3]
* Use the correct native function IDs
* Fix cpu_disable return values
* Report invalid MIGRATE_INFO_UP_CPU return values

Many thanks to those who have reviewed and tested so far! Unfortunately, due to
the volume of changes in the rebase I've dropped all Tested-by tags. I've
locally tested 32-bit and 64-bit kernels with DT.

Russell, are you happy with the penultimate patch? If so, would you be happy for
that to go via arm-soc (which I guess should take the series)?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/341770.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/344309.html
[3] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/cpu-init

Mark Rutland (12):
  arm/arm64: kvm: add missing PSCI include
  arm64: smp_plat: add get_logical_index
  arm64: smp: consistently use error codes
  arm64: psci: remove unnecessary id indirection
  arm64: psci: support unsigned return values
  arm64: psci: account for Trusted OS instances
  arm64: psci: kill psci_power_state
  arm64: psci: remove ACPI coupling
  arm64: psci: factor invocation code to drivers
  drivers: psci: support native SMC{32,64} calls
  ARM: migrate to common PSCI client code
  MAINTAINERS: add PSCI entry

 MAINTAINERS                                    |   9 +
 arch/arm/Kconfig                               |   1 +
 arch/arm/include/asm/psci.h                    |  23 --
 arch/arm/kernel/Makefile                       |   2 +-
 arch/arm/kernel/psci.c                         | 299 -------------------
 arch/arm/kernel/psci_smp.c                     |  29 +-
 arch/arm/kernel/setup.c                        |   3 +-
 arch/arm/kvm/psci.c                            |   2 +
 arch/arm/mach-highbank/highbank.c              |   2 +-
 arch/arm/mach-highbank/pm.c                    |   8 +-
 arch/arm64/Kconfig                             |   1 +
 arch/arm64/include/asm/acpi.h                  |  17 +-
 arch/arm64/include/asm/psci.h                  |  20 --
 arch/arm64/include/asm/smp_plat.h              |  16 +
 arch/arm64/kernel/acpi.c                       |  11 +
 arch/arm64/kernel/psci.c                       | 398 ++-----------------------
 arch/arm64/kernel/setup.c                      |   2 +-
 arch/arm64/kernel/smp.c                        |  10 +-
 drivers/cpuidle/cpuidle-calxeda.c              |   7 +-
 drivers/firmware/Kconfig                       |   3 +
 drivers/firmware/Makefile                      |   1 +
 drivers/firmware/psci.c                        | 383 ++++++++++++++++++++++++
 {arch/arm/include/asm => include/linux}/psci.h |  40 +--
 23 files changed, 523 insertions(+), 764 deletions(-)
 delete mode 100644 arch/arm/kernel/psci.c
 delete mode 100644 arch/arm64/include/asm/psci.h
 create mode 100644 drivers/firmware/psci.c
 copy {arch/arm/include/asm => include/linux}/psci.h (55%)

-- 
1.9.1
