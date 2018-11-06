From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 6 Nov 2018 14:10:52 +0530
Subject: [PATCH v3 00/13] Add support for TISCI irqchip drivers
Message-ID: <20181106084105.32483-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TISCI abstracts the handling of IRQ routes where interrupt sources
are not directly connected to host interrupt controller. This series
adds support for:
- TISCI commands needed for IRQ configuration
- Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers

More information on TISCI IRQ management can be found here[1].
Complete TISCI resource management information can be found here[2].
AM65x SoC related TISCI information can be found here[3].
INTR and INTA related information can be found in TRM[4].

[1] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
[2] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm
[3] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/index.html#am6-soc-family
[4] http://www.ti.com/lit/pdf/spruid7

Changes since v2:
- Added MSI support for allocating INTA interrupts
- Each patch contains respective changes.

Changes since v1:
- Consolidated both TISCI and irqchip drivers as suggested by Marc.
- Each patch contains respective changes.


Grygorii Strashko (1):
  firmware: ti_sci: Add support to get TISCI handle using of_phandle

Lokesh Vutla (11):
  firmware: ti_sci: Add support for RM core ops
  firmware: ti_sci: Add support for IRQ management
  firmware: ti_sci: Add helper apis to manage resources
  dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
  irqchip: ti-sci-intr: Add support for Interrupt Router driver
  genirq/msi: Add support for allocating single MSI for a device
  genirq/msi: Add support for .msi_unprepare callback
  soc: ti: Add MSI domain support for K3 Interrupt Aggregator
  dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
  irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
  soc: ti: am6: Enable interrupt controller drivers

Peter Ujfalusi (1):
  firmware: ti_sci: Add RM mapping table for am654

 .../bindings/arm/keystone/ti,sci.txt          |   3 +-
 .../interrupt-controller/ti,sci-inta.txt      |  74 ++
 .../interrupt-controller/ti,sci-intr.txt      |  84 ++
 MAINTAINERS                                   |   4 +
 drivers/firmware/ti_sci.c                     | 850 ++++++++++++++++++
 drivers/firmware/ti_sci.h                     | 102 +++
 drivers/irqchip/Kconfig                       |  23 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-ti-sci-inta.c             | 543 +++++++++++
 drivers/irqchip/irq-ti-sci-intr.c             | 310 +++++++
 drivers/soc/ti/Kconfig                        |   9 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/k3_inta_msi.c                  | 163 ++++
 include/linux/irqdomain.h                     |   1 +
 include/linux/msi.h                           |  12 +
 include/linux/soc/ti/k3_inta_msi.h            |  21 +
 include/linux/soc/ti/ti_sci_protocol.h        | 169 ++++
 kernel/irq/msi.c                              |  72 +-
 18 files changed, 2420 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 drivers/soc/ti/k3_inta_msi.c
 create mode 100644 include/linux/soc/ti/k3_inta_msi.h

-- 
2.19.1
