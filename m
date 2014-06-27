From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Jun 2014 11:49:23 +0800
Subject: [PATCH v4 00/13] Enable ACPI on ARM64 in Kconfig
Message-ID: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is the first part of ARM64 ACPI core patches to
running ACPI on ARM64, it just handle some compile errors when
ACPI is introduced to ARM64 platform and enable ACPI on ARM64
in Kconfig.

Following core patch sets for ACPI based SMP/GIC/Arch Timer
initialization to enable ACPI on ARM64 are under interally
review and will send out when ACPI 5.1 is released.

patch 1~3 are cleanups for ACPI core;
patch 4~13 are arch dependent code for ARM64 ACPI;

This patch set is based on linux-next branch of Rafael's linux-pm
tree, and PCI patches for ARM64 from Liviu:
Support for creating generic host_bridge from device tree
https://lkml.org/lkml/2014/3/14/279

Add support for PCI in AArch64
http://comments.gmane.org/gmane.linux.ports.arm.kernel/309392

Changes since v3:
- Introduce three new patches
	- acpi: arm64 does not have a BIOS add config for BIOS table scan
	- ACPI: Don't use acpi_lapic in ACPI core code
	- ARM64 / ACPI: if we chose to boot from acpi then disable FDT
- Rebase on the latest linux-next branch of Rafael's tree, and
  introduce asm/acenv.h for ARM64;
- Introduce ARCH_HAS_ACPI_PDC to move all the _PDC related code
  to a single place and make x86 and ia64 select ARCH_HAS_ACPI_PDC;
- Fix some checpatch warning;
- Fix broken Signed-off-by chain;
- Remove duplicate interface macros for ACPICA pointed out by Mark
  Rutland and Zheng Lv;
- Redefine ACPI_FLUSH_CPU_CACHE();
- Stub out some PCI functions suggested by Arnd and already merged into 3.16

Comments still need to be addressed:
	- Empty PCI implementation in arch/arm64 which suggested by Arnd;
	- suspend and sleep on ARM64 platform pointed out by Lorenzo;

Changes since v2:
- Make ACPI depend on PCI on ARM64
- rework all the patches and seperate some of the patches
  into fine-grained, and add some comments and changelog to
  make it easier for review.

Al Stone (3):
  ARM64 / ACPI: Introduce arm-core.c and its related head file
  ARM64 / ACPI: Introduce early_param for "acpi"
  ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
    ARM64

Graeme Gregory (6):
  acpi: arm64 does not have a BIOS add config for BIOS table scan.
  ACPI: Don't use acpi_lapic in ACPI core code
  ARM64 : Add dummy asm/cpu.h
  ARM64 / ACPI: Introduce lowlevel suspend function
  ARM64 / ACPI: if we chose to boot from acpi then disable FDT
  ARM64 / ACPI: Enable ARM64 in Kconfig

Hanjun Guo (4):
  ACPI / processor: Introduce ARCH_HAS_ACPI_PDC
  ARM64 / ACPI: Introduce arch_fix_phys_package_id() for cpu topology
  ARM64 / ACPI: Introduce PCI functions for ACPI on ARM64
  ACPI: Make EC debugfs depend on X86 || IA64 in Kconfig

 Documentation/kernel-parameters.txt |    3 +-
 arch/arm64/Kconfig                  |    3 +
 arch/arm64/include/asm/acenv.h      |   18 +++
 arch/arm64/include/asm/acpi.h       |   61 +++++++++++
 arch/arm64/include/asm/cpu.h        |   11 ++
 arch/arm64/include/asm/pci.h        |    6 +
 arch/arm64/include/asm/topology.h   |    2 +
 arch/arm64/kernel/pci.c             |   28 +++++
 arch/arm64/kernel/setup.c           |    7 +-
 arch/arm64/kernel/topology.c        |   14 +++
 arch/ia64/Kconfig                   |    2 +
 arch/ia64/include/asm/acpi.h        |    5 +
 arch/x86/Kconfig                    |    2 +
 arch/x86/include/asm/acpi.h         |    5 +
 drivers/acpi/Kconfig                |   19 +++-
 drivers/acpi/Makefile               |    3 +
 drivers/acpi/acpi_processor.c       |    2 +-
 drivers/acpi/internal.h             |    5 +
 drivers/acpi/osl.c                  |    4 +-
 drivers/acpi/plat/Makefile          |    1 +
 drivers/acpi/plat/arm-core.c        |  138 +++++++++++++++++++++++
 drivers/acpi/processor_core.c       |  198 ---------------------------------
 drivers/acpi/processor_pdc.c        |  206 +++++++++++++++++++++++++++++++++++
 23 files changed, 539 insertions(+), 204 deletions(-)
 create mode 100644 arch/arm64/include/asm/acenv.h
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/include/asm/cpu.h
 create mode 100644 drivers/acpi/plat/Makefile
 create mode 100644 drivers/acpi/plat/arm-core.c
 create mode 100644 drivers/acpi/processor_pdc.c

-- 
1.7.9.5
