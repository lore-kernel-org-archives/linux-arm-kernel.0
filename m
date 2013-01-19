From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Jan 2013 20:05:19 +0000
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50FABBED.1020905@web.de>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <201301172026.45514.arnd@arndb.de> <50FABBED.1020905@web.de>
Message-ID: <201301192005.20093.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 January 2013, Soeren Moch wrote:
> What I can see in the log: a lot of coherent mappings from sata_mv and 
> orion_ehci, a few from mv643xx_eth, no other coherent mappings.
> All coherent mappings are page aligned, some of them (from orion_ehci)
> are not really small (as claimed in __alloc_from_pool).

Right. Unfortunately, the output does not show which of the mappings
are atomic, so we still need to look through those that can be atomic
to understand what's going on. There are a few megabytes of coherent
mappings in total according to the output, but it seems that a significant
portion of them is atomic, which is a bit unexpected.

> I don't believe in a memory leak. When I restart vdr (the application
> utilizing the dvb sticks) then there is enough dma memory available
> again.

I found at least one source line that incorrectly uses an atomic
allocation, in ehci_mem_init():

                dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
                        ehci->periodic_size * sizeof(__le32),
                        &ehci->periodic_dma, 0);

The last argument is the GFP_ flag, which should never be zero, as
that is implicit !wait. This function is called only once, so it
is not the actual culprit, but there could be other instances
where we accidentally allocate something as GFP_ATOMIC.

The total number of allocations I found for each type are

sata_mv: 66 pages (270336 bytes)
mv643xx_eth: 4 pages == (16384 bytes)
orion_ehci: 154 pages (630784 bytes)
orion_ehci (atomic): 256 pages (1048576 bytes)

from the distribution of the numbers, it seems that there is exactly 1 MB
of data allocated between bus addresses 0x1f90000 and 0x1f9ffff, allocated
in individual pages. This matches the size of your pool, so it's definitely
something coming from USB, and no single other allocation, but it does not
directly point to a specific line of code.

One thing I found was that the ARM dma-mapping code seems buggy in the way
that it does a bitwise and between the gfp mask and GFP_ATOMIC, which does
not work because GFP_ATOMIC is defined by the absence of __GFP_WAIT.

I believe we need the patch below, but it is not clear to me if that issue
is related to your problem or now.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b2fb87..c57975f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -640,7 +641,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (is_coherent || nommu())
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
-	else if (gfp & GFP_ATOMIC)
+	else if (!(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
 	else if (!IS_ENABLED(CONFIG_CMA))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
@@ -1272,7 +1273,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
-	if (gfp & GFP_ATOMIC)
+	if (!(gfp & __GFP_WAIT))
 		return __iommu_alloc_atomic(dev, size, handle);
 
 	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
8<-------

There is one more code path I could find, which is usb_submit_urb() =>
usb_hcd_submit_urb => ehci_urb_enqueue() => submit_async() =>
qh_append_tds() => qh_make(GFP_ATOMIC) => ehci_qh_alloc() =>
dma_pool_alloc() => pool_alloc_page() => dma_alloc_coherent()

So even for a GFP_KERNEL passed into usb_submit_urb, the ehci driver
causes the low-level allocation to be GFP_ATOMIC, because 
qh_append_tds() is called under a spinlock. If we have hundreds
of URBs in flight, that will exhaust the pool rather quickly.

	Arnd
