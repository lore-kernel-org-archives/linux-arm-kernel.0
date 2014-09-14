From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Sun, 14 Sep 2014 01:30:14 -0500
Subject: [PATCH 0/2 V6] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Message-ID: <1410676216-27953-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This depends on and has been tested with the following patch set which
implements PCI supports for ARM64:
 
    * https://lkml.org/lkml/2014/8/12/394
    * https://lkml.org/lkml/2014/8/12/361

Changes in V6:
    * Fix the logic in patch 1 in drivers/irqchip/irq-gic.c: gic_of_init()
      to print warning message when gicv2m_of_init fails instead of
      returning error since v2m is optional.

    * Minor clean up

Changes in V5:
    * Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/core

  Marc Zyngier suggestions:
    * Only use GICv2m irq_chip for MSI interrupts.
    * Simplify logic to support multi-MSI in arch/arm64/kernel/msi.c.
    * Modify gicv2m_setup_msi_irq() to also handle multi-MSI.

  Mark Rutlan suggestions: 
    * V4 patch set did not support multiple MSI register frame within a GIC.
      Although, the proposed GICv2m device tree binding should be able to
      handle the case.  Mark was questioning on how we can properly handle
      this in the code. Therefore, I try to implement this by iterating through
      the subnodes and look for msi-controller property. Once found, the code
      parses v2m register frame information and store it in the v2m_list of
      each gic_chip_data.

  Jingoo han suggestions:
    * Misc clean up.

Suravee Suthikulpanit (2):
  irqchip: gic: Add supports for ARM GICv2m MSI(-X)
  irqchip: gicv2m: Add support for multiple MSI for ARM64 GICv2m

 Documentation/devicetree/bindings/arm/gic.txt |  39 +++
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/msi.c                       |  41 ++++
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 328 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c                     |  88 ++++---
 drivers/irqchip/irq-gic.h                     |  51 ++++
 8 files changed, 528 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/kernel/msi.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
1.9.3
