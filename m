From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:38:11 +0100
Subject: [PATCHv2 00/12] arm/arm64: Unify PSCI client support
Message-ID: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
the FW invocation and probing out to a common locaiton in drivers/firmware.
As part of this, the remaining edge cases for PSCI 0.2 (Trusted OSs rejecting
CPU_OFF) are accounted for, maknig both 32-bit adn 64-bit clients more robust.

This results in a reasonable saving in terms of lines of code, and will allow
for PSCI 1.0 support to be unified form the beginning, avoiding further
duplication.

The series is based on v4.1-rc3.

Since v1 [1]:
* Fix build when PSCI isn't selected
* Don't indirect migrate_info_up_cpu
* Fix ver to u32 in psci_get_version

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/341770.html

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

 MAINTAINERS                                  |   9 +
 arch/arm/Kconfig                             |   1 +
 arch/arm/include/asm/psci.h                  |  23 --
 arch/arm/kernel/Makefile                     |   2 +-
 arch/arm/kernel/psci_smp.c                   |  29 +-
 arch/arm/kernel/setup.c                      |   3 +-
 arch/arm/kvm/psci.c                          |   2 +
 arch/arm/mach-highbank/highbank.c            |   2 +-
 arch/arm/mach-highbank/pm.c                  |   8 +-
 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/acpi.h                |  14 -
 arch/arm64/include/asm/psci.h                |  20 --
 arch/arm64/include/asm/smp_plat.h            |  16 ++
 arch/arm64/kernel/acpi.c                     |  11 +
 arch/arm64/kernel/psci.c                     | 398 +++------------------------
 arch/arm64/kernel/setup.c                    |   2 +-
 arch/arm64/kernel/smp.c                      |  10 +-
 drivers/cpuidle/cpuidle-calxeda.c            |   7 +-
 drivers/firmware/Kconfig                     |   3 +
 drivers/firmware/Makefile                    |   1 +
 {arch/arm/kernel => drivers/firmware}/psci.c | 245 +++++++++++------
 include/linux/psci.h                         |  51 ++++
 22 files changed, 328 insertions(+), 530 deletions(-)
 delete mode 100644 arch/arm64/include/asm/psci.h
 rename {arch/arm/kernel => drivers/firmware}/psci.c (50%)
 create mode 100644 include/linux/psci.h

-- 
1.9.1
