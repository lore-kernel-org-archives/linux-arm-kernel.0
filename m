From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  2 Jul 2015 18:12:32 +0100
Subject: [PATCHv4 0/5] arm/arm64: Unify PSCI client support	
Message-ID: <1435857157-24952-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
the FW invocation and probing out to a common location in drivers/firmware. The
bulk of the PSCI 0.2 cleanups have hit mainline now, so this is just the
unification portion.

This results in a reasonable saving in terms of lines of code, and will allow
for PSCI 1.0 support to be unified form the beginning, avoiding further
duplication.

Since v3 [1]:
* Drop the PSCI 0.2 patches as they're in mainline
* s/__pa/virt_to_idmap/ from Grygorii Strashko
* Use macros for Calxeda CPU_SUSPEND parameters

Russell, are you happy with the penultimate patch? If so, how would you prefer
that this be merged?

Rob, are you happy with the Highbank PM and Calxeda cpuidle changes?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346492.html

Grygorii Strashko (1):
  ARM: psci: boot_secondary: replace __pa with virt_to_idmap

Mark Rutland (4):
  arm64: psci: factor invocation code to drivers
  drivers: psci: support native SMC{32,64} calls
  ARM: migrate to common PSCI client code
  MAINTAINERS: add PSCI entry

 MAINTAINERS                       |   9 +
 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/psci.h       |  23 ---
 arch/arm/kernel/Makefile          |   2 +-
 arch/arm/kernel/psci.c            | 299 -----------------------------
 arch/arm/kernel/psci_smp.c        |  31 ++-
 arch/arm/kernel/setup.c           |   3 +-
 arch/arm/mach-highbank/highbank.c |   2 +-
 arch/arm/mach-highbank/pm.c       |  16 +-
 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/acpi.h     |   4 +-
 arch/arm64/include/asm/psci.h     |  28 ---
 arch/arm64/kernel/psci.c          | 361 +----------------------------------
 arch/arm64/kernel/setup.c         |   2 +-
 drivers/cpuidle/cpuidle-calxeda.c |  15 +-
 drivers/firmware/Kconfig          |   3 +
 drivers/firmware/Makefile         |   1 +
 drivers/firmware/psci.c           | 383 ++++++++++++++++++++++++++++++++++++++
 include/linux/psci.h              |  52 ++++++
 19 files changed, 501 insertions(+), 735 deletions(-)
 delete mode 100644 arch/arm/kernel/psci.c
 delete mode 100644 arch/arm64/include/asm/psci.h
 create mode 100644 drivers/firmware/psci.c
 create mode 100644 include/linux/psci.h

-- 
1.9.1
