From: majun258@huawei.com (majun (F))
Date: Sat, 30 May 2015 11:19:00 +0800
Subject: [PATCH 0/4] Cover: Support mbigen msi interrupt controller
Message-ID: <55692C24.107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is applied to supprot the mbigen device.

Mbigen means message based interrupt generator.
It locate in ITS or out side of ITS.

In fact, mbigen is a kind of interrupt controller collects
the irq form Non-PCI devices and generate msi interrupt.

Hisilicon designed mbigen to reduce the wired interrupt
number connected to GIC.

In these patches, the interrupts from Non-PCI devices are
named as MBI to distiguish between legacy MSI interrupt from
PCI devices.

As a MSI interrupt controller, the mbigen is used as a child
domain of MSI domain just like PCI devices.

So,in order to support the mbigen interrupt controller, the
msi.c and its-gic-v3-its.c are changed.

Ma Jun (4):
  Add mbigen driver to support mbigen interrupt controller
  Change msi to support the Mbigen interrupt
  Change arm-gic-its to support the Mbigen interrupt
  dt-binding:Documents the mbigen bindings

 Documentation/devicetree/bindings/arm/mbigen.txt |   51 ++
 drivers/irqchip/Kconfig                          |    4 +
 drivers/irqchip/Makefile                         |    1 +
 drivers/irqchip/irq-gic-v3-its.c                 |   71 +--
 drivers/irqchip/irq-mbigen.c                     |  562 ++++++++++++++++++++++
 include/linux/irq.h                              |    1 +
 include/linux/irqchip/arm-gic-its.h              |   68 +++
 include/linux/irqdomain.h                        |    2 +-
 include/linux/mbi.h                              |   77 +++
 include/linux/msi.h                              |    1 +
 kernel/irq/chip.c                                |   12 +-
 kernel/irq/msi.c                                 |   22 +-
 12 files changed, 818 insertions(+), 54 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/arm/mbigen.txt
 mode change 100644 => 100755 drivers/irqchip/Kconfig
 mode change 100644 => 100755 drivers/irqchip/Makefile
 mode change 100644 => 100755 drivers/irqchip/irq-gic-v3-its.c
 create mode 100755 drivers/irqchip/irq-mbigen.c
 create mode 100755 include/linux/irqchip/arm-gic-its.h
 create mode 100644 include/linux/mbi.h
 mode change 100644 => 100755 include/linux/msi.h
 mode change 100644 => 100755 kernel/irq/msi.c
