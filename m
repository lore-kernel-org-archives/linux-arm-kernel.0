From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  8 Apr 2013 08:06:29 -0300
Subject: [PATCH v4 0/5] Device Bus support for Marvell EBU SoC
Message-ID: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset continues the effort to add Device Bus support
on Marvell EBU SoC.

If you're reading this for the first time you can grab the full details here:

  http://www.spinics.net/lists/arm-kernel/msg236151.html

This new version changes the way each chip select is described in the DT.
Now there's a separate node for each Device Bus chip select, like this:

	devbus-bootcs at d0010400 {
		compatible = "marvell,mvebu-devbus";
		reg = <0xd0010400 0x8>;
		ranges = <0 0 0xf0000000 0x8000000>; /* CS0 @addr 0xf000000, size 0x8000000 */

		device at 0 {
			reg = <0 0 0x8000000>;
		}
	};

	// ...

	devbus-cs1 at d0010410 {
		compatible = "marvell,mvebu-devbus";
		reg = <0xd0010410 0x8>;
	};

In particular, please note that once the window handling is properly added
to the DT, and we remove the mbus usage from this driver, in the above DT nodes
the ranges property value will have to be changed, but the ABI will be the same.

This applies on top of v3.9-rc5 with mbus patches applied, which can 
be found in Jason Cooper's mvebus/soc branch.
If anyone wants to try this, there's a public branch available at:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/mvebu-devbus-v4

How does this version look regarding its inclusion in v3.10?
@Jason, @Arnd: if you think this v4 meets your expectation,
I'd like to have your Ack so I can ask Jason Cooper to apply this.

If the driver looks good and the temporary window handling is accepted,
then I can prepare a rebased patchset on top of Gregory's LPAE work,
or on top of any other required patches.

Changes from v3:

  * Rename devbus,dev-width to devbus,bus-width and changed the
    parameter value from bytes to bits: <8>, <16>, ...
    Suggested by Arnd Bergmann.

  * As suggested by Jason Gunthorpe and agreed by Arnd Bergmann.
    Reworked the whole devbus child chip-select device tree design.
    Now there's a separate devbus at addr DT node for each controller
    chip select. The impact of this is:
      1. Timing parameters now go into the parent node.
      2. There can only be one child per devbus node.

  * Remove unneeded bank-width parameter read.

Changes from v2:

  * Replace the 'NOR' specific probe by a generic probe.
    Currently, we don't see anything specific to NOR in this driver.
    Suggested by Jason Gunthorpe.

  * Add a check to detect that every timing parameter is specified
    in the device tree node.
    Suggested by Jason Gunthorpe.

Changes from v1:

  * Added a remove() function to unregister childs and remove address windows,
    as suggested by Thomas Petazzoni.

  * Remove unneeded 'inline' prefix on functions as suggested by Thomas Petazzoni.

  * Timings parameters are now mandatory and expressed in picoseconds,
    as requested by Jason Gunthorpe.
    This is consistent with OMAP's GPMC dts binding.

  * Fix documentation as suggested by Jason Gunthorpe.

Thanks!

Ezequiel Garcia (5):
  drivers: memory: Introduce Marvell EBU Device Bus driver
  ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
  ARM: mvebu: Add support for NOR flash device on Armada XP-GP board
  ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board
  ARM: mvebu: Add Device Bus and CFI flash memory support to defconfig

 .../bindings/memory-controllers/mvebu-devbus.txt   | 156 ++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  45 +++
 arch/arm/boot/dts/armada-xp-gp.dts                 |  29 ++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  29 ++
 arch/arm/configs/mvebu_defconfig                   |   7 +
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mvebu-devbus.c                      | 344 +++++++++++++++++++++
 8 files changed, 621 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
 create mode 100644 drivers/memory/mvebu-devbus.c

-- 
1.8.1.5
