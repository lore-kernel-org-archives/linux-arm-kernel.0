From: majun258@huawei.com (Ma Jun)
Date: Fri, 12 Jun 2015 10:49:56 +0800
Subject: [PATCH v2 0/3] IRQ/Gic-V3:Support Mbigen interrupt controller
Message-ID: <1434077399-32200-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is applied to supprot the mbigen device.

Mbigen means message based interrupt generator.
It locate in ITS or out side of ITS.

In fact, mbigen is a kind of interrupt controller collects
the irq form non-PCI devices and generate msi interrupt.

Hisilicon designed mbigen to reduce the wired interrupt 
number connected to GIC.

In these patches, the interrupts from non-PCI devices are
named as MBI to distiguish between legacy MSI interrupt from
PCI devices.

As a kind of MSI interrupt controller, the mbigen is used as a child 
domain of ITS domain just like PCI devices.

So,in order to support the mbigen interrupt controller, the 
its-gic-v3-its.c and other related files are changed.

Change in v2
---Compared to v1, mbigen domain is used as a child domain of ITS accroding
   to Marc's advice.So, all changed files related with MSI in v1 are removed.
   Now, only its domain related files are changed to support this new interrupt
   controller.



Ma Jun (3):
  Add mbigen driver to support mbigen interrupt controller
  Change arm-gic-its to support the Mbigen interrupt
  dt-binding:Documents the mbigen bindings

 Documentation/devicetree/bindings/arm/mbigen.txt |   59 +++
 drivers/irqchip/Kconfig                          |    7 +
 drivers/irqchip/Makefile                         |    1 +
 drivers/irqchip/irq-gic-v3-its.c                 |   66 +++-
 drivers/irqchip/irq-mbigen.c                     |  579 ++++++++++++++++++++++
 include/linux/irq.h                              |    5 +
 include/linux/mbi.h                              |  114 +++++
 kernel/irq/chip.c                                |   40 ++-
 8 files changed, 866 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen.c
 create mode 100644 include/linux/mbi.h
