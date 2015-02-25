From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 25 Feb 2015 16:39:40 +0800
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Message-ID: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v8:
  - remove MPIDR packing things by introducing phys_cpuid_t;

  - update patch acpi: fix acpi_os_ioremap for arm64 to follow
    Rafael's suggestion;

  - Squash patch (disable ACPI if ACPI less than 5.1) to patch
    (Get RSDP and ACPI boot-time table);

  - Move sleep_arm.c to arch/arm64/ and rename it as acpi_sleep.c 

  - Rework the uefi generated empty dtb to enable acpi when no dtb
    is available, thanks Ard for the updated patch.

  - rework the function of register cpu for kexec case

  - use pr_debug() instead of pr_info() when scanning MADT.

  - rebase on top of 4.0-rc1

Thanks
Hanjun

Al Stone (4):
  ARM64 / ACPI: Get RSDP and ACPI boot-time tables
  ARM64 / ACPI: Introduce early_param "acpi=" to enable/disable ACPI
  ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
    ARM64
  ARM64 / ACPI: additions of ACPI documentation for arm64

Graeme Gregory (6):
  ACPI: add arm64 to the platforms that use ioremap
  ACPI / sleep: Introduce arm64 specific acpi_sleep.c
  ARM64 / ACPI: If we chose to boot from acpi then disable FDT
  ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
  ARM64 / ACPI: Enable ARM64 in Kconfig
  Documentation: ACPI for ARM64

Hanjun Guo (8):
  ACPI / table: Use pr_debug() instead of pr_info() for MADT table
    scanning
  ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID
  ARM64 / ACPI: Introduce PCI stub functions for ACPI
  ACPI / table: Print GIC information when MADT is parsed
  ARM64 / ACPI: Parse MADT for SMP initialization
  ACPI / processor: Make it possible to get CPU hardware ID via GICC
  ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
  clocksource / arch_timer: Parse GTDT to initialize arch timer

Mark Salter (2):
  ARM64: allow late use of early_ioremap
  ACPI: fix acpi_os_ioremap for arm64

Tomasz Nowicki (1):
  irqchip: Add GICv2 specific ACPI boot support

 Documentation/arm64/acpi_object_usage.txt | 594 ++++++++++++++++++++++++++++++
 Documentation/arm64/arm-acpi.txt          | 506 +++++++++++++++++++++++++
 Documentation/arm64/why_use_acpi.txt      | 231 ++++++++++++
 Documentation/kernel-parameters.txt       |   3 +-
 arch/arm64/Kconfig                        |   3 +
 arch/arm64/include/asm/acenv.h            |  18 +
 arch/arm64/include/asm/acpi.h             |  96 +++++
 arch/arm64/include/asm/cpu_ops.h          |   1 +
 arch/arm64/include/asm/fixmap.h           |   3 +
 arch/arm64/include/asm/pci.h              |   6 +
 arch/arm64/include/asm/psci.h             |   3 +-
 arch/arm64/include/asm/smp.h              |   5 +-
 arch/arm64/kernel/Makefile                |   1 +
 arch/arm64/kernel/acpi.c                  | 386 +++++++++++++++++++
 arch/arm64/kernel/acpi_sleep.c            |  28 ++
 arch/arm64/kernel/cpu_ops.c               |   2 +-
 arch/arm64/kernel/pci.c                   |  25 ++
 arch/arm64/kernel/psci.c                  |  78 ++--
 arch/arm64/kernel/setup.c                 |  21 +-
 arch/arm64/kernel/smp.c                   |   2 +-
 arch/arm64/kernel/time.c                  |   7 +
 arch/ia64/include/asm/acpi.h              |   4 +
 arch/ia64/kernel/acpi.c                   |   2 +-
 arch/x86/include/asm/acpi.h               |   4 +
 arch/x86/kernel/acpi/boot.c               |   2 +-
 drivers/acpi/Kconfig                      |   3 +-
 drivers/acpi/Makefile                     |   2 +
 drivers/acpi/acpi_processor.c             |   7 +-
 drivers/acpi/bus.c                        |   3 +
 drivers/acpi/osl.c                        |   6 +-
 drivers/acpi/processor_core.c             |  60 ++-
 drivers/acpi/tables.c                     |  52 ++-
 drivers/clocksource/arm_arch_timer.c      | 132 +++++--
 drivers/irqchip/irq-gic.c                 | 102 +++++
 drivers/irqchip/irqchip.c                 |   3 +
 include/acpi/acpi_io.h                    |   4 +
 include/acpi/processor.h                  |   6 +-
 include/linux/acpi.h                      |  17 +-
 include/linux/clocksource.h               |   6 +
 include/linux/irqchip/arm-gic-acpi.h      |  29 ++
 40 files changed, 2359 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/arm64/acpi_object_usage.txt
 create mode 100644 Documentation/arm64/arm-acpi.txt
 create mode 100644 Documentation/arm64/why_use_acpi.txt
 create mode 100644 arch/arm64/include/asm/acenv.h
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/kernel/acpi.c
 create mode 100644 arch/arm64/kernel/acpi_sleep.c
 create mode 100644 include/linux/irqchip/arm-gic-acpi.h

-- 
1.9.1
