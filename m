From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 22 Mar 2016 10:11:28 +0000
Subject: [PATCH] arm64: mm: allow preemption in copy_to_user_page
Message-ID: <1458641488-21455-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we disable preemption in copy_to_user_page; a behaviour that
we inherited from the 32-bit arm code. This was necessary for older
cores without broadcast data cache maintenance, and ensured that cache
lines were dirtied and cleaned by the same CPU. On these systems dirty
cache line migration was not possible, so this was sufficient to
guarantee coherency.

On contemporary systems, cache coherence protocols permit (dirty) cache
lines to migrate between CPUs as a result of speculation, prefetching,
and other behaviours. To account for this, in ARMv8 data cache
maintenance operations are broadcast and affect all data caches in the
domain associated with the VA (i.e. ISH for kernel and user mappings).

In __switch_to we ensure that tasks can be safely migrated in the middle
of a maintenance sequence, using a dsb(ish) to ensure prior explicit
memory accesses are observed and cache maintenance operations are
completed before a task can be run on another CPU.

Given the above, it is not necessary to disable preemption in
copy_to_user_page. This patch removes the preempt_{disable,enable}
calls, permitting preemption.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/flush.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 60585bd..dbd12ea 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -58,17 +58,13 @@ static void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
  * Copy user data from/to a page which is mapped into a different processes
  * address space.  Really, we want to allow our "user space" model to handle
  * this.
- *
- * Note that this code needs to run on the current CPU.
  */
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long uaddr, void *dst, const void *src,
 		       unsigned long len)
 {
-	preempt_disable();
 	memcpy(dst, src, len);
 	flush_ptrace_access(vma, page, uaddr, dst, len);
-	preempt_enable();
 }
 
 void __sync_icache_dcache(pte_t pte, unsigned long addr)
-- 
1.9.1
