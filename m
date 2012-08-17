From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 17 Aug 2012 18:03:00 +0100
Subject: [PATCH] arm: mm: Fix vmalloc overlap check for !HIGHMEM
Message-ID: <1345222980-16965-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With !HIGHMEM, sanity_check_meminfo checks for banks that completely or
partially overlap the vmalloc region. The test for partial overlap checks
__va(bank->start + bank->size) > vmalloc_min. This is not appropriate if
there is a non-linear translation between virtual and physical addresses,
as bank->start + bank->size is actually in the bank following the one being
interrogated.

In most cases, even when using SPARSEMEM, this is not problematic as the
subsequent bank will start at a higher va than the one in question. However
if the physical to virtual address conversion is not monotonic increasing,
the incorrect test could result in a bank not being truncated when it
should be.

This patch ensures we perform the va-pa conversion on memory from the
bank we are interested in, not the following one.

Reported-by: ????????? (Steve) <zhanzhenbo@gmail.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---

This is modified based on Russell's feedback in the original
discussion (Why the region area don't decrease 1 in function
sanity_check_meminfo?)

 arch/arm/mm/mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4c2d045..dbd9ff6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -961,8 +961,8 @@ void __init sanity_check_meminfo(void)
 		 * Check whether this memory bank would partially overlap
 		 * the vmalloc area.
 		 */
-		if (__va(bank->start + bank->size) > vmalloc_min ||
-		    __va(bank->start + bank->size) < __va(bank->start)) {
+		if (__va(bank->start + bank->size - 1) >= vmalloc_min ||
+		    __va(bank->start + bank->size - 1) <= __va(bank->start)) {
 			unsigned long newsize = vmalloc_min - __va(bank->start);
 			printk(KERN_NOTICE "Truncating RAM at %.8llx-%.8llx "
 			       "to -%.8llx (vmalloc region overlap).\n",
-- 
1.7.1
