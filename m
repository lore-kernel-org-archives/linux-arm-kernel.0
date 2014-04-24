From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Apr 2014 13:37:52 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <5427496.9FZVDz0Wjn@wuerfel>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <6414220.SShvCHLvZQ@wuerfel> <20140424105846.GE19564@arm.com>
 <5427496.9FZVDz0Wjn@wuerfel>
Message-ID: <20140424123752.GA14110@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 01:12:16PM +0100, Arnd Bergmann wrote:
> On Thursday 24 April 2014 11:58:46 Will Deacon wrote:
> > On Wed, Apr 23, 2014 at 07:58:05PM +0100, Arnd Bergmann wrote:
> > > Another problem is MSI processing. MSI was specifically invented to avoid
> > > having to check an MMIO register for a DMA completion that as a side-effect
> > > flushes pending DMAs from the same device. This breaks down if the MSI
> > > packet gets turned into a level interrupt before it reaches the CPU's
> > > coherency domain, which is likely the case on the dw-pcie controller that
> > > comes with its own MSI block.
> > 
> > I'm not sure there's anything special about MSI which helps with this
> > problem. For GICv3, the MSI write will target the ITS (a slave device),
> > whereas the data produced is assumedly targetting main memory. That still
> > requires careful ordering by the producer, in the same way as if it was
> > signalling a legacy interrupt.
> 
> With legacy interrupts a PCI bus master has no way to order the transactions:
> It initiates the DMA to memory, but does not wait for the DMA to complete.
> It raises the interrupt line, which causes the interrupt handler of the
> driver to start. The driver then reads a status register from the bus master
> device, and this read is ordered with respect to the DMA that may still
> be in progress at the time. Any PCI driver that works with legacy interrupts
> and DMA has to do this, and the PCI host controller has to ensure that these
> ordering semantics are maintained on the upstream buses.
> 
> The difference with MSI is that the driver does not have to do an MMIO read
> transaction, and that the host controller has to ensure ordering between
> the (possibly weakly ordered) data DMA and the MSI transaction, rather than
> between the DMA and the MMIO read. These two are not the same, and it's
> totally possible for a broken implementation to get one of them right
> but not the other.

Ok, so the problem of enforcing ordering (from the CPU's perspective) moves
from the endpoint to the host controller. That's certainly an improvement,
but it doesn't seem unlikely for the host controller to screw that up :(

Will
