From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  4 Dec 2013 00:39:04 +0800
Subject: [RFC part2 PATCH 0/9] Using ACPI MADT table to initialise SMP and GIC
Message-ID: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is based on part1 "Make ACPI core running on ARM64" patch
set.

After we can get the ACPI tables from UEFI, we can use these tables
to initialise the system now.

GIC (means GIC cpu interface) structure and GIC distributor structure in
MADT table contains the information of GIC cpu interface base address
and GIC distributor base address, which can be used to initialise GIC.

Further more, parked address in GIC structure can be used as cpu release
address for spin table SMP initialisation.

This patch set use these information to init SMP and GIC.

Please refer to chapter 5.2.12.14/15 of ACPI 5.0 spec for GIC and GIC
distributor structure information.

Amit Daniel Kachhap (1):
  irqdomain: Add a new API irq_create_acpi_mapping()

Hanjun Guo (8):
  ARM64 / ACPI: Implement core functions for parsing MADT table
  ARM64 / ACPI: Prefill cpu possible/present maps and map logical cpu
    id to APIC id
  ARM64 / ACPI: Introduce map_gic_id() to get apic id from MADT or _MAT
    method
  ARM64 / ACPI: Use Parked Address in GIC structure for spin table SMP
    initialisation
  ACPI: Define ACPI_IRQ_MODEL_GIC needed for arm
  Irqchip / gic: Set as default domain so we can access from ACPI
  ACPI / ARM64: Update acpi_register_gsi to register with the core IRQ
    subsystem
  ACPI / GIC: Initialize GIC using the information in MADT

 arch/arm64/include/asm/acpi.h      |   16 +-
 arch/arm64/kernel/irq.c            |    5 +
 arch/arm64/kernel/setup.c          |    2 +
 arch/arm64/kernel/smp.c            |    2 +
 arch/arm64/kernel/smp_spin_table.c |   16 +-
 drivers/acpi/bus.c                 |    3 +
 drivers/acpi/plat/arm-core.c       |  397 +++++++++++++++++++++++++++++++++++-
 drivers/acpi/processor_core.c      |   26 +++
 drivers/acpi/tables.c              |   21 ++
 drivers/irqchip/irq-gic.c          |    7 +
 include/linux/acpi.h               |    9 +
 kernel/irq/irqdomain.c             |   27 +++
 12 files changed, 521 insertions(+), 10 deletions(-)

-- 
1.7.9.5
