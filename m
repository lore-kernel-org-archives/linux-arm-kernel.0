From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Mar 2013 09:54:20 -0300
Subject: [PATCH 0/5] Device Bus support for Marvell EBU SoC
Message-ID: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mbus driver has been introduced to allocate address
decoding windows it's possible to introduce the Device Bus driver.
This driver allows to access several memories and I/O devices
such as NOR, NAND, SRAM and FPGAs.

Currently the SoCs that include this Device Bus controller are:

  * Discovery:    mv78100, mv78200
  * Armada XP:    mv78230, mv78260, mv78460
  * Armada 370:   88f6710. 88f6707, 88f6w11
  * Orion 5x:     88f5182, 88f5181, 88f5281

Please note that this patchset adds proper support for
Discovery, Armada XP and Armada 370 SoC only.

Although these SoC allow to dynamically choose a base address for the child
device within the entire address space (because of flexible and dynamic
address decoding windows) this feature is still not implemented and it's
required to specify such a base address in each child's device tree node.

This applies on top of Thomas Petazzoni series for Marvell EBU mbus driver.
(see http://comments.gmane.org/gmane.linux.ports.arm.kernel/221198)

In fact this patchset is not entirely dependent on the mbus implementation,
but only in the mbus public API:

  int mvebu_mbus_add_window(const char *devname, phys_addr_t base, size_t size);
  int mvebu_mbus_del_window(phys_addr_t base, size_t size);

Given there has been some discussions regarding the mbus driver DT binding
and the way to describe address windows, it's worth mentioning that this
patchset proposes a way to easily handle address decoding windows for the
devices controlled by the Device Bus (NOR, NAND, etc.).

The windows are created based in the 'ranges' property present in the
device bus node:

	device-bus at d0010400 {

		ranges = <0 0 0xf0000000 0x8000000>;
		/* ... */
	}

For instance, in the above example, when the device bus driver finds a child
node for chip select '0', he will request the mbus driver to allocate a window
as described by the 'ranges' property, starting at address 0xf0000000.

If we want to upgrade this behavior and support dynamically allocated windows,
we can simply fix the device bus driver to find a suitable address when
there is no 'ranges' property for that chip select.

Therefore we see that the current bindings (both mbus and device bus) are
perfectly suitable to handle both static and dynamic windows
for devices such as NOR, NAND, etc.

Tested on an Armada XP GP board and Plathome Openblocks AX3.
Any further testing and feedback will be greatly appreciated!

Ezequiel Garcia (5):
  drivers: memory: Introduce Marvell EBU Device Bus driver
  ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
  ARM: mvebu: Add support for NOR flash device on Armada XP-GP board
  ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board
  ARM: mvebu: Update defconfig to select Device Bus (memory-controller)
    support

 .../bindings/memory-controllers/orion-devbus.txt   |  150 ++++++++++
 arch/arm/boot/dts/armada-370.dtsi                  |    7 +
 arch/arm/boot/dts/armada-xp-gp.dts                 |   12 +
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   12 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    7 +
 arch/arm/configs/mvebu_defconfig                   |    2 +
 drivers/memory/Kconfig                             |   11 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/mvebu-devbus.c                      |  296 ++++++++++++++++++++
 9 files changed, 498 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/orion-devbus.txt
 create mode 100644 drivers/memory/mvebu-devbus.c

-- 
1.7.8.6
