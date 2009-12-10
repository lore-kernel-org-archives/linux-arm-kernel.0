From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Dec 2009 17:15:43 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <20091210163920.GA13210@n2100.arm.linux.org.uk>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>
	<20091210163920.GA13210@n2100.arm.linux.org.uk>
Message-ID: <1260465343.23073.63.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-10 at 16:39 +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 10, 2009 at 03:35:07PM +0000, Catalin Marinas wrote:
> > On Thu, 2009-12-10 at 14:59 +0000, mkl lin wrote:
> > > CPU0 also called ata_scsi_queuecmd and stuck in a spinlock, which is
> > > obtained by CPU1, with IRQ disabled. So CPU0 could not handle the IPI,
> > > keep spining, and CPU1 is waiting for CPU0 to finish handling IPI.
> >
> > This looks like a valid scenario, thanks for the analysis.
> >
> > The DMA broadcasting patch allows IPI's with interrupts disabled on the
> > issuing CPU but that's slightly different and any IPI (not only the DMA
> > broadcasting would fail). Basically you can't issue an IPI while holding
> > a lock that may be held by a different CPU with interrupts disabled.
> 
> I was rather expecting a deadlock report over the DMA cache ops broadcasting,
> which is why I've been holding off merging it.

It's good that people tested it in various configurations since my
simple tests haven't shown any problem. So I won't be pushing this
patch.

> > or (2) instead of broadcasting, do a "Read or Write For Ownership"
> > on the calling CPU before invoking the cache operation. By doing this
> > the current CPU becomes the owner of the cache lines and it can do cache
> > maintenance on them. For large buffers, this RFO/WFO is slower than IPI
> > but in the general case it may be actually quicker.
> 
> This is probably the best we can do, and it will make DMA performance
> suck

For relatively small buffers, this may be faster than the whole IPI
procedure but you can't say for sure without benchmarking.

> Let's hope that all ARMv7 SMP implementations broadcast the cache
> operations.

They do broadcast both cache operations and TLB maintenance (but for the
latter we have an issue with global ASID allocation, see my
corresponding patch). With speculative accesses would actually make this
impossible if broadcasting isn't done in hardware.

> If it is just ARMv6 which is affected by this (note that we can not rely
> upon ID_MMFR3 telling us since this register has a different purpose
> there) then we can solve this by just modifying the ARMv6 DMA cache
> methods - which becomes easier if I get the rearrangement of the DMA
> stuff finally sorted.

Good point, that's actually a quick modification (2-3 lines in each
cache function). Mac Lin, can you try the patch below (without the other
broadcasting patch)? If it works, I'll add some comment:

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 295e25d..828a78e 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -210,6 +210,9 @@ ENTRY(v6_dma_inv_range)
 	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
 #endif
 1:
+#ifdef CONFIG_SMP
+	str	r0, [r0]			@ write for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
 #else
@@ -230,6 +233,9 @@ ENTRY(v6_dma_inv_range)
 ENTRY(v6_dma_clean_range)
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
+#ifdef CONFIG_SMP
+	ldr	r2, [r0]			@ read for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
 #else
@@ -250,6 +256,10 @@ ENTRY(v6_dma_clean_range)
 ENTRY(v6_dma_flush_range)
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
+#ifdef CONFIG_SMP
+	ldr	r2, [r0]			@ read for ownership
+	str	r2, [r0]			@ write for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
 #else

>   The *only* thing that remains in the way of that
> is the stupid flush_ioremap_region() crap for just one MTD driver.

But that calls v6_dma_inv_range() anyway.

-- 
Catalin
