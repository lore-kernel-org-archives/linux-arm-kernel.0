From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 15:55:20 +0200
Subject: [PATCH 00/17] Add System Error Interrupt support to Armada SoCs
Message-ID: <20180421135537.24716-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICU is an IRQ chip found in Armada CP110. It currently has 207 wired
inputs. Its purpose is to aggregate all CP interrupts and report them to
the AP through MSIs. The ICU writes into GIC registers (AP side) by way
of the interconnect. These interrupts can be of several groups:
- SecuRe (SR);
- Non-SecuRe (NSR);
- System Error Interrupts (SEI);
- RAM Error Interrupts (REI);
- ...
Each ICU wired interrupt can be of any of these groups. The group is
encoded in the MSI payload.

Until now, only the non-secure interrupts (NSR) were handled by the ICU
driver. Interrupts of another group could work by chance because the
ICU driver does not erase all ATF configuration; it only erases the
configuration for NSR interrupts.

This series aims at adding support for the System Error Interrupts
(SEI). For this purpose, the ICU driver is a bit reworked to separate
the ICU 'generic' configuration from the NSR-related handling. Then,
the SEI driver (part of the GIC) is introduced and finally, support for
SEI interrupts are also added to the ICU driver.

The SEI driver is a bit different than its cousin the GICP because it
must handle MSIs from the CPs, as well as wired interrupts from the AP
itself. MSIs and wired interrupts will automatically update two
registers (GICP_SECR0/GICP_SECR1) that will trigger a single top-level
interrupt (SPI #32).

As this is my first contribution in the IRQ subsystem I might have
missed some specificities or misunderstood the API, please do not
hesitate to correct me if I'm wrong.

Also, for the sake of understandability (and because I love ASCII art),
this is a try to explain the ICU/SEI architecture:


 ---------------------------------------------------------------------
/                                                                      \
|                                                                      |
|     SPIa SPIb        SPIz                    SPI 32                  |
|       ^    ^           ^                       ^                     |
|       |    |   . . .   |                       |                     |
|  ------------------------------------------------------------------  |
| /     |    |           |                       |                   \ |
| |     |    |   . . .   |                       |                   | |
| |  ------------------------     ---------------------------------  | |
| | /   |    |           |   \   /               |                 \ | |
| | |   |    |           |   |   |   SEI         |                 | | |
| | |   |    |   . . .   |   |   |       ________|_______          | | |
| | |   |    |           |   |   |      /___SEI_SECR_____\         | | |
| | |   |____|___________|   |   |     /       |         \\        | | |
| | |    \_GICP_SETSPI _/    |   |    /        |          \\       | | |
| | |                ||      |   |   /   ...   |           \\      | | |
| | \  GICP          ||      /   \  |          |            \\     / | |
| |  ----------------||------     --|----------|------------||-----  | |
| |                  ||             |          |            ||       | |
| \   GIC            ||             |    ...   |            ||       / |
|  ------------------||-------------^----------^------------||-------  |
|                    ||             |          |            ||         |
|                     \\_______   int 0  ... int 20        //          |
|                      \_NSR__ \                          //           |
|                              \\    ____________________//            |
|                               \\  /________SEI_________/             |
|   AP 806                       \\//                                  |
\                                 ||                                   /
 ---------------------------------||-----------------------------------
                                  ||
                                  || Interconnect
                                  ||\
                                  ||\\______
                                  || \______ <---> Others CP 110
                                  ||
 ---------------------------------||----------------------------------
/                                 ||                                   \
|   CP 110                        ||                                   |
|                                 ||                                   |
|        -------------------------||------------------------           |
|       /                         || MSI                    \          |
|       |   ICU                   ||                        |          |
|       |         /--------------/  \------\                |          |
|       |        /      /-------/           \               |          |
|       |       /      /       /             \              |          |
|       |      /      /       /     . . .     \             |          |
|       |     /      /       /                 \            |          |
|       |   NSR     NSR     SEI               NSR           |          |
|       \    |       |       |                 |            /          |
|        ----^-------^-------^-----------------^------------           |
|            |       |       |                 |                       |
|            |       |       |      . . .      |                       |
|            |       |       |                 |                       |
|         int 0   int 1   int 2             int 206                    |
|                                                                      |
\                                                                      /
 ----------------------------------------------------------------------



Thank you,
Miqu?l


Miquel Raynal (17):
  dt-bindings/interrupt-controller: fix Marvell ICU length in the
    example
  arm64: dts: marvell: fix CP110 ICU node size
  arm64: dts: marvell: add syscon compatible to CP110 ICU node
  irqchip/irq-mvebu-icu: fix wrong user data retrieval
  irqchip/irq-mvebu-icu: clarify the reset operation of configured
    interrupts
  irqchip/irq-mvebu-icu: switch to regmap
  irqchip/irq-mvebu-icu: make irq_domain local
  irqchip/irq-mvebu-icu: disociate ICU and NSR
  irqchip/irq-mvebu-icu: support ICU subnodes
  irqchip/irq-mvebu-sei: add new driver for Marvell SEI
  arm64: marvell: enable SEI driver
  irqchip/irq-mvebu-icu: add support for System Error Interrupts (SEI)
  dt-bindings/interrupt-controller: update Marvell ICU bindings
  dt-bindings/interrupt-controller: add description for Marvell SEI node
  arm64: dts: marvell: add AP806 SEI subnode
  arm64: dts: marvell: use new bindings for CP110 interrupts
  arm64: dts: marvell: add CP110 ICU SEI subnode

 .../bindings/interrupt-controller/marvell,icu.txt  |  62 ++-
 .../bindings/interrupt-controller/marvell,sei.txt  |  54 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  19 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 125 +++---
 drivers/irqchip/Kconfig                            |   3 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-mvebu-icu.c                    | 294 ++++++++++----
 drivers/irqchip/irq-mvebu-sei.c                    | 449 +++++++++++++++++++++
 drivers/irqchip/irq-mvebu-sei.h                    |  12 +
 10 files changed, 877 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
 create mode 100644 drivers/irqchip/irq-mvebu-sei.c
 create mode 100644 drivers/irqchip/irq-mvebu-sei.h

-- 
2.14.1
