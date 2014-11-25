From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Nov 2014 18:47:21 +0000
Subject: [PATCH v11 0/2] irqchip: add support for GICv2m MSI controller
Message-ID: <1416941243-7181-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICv2m is a very simple addition to the standard GICv2 interrupt
controller, offering a way to convert writes from a device to a
"wire-like" interrupt. Basically what we need to support MSI on the
GIC.

The v2m widget exposes a "frame", containing a read-only register
describing the range of interrupts that are MSI-capable, as well as a
doorbell that the device can kick to generate the interrupt. All the
rest of the infrastructure is provided by the GIC itself (enabling,
routing, ack/eoi...). This makes an ideal case for stacked irq
domains.

These patches were originally written by Suravee, but I've converted
them to the stacked irq domains. As this turned out to be quite a
sizeable rewrite of the original code, please blame me for any issue
in this code, and not Suravee.

Unsurprisingly, there is quite a long dependency chain here. You need:
- Jiang's stacked domain patches, from tip/irq/irqdomain
- The first patch in my GICv3 ITS series:
  https://lkml.org/lkml/2014/11/24/409
- The first patch in Yingjoe's sysirq series:
  https://lkml.org/lkml/2014/11/25/130

For everyone's convenience, I have a branch containing all that, and
much more:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/v2m

This has been fairly heavily tested on an arm64 platform driving a
pair of igb interfaces.

>From v10:
- Rewrote the driver to solely rely on irq domains, and not the
setup_irq/teardown_irq methods that were used before (similar to what
has been done for the GICv3 ITS).

Suravee Suthikulpanit (2):
  irqchip: gicv2m: Add support for ARM GICv2m MSI(-X) doorbell
  irqchip: gicv2m: Add DT bindings for GICv2m

 Documentation/devicetree/bindings/arm/gic.txt |  53 ++++
 arch/arm64/Kconfig                            |   1 +
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 333 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c                     |   4 +
 include/linux/irqchip/arm-gic.h               |   2 +
 7 files changed, 400 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-v2m.c

-- 
2.1.3
