From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 17:07:14 -0300
Subject: [PATCH v4 00/12] MBus device tree binding
Message-ID: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the previous version of this patchset for further context:

http://www.spinics.net/lists/arm-kernel/msg252656.html

In the current patchset, the proposal is slightly different.
As an example of the current status, here's an extract of a device tree:

	#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))

	soc {
		compatible = "marvell,armadaxp-mbus";
		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;

		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000   /* internal-regs */
			  MBUS_ID(0xf0, 0x02) 0xe0000000 0 0xe0000000 0x8100000  /* pcie */
			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;

		bootrom {
			compatible = "marvell,bootrom";
			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>
		};

		devbus-bootcs {
			status = "okay";

			/* NOR */
			nor {
				compatible = "cfi-flash";
				reg = <0 0x8000000>;
				bank-width = <2>;
			};
		};

		pcie-controller {
			compatible = "marvell,armada-xp-pcie";
			status = "okay";
			device_type = "pci";

			#address-cells = <3>;
			#size-cells = <2>;

			ranges =
			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
				0x82000000 0 0xe0000000 MBUS_ID(0xf0, 0x02) 0xe0000000 0 0x08000000   /* non-prefetchable memory */
				0x81000000 0 0 MBUS_ID(0xf0, 0x02) 0xe8000000 0 0x00100000>; /* downstream I/O */

			pcie at 1,0 {
				/* Port 0, Lane 0 */
				status = "okay";
			};
		};

		internal-regs {
			compatible = "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			...
		};
	};

This patchset is based on v3.10-rc4, with Jason Cooper's mvebu/regmap branch
applied, and with the mvebu-devbus commit (3edad321b1 in linux-next):
"drivers: memory: Introduce Marvell EBU Device Bus driver"

Changes from v3:
 * Fixed the pcie-controller to mbus address space translations, to match
   a 1:1 mapping between the PCI and CPU busses.

 * Fixed the binding documentation with suggestions from Arnd Bergmann.

 * Added a BootROM sanity check on AXP SMP initialization, as suggested
   by Jason Gunthorpe. This also implied changing slightly the bootrom
   node.

 * Changed the first cell format for the MBus address space.

Changes from v2:
 * Replaced the PCIe mapping with 0xffff0002, to avoid using a representation
   that might correspond to a possible window id.

 * Remove every mbus-node 'ranges' property from the dtsi files. Having them
   on the per-board dts files only makes maintaince less painful.

 * Declare children window size, in the children 'ranges' property, as large
   as possible (4 GiB size) and move the property to the dtsi files.
   The per-board dts, does not need to declare that property now.
 
 * The MBus driver now creates the decoding window using the base address and
   size specified in the mbus-node, instead of using the children entries.

Change from v1:
 * Changed the way the address spaces were declared: the window's base
   addresses are only present in the mbus-node ranges property.
   This makes sense since that information belongs only to the MBus
   address space.

 * Drop the ranges dynamic update, since now the DT translations are complete.
 
 * Replaced the internal register first cell mapping with 0xffff0001, to avoid
   clashing when using 0x00000000.

 * Replaced the PCIe mapping with 0xffff0000.

Thanks a lot!


Ezequiel Garcia (12):
  bus: mvebu-mbus: Factor out initialization details
  bus: mvebu-mbus: Introduce device tree binding
  bus: mvebu-mbus: Add static window allocation to the DT binding
  ARM: mvebu: Initialize MBus using the DT binding
  ARM: mvebu: Remove the harcoded BootROM window allocation
  memory: mvebu-devbus: Remove address decoding window workaround
  ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
  ARM: mvebu: Add MBus to Armada 370/XP device tree
  ARM: mvebu: Add BootROM to Armada 370/XP device tree
  ARM: mvebu: Relocate Armada 370/XP DeviceBus device tree nodes
  ARM: mvebu: Relocate Armada 370 PCIe device tree nodes
  ARM: mvebu: Relocate Armada XP PCIe device tree nodes

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 203 +++++++++++
 arch/arm/boot/dts/armada-370-db.dts                |   5 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  38 ++-
 arch/arm/boot/dts/armada-370-rd.dts                |   5 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               | 103 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 109 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 |  72 ++--
 arch/arm/boot/dts/armada-xp-gp.dts                 | 107 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 209 ++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 247 +++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 379 +++++++++++----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  83 ++---
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
 arch/arm/mach-mvebu/platsmp.c                      |  25 +-
 drivers/bus/mvebu-mbus.c                           | 196 ++++++++++-
 drivers/memory/mvebu-devbus.c                      |  64 +---
 include/linux/mbus.h                               |   1 +
 18 files changed, 1116 insertions(+), 774 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
1.8.1.5
