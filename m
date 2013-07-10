From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 10 Jul 2013 18:15:32 +0200
Subject: pci-mvebu driver on km_kirkwood
Message-ID: <51DD88A4.1030506@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I am trying to use the pci-mvebu driver on one of our km_kirkwood 
boards. The board is based on Marvell's 98dx4122, which should 
essentially be 6281 compatible.

So I copied the following block from kirkwood-6281.dtsi into
kirkwood-98dx4122.dtsi:

		pcie-controller {
			compatible = "marvell,kirkwood-pcie";
			status = "disabled";
			device_type = "pci";

			#address-cells = <3>;
			#size-cells = <2>;

			bus-range = <0x00 0xff>;

			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 
0.0 registers */
				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* 
non-prefetchable memory */
			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* 
downstream I/O */

			pcie at 1,0 {
				device_type = "pci";
				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
				reg = <0x0800 0 0 0 0>;
				#address-cells = <3>;
				#size-cells = <2>;
				#interrupt-cells = <1>;
				ranges;
				interrupt-map-mask = <0 0 0 0>;
				interrupt-map = <0 0 0 0 &intc 9>;
				marvell,pcie-port = <0>;
				marvell,pcie-lane = <0>;
				clocks = <&gate_clk 2>;
				status = "disabled";
			};
		};

And added the following block to kirkwood-km_kirkwood.dts:

		pcie-controller {
			status = "okay";

			pcie at 1,0 {
				status = "okay";
			};
		};

The code I took from jcooper's repo:

   http://git.infradead.org/users/jcooper/linux.git

I took the tag

   dt-3.11-6

on top of which I merged:

   mvebu/pcie
   mvebu/pcie_bridge
   mvebu/pcie_kirkwood

Only with the latest merge did I get some conflict on
kirkwood.dtsi:

<<<<<<< HEAD
		ranges = <0x00000000 0xf1000000 0x0100000		
		          0xf4000000 0xf4000000 0x0000400
=======
		ranges = <0x00000000 0xf1000000 0x4000000
		          0xe0000000 0xe0000000 0x8100000
 >>>>>>> jcooper/mvebu/pcie_kirkwood

tried both variants, (almost) the same result:

<<<<<<< HEAD
Kirkwood: MV88F6281-A0, TCLK=200000000.
Feroceon L2: Cache support initialised, in WT override mode.
mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xffffffff-0x07fffffe]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [10ee:0008] type 00 class 0x050000
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x007fffff]
pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00001fff]
pci 0000:01:00.0: reg 24: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
pci 0000:01:00.0: BAR 1: can't assign mem (size 0x8000000)
pci 0000:01:00.0: BAR 3: can't assign mem (size 0x800000)
pci 0000:01:00.0: BAR 4: can't assign mem (size 0x2000)
pci 0000:01:00.0: BAR 0: can't assign mem (size 0x1000)
pci 0000:01:00.0: BAR 2: can't assign mem (size 0x1000)
pci 0000:01:00.0: BAR 5: can't assign mem (size 0x1000)
pci 0000:00:01.0: PCI bridge to [bus 01]
=======
Kirkwood: MV88F6281-A0, TCLK=200000000.
Feroceon L2: Cache support initialised, in WT override mode.
mvebu-pcie pcie-controller.2: PCIe0.0: link up
mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [10ee:0008] type 00 class 0x050000
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x007fffff]
pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00001fff]
pci 0000:01:00.0: reg 24: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
pci 0000:01:00.0: BAR 1: can't assign mem (size 0x8000000)
pci 0000:01:00.0: BAR 3: can't assign mem (size 0x800000)
pci 0000:01:00.0: BAR 4: can't assign mem (size 0x2000)
pci 0000:01:00.0: BAR 0: can't assign mem (size 0x1000)
pci 0000:01:00.0: BAR 2: can't assign mem (size 0x1000)
pci 0000:01:00.0: BAR 5: can't assign mem (size 0x1000)
pci 0000:00:01.0: PCI bridge to [bus 01]

 >>>>>>> jcooper/mvebu/pcie_kirkwood

Compared to a working configuration, here I see a spurious

   pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)

which I don't understand, plus all others which are failing.

It's weird how with the second configuration:

   mvebu-pcie pcie-controller.2: PCIe0.0: link up
   mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
   pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
   pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]

I get a second mvebu-pcie pcie-controller.2, although with a more 
reasonable memory range.

Needless to say, I did try several other combinations of your recent and 
not-so-recent patches (from May 23rd onwards), with essentially the same 
results.

It *must* be something trivial. Any hints?

Thanks a lot!
Gerlando
