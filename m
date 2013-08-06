From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 6 Aug 2013 13:30:28 -0300
Subject: [PATCH v9 00/30] MBus DT binding for Armada 370/XP and Kirkwood
In-Reply-To: <20130806155623.GV19280@titan.lakedaemon.net>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130806155623.GV19280@titan.lakedaemon.net>
Message-ID: <20130806163026.GA2705@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Aug 06, 2013 at 11:56:23AM -0400, Jason Cooper wrote:
> 
> Whole series applied to mvebu/mbus_dt
> 

Hooray!

Thanks a lot!

> 
> On Fri, Jul 26, 2013 at 10:17:37AM -0300, Ezequiel Garcia wrote:
> > This is a minor revision of the patchset, splitting patches with DT bindings
> > changes to separate patches. See the changelog for more context information.
> > 
> > Except for this patch splitting, this can be considered as a v8 resend.
> > 
> > This has been tested on several Armada 370/XP boards, and on Plathome Openblocks
> > A6 Kirkwood board by myself; Kirkwood and Dove testing has been performed by
> > Andrew Lunn and Sebastian Hesselbarth respectively.
> > 
> > If anyone wants to do further testing, there's a public branch:
> > 
> >   https://github.com/MISL-EBU-System-SW/mainline-public/tree/marvell-mvebu-mbus-v9
> > 
> > At this point all that's left is to have formal Acked-by from some DT maintainer/s
> > to the DT binding itself.
> > 
> > This is based on v3.11-rc2.
> > 
> > Changelog
> > ---------
> > 
> > v9:
> > 
> >  * Split DT bindings in separate patches and send only these to the devicetree
> >    mailing list to avoid overloading it, as suggested by Olof Johansson.
> > 
> > v8:
> > 
> >  * Introduce Kirkwood MBus DT binding and use it to relocate
> >    the PCIe nodes *only*.
> > 
> >  * Allow MBus to initialize when the node has no ranges property.
> > 
> >  * Add a sanity check for PCIe port base address to prevent a kernel
> >    panic when this address has not been obtained. Instead of panic,
> >    the PCIe won't work in such cases.
> > 
> > v7:
> > 
> >  * Add two optional properties pcie-{mem,io}-aperture to the MBus node
> >    defining the PCIe mem and IO region apertures.
> > 
> >  * Encode the PCIe port in the second cell of the ranges entries, using
> >    the PCIe slot; and remove such encoding from the first cell, since it
> >    was violating the specification.
> > 
> >    Quoting Jason Gunthorpe:
> >    """ [...] the OF spec says that the phys.hi fields of the child address
> >    spaces in the "ranges" property for PCI does not contain the same
> >    information as "reg" property entries within PCI nodes. The only information
> >    that is present in "ranges" phys.hi entries are the non-relocatable,
> >    prefetchable and the PCI address space bits for which the entry applies.
> >    I.e., only the n, p and ss bits are present; the bbbbbbbb, ddddd, fff and
> >    rrrrrrrr fields are 0."""
> > 
> > v6:
> > 
> >  * Change the PCIe ranges translations encoding, removing the big fake
> >    window encoded as MBUS_ID(0xf0, 0x02) by an array of entries representing
> >    the PCIe real windows with full 4 GiB size.
> > 
> >  * The corresponding PCIe port is selected by encoding the bus in the first cell
> >    of the PCIe controller node ranges entry.
> > 
> >  * Remove the name-based MBus window allocation API, replacing it by an
> >    ID-based API.
> > 
> > v5:
> > 
> >  * Add a required a 'controller' property to specify a phandle containing
> >    the MBus controller MMIO registers.
> > 
> > v4:
> > 
> >  * Fixed the pcie-controller to mbus address space translations, to match
> >    a 1:1 mapping between the PCI and CPU busses.
> > 
> >  * Fixed the binding documentation with suggestions from Arnd Bergmann.
> > 
> >  * Added a BootROM sanity check on AXP SMP initialization, as suggested
> >    by Jason Gunthorpe. This also implied changing slightly the bootrom
> >    node.
> > 
> >  * Changed the first cell format for the MBus address space.
> > 
> > v3:
> > 
> >  * Replaced the PCIe mapping with 0xffff0002, to avoid using a representation
> >    that might correspond to a possible window id.
> > 
> >  * Remove every mbus-node 'ranges' property from the dtsi files. Having them
> >    on the per-board dts files only makes maintaince less painful.
> > 
> >  * Declare children window size, in the children 'ranges' property, as large
> >    as possible (4 GiB size) and move the property to the dtsi files.
> >    The per-board dts, does not need to declare that property now.
> > 
> >  * The MBus driver now creates the decoding window using the base address and
> >    size specified in the mbus-node, instead of using the children entries.
> > 
> > v2:
> > 
> >  * Use the preprocessor on the DT and define a macro for the window ID.
> > 
> >  * Changed the way the address spaces were declared: the window's base
> >    addresses are only present in the mbus-node ranges property.
> >    This makes sense since that information belongs only to the MBus
> >    address space.
> > 
> >  * Drop the ranges dynamic update, since now the DT translations are complete.
> > 
> >  * Replaced the internal register first cell mapping with 0xffff0001, to avoid
> >    clashing when using 0x00000000.
> > 
> >  * Replaced the PCIe mapping with 0xffff0000.
> > 
> > v1:
> > 
> >   * Initial proposal
> > 
> > Example
> > -------
> > 
> > Here's an example showing how the MBus DT binding looks now:
> > 
> > soc {
> > 	compatible = "marvell,armadaxp-mbus", "simple-bus";
> > 	controller = <&mbusc>;
> > 	pcie-mem-aperture = <0xe0000000 0x8000000>;
> > 	pcie-io-aperture  = <0xe8000000 0x100000>;
> > 
> > 	ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000   /* internal-regs */
> > 		  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> > 		  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
> > 
> > 	bootrom {
> > 		compatible = "marvell,bootrom";
> > 		reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
> > 	};
> > 
> > 	devbus-bootcs {
> > 		status = "okay";
> > 		ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x8000000>;
> > 
> > 		/* NOR */
> > 		nor {
> > 			compatible = "cfi-flash";
> > 			reg = <0 0x8000000>;
> > 			bank-width = <2>;
> > 		};
> > 	};
> > 
> > 	pcie-controller {
> > 		compatible = "marvell,armada-xp-pcie";
> > 		status = "okay";
> > 		device_type = "pci";
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 
> > 		ranges =
> > 			<0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> > 			0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
> > 			0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
> > 			0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
> > 			0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> > 			0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
> > 			0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO */
> > 			0x82000000 0x2 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
> > 			0x81000000 0x2 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO */>;
> > 
> > 
> > 		pcie at 1,0 {
> > 			device_type = "pci";
> > 			assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
> > 			reg = <0x0800 0 0 0 0>;
> > 			#address-cells = <3>;
> > 			#size-cells = <2>;
> > 			#interrupt-cells = <1>;
> > 			ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> > 				  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> > 			interrupt-map-mask = <0 0 0 0>;
> > 			interrupt-map = <0 0 0 0 &mpic 58>;
> > 			marvell,pcie-port = <0>;
> > 			marvell,pcie-lane = <0>;
> > 			clocks = <&gateclk 5>;
> > 			status = "disabled";
> > 		};
> > 
> > 		pcie at 2,0 {
> > 			device_type = "pci";
> > 			assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
> > 			reg = <0x1000 0 0 0 0>;
> > 			#address-cells = <3>;
> > 			#size-cells = <2>;
> > 			#interrupt-cells = <1>;
> > 			ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> > 				  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> > 			interrupt-map-mask = <0 0 0 0>;
> > 			interrupt-map = <0 0 0 0 &mpic 62>;
> > 			marvell,pcie-port = <1>;
> > 			marvell,pcie-lane = <0>;
> > 			clocks = <&gateclk 9>;
> > 			status = "disabled";
> > 		};
> > 	};
> > 
> > 	internal-regs {
> > 		compatible = "simple-bus";
> > 		#address-cells = <1>;
> > 		#size-cells = <1>;
> > 		ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
> > 
> > 		mbusc: mbus-controller at 20000 {
> > 			reg = <0x20000 0x100>, <0x20180 0x20>;
> > 		};
> > 
> > 		interrupt-controller at 20000 {
> > 			reg = <0x20a00 0x2d0>, <0x21070 0x58>;
> > 		};
> > 	};
> > };
> > 
> > 
> > Ezequiel Garcia (19):
> >   memory: mvebu-devbus: Remove address decoding window workaround
> >   bus: mvebu-mbus: Factor out initialization details
> >   bus: mvebu-mbus: Introduce device tree binding
> >   bus: mvebu-mbus: Add static window allocation to the DT binding
> >   bus: mvebu-mbus: Add new API for the PCIe memory and IO aperture
> >   PCI: mvebu: Check valid base address before port setup
> >   ARM: mvebu: Remove the harcoded BootROM window allocation
> >   ARM: mvebu: Initialize MBus using the DT binding
> >   ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
> >   ARM: mvebu: Add MBus to Armada 370/XP device tree
> >   ARM: mvebu: Add BootROM to Armada 370/XP device tree
> >   ARM: mvebu: Relocate Armada 370/XP DeviceBus device tree nodes
> >   ARM: mvebu: Relocate Armada 370/XP PCIe device tree nodes
> >   ARM: kirkwood: Split DT and legacy MBus initialization
> >   ARM: kirkwood: Use the preprocessor on device tree files
> >   ARM: kirkwood: Introduce MBus DT node
> >   ARM: kirkwood: Introduce MBUS_ID
> >   ARM: kirkwood: Relocate PCIe device tree nodes
> >   bus: mvebu-mbus: Add devicetree binding
> > 
> > Thomas Petazzoni (11):
> >   bus: mvebu-mbus: Add new API for window creation
> >   ARM: kirkwood: Move to ID based MBus window creation
> >   ARM: mv78xx0: Move to ID based window creation
> >   ARM: orion5x: Move to ID based window creation
> >   ARM: dove: Move to ID based window creation
> >   PCI: mvebu: Adapt to the new device tree layout
> >   bus: mvebu-mbus: Remove the no longer used name-based API
> >   bus: mvebu-mbus: Remove name -> target, attribute mapping tables
> >   bus: mvebu-mbus: Update main description
> >   bus: mvebu-mbus: Factorize Armada 370/XP data structures
> >   PCI: mvebu: Adapt to the new device tree layout
> > 
> >  .../devicetree/bindings/bus/mvebu-mbus.txt         | 276 +++++++++++++
> >  .../devicetree/bindings/pci/mvebu-pci.txt          | 145 +++++--
> >  arch/arm/boot/dts/armada-370-db.dts                |   5 +-
> >  arch/arm/boot/dts/armada-370-mirabox.dts           |  37 +-
> >  arch/arm/boot/dts/armada-370-rd.dts                |   5 +-
> >  arch/arm/boot/dts/armada-370-xp.dtsi               | 111 +++---
> >  arch/arm/boot/dts/armada-370.dtsi                  | 112 +++---
> >  arch/arm/boot/dts/armada-xp-db.dts                 | 131 +++---
> >  arch/arm/boot/dts/armada-xp-gp.dts                 | 107 +++--
> >  arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 222 ++++++-----
> >  arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 263 ++++++------
> >  arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 411 ++++++++++---------
> >  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  88 ++--
> >  arch/arm/boot/dts/armada-xp.dtsi                   |   9 +-
> >  arch/arm/boot/dts/kirkwood-6281.dtsi               |  66 +--
> >  arch/arm/boot/dts/kirkwood-6282.dtsi               | 102 ++---
> >  arch/arm/boot/dts/kirkwood-cloudbox.dts            |   4 +-
> >  arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   7 +-
> >  arch/arm/boot/dts/kirkwood-db-88f6282.dts          |   7 +-
> >  arch/arm/boot/dts/kirkwood-db.dtsi                 |  10 +-
> >  arch/arm/boot/dts/kirkwood-dns320.dts              |   2 +-
> >  arch/arm/boot/dts/kirkwood-dns325.dts              |   2 +-
> >  arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   4 +-
> >  arch/arm/boot/dts/kirkwood-dockstar.dts            |   4 +-
> >  arch/arm/boot/dts/kirkwood-dreamplug.dts           |   4 +-
> >  arch/arm/boot/dts/kirkwood-goflexnet.dts           |   4 +-
> >  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |   4 +-
> >  arch/arm/boot/dts/kirkwood-ib62x0.dts              |   4 +-
> >  arch/arm/boot/dts/kirkwood-iconnect.dts            |  23 +-
> >  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   4 +-
> >  arch/arm/boot/dts/kirkwood-is2.dts                 |   2 +-
> >  arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   4 +-
> >  arch/arm/boot/dts/kirkwood-lschlv2.dts             |   2 +-
> >  arch/arm/boot/dts/kirkwood-lsxhl.dts               |   2 +-
> >  arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   4 +-
> >  arch/arm/boot/dts/kirkwood-mplcec4.dts             |  23 +-
> >  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  23 +-
> >  arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   4 +-
> >  arch/arm/boot/dts/kirkwood-ns2.dts                 |   2 +-
> >  arch/arm/boot/dts/kirkwood-ns2lite.dts             |   2 +-
> >  arch/arm/boot/dts/kirkwood-ns2max.dts              |   2 +-
> >  arch/arm/boot/dts/kirkwood-ns2mini.dts             |   2 +-
> >  arch/arm/boot/dts/kirkwood-nsa310.dts              |  23 +-
> >  arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   4 +-
> >  arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |   4 +-
> >  arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |   2 +-
> >  arch/arm/boot/dts/kirkwood-sheevaplug.dts          |   2 +-
> >  arch/arm/boot/dts/kirkwood-topkick.dts             |   4 +-
> >  arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   6 +-
> >  arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  25 +-
> >  arch/arm/boot/dts/kirkwood-ts219.dtsi              |  17 +-
> >  arch/arm/boot/dts/kirkwood.dtsi                    |  17 +-
> >  arch/arm/mach-dove/common.c                        |  68 ++--
> >  arch/arm/mach-kirkwood/board-dt.c                  |   1 +
> >  arch/arm/mach-kirkwood/common.c                    |  26 +-
> >  arch/arm/mach-kirkwood/pcie.c                      |  40 +-
> >  arch/arm/mach-mv78xx0/pcie.c                       |  23 +-
> >  arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
> >  arch/arm/mach-mvebu/platsmp.c                      |  25 +-
> >  arch/arm/mach-orion5x/common.c                     |  36 +-
> >  arch/arm/mach-orion5x/common.h                     |  17 +
> >  arch/arm/mach-orion5x/d2net-setup.c                |   6 +-
> >  arch/arm/mach-orion5x/db88f5281-setup.c            |  24 +-
> >  arch/arm/mach-orion5x/dns323-setup.c               |   6 +-
> >  arch/arm/mach-orion5x/edmini_v2-setup.c            |   6 +-
> >  arch/arm/mach-orion5x/kurobox_pro-setup.c          |  12 +-
> >  arch/arm/mach-orion5x/ls-chl-setup.c               |   6 +-
> >  arch/arm/mach-orion5x/ls_hgl-setup.c               |   6 +-
> >  arch/arm/mach-orion5x/lsmini-setup.c               |   6 +-
> >  arch/arm/mach-orion5x/mss2-setup.c                 |   6 +-
> >  arch/arm/mach-orion5x/mv2120-setup.c               |   6 +-
> >  arch/arm/mach-orion5x/net2big-setup.c              |   6 +-
> >  arch/arm/mach-orion5x/pci.c                        |   9 +-
> >  arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |   6 +-
> >  arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |   6 +-
> >  arch/arm/mach-orion5x/rd88f5182-setup.c            |  13 +-
> >  arch/arm/mach-orion5x/terastation_pro2-setup.c     |   6 +-
> >  arch/arm/mach-orion5x/ts209-setup.c                |   6 +-
> >  arch/arm/mach-orion5x/ts409-setup.c                |   6 +-
> >  arch/arm/mach-orion5x/wnr854t-setup.c              |   6 +-
> >  arch/arm/mach-orion5x/wrt350n-v2-setup.c           |   6 +-
> >  drivers/bus/mvebu-mbus.c                           | 441 ++++++++++++---------
> >  drivers/memory/mvebu-devbus.c                      |  64 +--
> >  drivers/pci/host/pci-mvebu.c                       | 115 ++++--
> >  include/linux/mbus.h                               |  16 +-
> >  85 files changed, 2030 insertions(+), 1379 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> > 
> > -- 
> > 1.8.1.5
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
