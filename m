From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  9 Jul 2013 13:41:02 -0300
Subject: [PATCH v7 00/22] MBus DT binding: The return of PCIe
Message-ID: <1373388084-29520-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the new MBus DT binding, implementing the changes proposed
by Thomas when we discussed the previous patchset:

  http://www.spinics.net/lists/arm-kernel/msg257170.html

As far as I know, this round fixes *all* the concerns raised in the past
and therefore I'd like to get Acked-by's from all the parties involved
on the respective patches.

If there's anything left to review, we'll be glad to fix it quickly,
so don't hesitate in providing your feedback!

I guess many of you are dying to test this new MBus thing, so to make
it easier for those courageous enough, I've pushed a public branch:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/marvell-mvebu-mbus-v7

@Jason:

As previously agreed this should be taken by you entirely.

The patchset is based on linux-next next-20130705 and will probably
apply with no conflicts to v3.11-rc1. I'll rebase it and resend it
on v3.11-rc1 if you need me to.

Changelog
---------

v7:

 * Add two optional properties pcie-{mem,io}-aperture to the MBus node
   defining the PCIe mem and IO region apertures.

 * Encode the PCIe port in the second cell of the ranges entries, using
   the PCIe slot; and remove such encoding from the first cell, since it
   was violating the specification.

   Quoting Jason Gunthorpe:
   """ [...] the OF spec says that the phys.hi fields of the child address
   spaces in the "ranges" property for PCI does not contain the same
   information as "reg" property entries within PCI nodes. The only information
   that is present in "ranges" phys.hi entries are the non-relocatable,
   prefetchable and the PCI address space bits for which the entry applies.
   I.e., only the n, p and ss bits are present; the bbbbbbbb, ddddd, fff and
   rrrrrrrr fields are 0."""

v6:

 * Change the PCIe ranges translations encoding, removing the big fake
   window encoded as MBUS_ID(0xf0, 0x02) by an array of entries representing
   the PCIe real windows with full 4 GiB size.

 * The corresponding PCIe port is selected by encoding the bus in the first cell
   of the PCIe controller node ranges entry.

 * Remove the name-based MBus window allocation API, replacing it by an
   ID-based API.

v5:

 * Add a required a 'controller' property to specify a phandle containing
   the MBus controller MMIO registers.

v4:

 * Fixed the pcie-controller to mbus address space translations, to match
   a 1:1 mapping between the PCI and CPU busses.

 * Fixed the binding documentation with suggestions from Arnd Bergmann.

 * Added a BootROM sanity check on AXP SMP initialization, as suggested
   by Jason Gunthorpe. This also implied changing slightly the bootrom
   node.

 * Changed the first cell format for the MBus address space.

v3:

 * Replaced the PCIe mapping with 0xffff0002, to avoid using a representation
   that might correspond to a possible window id.

 * Remove every mbus-node 'ranges' property from the dtsi files. Having them
   on the per-board dts files only makes maintaince less painful.

 * Declare children window size, in the children 'ranges' property, as large
   as possible (4 GiB size) and move the property to the dtsi files.
   The per-board dts, does not need to declare that property now.

 * The MBus driver now creates the decoding window using the base address and
   size specified in the mbus-node, instead of using the children entries.

v2:

 * Use the preprocessor on the DT and define a macro for the window ID.

 * Changed the way the address spaces were declared: the window's base
   addresses are only present in the mbus-node ranges property.
   This makes sense since that information belongs only to the MBus
   address space.

 * Drop the ranges dynamic update, since now the DT translations are complete.

 * Replaced the internal register first cell mapping with 0xffff0001, to avoid
   clashing when using 0x00000000.

 * Replaced the PCIe mapping with 0xffff0000.

v1:

  * Initial proposal

Example
-------

Here's an example showing how the MBus DT binding looks now:

soc {
	compatible = "marvell,armadaxp-mbus", "simple-bus";
	controller = <&mbusc>;
	pcie-mem-aperture = <0xe0000000 0x8000000>;
	pcie-io-aperture  = <0xe8000000 0x100000>;

	ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000   /* internal-regs */
		  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
		  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;

	bootrom {
		compatible = "marvell,bootrom";
		reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
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
			<0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
			0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
			0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
			0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
			0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
			0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
			0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO */
			0x82000000 0x2 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
			0x81000000 0x2 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO */>;


		pcie at 1,0 {
			device_type = "pci";
			assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
			reg = <0x0800 0 0 0 0>;
			#address-cells = <3>;
			#size-cells = <2>;
			#interrupt-cells = <1>;
			ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
				  0x81000000 0 0 0x81000000 0x1 0 1 0>;
			interrupt-map-mask = <0 0 0 0>;
			interrupt-map = <0 0 0 0 &mpic 58>;
			marvell,pcie-port = <0>;
			marvell,pcie-lane = <0>;
			clocks = <&gateclk 5>;
			status = "disabled";
		};

		pcie at 2,0 {
			device_type = "pci";
			assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
			reg = <0x1000 0 0 0 0>;
			#address-cells = <3>;
			#size-cells = <2>;
			#interrupt-cells = <1>;
			ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
				  0x81000000 0 0 0x81000000 0x2 0 1 0>;
			interrupt-map-mask = <0 0 0 0>;
			interrupt-map = <0 0 0 0 &mpic 62>;
			marvell,pcie-port = <1>;
			marvell,pcie-lane = <0>;
			clocks = <&gateclk 9>;
			status = "disabled";
		};
	};

	internal-regs {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;

		mbusc: mbus-controller at 20000 {
			reg = <0x20000 0x100>, <0x20180 0x20>;
		};

		interrupt-controller at 20000 {
			reg = <0x20a00 0x2d0>, <0x21070 0x58>;
		};
	};
};

Ezequiel Garcia (12):
  memory: mvebu-devbus: Remove address decoding window workaround
  bus: mvebu-mbus: Factor out initialization details
  bus: mvebu-mbus: Introduce device tree binding
  bus: mvebu-mbus: Add static window allocation to the DT binding
  bus: mvebu-mbus: Add new API for the PCIe memory and IO aperture
  ARM: mvebu: Remove the harcoded BootROM window allocation
  ARM: mvebu: Initialize MBus using the DT binding
  ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
  ARM: mvebu: Add MBus to Armada 370/XP device tree
  ARM: mvebu: Add BootROM to Armada 370/XP device tree
  ARM: mvebu: Relocate Armada 370/XP DeviceBus device tree nodes
  ARM: mvebu: Relocate Armada 370/XP PCIe device tree nodes

Thomas Petazzoni (10):
  bus: mvebu-mbus: Add new API for window creation
  ARM: kirkwood: Move to ID based MBus window creation
  ARM: mv78xx0: Move to ID based window creation
  ARM: orion5x: Move to ID based window creation
  ARM: dove: Move to ID based window creation
  PCI: mvebu: Adapt to the new device tree layout
  bus: mvebu-mbus: Remove the no longer used name-based API
  bus: mvebu-mbus: Remove name -> target, attribute mapping tables
  bus: mvebu-mbus: Update main description
  bus: mvebu-mbus: Factorize Armada 370/XP data structures

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 267 +++++++++++++
 .../devicetree/bindings/pci/mvebu-pci.txt          | 145 +++++--
 arch/arm/boot/dts/armada-370-db.dts                |   5 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  37 +-
 arch/arm/boot/dts/armada-370-rd.dts                |   5 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               | 111 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 112 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 | 131 +++----
 arch/arm/boot/dts/armada-xp-gp.dts                 | 107 +++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 222 ++++++-----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 263 +++++++------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 411 ++++++++++---------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  88 ++---
 arch/arm/boot/dts/armada-xp.dtsi                   |   9 +-
 arch/arm/mach-dove/common.c                        |  68 ++--
 arch/arm/mach-kirkwood/common.c                    |  18 +-
 arch/arm/mach-kirkwood/pcie.c                      |  40 +-
 arch/arm/mach-mv78xx0/pcie.c                       |  23 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
 arch/arm/mach-mvebu/platsmp.c                      |  25 +-
 arch/arm/mach-orion5x/common.c                     |  36 +-
 arch/arm/mach-orion5x/common.h                     |  17 +
 arch/arm/mach-orion5x/d2net-setup.c                |   6 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |  24 +-
 arch/arm/mach-orion5x/dns323-setup.c               |   6 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |   6 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |  12 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |   6 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |   6 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |   6 +-
 arch/arm/mach-orion5x/mss2-setup.c                 |   6 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |   6 +-
 arch/arm/mach-orion5x/net2big-setup.c              |   6 +-
 arch/arm/mach-orion5x/pci.c                        |   9 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |   6 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |   6 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |  13 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |   6 +-
 arch/arm/mach-orion5x/ts209-setup.c                |   6 +-
 arch/arm/mach-orion5x/ts409-setup.c                |   6 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |   6 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |   6 +-
 drivers/bus/mvebu-mbus.c                           | 435 ++++++++++++---------
 drivers/memory/mvebu-devbus.c                      |  64 +--
 drivers/pci/host/pci-mvebu.c                       | 113 ++++--
 include/linux/mbus.h                               |  16 +-
 46 files changed, 1775 insertions(+), 1181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
1.8.1.5
