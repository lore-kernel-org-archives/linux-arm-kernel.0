From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 14:36:52 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304052149.33533.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate> <201304051928.14119.arnd@arndb.de>
 <20130405174845.GD3598@obsidianresearch.com>
 <201304052149.33533.arnd@arndb.de>
Message-ID: <20130405203652.GA10505@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 09:49:33PM +0200, Arnd Bergmann wrote:

> > So, given all of this - can you write out an example PCI controller
> > DT binding that uses target id in ranges?
> > 
> > This is why I suggested to include the PEX target IDs as meta-data in
> > the PEX nodes, rather than trying to encode them in ranges.
> 
> I mean something like

Okay, I see now.. Bit more complex for the PCI driver.

Here is a version with more detail:

mbus {
  ranges = <MAPDEF_INTERNAL 0xf1000000 0x100000
            MAPDEF_PEX0     ......     0xFFFFFFFF
            MAPDEF_PEX0_IO  ......     0xFFFFFFFF
            MAPDEF_PEX1     ......     0xFFFFFFFF
            MAPDEF_PEX1_IO  ......     0xFFFFFFFF>

  pcie-controller {
     compatible = "marvell,armada-370-pcie";

     // Mandatory, we need to change to PCI 3dw addressing here
     ranges = <
          // For assigned-addresses
          0x82000000 MAPDEF_INTERNAL 0 0x100000
          // Non prefetchable memory
          0x82000000 MAPDEF_PEX0  MAPDEF_PEX0  0 0xFFFFFFFF
          0x82000000 MAPDEF_PEX1  MAPDEF_PEX1  0 0xFFFFFFFF
          // IO memory
          0x81000000 MAPDEF_PEX0_IO  MAPDEF_PEX0_IO  0 0xFFFFFFFF
          0x81000000 MAPDEF_PEX1_IO  MAPDEF_PEX1_IO  0 0xFFFFFFFF>

     pcie at 0,0 {
          reg = <0x0800 0 0 0 0>;
          /* Mandatory, the driver needs to parse this range to learn
	     the MAPDEF values. */
          ranges = <0x82000000 0 0  0x82000000 MAPDEF_PEX0  0xFFFFFFFF
                    0x81000000 0 0  0x81000000 MAPDEF_PEX0_IO 0xFFFFFFFF>;

          // The internal register block for this PEX
          assigned-addresses = <0x82000800 MAPDEF_INTERNAL + 0x40000  0 0x2000>,
     }
}

Notes
 - The PEX link cannot be encoded in the highest DWORD due to the OF
   PCI rules, lets just use the lower 2 dws instead. MAPDEP_X is a 2
   dword value.
 - The bridge ranges would be offset 0 length 4G-1 in the DT since
   the value is not known. However firmware could do PCI address
   assignment and fill in corrected values.
 - Although unnecessary for Linux, the PCI driver could fill in the bridge
   ranges to reflect the actual bridge setup.
 - The top level mbus ranges can reflect the address translation:

   MAPDEF_PEX0 + 0xC0000000   0xC0000000 0x10000 // Identity map MMIO
   MAPDEF_PEX0_IO             0xD0000000 0x10000 // Translate 0xD0000000 to IO 0
 - A full featured firmware could fill in the various ranges to
   represent a working PCI bus configuration

So the PCI driver would now have to dynamically determine on its own a
host bridge aperture based on available space in the resource tree,
this is done instead of parsing ranges. I guess we could have a
'linux,host-aperture' or something as a stop gap.

The driver should create each root bridge by pulling
 - reg = the device.fn of the config space
 - assigned-addresess = the PEX internal register block
 - ranges = The target ID's for the PEX

So there is no longer a need to assume in the DT binding that a
particular device.fn refers to a particular PEX.

If this is the way to go, I hope it can be a revision on top of the
existing PCI patch set?

Did I miss anything Arnd?

Jason
