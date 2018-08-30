From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 17:15:39 +0100
Subject: [PATCH 05/12] arm64: tlbflush: Allow stride to be specified for
 __flush_tlb_range()
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535645747-9823-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we are unmapping intermediate page-table entries or huge pages, we
don't need to issue a TLBI instruction for every PAGE_SIZE chunk in the
VA range being unmapped.

Allow the invalidation stride to be passed to __flush_tlb_range(), and
adjust our "just nuke the ASID" heuristic to take this into account.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h      |  2 +-
 arch/arm64/include/asm/tlbflush.h | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a3233167be60..1e1f68ce28f4 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -53,7 +53,7 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	 * the __(pte|pmd|pud)_free_tlb() functions, so last level
 	 * TLBI is sufficient here.
 	 */
-	__flush_tlb_range(&vma, tlb->start, tlb->end, true);
+	__flush_tlb_range(&vma, tlb->start, tlb->end, PAGE_SIZE, true);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index ddbf1718669d..37ccdb246b20 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -149,25 +149,28 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
  */
-#define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
+#define MAX_TLBI_OPS	1024UL
 
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
-				     bool last_level)
+				     unsigned long stride, bool last_level)
 {
 	unsigned long asid = ASID(vma->vm_mm);
 	unsigned long addr;
 
-	if ((end - start) > MAX_TLB_RANGE) {
+	if ((end - start) > (MAX_TLBI_OPS * stride)) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
 
+	/* Convert the stride into units of 4k */
+	stride >>= 12;
+
 	start = __TLBI_VADDR(start, asid);
 	end = __TLBI_VADDR(end, asid);
 
 	dsb(ishst);
-	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
+	for (addr = start; addr < end; addr += stride) {
 		if (last_level) {
 			__tlbi(vale1is, addr);
 			__tlbi_user(vale1is, addr);
@@ -186,14 +189,14 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	 * We cannot use leaf-only invalidation here, since we may be invalidating
 	 * table entries as part of collapsing hugepages or moving page tables.
 	 */
-	__flush_tlb_range(vma, start, end, false);
+	__flush_tlb_range(vma, start, end, PAGE_SIZE, false);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
-	if ((end - start) > MAX_TLB_RANGE) {
+	if ((end - start) > (MAX_TLBI_OPS * PAGE_SIZE)) {
 		flush_tlb_all();
 		return;
 	}
-- 
2.1.4
