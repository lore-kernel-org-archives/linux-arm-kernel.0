From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 May 2015 20:59:10 +0800
Subject: [PATCH 00/11] Add self-probe infrastructure and stacked irqdomain
 support for ACPI based GICv2/3 init
Message-ID: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduce self-probe infrastructure to init IRQ
controllers and stacked irqdomain support for ACPI based GICv2/3
init.

The self-probe infrastructure for ACPI GIC init is similar as
IRQCHIP_DECLARE() and based on the GIC version support in ACPI
MADT table.

We introduce acpi_irq_domain for GICv2/3 core domain to support
stacked irqdomain, and pass the gsi (global system interrupt) as
the agument (void *arg) for gic_irq_domain_alloc(), then we can
alloc virqs via acpi_register_gsi() with stacked irqdomain.

In order to make ACPI related GIC init code slef-contained, I
consolidated all the GIC init code into drivers/irqchip/irq-gic-acpi.c.

update from RFC version:
 - Consolidate all the GIC init code into drivers/irqchip/irq-gic-acpi.c

Hanjun Guo (8):
  irqchip / GIC: Add GIC version support in ACPI MADT
  irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 init
    code
  irqchip / gic: Add stacked irqdomain support for ACPI based GICv2 init
  ACPI / gsi: Add gsi_mutex to synchronize
    acpi_register_gsi()/acpi_unregister_gsi()
  irqchip / GICv3: Add ACPI support for GICv3+ initialization
  irqchip / GICv3: Add stacked irqdomain support for ACPI based init
  irqchip / GICv2 / ACPI: Consolidate GICv2 ACPI related init code
  irqchip / GICv3 / ACPI: Consolidate GICv3 ACPI related init code

Tomasz Nowicki (3):
  ACPICA: Introduce GIC version for arm based system
  ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
    controller
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/irq.h         |  13 --
 arch/arm64/kernel/acpi.c             |  25 ---
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/gsi.c                   |  41 +++--
 drivers/acpi/irq.c                   |  40 +++++
 drivers/irqchip/Kconfig              |   3 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-gic-acpi.c       | 318 +++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c         | 149 +++++++++-------
 drivers/irqchip/irq-gic.c            | 129 ++------------
 drivers/irqchip/irqchip.h            |  12 ++
 include/acpi/actbl1.h                |  17 +-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/acpi.h                 |  14 ++
 include/linux/acpi_irq.h             |   4 +-
 include/linux/irqchip/arm-gic-acpi.h |  13 +-
 include/linux/irqchip/arm-gic-v3.h   |  10 ++
 include/linux/mod_devicetable.h      |   7 +
 19 files changed, 577 insertions(+), 234 deletions(-)
 create mode 100644 drivers/acpi/irq.c
 create mode 100644 drivers/irqchip/irq-gic-acpi.c

-- 
1.9.1
