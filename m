From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Nov 2018 17:01:07 +0000
Subject: [PATCH] arm64: tlbi: Set MAX_TLBI_OPS to PTRS_PER_PTE
Message-ID: <1543251667-30520-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to reduce the possibility of soft lock-ups, we bound the
maximum number of TLBI operations performed by a single call to
flush_tlb_range() to an arbitrary constant of 1024.

Whilst this does the job of avoiding lock-ups, we can actually be a bit
smarter by defining this as PTRS_PER_PTE. Due to the structure of our
page tables, using PTRS_PER_PTE means that an outer loop calling
flush_tlb_range() for entire table entries will end up performing just a
single TLBI operation for each entry. As an example, mremap()ing a 1GB
range mapped using 4k pages now requires only 512 TLBI operations when
moving the page tables as opposed to 262144 operations (512*512) when
using the current threshold of 1024.

Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index c3c0387aee18..460fdd69ad5b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -179,7 +179,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
  */
-#define MAX_TLBI_OPS	1024UL
+#define MAX_TLBI_OPS	PTRS_PER_PTE
 
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
@@ -188,7 +188,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long asid = ASID(vma->vm_mm);
 	unsigned long addr;
 
-	if ((end - start) > (MAX_TLBI_OPS * stride)) {
+	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
-- 
2.1.4
