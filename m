From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Nov 2015 08:26:01 +0000
Subject: [PATCH v2 0/7] Adding core support for wire-MSI bridges
Message-ID: <1448267168-17360-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There seems to be a new class of interrupt controller out there whose
sole purpose (apart from making everybody's life a nightmare) is to
turn wired interrupts into MSIs (see [1] for a prime example of the
what this actually is).

Instead of considering that the MSIs allocated to a device are for the
direct use of that device, we can turn this set of MSIs into a irq
domain, and use this domain to back a stacked irqchip implemented by
the device. When combined with a GICv3 and its ITS, we end-up with the
following stack:

              wire                MSI
Client-device ----> Bridge-Device ----> Platform-MSI -> ITS -> GICv3

where we have a 1:1 mapping between wired interrupts and MSIs.

This requires some (slightly ugly) surgery in both the generic MSI and
platform MSI layers, but the amount of code is actually relatively
small (about +220 LoC so far).

On top of that, we add a dummy driver for a such a bridge, hoping that
this will give enough information to driver authors so that they can
use this new feature. An even more stupid client driver is provided to
show the interrupt stack allocation:

     dummydev dummy-dev: Probing
     dummydev dummy-dev: Allocated IRQ35
     dummydev dummy-dev: Probing OK
     dummydev dummy-dev: IRQ35 hwirq 5 domain msichip_domain_ops
     dummydev dummy-dev: IRQ35 hwirq 0 domain msi_domain_ops
     dummydev dummy-dev: IRQ35 hwirq 8192 domain its_domain_ops
     dummydev dummy-dev: IRQ35 hwirq 8192 domain gic_irq_domain_ops

Of course, it goes without saying that this last patch is not to be
merged...

While this does work, it is far from being perfect:

- It relies on not declaring this bridge with IRQCHIP_DECLARE in order
  to prevent the DT layer from allocating interrupts behind our back.

- There are probe ordering issues between the bridge and the wired
  interrupt device, leading to the use of -EPROBE_DEFER.

The last two points could be addressed directly in the OF layer, as
this is a generic device ordering issue (and people are already
working on that).

* From v1:
  - Added the error handling that was completely absent from the original
    prototype
  - Allow interrupts to be freed
  - Added API documentation
  - Rebased on top of 4.4-rc1

[1] https://lkml.org/lkml/2015/11/22/244

Marc Zyngier (7):
  platform-msi: Allow MSIs to be allocated in chunks
  platform-msi: Factor out allocation/free of private data
  irqdomain: Make irq_domain_alloc_irqs_recursive available
  genirq/msi: Make the .prepare callback reusable
  genirq/msi: Add msi_domain_populate_irqs
  platform-msi: Allow creation of a MSI-based stacked irq domain
  irqchip: [Example] dummy wired interrupt/MSI bridge driver

 drivers/base/platform-msi.c   | 254 ++++++++++++++++++++++++++++++---------
 drivers/irqchip/Kconfig       |   7 ++
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-msichip.c | 271 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/irqdomain.h     |   3 +
 include/linux/msi.h           |  18 +++
 kernel/irq/irqdomain.c        |   6 +-
 kernel/irq/msi.c              |  58 ++++++++-
 8 files changed, 558 insertions(+), 60 deletions(-)
 create mode 100644 drivers/irqchip/irq-msichip.c

-- 
2.1.4
