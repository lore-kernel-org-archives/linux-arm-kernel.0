From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Nov 2013 15:16:42 +0000
Subject: Physical memory start contraints in the Linux kernel  (Was:
 Re: Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel]
 [xen-unstable test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <alpine.DEB.2.02.1311121449550.26077@kaball.uk.xensource.com>
References: <osstest-21486-mainreport@xen.org>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <201311121437.55826.arnd@arndb.de>
 <alpine.DEB.2.02.1311121449550.26077@kaball.uk.xensource.com>
Message-ID: <20131112151642.GO16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 03:00:40PM +0000, Stefano Stabellini wrote:
> On Tue, 12 Nov 2013, Arnd Bergmann wrote:
> > > Or is this a lost fight and should we find a workaround (see below if we
> > > are curious) to make the start of memory look the same?
> > 
> > I don't see what hack you are referring to, can you elaborate?
> 
> The hack would be mapping dom0 memory at the same start address as it
> would be on the native platform but allocating its memory contiguously
> at an offset.
> 
> For example having dom0 psedo-physical memory start at 0x80000000 (as it
> would expect) and end at 0x88000000 (because let's sat that we only give
> 128MB of memory to dom0). The actual physical memory would be allocated
> contiguously from 0xA0000000. The swiotlb-xen code in Linux would be
> made aware of the offset 0xA0000000-0x80000000 via device tree and
> would calculate the right physical address to use for dma operations.
> Today swiotlb-xen assumes that pseudo-phisical addresses correspond to
> physical addresses for dom0.

First, let's get something right here.  Conceptually, DMA addresses have
_never_ been the same as physical addresses in the kernel (with the
exception of DMA masks being interpreted strangely.)

Physical addresses have always been what's required to be programmed into
things like the MMU to gain access to RAM.  We have virt_to_phys() etc
for translations of this nature for lowmem, and kmap() etc for highmem.

DMA addresses have always been the value which you program into the DMA
controller for it to be able to access RAM.  These use the DMA API to
obtain the DMA address.  Behind the DMA API, we have dma_to_virt() and
virt_to_dma() etc which do the appropriate translation for this.

Of course, for virtualisation, replacing the DMA ops is probably the
better solution to deal with this, where you can hook into the mapping/
unmapping/coherent functions and return the correct DMA addresses.

Remember though - anything which assumes virtual_address =
phys_to_virt(dma_addr_t) is basically violating the conceptual model
here, and should be fixed.
