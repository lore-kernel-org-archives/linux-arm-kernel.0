From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 19 Jun 2015 16:46:03 +0800
Subject: [PATCH v2 0/9] Add self-probe infrastructure and stacked irqdomain
 support for ACPI based GICv2/3 init
Message-ID: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduce self-probe infrastructure to init IRQ
controllers and stacked irqdomain support for ACPI based GICv2/3
init.

The self-probe infrastructure for ACPI GIC init is similar as
IRQCHIP_DECLARE() and based on the GIC version support in ACPI
MADT table. we match the GIC version and GIC driver and load
it.

We introduce acpi_irq_domain for GICv2/3 core domain to support
stacked irqdomain, and pass the gsi (global system interrupt) as
the agument (void *arg) for gic_irq_domain_alloc(), then we can
alloc virqs via acpi_register_gsi() with stacked irqdomain.

The stacked irq domain will be:

    acpi_irq_domain == gicv2 or gicv3 core domain
                   ^
                   |   (parent)
                   |
       ITS domain or GIv2m domain
                   ^
                   |
                   |
           MSI chip irq domain

Since there is one GICD supported for now, so there will be only
one irqdomain created when GICv2/3 initialized, for all the wired
hardware irqs for PPI, SGI and SPI, they will have unique hardware
irq number (GSI), so we can match the device to the acpi_irq_domain
with unique GSI and it will work. If there will be multi GICD in the
future, this will still works to follow the solution for x86 of ACPI
(mutil IOAPICs).


Note: patch 1~2 already merged in ACPICA core, I just send them out
for helping of better understanding later 7 patches.

Any comments are warmly welcomed.

update from RFC version:
 - Consolidate all the GIC init code into drivers/irqchip/irq-gic-acpi.c

v1->v2:
 - Remove the gicv2/v3 related driver code in drivers/irqchip/irq-gic-acpi.c
   which I was trying to consolidate them in one file, then arm-gic.h and
   arm-gic-v3.h will be used separately within parent driver only

 - Drop the gsi_mutex patch

 - Use the GIC version to match the GIC driver, then no need to test
   for the version in each driver

 - Move acpi_irq_init() to drivers/irqchip/irq-gic-acpi.c instead of
   in drivers/acpi/irq.c. maybe we need to rename acpi_irq_init() as
   acpi_gic_init() but I keep that name to accommodate of_irq_init(),
   any objections please let me know.

Bob Moore (1):
  ACPICA: ACPI 6.0: Add changes for MADT table.

Hanjun Guo (6):
  ACPICA: ACPI 6.0: Add values for MADT GIC version field.
  irqchip / GIC: Add GIC version support in ACPI MADT
  ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
    controller
  irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 init
    code
  irqchip / gic: Add stacked irqdomain support for ACPI based GICv2 init
  irqchip / GICv3: Add stacked irqdomain support for ACPI based init

Tomasz Nowicki (2):
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
  irqchip / GICv3: Add ACPI support for GICv3+ initialization

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/acpi.h        |   1 -
 arch/arm64/include/asm/irq.h         |  13 --
 arch/arm64/kernel/acpi.c             |  25 ----
 drivers/acpi/gsi.c                   |  28 ++--
 drivers/irqchip/Kconfig              |   3 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-gic-acpi.c       | 141 +++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c         | 264 ++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c            |  35 ++---
 drivers/irqchip/irqchip.h            |  12 ++
 include/acpi/actbl1.h                |  33 ++++-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/acpi.h                 |  16 +++
 include/linux/acpi_irq.h             |   4 +-
 include/linux/irqchip/arm-gic-acpi.h |  10 +-
 include/linux/mod_devicetable.h      |   8 ++
 17 files changed, 473 insertions(+), 135 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-acpi.c

-- 
1.9.1
