From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:39:59 +0800
Subject: [PATCH v3 00/62] Add ACPI support for arm64 on Xen
Message-ID: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

This patch set adds ACPI support for arm64 on Xen. The design document
could be found from [1].

Xen reads static tables described by ACPI standard (6.0) from uefi and
configures timer, GIC and UART. ACPI tables are modified to enable PSCI,
HVC and Xen specific information and mapped into Dom0 address space.
A minimal device tree is created to pass EFI table which contains memory
layout (which cannot be passed using ACPI) and RSDP pointer to Dom0
through the node "uefi" under /hypervisor node. Dom0 parses dynamic ACPI
tables and configure other peripherals.

Patch 1 reverts "xen/arm: vgic-v2: Drop cbase from arch_domain" because
d->arch.vgic.cbase will be used by creating Dom0 MADT table later.
Patches 2-36 add ACPI support for Xen/uefi interface.
Patches 37-62 add ACPI support for Xen/Dom0 interface.
Last patch "xen: arm64: Add ACPI support" enables the support for ACPI
so that individual patches do not affect working xen code base.

ACPI is now configurable via command line option "acpi=". To boot from
ACPI this parameter should be set to "force".

Patches are tested on FVP base model. Instructions for reproducing the
setup and working code base can be found from the following repositories
wiki[2], Xen[3], Linux[4], UEFI[5]. Also you can get the test scripts
and firmware binaries from[6].

Note currently the EFI runtime service is not added in this patch set
since I didn't figure out a good way to support that. Dom0 will check if
Xen supports runtime service. If not, Dom0 will not initialize runtime
services. It's a long time since previous patch set and most work has
been done. So I send this patch set out without runtime service support
and later I could continue working on adding runtime service support or
maybe other people who know this better could help work on that based on
this patch set.

Thanks,
Shannon

[1] http://lists.xen.org/archives/html/xen-devel/2015-11/msg00488.html
[2] https://wiki.linaro.org/LEG/Engineering/Xen_boot_on_FVP_ACPI_UEFI
[3] http://git.linaro.org/people/shannon.zhao/linux-mainline.git  ACPI_XEN_ARM_Linux_V1
[4] http://git.linaro.org/people/shannon.zhao/xen.git  ACPI_XEN_ARM_V3
[5] http://git.linaro.org/people/shannon.zhao/linaro-edk2.git  acpi-xen-uefi-v3
[6] http://people.linaro.org/~shannon.zhao/ACPI_XEN/

Most changes since v2:
* Create Dom0 ACPI tables based on new design
* Pass UEFI information to Dom0 through "uefi" node under /hypervisor
  node within FDT
* Define HAVE_NUMA option for NUMA
* Make pmstat dependent on HAS_CPUFREQ
* Refactor some ACPI codes to be aligned wit Linux
* Add GICv3 ACPI support
* Add a hypercall for device MMIO mapping
* Add a hypercall for event-channel interrupt
* Map newly created EFI and ACPI tables to the Xen and Dom0 unused place

Bob Moore (3):
  ACPICA: ACPI 6.0: Add changes for FADT table
  ACPICA: ACPI 6.0: Add changes for MADT table.
  ACPICA: ACPI 6.0: Add support for STAO table

Hanjun Guo (1):
  ACPICA: ACPI 6.0: Add values for MADT GIC version field

Naresh Bhat (3):
  acpi/NUMA: Build NUMA for x86 only
  arm/acpi: Print GIC information when MADT is parsed
  xen/arm64: Add ACPI support

Parth Dixit (17):
  acpi/pmstat: Build pmstat for x86 only
  arm/acpi: Emulate io ports for arm
  arm/acpi: Add basic ACPI initialization
  arm/acpi: Parse MADT to map logical cpu to MPIDR and get
    cpu_possible_map
  arm/smpboot: Move dt specific code in smp to seperate functions
  acpi/table: Introduce acpi_parse_entries
  arm: Introduce a generic way to use a device from acpi
  arm/gic-v2: Add ACPI boot support for GICv2
  arm/acpi: Add GTDT support updated by ACPI 5.1
  arm/irq: Add helper function for setting interrupt type
  arm/acpi: Parse GTDT to initialize timer
  arm/uart: Create generic uart initialization function
  arm/acpi: Initialize serial port from ACPI SPCR table
  arm/acpi: Read acpi memory info from uefi
  arm/p2m: Add helper functions to map memory regions
  arm/acpi: Configure interrupts dynamically
  arm/acpi: Add acpi parameter to enable/disable acpi

Shannon Zhao (38):
  Revert "xen/arm: vgic-v2: Drop cbase from arch_domain"
  acpi: Don't do traditional BIOS table scan for ARM64
  acpi: Refactor acpi_os_map_memory to be architecturally independent
  arm/acpi: Add arch_acpi_os_map_memory helper function for ARM
  arm/acpi: Add arm specific acpi header file
  arm/acpi: Move end_boot_allocator after acpi_boot_table_init
  arm/acpi: Introduce ARM Boot Architecture Flags in FADT
  arm/acpi: Parse FADT table and get PSCI flags
  arm/acpi: Add Generic Interrupt and Distributor struct
  arm/acpi: Add ACPI support for SMP initialization
  arm/gic-v2: Refactor gicv2_init into generic and dt specific parts
  arm/gic-v3: Refactor gicv3_init into generic and dt specific parts
  acpi/table: Introduce acpi_get_entry to get specified entry
  arm/gic-v3: Add ACPI boot support for GICv3
  arm/gic: Add ACPI support for GIC preinit
  arm/acpi: Add a helper function to get interrupt type
  pl011: Refactor pl011 driver to dt and common initialization parts
  serial: Rename SERHND_DTUART to SERHND_UART
  arm/acpi: Define a enum for reserved tables
  arm/acpi: Add placeholder for efi and acpi load address
  arm/acpi: Estimate memory required for acpi/efi tables
  arm/acpi: Add a helper function to get the acpi table offset
  arm/acpi: Prepare FADT table for Dom0
  arm/acpi: Prepare MADT table for Dom0
  arm/acpi: Prepare STAO table for Dom0
  arm/acpi: Prepare XSDT table for Dom0
  arm/acpi: Prepare RSDP table for Dom0
  arm/acpi: Map rest tables for Dom0
  xen/efi: store EFI system table in efi structure
  arm/acpi: Prepare EFI system table for Dom0
  arm/acpi: Prepare EFI memory descriptor for Dom0
  arm/acpi: Map the new created EFI and ACPI tables to Dom0
  arm/acpi: Create min DT stub for Dom0
  arm/acpi: Route all Xen unused SPIs to Dom0
  arm/acpi: Deny MMIO access of UART
  hvm/params: Add a new dilivery type for event-channel in
    HVM_PARAM_CALLBACK_IRQ
  xen/acpi: Fix event-channel interrupt when booting with ACPI
  xen/arm: Add a hypercall for device mmio mapping

 config/arm64.mk                    |   1 +
 xen/arch/arm/Makefile              |   1 +
 xen/arch/arm/acpi/Makefile         |   2 +
 xen/arch/arm/acpi/boot.c           | 214 ++++++++++++
 xen/arch/arm/acpi/lib.c            |  85 +++++
 xen/arch/arm/arm64/smpboot.c       |  12 +-
 xen/arch/arm/device.c              |  19 ++
 xen/arch/arm/domain.c              |   4 +
 xen/arch/arm/domain_build.c        | 667 ++++++++++++++++++++++++++++++++++++-
 xen/arch/arm/efi/efi-boot.h        |  23 ++
 xen/arch/arm/gic-v2.c              | 141 +++++++-
 xen/arch/arm/gic-v3.c              | 271 ++++++++++++---
 xen/arch/arm/gic.c                 |  55 ++-
 xen/arch/arm/irq.c                 |  22 +-
 xen/arch/arm/mm.c                  |   4 +
 xen/arch/arm/p2m.c                 |  60 ++++
 xen/arch/arm/psci.c                |  30 +-
 xen/arch/arm/setup.c               |  37 +-
 xen/arch/arm/smpboot.c             |  34 +-
 xen/arch/arm/time.c                |  73 +++-
 xen/arch/arm/vgic-v2.c             |  10 +-
 xen/arch/arm/vgic.c                |  19 ++
 xen/arch/arm/vuart.c               |   2 +-
 xen/arch/arm/xen.lds.S             |   7 +
 xen/arch/x86/Rules.mk              |   1 +
 xen/arch/x86/acpi/lib.c            |  16 +
 xen/common/efi/boot.c              | 182 ++++++++++
 xen/common/efi/runtime.c           |   2 +-
 xen/common/sysctl.c                |   2 +-
 xen/drivers/acpi/Makefile          |   4 +-
 xen/drivers/acpi/osl.c             |  14 +-
 xen/drivers/acpi/tables.c          | 120 ++++++-
 xen/drivers/char/Makefile          |   2 +-
 xen/drivers/char/arm-uart.c        | 136 ++++++++
 xen/drivers/char/cadence-uart.c    |   2 +-
 xen/drivers/char/dt-uart.c         | 107 ------
 xen/drivers/char/exynos4210-uart.c |   2 +-
 xen/drivers/char/omap-uart.c       |   2 +-
 xen/drivers/char/pl011.c           | 101 ++++--
 xen/drivers/char/scif-uart.c       |   2 +-
 xen/drivers/char/serial.c          |   2 +-
 xen/include/acpi/actbl.h           |  29 +-
 xen/include/acpi/actbl1.h          |  94 +++++-
 xen/include/acpi/actbl2.h          |   5 +
 xen/include/acpi/actbl3.h          | 114 ++++++-
 xen/include/asm-arm/acpi.h         | 108 ++++++
 xen/include/asm-arm/arm64/io.h     |  14 +
 xen/include/asm-arm/config.h       |   5 +
 xen/include/asm-arm/device.h       |  30 ++
 xen/include/asm-arm/domain.h       |   6 +
 xen/include/asm-arm/irq.h          |   2 +
 xen/include/asm-arm/p2m.h          |  15 +
 xen/include/asm-arm/setup.h        |  11 +
 xen/include/public/hvm/params.h    |   5 +
 xen/include/public/memory.h        |   1 +
 xen/include/xen/acpi.h             |  13 +
 xen/include/xen/efi.h              |   1 +
 xen/include/xen/serial.h           |   4 +-
 58 files changed, 2632 insertions(+), 315 deletions(-)
 create mode 100644 xen/arch/arm/acpi/Makefile
 create mode 100644 xen/arch/arm/acpi/boot.c
 create mode 100644 xen/arch/arm/acpi/lib.c
 create mode 100644 xen/drivers/char/arm-uart.c
 delete mode 100644 xen/drivers/char/dt-uart.c
 create mode 100644 xen/include/asm-arm/acpi.h

-- 
2.1.0
