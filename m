From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Fri, 31 Oct 2014 03:26:28 -0500
Subject: [V9 PATCH 0/2] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Message-ID: <1414743990-28421-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This patch set is rebased from: 
    Git tree   : git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
    Git branch : domain_hierarchy
    Last commit: 97d4ea1f0922fb47dd1b09cd2694b7fa5b519db9

Changes in V9 includes:
  * GICv2m is now adopting the new domain hierarchy, which requires
    GICv2m to implements its own irq_chip and irq_domain, as a child of GIC. 
    GICv2m domain is intialized using the SPI base and the number of SPIs from
    V2M_MSI_TYPER registers (or the override value from DT).

  * Simplified GIC logic that was used to handle MSI stuff. Now the v2m
    stuff is cleanly separated.

History:
    V8: https://lkml.org/lkml/2014/9/20/111
    V7: https://lkml.org/lkml/2014/9/17/751

Suravee Suthikulpanit (2):
  genirq: Add irq_chip_set_type_parent function
  irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)

 Documentation/devicetree/bindings/arm/gic.txt |  53 ++++
 arch/arm64/Kconfig                            |   1 +
 drivers/irqchip/Kconfig                       |   5 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 395 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v2m.h                 |   7 +
 drivers/irqchip/irq-gic.c                     |  21 +-
 include/linux/irq.h                           |   1 +
 kernel/irq/chip.c                             |  10 +
 9 files changed, 490 insertions(+), 4 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.h

-- 
1.9.3
