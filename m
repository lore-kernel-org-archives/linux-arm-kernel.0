From: labbott@redhat.com (Laura Abbott)
Date: Tue, 16 Aug 2016 13:39:48 -0700
Subject: [RFCv2][PATCH 2/5] arm: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <20160810232258.GQ1041@n2100.armlinux.org.uk>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
 <1470678577-14010-3-git-send-email-labbott@redhat.com>
 <20160810232258.GQ1041@n2100.armlinux.org.uk>
Message-ID: <9541c5aa-4087-0554-5ac6-8aa830ab7b1b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 04:22 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 08, 2016 at 10:49:34AM -0700, Laura Abbott wrote:
>> +/*
>> + * Make an area consistent for devices.
>> + * Note: Drivers should NOT use this function directly, as it will break
>> + * platforms with CONFIG_DMABOUNCE.
>> + * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
>> + */
>> +void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
>> +	size_t size, enum dma_data_direction dir)
>> +{
>> +	phys_addr_t paddr;
>> +
>> +	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
>> +
>> +	paddr = page_to_phys(page) + off;
>> +	if (dir == DMA_FROM_DEVICE) {
>> +		outer_inv_range(paddr, paddr + size);
>> +	} else {
>> +		outer_clean_range(paddr, paddr + size);
>> +	}
>> +	/* FIXME: non-speculating: flush on bidirectional mappings? */
>> +}
>> +
>> +void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
>> +	size_t size, enum dma_data_direction dir)
>> +{
>> +	phys_addr_t paddr = page_to_phys(page) + off;
>> +
>> +	/* FIXME: non-speculating: not required */
>> +	/* in any case, don't bother invalidating if DMA to device */
>> +	if (dir != DMA_TO_DEVICE) {
>> +		outer_inv_range(paddr, paddr + size);
>> +
>> +		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
>> +	}
>> +
>> +	/*
>> +	 * Mark the D-cache clean for these pages to avoid extra flushing.
>> +	 */
>> +	if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
>> +		unsigned long pfn;
>> +		size_t left = size;
>> +
>> +		pfn = page_to_pfn(page) + off / PAGE_SIZE;
>> +		off %= PAGE_SIZE;
>> +		if (off) {
>> +			pfn++;
>> +			left -= PAGE_SIZE - off;
>> +		}
>> +		while (left >= PAGE_SIZE) {
>> +			page = pfn_to_page(pfn++);
>> +			set_bit(PG_dcache_clean, &page->flags);
>> +			left -= PAGE_SIZE;
>> +		}
>> +	}
>> +}
>
> I _really_ don't want these exposed in any shape or form to driver
> code.  I've seen too many hacks out there where people have gone
> under the cover of the APIs they should be using, and headed straight
> for the low-level functionality - adding function prototypes to get
> at stuff they have no business doing.  Moving this here is just
> asking for it to be abused.
>
>> +
>> +void kernel_force_cache_clean(struct page *page, size_t size)
>> +{
>> +	__dma_page_cpu_to_dev(page, 0, size, DMA_BIDIRECTIONAL);
>> +}
>> +
>> +void kernel_force_cache_invalidate(struct page *page, size_t size)
>> +{
>> +	__dma_page_dev_to_cpu(page, 0, size, DMA_BIDIRECTIONAL);
>> +}
>
> Nothing in our implementation of these DMA operations guarantees
> that those mean "clean" and "invalidate".  The DMA operations are
> there so that CPUs can implement whatever they need at the map and
> unmap times - and I've been very careful not to specify which cache
> operations are involved.
>
> For example, on older CPUs, __dma_page_dev_to_cpu() is almost
> always a no-op.
>
> If you want something that does something specific, then we need
> something designed to do something specific.  Please don't re-use
> what you think will fit.
>

I see what you are saying. What I really wanted was to re-use some of
the code that dma_cache_maint_page was doing for highmem handling
but it looks like I picked the wrong layer to make common. I'll give
this some thought.

Thanks,
Laura
