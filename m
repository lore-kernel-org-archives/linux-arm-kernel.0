From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 15 Feb 2011 14:14:55 +0100
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
Message-ID: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

My question concerns this patch
--------
commit 2ffe2da3e71652d4f4cae19539b5c78c2a239136
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat Oct 31 16:52:16 2009 +0000

    ARMv6 and ARMv7 CPUs can perform speculative prefetching, which makes
    DMA cache coherency handling slightly more interesting.  Rather than
    being able to rely upon the CPU not accessing the DMA buffer until DMA
    has completed, we now must expect that the cache could be loaded with
    possibly stale data from the DMA buffer.

    Where DMA involves data being transferred to the device, we clean the
    cache before handing it over for DMA, otherwise we invalidate the buffer
    to get rid of potential writebacks.  On DMA Completion, if data was
    transferred from the device, we invalidate the buffer to get rid of
    any stale speculative prefetches.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
    Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>
---------

file: arch/arm/mm/dma-mapping.c
> void ___dma_page_cpu_to_dev(struct page *page, unsigned long off,
> 	size_t size, enum dma_data_direction dir)
> {
> ...
> 	if (dir == DMA_FROM_DEVICE) {
> 		outer_inv_range(paddr, paddr + size);
> ...
> }
> EXPORT_SYMBOL(___dma_page_cpu_to_dev);
>
> void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
> 	size_t size, enum dma_data_direction dir)
> {
> ...
> 	if (dir != DMA_TO_DEVICE)
> 		outer_inv_range(paddr, paddr + size);
> ...
> }

outer_inv_range () is called twice for DMA_FROM_DEVICE.
The first time to "get rid of potential writebacks" and the second
time to "get rid of any stale speculative prefetches"
outer_inv_range() is a rather expensive operation. In the first case
isn't it enough to just call cache_sync()?

What about:
void ___dma_page_cpu_to_dev(struct page *page, unsigned long off,
	size_t size, enum dma_data_direction dir)
{
...
	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
+		outer_sync();
...
}

/Per
