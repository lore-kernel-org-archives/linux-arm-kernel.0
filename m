From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Dec 2013 18:26:03 +0000
Subject: [PATCH 3/3] ARM: mm: flesh out and fix the comments in the ASID
 allocator
In-Reply-To: <1386872763-14845-1-git-send-email-will.deacon@arm.com>
References: <1386872763-14845-1-git-send-email-will.deacon@arm.com>
Message-ID: <1386872763-14845-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ASID allocator has to deal with some pretty horrible behaviours by
the CPU, so expand on some of the comments in there so I remember why
we can never allocate ASID zero to a userspace task.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 52e6f13ac9c7..6eb97b3a7481 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -36,8 +36,8 @@
  * The context ID is used by debuggers and trace logic, and
  * should be unique within all running processes.
  *
- * In big endian operation, the two 32 bit words are swapped if accesed by
- * non 64-bit operations.
+ * In big endian operation, the two 32 bit words are swapped if accessed
+ * by non-64-bit operations.
  */
 #define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
 #define NUM_USER_ASIDS		ASID_FIRST_VERSION
@@ -195,8 +195,11 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 		 * Allocate a free ASID. If we can't find one, take a
 		 * note of the currently active ASIDs and mark the TLBs
 		 * as requiring flushes. We always count from ASID #1,
-		 * as we reserve ASID #0 to switch via TTBR0 and indicate
-		 * rollover events.
+		 * as we reserve ASID #0 to switch via TTBR0 and to
+		 * avoid speculative page table walks from hitting in
+		 * any partial walk caches, which could be populated
+		 * from overlapping level-1 descriptors used to map both
+		 * the module area and the userspace stack.
 		 */
 		asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
 		if (asid == NUM_USER_ASIDS) {
@@ -224,8 +227,9 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 		__check_vmalloc_seq(mm);
 
 	/*
-	 * Required during context switch to avoid speculative page table
-	 * walking with the wrong TTBR.
+	 * We cannot update the pgd and the ASID atomicly with classic
+	 * MMU, so switch exclusively to global mappings to avoid
+	 * speculative page table walking with the wrong TTBR.
 	 */
 	cpu_set_reserved_ttbr0();
 
-- 
1.8.2.2
