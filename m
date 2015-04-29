From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 12:07:10 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <5540A8B9.7010100@topic.nl>
References: <5538DD02.6050401@topic.nl>
 <20150429091714.GH12732@n2100.arm.linux.org.uk> <5540A8B9.7010100@topic.nl>
Message-ID: <2919263.vEuyzce5K7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 11:47:37 Mike Looijmans wrote:
> On 29-04-15 11:17, Russell King - ARM Linux wrote:
> > On Wed, Apr 29, 2015 at 11:01:35AM +0200, Arnd Bergmann wrote:
> >> You still need to synchronize MMIO register accesses with write buffers,
> >> as the readl() and writel() functions do in the kernel.
> >>
> >> In particular, after you have written a buffer to memory from the CPU,
> >> you will need to do an outer_sync() before the MMIO write that triggers
> >> the DMA. This is still much cheaper than doing the cache flush though.
> >
> > Note that outer_sync() is already done by readl/writel and/or the write
> > memory barriers (mb()/wmb()).
> 
> I initiate the DMA transfers using iowrite32() so if I understand correctly, 
> I'm already doing the right thing here.
> 
> Just to be completely clear, there is no direct register access from user 
> space, the driver does all MMIO. Userspace only gets an mmap for DMA buffers, 
> and uses ioctl to initiate transfers.

Ok, that seems all fine then.

> >> Another possible problem would be if the driver mmaps the buffer in
> >> uncached mode to user space. This is something your kernel driver has
> >> to get right, it won't be handled automatically by setting the
> >> "dma-coherent" property in DT.
> >
> > The buffer should also be mapped into userspace with the same memory
> > type and cache attributes as the kernel side mapping.  If using ACP,
> > then you probably want "normal memory, cacheable, writeback, read
> > allocate" or in the case of SMP, the same but "read/write allocate".
> 
> I currently use dma_alloc_coherent() to allocate buffers and 
> dma_mmap_coherent() to map them to user space. I was under the assumption that 
> these would do the right thing. Is that correct? If not, then what should I use?

dma_mmap_coherent() is the right interface, but I've just looked at the
implementation of arm_dma_mmap() and I'm not sure that it actually uses the
correct vma->vm_page_prot value here, because I don't see where it takes
into account whether the device is coherent or not. Most ARM machines have
only noncoherent devices, and dma_mmap_coherent() is used rarely by drivers,
so it's quite possible that this interface got broken without anybody
noticing.

If my suspicion is correct, we should either change arm_coherent_dma_ops()
to refer to a different mmap() callback that does the right thing for
coherent devices, or change arm_dma_mmap() to look at dev->is_coherent.

	Arnd
