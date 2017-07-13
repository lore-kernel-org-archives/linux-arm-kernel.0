From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 13 Jul 2017 15:57:19 +0100
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <20170713070718.GA3871@mmlinux>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
 <5235ccf4-9dc2-a4aa-280b-18a0ab5a42bf@arm.com>
 <20170713070718.GA3871@mmlinux>
Message-ID: <37eec44d-2157-1f11-681f-7fbc50983d62@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/17 08:07, michael.moese at men.de wrote:
> 
> 
> On Tue, Jul 11, 2017 at 03:50:19PM +0100, Robin Murphy wrote:
>> I don't much like the sound of that "and" there - coherent DMA
>> allocations are, as the name implies, already coherent for CPU and DMA
>> accesses, and require no maintenance; the streaming DMA API
>> (dma_{map,unmap,sync}_*) on the other hand is *only* for use on
>> kmalloced memory.
> Ok, I hope I am correct. I alloc my memory using dma_alloc_coherent()
> once, the dma_handle is passed to the device, with no other dma_map*()
> or dma_sync_*() calls needed?
> 
> Yesterday I observed some strange behavior  when I did some debug prints in 
> the driver, printing me the result from phys_to_virt() of my
> virtual address and the dma_handle. I know these may be different, but,
> when I dump the memory (from userspace using mmap), I can see the data
> at the adress of my dma_handle, but the memory the driver has the
> pointer for has different contents. I don't understand this.
> 
>  
>> The PL310 does have more than its fair share of wackiness, but unless
>> you also see DMA going wrong for the on-chip peripherals, the problem is
>> almost certainly down to the driver itself rather than the cache
>> configuration.
> Well, I think I need do dive into this as well, my former co-worker
> disabled DMA for SPI, for example, in the device tree. That may be
> another hint. I think I will need to find out what is setup here.

OK, the first thing I'd check is that you have the "arm,shared-override"
property on the DT node for the PL310 and that it's being applied
correctly (e.g. you're not entering the kernel with L2 already enabled).
Otherwise I think it might be possible to end up in a situation where
you get stale data into L2 that even reads from the non-cacheable remap
of the buffer can hit, which would probably look rather like what you're
describing.

Robin.
