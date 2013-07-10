From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Jul 2013 12:43:51 -0600
Subject: [PATCH V2] ARM: mm: restrict early_alloc to section-aligned memory
Message-ID: <1373481831-31459-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk@arm.linux.org.uk>

When map_lowmem() runs, and processes a memory bank whose start or end
is not section-aligned, memory must be allocated to store the 2nd-level
page tables. Those allocations are made by calling memblock_alloc().

At this point, the only memory that is free *and* mapped is memory which
has already been mapped by map_lowmem() itself. For this reason, we must
calculate the first point at which map_lowmem() will need to allocate
memory, and set the memblock allocation limit to a lower address, so that
memblock_alloc() is guaranteed to return memory that is already mapped.

This patch enhances sanity_check_meminfo() to calculate that memory
address, and pass it to memblock_set_current_limit(), rather than just
assuming the limit is arm_lowmem_limit.

The algorithm applied is:

* Default memblock_limit to arm_lowmem_limit in the absence of any other
  limit; arm_lowmem_limit is the highest memory that is mapped by
  map_lowmem().

* While walking the list of memblocks, if the start of a block is not
  aligned, 2nd-level page tables will need to be allocated to map the
  first few pages of the block. Hence, the memblock_limit must be before
  the start of the block.

* Similarly, if the end of any block is not aligned, 2nd-level page
  tables will need to be allocated to map the last few pages of the
  block. Hence, the memblock_limit must point at the end of the block,
  rounded down to section-alignment.

* The memory blocks are assumed to be sorted in address order, so the
  first unaligned block start or end is used to set the limit.

With this algorithm, the start or end of almost any bank can be non-
section-aligned. The only exception is that the start of bank 0 must
be section-aligned, since otherwise memory would need to be allocated
when mapping the start of bank 0, which occurs before any free memory
is mapped.

Not-yet-signed-off-by: Russell King <rmk@arm.linux.org.uk>
[swarren, wrote commit description, rewrote calculation of memblock_limit]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
V2: completely new implementation based on Russell's suggestion.

Russell, since this is strongly based on your patch, I set you as the
author in git. I assume that's OK. If not, let me know and I'll change
the patch to my authorship and add a note to the commit description
that it's based on your original.

I rewrote the algorithm that calculates memblock_limit to cover the case
of the following memblocks:

0          .. 0x1fc00000 (all section aligned)
0x1fd01000 .. 0x20000000 (start isn't section aligned)

Neither of those matched your start-is-aligned-end-isn't test, so your
patch didn't quite solve my problem, since it didn't set memblock_limit.

 arch/arm/mm/mmu.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index d7229d2..08cfa31 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -989,6 +989,7 @@ phys_addr_t arm_lowmem_limit __initdata = 0;
 
 void __init sanity_check_meminfo(void)
 {
+	phys_addr_t memblock_limit = 0;
 	int i, j, highmem = 0;
 	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
 
@@ -1052,9 +1053,32 @@ void __init sanity_check_meminfo(void)
 			bank->size = size_limit;
 		}
 #endif
-		if (!bank->highmem && bank->start + bank->size > arm_lowmem_limit)
-			arm_lowmem_limit = bank->start + bank->size;
+		if (!bank->highmem) {
+			phys_addr_t bank_end = bank->start + bank->size;
 
+			if (bank_end > arm_lowmem_limit)
+				arm_lowmem_limit = bank_end;
+
+			/*
+			 * Find the first non-section-aligned page, and point
+			 * memblock_limit at it. This relies on rounding the
+			 * limit down to be section-aligned, which happens at
+			 * the end of this function.
+			 *
+			 * With this algorithm, the start or end of almost any
+			 * bank can be non-section-aligned. The only exception
+			 * is that the start of the bank 0 must be section-
+			 * aligned, since otherwise memory would need to be
+			 * allocated when mapping the start of bank 0, which
+			 * occurs before any free memory is mapped.
+			 */
+			if (!memblock_limit) {
+				if (!IS_ALIGNED(bank->start, SECTION_SIZE))
+					memblock_limit = bank->start;
+				else if (!IS_ALIGNED(bank_end, SECTION_SIZE))
+					memblock_limit = bank_end;
+			}
+		}
 		j++;
 	}
 #ifdef CONFIG_HIGHMEM
@@ -1079,7 +1103,18 @@ void __init sanity_check_meminfo(void)
 #endif
 	meminfo.nr_banks = j;
 	high_memory = __va(arm_lowmem_limit - 1) + 1;
-	memblock_set_current_limit(arm_lowmem_limit);
+
+	/*
+	 * Round the memblock limit down to a section size.  This
+	 * helps to ensure that we will allocate memory from the
+	 * last full section, which should be mapped.
+	 */
+	if (memblock_limit)
+		memblock_limit = round_down(memblock_limit, SECTION_SIZE);
+	if (!memblock_limit)
+		memblock_limit = arm_lowmem_limit;
+
+	memblock_set_current_limit(memblock_limit);
 }
 
 static inline void prepare_page_table(void)
@@ -1276,8 +1311,6 @@ void __init paging_init(struct machine_desc *mdesc)
 {
 	void *zero_page;
 
-	memblock_set_current_limit(arm_lowmem_limit);
-
 	build_mem_type_table();
 	prepare_page_table();
 	map_lowmem();
-- 
1.8.1.5
