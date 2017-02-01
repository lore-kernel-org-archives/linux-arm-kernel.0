From: rrichter@cavium.com (Robert Richter)
Date: Wed, 1 Feb 2017 18:38:24 +0100
Subject: [PATCH 0/9] irqchip/gic-v3-its: Implement ITS nodes as kernel devices
 and use CMA
Message-ID: <20170201173833.12630-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements ITS nodes as kernel devices. The
advantage of that is that CMA can be used to allocate large ITS
tables, where standard memory and page allocation fails (above
MAX_ORDER - 1). This approach was suggested first here:

 https://marc.info/?i=56D44812.6000309%40arm.com

Another advantage is that all memory resources of the device are now
device managed, thus the code for releasing the device becomes much
easier.

The following is required to implement this:

 * each ITS node must be assigned to a struct device each,

 * the ITS initialization must be moved to a later point during boot,

 * the ITS enablement must be separated from the GIC code (the GIC
   still needs to be enabled early),

 * the early ITS node probing by DT or ACPI must be separated from the
   ITS initialization,

 * ITS table allocation must be changed to use dma_alloc_coherent()
   which uses CMA for allocation of large memory ranges.

The patches of this series implement this.

The first patch is a fix and should be marked stable.


Robert Richter (9):
  irqchip/gic-v3-its: Fix command buffer allocation
  irqchip/gic-v3-its: Initialize its nodes in probe order
  irqchip/gic-v3-its: Initialize MSIs with subsys_initcalls
  irqchip/gic-v3-its: Split probing from its node initialization
  irqchip/gic-v3-its: Decouple its initialization from gic
  irqchip/gic-v3-its: Prevent its init ordering dependencies
  irqchip/gic-v3-its: Initialize its nodes later
  irqchip/gic-v3-its: Handle its nodes as kernel devices
  irqchip, gicv3-its, cma: Use CMA for allocation of large device tables

 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   6 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |   6 +-
 drivers/irqchip/irq-gic-v3-its.c              | 273 ++++++++++++++++----------
 drivers/irqchip/irq-gic-v3.c                  |   8 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/irqchip/arm-gic-v3.h            |   5 +-
 6 files changed, 184 insertions(+), 115 deletions(-)

-- 
2.11.0
