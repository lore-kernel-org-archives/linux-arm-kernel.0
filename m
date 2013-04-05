From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 11:48:45 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304051928.14119.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate> <201304051636.56410.arnd@arndb.de>
 <20130405170725.GB3598@obsidianresearch.com>
 <201304051928.14119.arnd@arndb.de>
Message-ID: <20130405174845.GD3598@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 07:28:13PM +0200, Arnd Bergmann wrote:

> > The Linux PCI core requires a single host bridge aperture, that is
> > what the ranges indicate. It is up to the PCI core to select the
> > address window(s) the PEX will use. When it does this it tells the PCI
> > driver, which tells the MBUS driver, which ultimately creates the
> > window. The address selection must be slaved to the PCI core, the MBUS
> > driver cannot operate autonomously.
> > 
> > This is an unavoidable consequence of merging all the PEX's into a
> > single root complex. If you recall this was required to support the 10
> > PEX case. Cross port address assignment is necessary to avoid address
> > space exhaustion.
> 
> Right, I remembered that already and wrote above that we need to leave
> a single phys_addr_t range for all the PCIe ranges after assigning
> everything else. However, I think the DT representation should still
> reflect what the hardware looks like, meaning that the ranges property
> of the root complex can have one static range for each port, translating
> the 4GB address space of the port to the 4GB mbus window.

The DT representation reflects what the HW looks like 'from the view
point of the PCI-E specification' - which is appropriate since it is a
'device_type=pci' node and has special OF specifications governing its
behaviour.

PCI-E, and the OF PCI bindings want each port to be allocatable within
a 'host aperture', dynamically, based on need. Trying to statically
assign each port's address space in the DT is really struggling
against that :)

Further, there just isn't enough address space to do it. Example:

A system has 3GiB of low RAM, and should support a single VGA card
with a 256MiB BAR - plugged into any PEX port. It has about 512MiB of
low address space to allocate to the PCI host aperture and 10 ports.

It simply cannot be done statically. The kernel must go through all
the PEX's, find the VGA card, allocate 256MiB to that one PEX and then
allocate much smaller amounts to all others.

So, given all of this - can you write out an example PCI controller
DT binding that uses target id in ranges?

This is why I suggested to include the PEX target IDs as meta-data in
the PEX nodes, rather than trying to encode them in ranges.

Jason
