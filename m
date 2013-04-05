From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 21:49:33 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405174845.GD3598@obsidianresearch.com>
References: <20130405150200.7b6dee63@skate> <201304051928.14119.arnd@arndb.de>
 <20130405174845.GD3598@obsidianresearch.com>
Message-ID: <201304052149.33533.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Jason Gunthorpe wrote:
> The DT representation reflects what the HW looks like 'from the view
> point of the PCI-E specification' - which is appropriate since it is a
> 'device_type=pci' node and has special OF specifications governing its
> behaviour.
> 
> PCI-E, and the OF PCI bindings want each port to be allocatable within
> a 'host aperture', dynamically, based on need. Trying to statically
> assign each port's address space in the DT is really struggling
> against that :)

I did not say anything about assigning the phys_addr_t range of
the port in DT, quite the contrary. What I meant is to describe
how a bus address on any of the PCIe ports is wired to the
mbus, which is really a 4GB space per port.

> Further, there just isn't enough address space to do it. Example:
> 
> A system has 3GiB of low RAM, and should support a single VGA card
> with a 256MiB BAR - plugged into any PEX port. It has about 512MiB of
> low address space to allocate to the PCI host aperture and 10 ports.
> 
> It simply cannot be done statically. The kernel must go through all
> the PEX's, find the VGA card, allocate 256MiB to that one PEX and then
> allocate much smaller amounts to all others.

Not what I meant.

> So, given all of this - can you write out an example PCI controller
> DT binding that uses target id in ranges?
> 
> This is why I suggested to include the PEX target IDs as meta-data in
> the PEX nodes, rather than trying to encode them in ranges.

I mean something like

/ {
	#address-cells = <1>;
	#size-cells = <1>;

	mbus {
		#address-cells = <2>;
		#size-cells = <1>;

		/* ignore the specific encoding here */

		ranges = <0x1 0 0xd0000000 0x100000>, /* internal regs */
			 <0xa 0xc0000000 0xc0000000 0x10000> /* PCI port a,
							already assigned */


		internal-bus {
			#address-cells = <1>;
			#size-cells = <0>;
			ranges = <0x1 0 0 0x100000>;
	
			...
		};


		pcie {
			#address-cells = <3>;
			#size-cells = <2>;

			ranges = <0x82000800 0 0 0xa 0 0x1 0>, # port a
				 <0x82001000 0 0 0xb 0 0x1 0>, # port b
				 <0x82001800 0 0 0xc 0 0x1 0>, # port c
				 <0x82002000 0 0 0xd 0 0x1 0>, # port d
				 <0x82002800 0 0 0xe 0 0x1 0>; # port e

			pci { /* port a at device 000800*/
				/* only decodes range 0xc0000000 to 0xc0010000 */
				ranges = <0x82000800 0 0xc0000000 0x82000800 0 0xc0000000 0 0x10000>;
			};
			pci { /* port b at device 001000 */
				/* or just translate everything, to be more sloppy ;-) */
				ranges;
			};
		};
	};
};

	Arnd
