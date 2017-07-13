From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jul 2017 11:18:45 +0100
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <20170713100031.GA31131@mmlinux>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
 <5235ccf4-9dc2-a4aa-280b-18a0ab5a42bf@arm.com>
 <20170713070718.GA3871@mmlinux>
 <20170713090423.GA31807@n2100.armlinux.org.uk>
 <20170713100031.GA31131@mmlinux>
Message-ID: <20170713101845.GB31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 12:00:31PM +0200, michael.moese at men.de wrote:
> On Thu, Jul 13, 2017 at 10:04:23AM +0100, Russell King - ARM Linux wrote:
> > You must always use the two addresses returned from dma_alloc_coherent()
> > and never try to translate them - the DMA address is for programming
> > into the hardware, and the virtual address for CPU accesses.  If you do
> > try to pass these to the various translators (like virt_to_phys()) the
> > result is undefined.
> 
> I was trying to just print some addresses for debugging. I removed this
> again. I'm just confused, because the DMA device address seems to be the
> physical one. At least the memory contains my data. The virtual memory
> contains different data. 

The DMA address might be a physical address if that's what the device
requires, but equally, it might not be.

If it is a physical address, phys_to_virt() will return the virtual
address in the lowmem mapping provided that the physical address
corresponds with a lowmem mapped page.  If it's a highmem page, then
phys_to_virt() will still return something that looks like a virtual
address, but it could be anything.  It's undefined.

Accessing memory through that pointer could end up hitting a cacheable
mapping, which would destroy the semantics of the DMA coherent mapping,
thereby leading to unpredictable behaviour.

As I've already said, use _both_ pointers for a DMA coherent allocation.
If you want to dump the data in the DMA coherent memory, use the virtual
address returned from dma_alloc_coherent() - this will have the least
side effects.

If you access it through phys_to_virt(dma_addr) then you could be
dragging the data into the caches, and the first time you print it, it
would look correct, but when the DMA device updates it, it becomes stale,
and even if you subsequently access it through the correct pointer, you
could continue receiving the stale data.  Just don't do this - using
phys_to_virt() may seem like a short-cut, but it really isn't.

> Could it be possible this mapping on my board is going wrong?

Unlikely.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
