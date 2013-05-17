From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 18:07:51 +0100
Subject: [PATCH 12/14] ARM: mm: clean up membank size limit checks
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <1368810473-26070-13-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch cleans up the highmem sanity check code by simplifying the range
checks with a pre-calculated size_limit.  This patch should otherwise have no
functional impact on behavior.

This patch also removes a redundant (bank->start < vmalloc_limit) check, since
this is already covered by the !highmem condition.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/mmu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ae249d1..280f91d 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -992,10 +992,15 @@ void __init sanity_check_meminfo(void)
 
 	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
 		struct membank *bank = &meminfo.bank[j];
+		phys_addr_t size_limit;
+
 		*bank = meminfo.bank[i];
+		size_limit = bank->size;
 
 		if (bank->start >= vmalloc_limit)
 			highmem = 1;
+		else
+			size_limit = vmalloc_limit - bank->start;
 
 		bank->highmem = highmem;
 
@@ -1004,8 +1009,7 @@ void __init sanity_check_meminfo(void)
 		 * Split those memory banks which are partially overlapping
 		 * the vmalloc area greatly simplifying things later.
 		 */
-		if (!highmem && bank->start < vmalloc_limit &&
-		    bank->size > vmalloc_limit - bank->start) {
+		if (!highmem && bank->size > size_limit) {
 			if (meminfo.nr_banks >= NR_BANKS) {
 				printk(KERN_CRIT "NR_BANKS too low, "
 						 "ignoring high memory\n");
@@ -1014,12 +1018,12 @@ void __init sanity_check_meminfo(void)
 					(meminfo.nr_banks - i) * sizeof(*bank));
 				meminfo.nr_banks++;
 				i++;
-				bank[1].size -= vmalloc_limit - bank->start;
+				bank[1].size -= size_limit;
 				bank[1].start = vmalloc_limit;
 				bank[1].highmem = highmem = 1;
 				j++;
 			}
-			bank->size = vmalloc_limit - bank->start;
+			bank->size = size_limit;
 		}
 #else
 		/*
@@ -1037,14 +1041,13 @@ void __init sanity_check_meminfo(void)
 		 * Check whether this memory bank would partially overlap
 		 * the vmalloc area.
 		 */
-		if (bank->start + bank->size > vmalloc_limit)
-			unsigned long newsize = vmalloc_limit - bank->start;
+		if (bank->size > size_limit) {
 			printk(KERN_NOTICE "Truncating RAM at %.8llx-%.8llx "
 			       "to -%.8llx (vmalloc region overlap).\n",
 			       (unsigned long long)bank->start,
 			       (unsigned long long)bank->start + bank->size - 1,
-			       (unsigned long long)bank->start + newsize - 1);
-			bank->size = newsize;
+			       (unsigned long long)bank->start + size_limit - 1);
+			bank->size = size_limit;
 		}
 #endif
 		if (!bank->highmem && bank->start + bank->size > arm_lowmem_limit)
-- 
1.8.2.2
