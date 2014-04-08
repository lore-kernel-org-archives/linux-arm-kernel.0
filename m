From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Apr 2014 12:08:28 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408175324.GH11052@1wt.eu>
References: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu>
Message-ID: <20140408180828.GC32490@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 07:53:24PM +0200, Willy Tarreau wrote:
> Hi Jason,
> 
> On Tue, Apr 08, 2014 at 11:14:17AM -0600, Jason Gunthorpe wrote:
> > The mbus hardware requires a power of two size, if a non-power
> > of two is passed in to the low level routines they configure the
> > register in a way that results in undefined behaviour.
> > 
> > - WARN_ON to make this invalid usage really obvious
> > - Round down to the nearest power of two so we only stuff a valid
> >   size into the HW
> 
> So if I understand it right, for example when my first NIC registers
> e0000000-e02fffff, then we'll truncate it down to e0000000-e01fffff,
> won't that cause any issue, for example if the NIC needs to access
> data beyond that limit ?

The mbus windows are assigned to the bridge, not to the NIC bars:

00:0a.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Memory behind bridge: e0000000-e17fffff

So the above is not OK, 17fffff is not a power of two. The patch
causes the mbus to WARN_ON and then round down so that the hardware is
at least in a defined configuration.

> BTW I can try your patch with the myricom NIC which started to work
> when rounding up, I'll quickly see if that fixes the issue as well,
> but I'm now a little bit confused.

This patch won't fix anything, it just fixes the mbus driver to always
program the hardware with valid values, even if the upper layer
requests something invalid. Basically, we spent a few weeks tracking
this behavior down, the patch would ensure that time doesn't get spent
again.

The goal now is to avoid the WARN_ON in the patch from firing.

For a proper fix, something like this to create multiple aligned
windows is a simple option (untested, need the inverse on the
de-register, loop should probably live in mbus code):

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 789cdb2..7312c82 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -382,6 +382,9 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 {
+       phys_addr_t base;
+       unsigned int mapped_size;
+
        /* Are the new membase/memlimit values invalid? */
        if (port->bridge.memlimit < port->bridge.membase ||
            !(port->bridge.command & PCI_COMMAND_MEMORY)) {
@@ -408,8 +411,16 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
                (((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
                port->memwin_base;
 
-       mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
-                                   port->memwin_base, port->memwin_size);
+       base = port->memwin_base;
+       mapped_size = 0;
+       while (mapped_size < port->memwin_size) {
+               unsigned int size =
+                   rounddown_pow_of_two(port->memwin_size - mapped_size);
+               mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
+                                           base, size);
+               base += size;
+               mapped_size += size;
+       }
 }
 

Jason
