From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:46 +0100
Subject: [RFC PATCH 11/11] arm64: tlb: Avoid synchronous TLBIs when freeing
 page tables
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By selecting HAVE_RCU_TABLE_INVALIDATE, we can rely on tlb_flush() being
called if we fail to batch table pages for freeing. This in turn allows
us to postpone walk-cache invalidation until tlb_finish_mmu(), which
avoids lots of unnecessary DSBs and means we can shoot down the ASID if
the range is large enough.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/tlb.h      |  3 ---
 arch/arm64/include/asm/tlbflush.h | 11 -----------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 29e75b47becd..89059ee1eccc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -142,6 +142,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_RCU_TABLE_INVALIDATE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index baca8dff6884..4f65614b3141 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -54,7 +54,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	__flush_tlb_pgtable(tlb->mm, addr);
 	pgtable_page_dtor(pte);
 	tlb_remove_table(tlb, pte);
 }
@@ -63,7 +62,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	__flush_tlb_pgtable(tlb->mm, addr);
 	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
@@ -72,7 +70,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	__flush_tlb_pgtable(tlb->mm, addr);
 	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 1f77d08e638b..2064ba97845f 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -215,17 +215,6 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
  * Used to invalidate the TLB (walk caches) corresponding to intermediate page
  * table levels (pgd/pud/pmd).
  */
-static inline void __flush_tlb_pgtable(struct mm_struct *mm,
-				       unsigned long uaddr)
-{
-	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
-
-	dsb(ishst);
-	__tlbi(vae1is, addr);
-	__tlbi_user(vae1is, addr);
-	dsb(ish);
-}
-
 static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 {
 	unsigned long addr = __TLBI_VADDR(kaddr, 0);
-- 
2.1.4
