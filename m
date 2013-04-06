From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat,  6 Apr 2013 08:15:25 -0300
Subject: [PATCH v3 0/5] Device Bus support for Marvell EBU SoC
Message-ID: <1365246930-13315-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mbus driver has been added to manage address decoding
windows it's possible to introduce the Device Bus driver.
This driver allows to access several memories and I/O devices
such as NOR, NAND, SRAM and FPGAs.

Currently the SoCs that include this Device Bus controller are:

  * Discovery:    mv78100, mv78200
  * Armada XP:    mv78230, mv78260, mv78460
  * Armada 370:   88f6710. 88f6707, 88f6w11
  * Orion 5x:     88f5182, 88f5181, 88f5281

Please note that this patchset adds proper support for
Armada XP and Armada 370 SoC only.

This applies on top of v3.9-rc5 with mbus patches applied, which can 
be found in Jason Cooper's mvebus/soc branch.
If anyone wants to try this, there's a public branch available at:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/mvebu-devbus-v3

There has been a 'byzantine' discussion regarding the mbus driver DT binding
and the way to describe address windows, and this discussion is still not
settled.

However, since I'd like to see this in v3.10, and the only thing left
to solve seems to be the device tree binding for the mbus window,
this current patchset attempts a temporary workaround.

The decoding windows are handled by the devbus driver, through the mbus API,
using the information present in the 'ranges' property. For instance:

	device-bus at d0010400 {

		ranges = <0 0 0xf0000000 0x8000000>;
		/* ... */
	}

In the above example, when the device bus driver finds a child
node for chip select '0', it will request the mbus driver to allocate a window
as described by the 'ranges' property, starting at address 0xf0000000.

As this approach has been explicitly rejected by the maintainers,
it will be completely removed as soon as the mbus bindings are decided
and the address windows are statically describe in the dts files.

Tested on an Armada XP GP board and Plathome Openblocks AX3.

In particular I'd like to know what's the chance of having this included
for v3.10. If the driver looks good and the temporary window handling
is accepted, then I can prepare a rebased patchset on top of Gregory's
LPAE work, or on top of any other required patches.

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

 .../bindings/memory-controllers/mvebu-devbus.txt   | 157 +++++++++
 arch/arm/boot/dts/armada-370.dtsi                  |   8 +
 arch/arm/boot/dts/armada-xp-gp.dts                 |  29 ++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  29 ++
 arch/arm/boot/dts/armada-xp.dtsi                   |   8 +
 arch/arm/configs/mvebu_defconfig                   |   7 +
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mvebu-devbus.c                      | 383 +++++++++++++++++++++
 9 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
 create mode 100644 drivers/memory/mvebu-devbus.c

-- 
1.8.1.5
