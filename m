From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 22:55:07 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704111338.GD8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
Message-ID: <20110704215507.GH8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 12:13:38PM +0100, Russell King - ARM Linux wrote:
> As far as the BTB goes, I wonder if we can postpone that for user TLB
> ops by setting a TIF_ flag and checking that before returning to userspace.
> That would avoid having to needlessly destroy the cached branch information
> for kernel space while looping over the page tables.  The only other place
> that needs to worry about that is module_alloc() and vmap/vmalloc with
> PROT_KERNEL_EXEC, all of which can be done in flush_cache_vmap().

Actually, we don't need to do BTC invalidate in flush_cache_vmap(),
but we do need to do a dsb+isb.

Firstly, the majority of mappings are created with NX set, so the BTC
can't be involved in anything created there (as we can't execute code
there.)

Secondly, if we're loading a code into kernel space to execute, then we
need to ensure I/D coherency via flush_icache_range(), which has to
happen after the mappings have been created, and this already does our
BTC invalidate+dsb+isb.

So, as far as kernel space TLB invalidation goes, my conclusion is that
we do not have to touch the BTC at all there, and we can leave that to
flush_icache_range() (and therefore cpu..coherent_kern_range) to deal
with.

Practically, testing it out on Versatile Express loading/unloading a
few modules shows no ill effects from dropping the BTC invalidates from
the kernel TLB invalidate ops.

8<----------
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: btc: avoid invalidating the branch target cache on kernel TLB maintanence

Kernel space needs very little in the way of BTC maintanence as most
mappings which are created and destroyed are non-executable, and so
could never enter the instruction stream.

The case which does warrant BTC maintanence is when a module is loaded.
This creates a new executable mapping, but at that point the pages have
not been initialized with code and data, so at that point they contain
unpredictable information.  Invalidating the BTC at this stage serves
little useful purpose.

Before we execute module code, we call flush_icache_range(), which deals
with the BTC maintanence requirements.  This ensures that we have a BTC
maintanence operation before we execute code via the newly created
mapping.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/tlbflush.h |   23 -----------------------
 arch/arm/mm/tlb-v6.S            |    1 -
 arch/arm/mm/tlb-v7.S            |    4 ----
 3 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 9aeddce..3704d03 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -481,19 +481,6 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (kaddr) : "cc");
 	if (tlb_flag(TLB_V7_UIS_PAGE))
 		asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (kaddr) : "cc");
-
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
 }
 
 /*
diff --git a/arch/arm/mm/tlb-v6.S b/arch/arm/mm/tlb-v6.S
index 73d7d89..cdbfda5 100644
--- a/arch/arm/mm/tlb-v6.S
+++ b/arch/arm/mm/tlb-v6.S
@@ -83,7 +83,6 @@ ENTRY(v6wbi_flush_kern_tlb_range)
 	add	r0, r0, #PAGE_SZ
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 	mcr	p15, 0, r2, c7, c10, 4		@ data synchronization barrier
 	mcr	p15, 0, r2, c7, c5, 4		@ prefetch flush
 	mov	pc, lr
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index 53cd5b4..dc84f72 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -75,11 +75,7 @@ ENTRY(v7wbi_flush_kern_tlb_range)
 	add	r0, r0, #PAGE_SZ
 	cmp	r0, r1
 	blo	1b
-	mov	r2, #0
-	ALT_SMP(mcr	p15, 0, r2, c7, c1, 6)	@ flush BTAC/BTB Inner Shareable
-	ALT_UP(mcr	p15, 0, r2, c7, c5, 6)	@ flush BTAC/BTB
 	dsb
-	isb
 	mov	pc, lr
 ENDPROC(v7wbi_flush_kern_tlb_range)
 
