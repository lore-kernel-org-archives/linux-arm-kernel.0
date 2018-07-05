From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 14:39:57 +0200
Subject: [PATCH v4 00/14] Add System Error Interrupt support to Armada SoCs
Message-ID: <20180705124011.7661-1-miquel.raynal@bootlin.com>
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


+----------------------------------------------------------------------+
|                                                                      |
|                                                                      |
|     SPIa SPIb        SPIz                    SPI 32                  |
|       ^    ^           ^                       ^                     |
|       |    |   . . .   |                       |                     |
|       |    |           |                       |                     |
|       |    |   . . .   |                       |                     |
|   +------------------------+   +---------------------------------+   |
|   |   |    |           |   |   |               |                 |   |
|   |   |    |           |   |   |   SEI         |                 |   |
|   |   |    |   . . .   |   |   |       ________|_______          |   |
|   |   |    |           |   |   |      /___SEI_SECR_____\         |   |
|   |   |____|___________|   |   |     /       |         \\        |   |
|   |    \_GICP_SETSPI _/    |   |    /        |          \\       |   |
|   |                ||      |   |   /   ...   |           \\      |   |
|   |  GICP          ||      |   |  |          |            \\     |   |
|   +----------------||------+   +--|----------|------------||-----+   |
|                    ||             |          |            ||         |
|                    ||             |    ...   |            ||         |
|                    ||             |          |            ||         |
|                    ||             |          |            ||         |
|                     \\_______   int 0  ... int 20        //          |
|                      \_NSR__ \                          //           |
|                              \\    ____________________//            |
|                               \\  /________SEI_________/             |
|   AP 806                       \\//                                  |
|                                 ||                                   |
+---------------------------------||-----------------------------------+
                                  ||
                                  || Interconnect
                                  ||\
                                  ||\\______
                                  || \______ <---> Others CP 110
                                  ||
+---------------------------------||-----------------------------------+
|                                 ||                                   |
|   CP 110                        ||                                   |
|                                 ||                                   |
|       +-------------------------||------------------------+          |
|       |                         || MSI                    |          |
|       |   ICU                   ||                        |          |
|       |         /--------------/  \------\                |          |
|       |        /      /-------/           \               |          |
|       |       /      /       /             \              |          |
|       |      /      /       /     . . .     \             |          |
|       |     /      /       /                 \            |          |
|       |   NSR     NSR     SEI               NSR           |          |
|       |    |       |       |                 |            |          |
|       +----^-------^-------^-----------------^------------+          |
|            |       |       |                 |                       |
|            |       |       |      . . .      |                       |
|            |       |       |                 |                       |
|         int 0   int 1   int 2             int 206                    |
|                                                                      |
|                                                                      |
+----------------------------------------------------------------------+


Thank you,
Miqu?l

Changes since v3:
=================
* Added an helper to create MSI tree domains.

ICU driver
----------
* Updated the code to use this helper.
* Removed the use of a regmap for the ICU subnodes.
* Squashed patches "irqchip/irq-mvebu-icu: make irq_domain local" and
  "irqchip/irq-mvebu-icu: disociate ICU and NSR".
* Fixed a regression: when using old bindings, no platform data was
  available for the NSR subset, preventing the ICU driver to probe
  correctly.
* Removed the stale comment in a commit log about using linear (instead
  of tree) domains.
* Pass a driver structure (called msi_domain) to mvebu_icu_init()
  intead of an IRQ domain from which the above structure was derived
  from.

SEI driver
----------
* Renamed the 'number' member of the mvebu_sei_interrupt_range structure
  into 'size' in the SEI driver.
* Used _relaxed accessors.
* Simplified the 'over' checking around the sei and sei->ap_domain
  pointers.
* Do not write GICP_SECR register if the irqmap read has no bit set
  (ie. nothing to clear, do not do the writel operation).
* Moved irq_set_chained_handler() and irq_set_handler_data() at the end
  of the probe.
* Simplified the chained handler with only one inner loop after having
  created a bitmap of the pending interrupts.

Changes since v2:
=================
* Rebased on top of v4.18-rc1

platform-msi:
-------------
* New patch to allow using MSI tree domains.

irqchip/irq-mvebu-sei: add new driver for  Marvell SEI
------------------------------------------------------
* Updated commit message with Marc comments
* Wrote two functions to fill ->irq_set_type() in the irq_chip
  structures, one accepting only rising edge interrupts (for MSI),
  another one accepting only high level interrupts (for wired IRQ).
* Changed the spin lock protecting the allocated SEIs bitmap into a
  mutex.
* Changed the bitmap allocation line to respect the actual number of
  MSIs instead of pretending having SEI_IRQ_COUNT (64) MSI available.
* I did not split the code to have one function per domain because it
  would duplicate a _lot_ of code. Requested some advices instead.
* Stopped using the fwnode when creating the AP (wired) IRQ domain.
* Implemented the AP IRQ domain ->match() hook.
* Used marvell,sei-xx-ranges properties to get the relevant IRQ numbers
  from DT. 'xx' is either 'ap' or 'cp'.

irqchip/irq-mvebu-icu: add support for System  Error Interrupts (SEI)
---------------------------------------------------------------------
* Added a patch to ease the creation of tree domains (changes in the
  core).
* Changed the code accordingly to use tree domains.
* Created a couple of helpers to do the bitmap allocation/release.
* Removed the .offset_clr_a[hl] entries of the sei_subset_data
  structure to avoid confusion. These registers actually exist, but
  are not used here because the upper block (SEI) only supports
  edge-MSI and not level-MSI like the NSR one.

dt-bindings/interrupt-controller: update  Marvell ICU bindings
--------------------------------------------------------------
* Explained better in the commit message that backward compatibility
  is not broken.
* Changed subnodes names to be 'interrupt-controller' as requested.
* Added a range associated to each sub-node (as well as in the DT).
* Replaced spaces by tabs.
* Merged the SEI's subnodes so that there is only one SEI node and no
  subnodes anymore.

Changes since v1:
=================
General
-------
* Spelling/function names/comments.
* Added Reviewed-by tags.
* Rebased on top of Marc Zyngier level-MSI series (tip:irq/core).

SEI
---
* Change the license for GPL-2.0 only in irq-mvebu-sei.c C file.
* Used alphabetic ordering when adding SEI driver in Makefile.
* Re-ordered register definitions by increasing offset.
* s/NB/COUNT/ in register definitions.
* avoid enabling all interrupt by default.
* fixed mask/unmask functions using the wrong hwirq number.
* removed hackish doorbell mechanism.
* Removed the ->xlate hook assigned for CP MSIs.
* Used devm_*() helpers.
* s/top_level_spi/parent_irq/ in probe.
* Added forgotten of_node_put(child).
* Reset the SEI registers before registering the IRQ domains.
* Introduced new DT property "marvell,sei-ranges" instead of using
  "reg" to declare the range of MSI interrupts vs. wired interrupts in
  the SEI subnodes.
* Finally did not change the ->alloc() about the fwspec->param[1]
  line (to be checked by Marc).

ICU
---
* Updated the ICU documentation so the legacy bindings are still
  documented somewhere.
* Added stable tags on the commit fixing the CP110 ICU node size.
* Removed the "syscon" compatible from the ICU node, instead the
  syscon is created at probe time.
* s/user data/private data/ in the title of commit
  "irqchip/irq-mvebu-icu: fix wrong user data retrieval"


Marc Zyngier (1):
  genirq/msi: Allow creation of a tree-based irqdomain for platform-msi

Miquel Raynal (13):
  dt-bindings/interrupt-controller: fix Marvell ICU length in the
    example
  irqchip/irq-mvebu-icu: fix wrong private data retrieval
  irqchip/irq-mvebu-icu: clarify the reset operation of configured
    interrupts
  irqchip/irq-mvebu-icu: disociate ICU and NSR
  irqchip/irq-mvebu-icu: support ICU subnodes
  irqchip/irq-mvebu-sei: add new driver for Marvell SEI
  arm64: marvell: enable SEI driver
  irqchip/irq-mvebu-icu: add support for System Error Interrupts (SEI)
  dt-bindings/interrupt-controller: update Marvell ICU bindings
  dt-bindings/interrupt-controller: add documentation for Marvell SEI
    controller
  arm64: dts: marvell: add AP806 SEI subnode
  arm64: dts: marvell: use new bindings for CP110 interrupts
  arm64: dts: marvell: add CP110 ICU SEI subnode

 .../bindings/interrupt-controller/marvell,icu.txt  |  85 +++-
 .../bindings/interrupt-controller/marvell,sei.txt  |  39 ++
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  11 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 125 +++---
 drivers/base/platform-msi.c                        |  14 +-
 drivers/irqchip/Kconfig                            |   3 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-mvebu-icu.c                    | 259 +++++++++---
 drivers/irqchip/irq-mvebu-sei.c                    | 440 +++++++++++++++++++++
 include/linux/msi.h                                |  17 +-
 11 files changed, 863 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
 create mode 100644 drivers/irqchip/irq-mvebu-sei.c

-- 
2.14.1
