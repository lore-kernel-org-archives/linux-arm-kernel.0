From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 14 Jun 2013 13:07:40 -0300
Subject: [RFC v2 00/12] MBus device tree binding
Message-ID: <1371226072-28896-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the v2 of the MBus driver patchset. A considerable re-work has been
made to the DT layout proposed in the previous patchset, as a result of
the recent discussion [1].

[1] http://www.spinics.net/lists/arm-kernel/msg249496.html

In the current device tree binding proposal, for each MBus' child device
there's a mbus-node 'ranges' property entry, in addition to the ranges
property of the child itself.

If the child is avaiable (i.e. status not 'disabled'), then the MBus driver
creates a decoding window for it, on probe time.
For instance, in the example below the BootROM child is specified:

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
			ranges = <0 0x011d0000 0 0x100000>;
		};
	};

The target ID and attribute are encoding in the first cell of the MBus
address space. The lower bytes are 0x0000 for entries that correspond
directly to decoding windows.

Since we also need to have valid translations for the internal register
space and the PCIe space, yet these translations do not correspond to
windows that need allocation, we choose to put 0xffff as target ID
and attribute, and use the lower bytes to allow different translations.

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
			ranges = <0 MBUS_ID(0x01, 0x1d) 0 0x100000>;
		};

		devbus-bootcs {
			status = "okay";
			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x8000000>;

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
			ranges = <0 0xffff0001 0 0x100000>;

			interrupt-controller at 20000 {
			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
			};
		};
	};

This binding is by no means complete. I'm sending this v2 merely to see how
things are going and receieve further feedback to continue the discussion.

The mbus driver itself can/will be fixed to change the way it creates the
windows from the information in the DT. However I expect this can be done
independently of the device tree itself, so I'd like to focus in the latter
for now and reach an agreement about how the DT binding should be.

This patchset is based on v3.10-rc4, with Jason Cooper's mvebu/regmap branch
applied, and with the mvebu-devbus commit (3edad321b1 in linux-next):
"drivers: memory: Introduce Marvell EBU Device Bus driver"

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

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 161 +++++++++
 arch/arm/boot/dts/armada-370-db.dts                |   2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  34 +-
 arch/arm/boot/dts/armada-370-rd.dts                |   2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  98 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 113 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 |  68 ++--
 arch/arm/boot/dts/armada-xp-gp.dts                 | 108 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 209 ++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 247 +++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 379 +++++++++++----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  84 ++---
 arch/arm/boot/dts/armada-xp.dtsi                   |  13 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
 arch/arm/mach-mvebu/platsmp.c                      |   1 -
 drivers/bus/mvebu-mbus.c                           | 194 ++++++++++-
 drivers/memory/mvebu-devbus.c                      |  64 +---
 include/linux/mbus.h                               |   1 +
 18 files changed, 1038 insertions(+), 774 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
1.8.1.5
