From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 24 Mar 2015 22:02:33 +0800
Subject: [patch v11 00/23] Introduce ACPI for ARM64 based on ACPI 5.1
Message-ID: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some fixes since last version:

 - Add a patch 19/23 for disabling ACPI for Xen on ARM64 for now to fix
   compile errors on XEN ACPI, Stefano and Julien are ok with this
   temporary solution.
 - Add patch "ARM64 / ACPI: Don't unflatten device tree if acpi=force 
   is passed", which will fix the problem that the device tree will
   be unflattened even if acpi=force passed, that will not obey the
   policy.
 - update patch "irqchip: Add GICv2 specific ACPI boot support",
   which will cause compile error on i386 with both DT and ACPI
   enabled:

   All error/warnings:

    In file included from include/linux/acpi_irq.h:4:0,
                     from drivers/irqchip/irqchip.c:11:
    arch/x86/include/asm/irq.h:35:8: error: unknown type name 'bool'
     extern bool handle_irq(unsigned irq, struct pt_regs *regs);
            ^
    arch/x86/include/asm/irq.h:35:45: warning: 'struct pt_regs' declared 
    inside parameter list
     extern bool handle_irq(unsigned irq, struct pt_regs *regs);
                                                 ^
    arch/x86/include/asm/irq.h:35:45: warning: its scope is only this 
    definition or declaration, which is probably not what you want
    ....

   That's because of I include the <asm/irq.h> in <linux/acpi_irq.h>,
   and <linux/acpi_irq.h> will be put on the top of all head files,
   so use <linux/irq.h> instead of <asm/irq.h> in acpi_irq.h (in
   <linux/irq.h>, it will include <linux/*.h> before include
   <asm/irq.h>), this is the only update for this patch.

Lorenzo will send some cleanup patches on top of this one soon.

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
  ACPI / sleep: Introduce CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
  ARM64 / ACPI: If we chose to boot from acpi then disable FDT
  ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
  ARM64 / ACPI: Enable ARM64 in Kconfig
  Documentation: ACPI for ARM64

Hanjun Guo (10):
  ACPI / table: Use pr_debug() instead of pr_info() for MADT table
    scanning
  ARM64 / ACPI: Introduce PCI stub functions for ACPI
  ACPI / table: Print GIC information when MADT is parsed
  ARM64 / ACPI: Parse MADT for SMP initialization
  ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID
  ACPI / processor: Make it possible to get CPU hardware ID via GICC
  ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
  clocksource / arch_timer: Parse GTDT to initialize arch timer
  XEN / ACPI: Make XEN ACPI depend on X86
  ARM64 / ACPI: Don't unflatten device tree if acpi=force is passed

Mark Salter (2):
  ARM64: allow late use of early_ioremap
  ACPI: fix acpi_os_ioremap for arm64

Tomasz Nowicki (1):
  irqchip: Add GICv2 specific ACPI boot support

 Documentation/arm64/acpi_object_usage.txt | 593 ++++++++++++++++++++++++++++++
 Documentation/arm64/arm-acpi.txt          | 505 +++++++++++++++++++++++++
 Documentation/kernel-parameters.txt       |   3 +-
 arch/arm64/Kconfig                        |   3 +
 arch/arm64/include/asm/acenv.h            |  18 +
 arch/arm64/include/asm/acpi.h             |  99 +++++
 arch/arm64/include/asm/cpu_ops.h          |   1 +
 arch/arm64/include/asm/fixmap.h           |   3 +
 arch/arm64/include/asm/irq.h              |  13 +
 arch/arm64/include/asm/pci.h              |   6 +
 arch/arm64/include/asm/psci.h             |   3 +-
 arch/arm64/include/asm/smp.h              |   5 +-
 arch/arm64/kernel/Makefile                |   1 +
 arch/arm64/kernel/acpi.c                  | 392 ++++++++++++++++++++
 arch/arm64/kernel/cpu_ops.c               |   2 +-
 arch/arm64/kernel/pci.c                   |  25 ++
 arch/arm64/kernel/psci.c                  |  78 ++--
 arch/arm64/kernel/setup.c                 |  21 +-
 arch/arm64/kernel/smp.c                   |   2 +-
 arch/arm64/kernel/time.c                  |   7 +
 arch/ia64/Kconfig                         |   1 +
 arch/ia64/kernel/acpi.c                   |   2 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/kernel/acpi/boot.c               |   2 +-
 drivers/acpi/Kconfig                      |   7 +-
 drivers/acpi/Makefile                     |   2 +-
 drivers/acpi/acpi_processor.c             |   7 +-
 drivers/acpi/bus.c                        |   3 +
 drivers/acpi/internal.h                   |   4 +
 drivers/acpi/osl.c                        |   6 +-
 drivers/acpi/processor_core.c             |  60 ++-
 drivers/acpi/tables.c                     |  52 ++-
 drivers/clocksource/arm_arch_timer.c      | 132 +++++--
 drivers/irqchip/irq-gic.c                 | 102 +++++
 drivers/irqchip/irqchip.c                 |   3 +
 drivers/xen/Kconfig                       |   4 +
 drivers/xen/Makefile                      |   2 +-
 include/acpi/acpi_io.h                    |   4 +
 include/acpi/processor.h                  |   6 +-
 include/linux/acpi.h                      |   8 +-
 include/linux/acpi_irq.h                  |  10 +
 include/linux/clocksource.h               |   6 +
 include/linux/irqchip/arm-gic-acpi.h      |  31 ++
 43 files changed, 2129 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/arm64/acpi_object_usage.txt
 create mode 100644 Documentation/arm64/arm-acpi.txt
 create mode 100644 arch/arm64/include/asm/acenv.h
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/kernel/acpi.c
 create mode 100644 include/linux/acpi_irq.h
 create mode 100644 include/linux/irqchip/arm-gic-acpi.h

-- 
1.9.1
