From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2012 15:13:07 +0000
Subject: [RFC PATCH] proc: clear_refs: do not clear reserved pages
Message-ID: <1326467587-22218-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/proc/pid/clear_refs is used to clear the Referenced and YOUNG bits for
pages and corresponding page table entries of the task with PID pid,
which includes any special mappings inserted into the page tables in
order to provide things like vDSOs and user helper functions.

On ARM this causes a problem because the vectors page is mapped as a
global mapping and since ec706dab ("ARM: add a vma entry for the user
accessible vector page"), a VMA is also inserted into each task for this
page to aid unwinding through signals and syscall restarts. Since the
vectors page is required for handling faults, clearing the YOUNG bit
(and subsequently writing a faulting pte) means that we lose the vectors
page *globally* and cannot fault it back in. This results in a system
deadlock on the next exception.

This patch avoids clearing the aforementioned bits for reserved pages,
therefore leaving the vectors page intact on ARM. Since reserved pages
are not candidates for swap, this change should not have any impact on
the usefulness of clear_refs.

Cc: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Reported-by: Moussa Ba <moussaba@micron.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

An aside: if you want to see this problem in action, just run:

$ echo 1 > /proc/self/clear_refs

on an ARM platform (as any user) and watch your system hang. I think this
has been the case since 2.6.37, so I'll CC stable once people are happy
with the fix.

 fs/proc/task_mmu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e418c5a..7dcd2a2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -518,6 +518,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!page)
 			continue;
 
+		if (PageReserved(page))
+			continue;
+
 		/* Clear accessed and referenced bits. */
 		ptep_test_and_clear_young(vma, addr, pte);
 		ClearPageReferenced(page);
-- 
1.7.4.1
