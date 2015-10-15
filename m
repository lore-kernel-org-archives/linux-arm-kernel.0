From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 16:05:09 +0200
Subject: [PATCH V1 00/10] Introduce ACPI world to GICv3 and ITS irqchips
Message-ID: <1444917919-21152-1-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches have been part of:
[PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
https://lkml.org/lkml/2015/7/29/234

Now patches address comments that came up during above series review and
take advantage of useful things like:
1. Making irqdmain independent from device node introduced by Marc:
[PATCH v2 00/17] Divorcing irqdomain and device_node
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v2
2. Self-probe infrastructure for probing irqchip introduced by Marc:
[PATCH v3 0/7] Early ACPI probing infrastructure
https://lkml.org/lkml/2015/9/28/421
3. Early MADT sanity check introduced by Al:
[PATCH v5 0/5] Provide better MADT subtable sanity checks
https://lkml.org/lkml/2015/9/29/968

The following git branch contains the submitted patches along with
the pre-requsite patches (mainly for ARM64 PCI support for ACPI).
https://git.linaro.org/leg/acpi/acpi.git pci-acpi-upstream

This has been tested on Cavium ThunderX 1 socket board.

Hanjun Guo (1):
  irqchip / GICv3: remove gic root node in ITS

Tomasz Nowicki (9):
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
  irqchip / GICv3: Add ACPI support for GICv3+ initialization
  irqchip,GICv3,ACPI: Add redistributor support via GICC structures.
  irqchip, gicv3, its: Mark its_init() and its children as __init
  irqchip/GICv3/ITS: Refator ITS dt init code to prepare for ACPI.
  ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
  irqchip, gicv3, its: Probe ITS in the ACPI way.
  acpi, gicv3, msi: Factor out code that might be reused for ACPI
    equivalent.
  acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
    initialization.

 drivers/acpi/Kconfig                     |   3 +
 drivers/acpi/Makefile                    |   1 +
 drivers/acpi/iort.c                      | 326 +++++++++++++++++++++++++++++
 drivers/irqchip/Kconfig                  |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |  89 ++++++--
 drivers/irqchip/irq-gic-v3-its.c         | 138 +++++++++----
 drivers/irqchip/irq-gic-v3.c             | 339 ++++++++++++++++++++++++++-----
 include/linux/iort.h                     |  38 ++++
 include/linux/irqchip/arm-gic-v3.h       |   2 +-
 9 files changed, 838 insertions(+), 99 deletions(-)
 create mode 100644 drivers/acpi/iort.c
 create mode 100644 include/linux/iort.h

-- 
1.9.1
