From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:28 +0800
Subject: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Message-ID: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, there are
some updates since v7:

 - Add two more documantation to explain why we need ACPI in ARM64 servers
   by Grant, and recommendations and prohibitions on the use of the numerous
   ACPI tables and objects by Al Stone.

 - Add two patches which is need to map acpi tables after acpi_gbl_permanent_mmap
   is set

 - Add another patch "dt / chosen: Add linux,uefi-stub-generated-dtb property"
   to address that if firmware providing no dtb, we can try ACPI configuration data
   even if no "acpi=force" is passed in early parameters. (I think ACPI for XEN and
   kexec need consider sperately as disscussed, correct me if I'm wrong).

 - Add CC in the patch to the subsystem maintainers and modify the subject
   of the patch to explicitly show the subsystem touched by this patch set,
   please help us to review and ack them if they make sense, thanks.

 - Add Tested-by from Qualcomm and Redhat;

 - Make ACPI depends on PCI suggested by Catalin;

 - Clean up SMP init function as Lorenzo suggested, remove physical
   CPU hot-plug code in the patch;

 - Address some comments from Marc and explicitly state that will
   implment statcked irqdomain and GIC init framework when GICv3 and
   ITS, GICv2m are implemented;

 - Rebased on top of 3.19-rc7.

previous version is here:
v7: https://lkml.org/lkml/2015/1/14/586
v6: https://lkml.org/lkml/2015/1/4/40

Any comments are welcome :)

Thanks
Hanjun

Al Stone (4):
  ARM64 / ACPI: Get RSDP and ACPI boot-time tables
  ARM64 / ACPI: Introduce early_param for "acpi" and pass acpi=force to
    enable ACPI
  ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
    ARM64
  arm64: ACPI: additions of ACPI documentation for arm64

Graeme Gregory (6):
  acpi: add arm64 to the platforms that use ioremap
  ACPI / sleep: Introduce sleep_arm.c
  ARM64 / ACPI: If we chose to boot from acpi then disable FDT
  ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
  ARM64 / ACPI: Enable ARM64 in Kconfig
  Documentation: ACPI for ARM64

Hanjun Guo (8):
  ARM64 / ACPI: Introduce PCI stub functions for ACPI
  dt / chosen: Add linux,uefi-stub-generated-dtb property
  ARM64 / ACPI: Disable ACPI if FADT revision is less than 5.1
  ACPI / table: Print GIC information when MADT is parsed
  ARM64 / ACPI: Parse MADT for SMP initialization
  ACPI / processor: Make it possible to get CPU hardware ID via GICC
  ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
  clocksource / arch_timer: Parse GTDT to initialize arch timer

Mark Salter (2):
  acpi: fix acpi_os_ioremap for arm64
  arm64: allow late use of early_ioremap

Tomasz Nowicki (1):
  irqchip: Add GICv2 specific ACPI boot support

 Documentation/arm/uefi.txt                |   3 +
 Documentation/arm64/acpi_object_usage.txt | 592 ++++++++++++++++++++++++++++++
 Documentation/arm64/arm-acpi.txt          | 506 +++++++++++++++++++++++++
 Documentation/arm64/why_use_acpi.txt      | 231 ++++++++++++
 Documentation/kernel-parameters.txt       |   3 +-
 arch/arm64/Kconfig                        |   3 +
 arch/arm64/include/asm/acenv.h            |  18 +
 arch/arm64/include/asm/acpi.h             | 103 ++++++
 arch/arm64/include/asm/cpu_ops.h          |   1 +
 arch/arm64/include/asm/fixmap.h           |   3 +
 arch/arm64/include/asm/pci.h              |   6 +
 arch/arm64/include/asm/psci.h             |   3 +-
 arch/arm64/include/asm/smp.h              |   5 +-
 arch/arm64/kernel/Makefile                |   1 +
 arch/arm64/kernel/acpi.c                  | 362 ++++++++++++++++++
 arch/arm64/kernel/cpu_ops.c               |   2 +-
 arch/arm64/kernel/pci.c                   |  25 ++
 arch/arm64/kernel/psci.c                  |  78 ++--
 arch/arm64/kernel/setup.c                 |  58 ++-
 arch/arm64/kernel/smp.c                   |   2 +-
 arch/arm64/kernel/time.c                  |   7 +
 drivers/acpi/Kconfig                      |   3 +-
 drivers/acpi/Makefile                     |   4 +
 drivers/acpi/bus.c                        |   3 +
 drivers/acpi/osl.c                        |   6 +-
 drivers/acpi/processor_core.c             |  37 ++
 drivers/acpi/sleep_arm.c                  |  28 ++
 drivers/acpi/tables.c                     |  43 +++
 drivers/clocksource/arm_arch_timer.c      | 132 +++++--
 drivers/firmware/efi/libstub/fdt.c        |   8 +
 drivers/irqchip/irq-gic.c                 | 102 +++++
 drivers/irqchip/irqchip.c                 |   3 +
 include/acpi/acpi_io.h                    |   6 +
 include/linux/acpi.h                      |  16 +
 include/linux/clocksource.h               |   6 +
 include/linux/irqchip/arm-gic-acpi.h      |  31 ++
 36 files changed, 2374 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/arm64/acpi_object_usage.txt
 create mode 100644 Documentation/arm64/arm-acpi.txt
 create mode 100644 Documentation/arm64/why_use_acpi.txt
 create mode 100644 arch/arm64/include/asm/acenv.h
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/kernel/acpi.c
 create mode 100644 drivers/acpi/sleep_arm.c
 create mode 100644 include/linux/irqchip/arm-gic-acpi.h

-- 
1.9.1
