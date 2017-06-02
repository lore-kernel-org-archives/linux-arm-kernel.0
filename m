From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  2 Jun 2017 12:06:51 +0200
Subject: [PATCH v2 0/6] Add support for the ICU unit in Marvell Armada 7K/8K
Message-ID: <1496398017-6487-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The Marvell Armada 7K/8K SoCs are composed of two parts: the AP (which
contains the CPU cores) and the CP (which contains most
peripherals). The 7K SoCs have one CP, while the 8K SoCs have two CPs,
doubling the number of available peripherals.

In terms of interrupt handling, all devices in the CPs are connected
through wired interrupt to a unit called ICU located in each CP. This
unit converts the wired interrupts from the devices into memory
transactions.

Inside the AP, there is a GIC extension called GICP, which allows a
memory write transaction to trigger a GIC SPI interrupt. The ICUs in
each CP are therefore configured to trigger a memory write into the
appropriate GICP register so that a wired interrupt from a CP device
is converted into a memory write, itself converted into a regular GIC
SPI interrupt.

Until now, the configuration of the ICU was done statically by the
firmware, and therefore the Device Tree files in Linux were specifying
directly GIC interrupts for the interrupts of CP devices. However,
with the growing number of devices in the CP, a static allocation
scheme doesn't work for the long term.

This patch series therefore makes Linux aware of the ICU: GIC SPI
interrupts are dynamically allocated, and the ICU is configured
accordingly to route a CP wired interrupt to the allocated GIC SPI
interrupt.

In detail:

 - The first two patches are the Device Tree binding patches

 - The third patch is a minimal driver for the GICP unit, which simply
   allows to allocate GICP interrupts.

 - The fourth patch is the most important done, which adds the driver
   for the ICU itself.

 - The fifth patch adjust Kconfig.platforms to select the GICP and ICU
   drivers.

 - The last patch adjusts the Device Tree files of the Armada 7K/8K to
   use the ICU.

Changes since v1:

 - Fix the #interrupt-cells value in the ICU DT binding
   example. Pointed by Marc Zyngier.

 - Add details about the possible group types in the ICU DT binding
   documentation, as requested by Marc Zyngier. This allowed to
   discover that the list of types listed was not matching the macros
   provided in <dt-bindings/interrupt-controller/mvebu-icu.h>, so this
   was fixed as well.

 - Changed the "gicp" property of the ICU to "marvell,gicp", as
   suggested by Marc Zyngier.

 - Add a marvell,spi-ranges property to the gicp node, which defines
   which ranges of GIC SPI interrupts are available for us by the
   GICP.

 - Move more GICP logic into the gicp driver. Indeed, it was confusing
   to have in the ICU driver some global logic mixed with per-ICU
   logic: there is only one GICP per system, but one ICU per CP (so in
   an Armada 8K we have one GICP but two ICUs). So it makes more sense
   to handle the GICP aspects in one driver (which has only one
   device) and the ICU aspects in another driver (which has one device
   per ICU).

 - Use writel_relaxed() as suggested by Marc Zyngier.

 - Use irq_set_irqchip_state() in the ICU driver to clear any pending
   interrupt when allocating an interrupt. This ensures we don't get
   bothered by an interrupt left pending by the firmware. This
   replaces a more manual pending interrupt clearing done in the GICP
   driver, which wasn't suitable for edge triggered
   interrupts. Suggested by Marc Zyngier.

 - Use devm_kstrdup() instead of kstrdup() to fix a potential memory
   leak in the error path of ICU's ->probe() function. Noticed by Marc
   Zyngier.

 - Change compatible strings from "marvell,gicp" to
   "marvell,ap806-gicp" and "marvell,icu" to "marvell,cp110-icu", as
   future versions of those IP blocks may be different. Suggested by
   Yehuda Yitschak.

 - Use a shorter name for the irqchip domain, suggested by Gr?gory
   Clement.

 - Rename ICU_{SATA0,SATA1}_IRQ_INT to ICU_{SATA0,SATA1}_ICU_ID to
   clarify we're talking about ICU identifiers and not interrupt
   numbers. Suggested by Yehuda Yitschak.

 - Fix bogus message when checking the ICU group type, make sure the
   message says "wrong ICU group type" and not "wrong ICU
   type". Suggested by Yehuda Yitschak.

 - Add a check that the ICU identifier used in the DT is not higher
   than ICU_MAX_IRQS. Suggested by Yehuda Yitschak.

Best regards,

Thomas


Thomas Petazzoni (6):
  dt-bindings: interrupt-controller: add DT binding for the Marvell GICP
  dt-bindings: interrupt-controller: add DT binding for the Marvell ICU
  irqchip: irq-mvebu-gicp: new driver for Marvell GICP
  irqchip: irq-mvebu-icu: new driver for Marvell ICU
  arm64: marvell: enable ICU and GICP drivers
  arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K

 .../bindings/interrupt-controller/marvell,gicp.txt |  24 ++
 .../bindings/interrupt-controller/marvell,icu.txt  |  54 ++++
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   6 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  60 ++--
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  54 ++--
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-mvebu-gicp.c                   | 170 ++++++++++
 drivers/irqchip/irq-mvebu-gicp.h                   |  15 +
 drivers/irqchip/irq-mvebu-icu.c                    | 346 +++++++++++++++++++++
 .../dt-bindings/interrupt-controller/mvebu-icu.h   |  15 +
 12 files changed, 706 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
 create mode 100644 drivers/irqchip/irq-mvebu-gicp.c
 create mode 100644 drivers/irqchip/irq-mvebu-gicp.h
 create mode 100644 drivers/irqchip/irq-mvebu-icu.c
 create mode 100644 include/dt-bindings/interrupt-controller/mvebu-icu.h

-- 
2.7.4
