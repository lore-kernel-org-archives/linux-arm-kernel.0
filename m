From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 28 May 2010 16:49:40 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <20100528202831.GD5189@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<20100528185604.GB5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281503260.24526@xanadu.home>
	<20100528194501.GC5189@n2100.arm.linux.org.uk>
	<20100528202831.GD5189@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1005281637290.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 May 2010, Russell King - ARM Linux wrote:

> On Fri, May 28, 2010 at 08:45:01PM +0100, Russell King - ARM Linux wrote:
> > On Fri, May 28, 2010 at 03:26:21PM -0400, Nicolas Pitre wrote:
> > > That is exactly the observed behavior on OMAP and Dove when this patch 
> > > is _not_ applied.
> > 
> > I'm about to test this on my OMAP4 board, which will be a DMA-based test,
> > which will be using the same filesystem.
> 
> Confirmed - on the OMAP4 board _with_ DMA, this patch fixes a problem
> causing various faults in userspace - though it's nowhere near as bad
> as the Versatile Express board.

In my experience, the badness depends on the actual amount of highmem 
you have.  Changing that number using the memory and vmalloc boot 
arguments will move the average behavior between "it almost boots" and 
"init doesn't even come up".

> So, we seem to have this behaviour:
> 
> - with PIO drivers, with this patch breaks userspace, without fixes userspace
> - with DMA drivers, with this patch fixes userspace, without breaks userspace

Could you possibly test a UP kernel on those as well?  That might 
provide a better matrix.

> Note that MMCI does do flush_dcache_page() on PIO read.
> 
> Maybe there's something wrong in __flush_dcache_page()?

One possible suspect might be the optimization in kmap_high_l1_vipt() 
which I couldn't test on SMP as I have no access to such beast.  Hence 
this patch might be worth testing as well:

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 77b030f..06abed2 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -169,7 +169,7 @@ void *kmap_high_l1_vipt(struct page *page, pte_t *saved_pte)
 
 	raw_local_irq_save(flags);
 	(*depth)++;
-	if (pte_val(*ptep) == pte_val(pte)) {
+	if (0 && pte_val(*ptep) == pte_val(pte)) {
 		*saved_pte = pte;
 	} else {
 		*saved_pte = *ptep;
@@ -198,7 +198,7 @@ void kunmap_high_l1_vipt(struct page *page, pte_t saved_pte)
 
 	raw_local_irq_save(flags);
 	(*depth)--;
-	if (*depth != 0 && pte_val(pte) != pte_val(saved_pte)) {
+	if (1 || (*depth != 0 && pte_val(pte) != pte_val(saved_pte))) {
 		set_pte_ext(ptep, saved_pte, 0);
 		local_flush_tlb_kernel_page(vaddr);
 	}

Nicolas
