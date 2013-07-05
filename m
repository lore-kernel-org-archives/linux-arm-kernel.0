From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:11 -0300
Subject: [PATCH v6 00/21] MBus DT binding: PCIe strikes back
Message-ID: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the previous version of this patchset for further context:

http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg35753.html

This new proposal is an attempt to address some issues raised about the PCIe
'fake' windows mapping present in the previous version.

Instead of defining a 'fake' MBUS_ID(0xf0, 0x02) region for the whole
PCIe memory and IO space, we use real target ID and attribute for the windows.

See the example below, where a somewhat complete device tree extract is shown:

	soc {
		compatible = "marvell,armadaxp-mbus", "simple-bus";
		controller = <&mbusc>;

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
				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */>;


			pcie at 1,0 {
				/* Port 0, Lane 0 */
				status = "okay";
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

With this new approach there's no mbus-node ranges translation for the 'fake'
window that maps the PCIe regions. Such a translation was actually wrong
in the sense that the windows are allocated dynamically and hence the mappings
need to be created dynamically.

As the target ID and attribute is now encoded in the device tree, it's
now possible to remove the name-based window allocation scheme, replacing
it by a new one based in the IDs only.

This makes the MBus DT binding much consistent, as now both the statically
and dynamically allocated decoding window are defined in the same way.

I'd like to see this binding accepted more or less soon, so if the current
proposal is not accepted it'll be great to hear some hints on how to move
forward.

This series applies on top of today's linux-next. I will rebase it on v3.11-rc1
as soon as that's available.

Thanks a lot!

Ezequiel Garcia (11):
  memory: mvebu-devbus: Remove address decoding window workaround
  bus: mvebu-mbus: Factor out initialization details
  bus: mvebu-mbus: Introduce device tree binding
  bus: mvebu-mbus: Add static window allocation to the DT binding
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
  pci: mvebu: Adapt to the new device tree layout
  bus: mvebu-mbus: Remove the no longer used name-based API
  bus: mvebu-mbus: Remove name -> target, attribute mapping tables
  bus: mvebu-mbus: Update main description
  bus: mvebu-mbus: Factorize Armada 370/XP data structures

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 256 +++++++++++++
 arch/arm/boot/dts/armada-370-db.dts                |   5 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  37 +-
 arch/arm/boot/dts/armada-370-rd.dts                |   5 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               | 109 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 110 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 | 131 ++++---
 arch/arm/boot/dts/armada-xp-gp.dts                 | 107 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 217 +++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 258 ++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 397 +++++++++++----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  88 +++--
 arch/arm/boot/dts/armada-xp.dtsi                   |   9 +-
 arch/arm/mach-dove/common.c                        |  68 ++--
 arch/arm/mach-kirkwood/common.c                    |  18 +-
 arch/arm/mach-kirkwood/pcie.c                      |  40 ++-
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
 drivers/bus/mvebu-mbus.c                           | 386 ++++++++++----------
 drivers/memory/mvebu-devbus.c                      |  64 +---
 drivers/pci/host/pci-mvebu.c                       | 152 ++++++--
 include/linux/mbus.h                               |  12 +-
 45 files changed, 1610 insertions(+), 1148 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
1.8.1.5
