From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:25 -0300
Subject: [PATCH v3 00/12] MBus device tree binding
Message-ID: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current device tree binding proposal, for each MBus' child device
there's an mbus-node 'ranges' property entry, in addition to the ranges
property of the child itself.

For each of this mbus-node ranges entry, the MBus driver creates a decoding
window for it, on probe time. For instance, in the example below the
BootROM child is specified:

	soc {
		compatible = "marvell,armada370-mbus", "simple-bus";
		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
		#address-cells = <2>;
		#size-cells = <1>;

		/* The window base address is encoded in this translation */
		ranges = < ... /* other entries */
			   0x011d0000 0 0 0xfff00000 0x100000>;

		bootrom {
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x011d0000 0 0xffffffff>;
		};
	};

Notice that, since the decoding windows are allocated using the base address
and size declared in the mbus-node, it's possible to declare a 'ranges'
translation on the entire window maximum size in the children nodes.
This simplifies a bit the representation, since it concentrates the relevant
information in only one place.

The target ID and attribute are encoding in the first cell of the MBus
address space. The lower bytes are 0x0000 for entries that correspond
directly to decoding windows.

Since we also need to have valid translations for the internal register
space and the PCIe space, yet these translations do not correspond to
windows that need allocation, we choose to put a non-zero value on the
lower bytes (using 0xffff as target ID and attribute). This way the binding
skips those entries, for they don't correspond to valid windows.

In the example below there's an extract of a device tree showing how
the internal-regs and pcie nodes can be represented:

	#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))

	soc {
		compatible = "marvell,armadaxp-mbus";
		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;

		ranges = <0xffff0001 0 0 0xd0000000 0x100000   /* internal-regs */
			  0xffff0000 0 0 0xe0000000 0x8100000  /* pcie */
			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;

		bootrom {
			#address-cells = <1>;
			#size-cells = <1>;
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
			       <0x82000000 0 0x40000 0xffff0001 0x40000 0 0x00002000   /* Port 0.0 registers */
				0x82000000 0 0x42000 0xffff0001 0x42000 0 0x00002000   /* Port 2.0 registers */
				0x82000000 0 0x44000 0xffff0001 0x44000 0 0x00002000   /* Port 0.1 registers */
				0x82000000 0 0x48000 0xffff0001 0x48000 0 0x00002000   /* Port 0.2 registers */
				0x82000000 0 0x4c000 0xffff0001 0x4c000 0 0x00002000   /* Port 0.3 registers */
				0x82000000 0 0x80000 0xffff0001 0x80000 0 0x00002000   /* Port 1.0 registers */
				0x82000000 0 0x82000 0xffff0001 0x82000 0 0x00002000   /* Port 3.0 registers */
				0x82000000 0 0xe0000000 0xffff0000 0 0 0x08000000   /* non-prefetchable memory */
				0x81000000 0 0 0xffff0000 0x8000000 0 0x00100000>; /* downstream I/O */

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

In this current patchset I think we've solved every issue, so I'd like to get
some acknowledgment for inclusion in v3.11. If there's anything left to fix
or review, I'd be happy to do so!

This patchset is based on v3.10-rc4, with Jason Cooper's mvebu/regmap branch
applied, and with the mvebu-devbus commit (3edad321b1 in linux-next):
"drivers: memory: Introduce Marvell EBU Device Bus driver"

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

 * Use the preprocessor on the DT and define a macro for the window ID.

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

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 168 +++++++++
 arch/arm/boot/dts/armada-370-db.dts                |   6 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  38 ++-
 arch/arm/boot/dts/armada-370-rd.dts                |   6 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               | 103 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 110 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 |  72 ++--
 arch/arm/boot/dts/armada-xp-gp.dts                 | 107 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 209 ++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 247 +++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 379 +++++++++++----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  83 ++---
 arch/arm/boot/dts/armada-xp.dtsi                   |  11 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
 arch/arm/mach-mvebu/platsmp.c                      |   1 -
 drivers/bus/mvebu-mbus.c                           | 196 ++++++++++-
 drivers/memory/mvebu-devbus.c                      |  64 +---
 include/linux/mbus.h                               |   1 +
 18 files changed, 1061 insertions(+), 774 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
1.8.1.5
