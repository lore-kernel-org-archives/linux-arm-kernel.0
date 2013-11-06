From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 06 Nov 2013 11:27:15 +0100
Subject: address translation for PCIe-to-localbus bridge
Message-ID: <527A1983.6020603@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I am currently trying to describe an external device within a device 
tree in a Kirkwood design.
Such device is accessed through a local (parallel) bus. Since Kirkwood 
does not provide such an interface, we added a custom FPGA (PCIe device) 
which implements a PCIe-to-localbus bridge.
So essentially BAR0 provides the configuration space for such a bridge, 
and BAR1 provides a remapped area where accesses to the localbus can be 
performed. BAR2 and BAR3 provide other functions.

So with the appropriate reg encoding of the PCI device, the PCI driver 
for the FPGA will automatically get an of_node.

My question is: is there any way I can describe this external device (I 
believe as a child node of the PCI device), so that a call to 
of_address_to_resource() (or equivalent) from its driver will 
automatically translate a localbus address (e.g. 0x0000abcd) to whatever 
address was assigned to BAR1 (in my case 0xe0000000 -> 0xe000abcd)?

I looked up drivers/of/address.c and found of_pci_address_to_resource() 
which seems to do what I want, but it seems that this must be explicitly 
called by the client driver. This means that the driver for the external 
device must be aware it's connected through PCI, which should in 
principle not be necessary.
What I'd like to do instead is describe the device at the appropriate 
location within the device tree (using the appropriate "ranges" 
description) so that its driver can figure out its address space 
automatically (after the PCI device gets probed and enabled of course).

But I found no way to describe which BAR it should refer to, for instance.

Perhaps the "rrrrrrrr" part of phys.hi, using BAR0=0x10, BAR1=0x14, and 
so on?
Or else I should define a new instance of of bus (i.e. 
"pci_lbus_bridge") and invent yet another address encoding syntax?
Any hints?

Thank you su much in advance!
Gerlando

P.S. Here's the skeleton of the this part of the tree (up to the bridge).

pcie-controller {
	compatible = "marvell,kirkwood-pcie";
	status = "okay";
	device_type = "pci";

	#address-cells = <3>;
	#size-cells = <2>;
	bus-range = <0x00 0xff>;

	ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 
registers */
		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* 
non-prefetchable memory */
	          0x81000000 0 0          0xe8000000 0 0x00100000>; /* 
downstream I/O */

			/* PCI BUS 1 */
			pcie at 1,0 {
				device_type = "pci";
				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
				reg = <0x0800 0 0 0 0>;
				#address-cells = <3>;
				#size-cells = <2>;
				...

				/* FPGA, device 0 */
				km_fpga: pcie at 0,0 {
					/* Only the first cell matters,
					npt000ss bbbbbbbb dddddfff rrrrrrrr
					where b is 8-bit bus, d is 5-bit device, f is 3-bit function */
					reg = <0x010000 0 0 0 0>;
					compatible = "km_fpga", "pci10ee,0009";
					...
				};
			};
		};

	};
};

And this is what I get at startup:

mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xebffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [10ee:0009] type 00 class 0x050000
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe8000000-0xe8000fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe8001000-0xe8001fff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe8002000-0xe8002fff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xebffffff]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)

What I'd like to have in the device tree is something like:

&km_fpga {
	...
	device_type = "pci"  /* or pci_lbus_bridge? */
	#address-cells = <2>;/* BAR + local bus address */
	#size-cells = <1>;   /* 32-bit addressing is more than enough */
	ranges = <?????>;    /* ???? */
	slave at 0,0 {
		compatible = "keymile,slave";
		reg = <1 0x000 0x200>; /* Use address space 0x0-0x200 from BAR 1 */
	}
}
