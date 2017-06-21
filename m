From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Jun 2017 15:29:11 +0200
Subject: [PATCH v5 0/6] Add support for the ICU unit in Marvell Armada 7K/8K
Message-ID: <20170621132917.14187-1-thomas.petazzoni@free-electrons.com>
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

 - The third patch adds a driver for the GICP.

 - The fourth patch adds the driver for the ICU.

 - The fifth patch adjust Kconfig.platforms to select the GICP and ICU
   drivers.

 - The last patch adjusts the Device Tree files of the Armada 7K/8K to
   describe and use the GICP/ICU.

Changes since v4:

 - Add Acked-by from Marc Zyngier on PATCH 5/6.

 - Add Reviewed-by from Marc Zyngier on PATCH 3/6 and 4/6.

 - Also test msg->address_hi in ->write_msg()
   implementation. Suggested by Marc Zyngier.

 - Use irq_domain_get_of_node() to retrieve the device_node of the MSI
   domain. Suggested by Marc Zyngier.

 - In order to avoid a build dependency between the Device Tree
   changes and the driver changes, the DT were changed to temporarily
   not use the <dt-bindings/interrupt-controller/mvebu-icu.h>
   include. Instead, we define ICU_GRP_NSR in the two .dtsi files
   where it is needed. This can be changed during the next kernel
   release.

Changes since v3:

 - Change the API between the ICU and the GICP driver to a single
   function "int mvebu_gicp_get_doorbells(struct device_node *dn,
   phys_addr_t *setspi, phys_addr_t *clrspi). This allows the ICU
   driver to retrieve the physical addresses of the doorbell registers
   of the GICP. This API was suggested by Marc Zyngier.

 - Remove a useless "*hwirq < 0" check, since hwirq is an unsigned
   long pointer.

 - Remove a bogus "put_device()" in the ICU error path. This is no
   longer needed, since we are no longer doing a get_device() on the
   GICP. It was a bug already present in the v3.

Changes since v2:

 - Major rework of the GICP/ICU interaction, as suggested by Marc
   Zyngier. Now the GICP acts as a proper MSI controller, and the ICU
   driver is a consumer of MSIs provided by the GICP.

   Therefore, the GICP now has a "msi-controller" property in the
   Device Tree, stating it is a provider of MSIs, while the ICUs have
   a "msi-parent" property pointing to the GICP, so that they allocate
   MSIs from the GICP.

   The only remaining non-standard interaction between ICU and GICP is
   transmitting the SETSPI/CLRSPI addresses from the GICP to the
   ICU. Unfortunately, the "struct msi_msg" is only designed to carry
   a single address, while we need two. So we still have two function
   calls from ICU to the GICP to retrieve those addresses.

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

 .../bindings/interrupt-controller/marvell,gicp.txt |  27 ++
 .../bindings/interrupt-controller/marvell,icu.txt  |  51 ++++
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   7 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  59 +++--
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  55 ++--
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-mvebu-gicp.c                   | 279 ++++++++++++++++++++
 drivers/irqchip/irq-mvebu-gicp.h                   |  12 +
 drivers/irqchip/irq-mvebu-icu.c                    | 289 +++++++++++++++++++++
 .../dt-bindings/interrupt-controller/mvebu-icu.h   |  15 ++
 12 files changed, 756 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
 create mode 100644 drivers/irqchip/irq-mvebu-gicp.c
 create mode 100644 drivers/irqchip/irq-mvebu-gicp.h
 create mode 100644 drivers/irqchip/irq-mvebu-icu.c
 create mode 100644 include/dt-bindings/interrupt-controller/mvebu-icu.h

-- 
2.9.4
