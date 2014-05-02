From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:08 +0100
Subject: [PATCH 1/8] ARM: cacheflush: use -st dsb option for ensuring
 completion
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dsb st can be used to ensure completion of pending cache maintenance
operations, so use it for the v7 cache maintenance operations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cacheflush.h |  2 +-
 arch/arm/mm/cache-v7.S            | 12 ++++++------
 arch/arm/mm/mmu.c                 |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 8b8b61685a34..00af9fe435e6 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -212,7 +212,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 static inline void __flush_icache_all(void)
 {
 	__flush_icache_preferred();
-	dsb();
+	dsb(ishst);
 }
 
 /*
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 778bcf88ee79..615c99e38ba1 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -59,7 +59,7 @@ ENTRY(v7_invalidate_l1)
        bgt     2b
        cmp     r2, #0
        bgt     1b
-       dsb
+       dsb     st
        isb
        mov     pc, lr
 ENDPROC(v7_invalidate_l1)
@@ -166,7 +166,7 @@ skip:
 finished:
 	mov	r10, #0				@ swith back to cache level 0
 	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
-	dsb
+	dsb	st
 	isb
 	mov	pc, lr
 ENDPROC(v7_flush_dcache_all)
@@ -335,7 +335,7 @@ ENTRY(v7_flush_kern_dcache_area)
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
+	dsb	st
 	mov	pc, lr
 ENDPROC(v7_flush_kern_dcache_area)
 
@@ -368,7 +368,7 @@ v7_dma_inv_range:
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
+	dsb	st
 	mov	pc, lr
 ENDPROC(v7_dma_inv_range)
 
@@ -390,7 +390,7 @@ v7_dma_clean_range:
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
+	dsb	st
 	mov	pc, lr
 ENDPROC(v7_dma_clean_range)
 
@@ -412,7 +412,7 @@ ENTRY(v7_dma_flush_range)
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
+	dsb	st
 	mov	pc, lr
 ENDPROC(v7_dma_flush_range)
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b68c6b22e1c8..2b001e5dce87 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1461,7 +1461,7 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	 * just complicate the code.
 	 */
 	flush_cache_louis();
-	dsb();
+	dsb(ishst);
 	isb();
 
 	/* remap level 1 table */
-- 
1.9.2
