From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:41 +0100
Subject: [RFC PATCH 06/11] arm64: tlb: Remove redundant
 !CONFIG_HAVE_RCU_TABLE_FREE code
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there's one thing the RCU-based table freeing doesn't need, it's more
ifdeffery.

Remove the redundant !CONFIG_HAVE_RCU_TABLE_FREE code, since this option
is unconditionally selected in our Kconfig.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 1e1f68ce28f4..bd00017d529a 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -22,16 +22,10 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-
-#define tlb_remove_entry(tlb, entry)	tlb_remove_table(tlb, entry)
 static inline void __tlb_remove_table(void *_table)
 {
 	free_page_and_swap_cache((struct page *)_table);
 }
-#else
-#define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
-#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
 
 static void tlb_flush(struct mmu_gather *tlb);
 
@@ -61,7 +55,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	__flush_tlb_pgtable(tlb->mm, addr);
 	pgtable_page_dtor(pte);
-	tlb_remove_entry(tlb, pte);
+	tlb_remove_table(tlb, pte);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -69,7 +63,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
 	__flush_tlb_pgtable(tlb->mm, addr);
-	tlb_remove_entry(tlb, virt_to_page(pmdp));
+	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
 
@@ -78,7 +72,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
 	__flush_tlb_pgtable(tlb->mm, addr);
-	tlb_remove_entry(tlb, virt_to_page(pudp));
+	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
 
-- 
2.1.4
