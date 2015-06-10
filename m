From: orca.chen@gmail.com (Min-Hua Chen)
Date: Thu, 11 Jun 2015 02:59:32 +0800
Subject: [PATCHv3 1/2] arm: fix non-section-aligned low memory mapping
In-Reply-To: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
References: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
Message-ID: <1433962773-8402-2-git-send-email-orca.chen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current design, the memblock.current_limit is set to
a section-aligned value in sanity_check_meminfo().

However, the section-aligned memblock may become non-section-aligned
after arm_memblock_init(). For example, the first section-aligned
memblock is 0x00000000-0x01000000 and sanity_check_meminfo sets
current_limit to 0x01000000. After arm_memblock_init, two memory blocks
[0x00c00000 - 0x00d00000] and [0x00ff0000 - 0x01000000] are reserved
by memblock_reserve() and make the original memory block
[0x00000000-0x01000000] becomes:

[0x00000000-0x00c00000]
[0x00d00000-0x00ff0000]

When creating the low memory mapping for [0x00d00000-0x00ff0000],
since the memory block is non-section-aligned, it will need to create
a second level page table. But the current_limit is set to 0x01000000,
and it's possible to allocate a unmapped memory block.

call flow:

setup_arch
 + sanity_check_meminfo
 + arm_memblock_init
 + paging_init
    + map_lowmem
    + bootmem_init

Move the memblock_set_current_limit logic to map_lowmem(), we point
the memblock current_limit to the first section-aligned memblock block.
Since map_lowmem() is called after arm_memblock_init(), there is no way to
change memblock layout. So we can say that the first section-aligned limit
is valid during map_lowmem(). Hence fix the problem described above.

Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>
---
 arch/arm/mm/mmu.c |   48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4e6ef89..73e64ab 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1068,7 +1068,6 @@ phys_addr_t arm_lowmem_limit __initdata = 0;
 
 void __init sanity_check_meminfo(void)
 {
-	phys_addr_t memblock_limit = 0;
 	int highmem = 0;
 	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
 	struct memblock_region *reg;
@@ -1110,43 +1109,10 @@ void __init sanity_check_meminfo(void)
 				else
 					arm_lowmem_limit = block_end;
 			}
-
-			/*
-			 * Find the first non-section-aligned page, and point
-			 * memblock_limit at it. This relies on rounding the
-			 * limit down to be section-aligned, which happens at
-			 * the end of this function.
-			 *
-			 * With this algorithm, the start or end of almost any
-			 * bank can be non-section-aligned. The only exception
-			 * is that the start of the bank 0 must be section-
-			 * aligned, since otherwise memory would need to be
-			 * allocated when mapping the start of bank 0, which
-			 * occurs before any free memory is mapped.
-			 */
-			if (!memblock_limit) {
-				if (!IS_ALIGNED(block_start, SECTION_SIZE))
-					memblock_limit = block_start;
-				else if (!IS_ALIGNED(block_end, SECTION_SIZE))
-					memblock_limit = arm_lowmem_limit;
-			}
-
 		}
 	}
 
 	high_memory = __va(arm_lowmem_limit - 1) + 1;
-
-	/*
-	 * Round the memblock limit down to a section size.  This
-	 * helps to ensure that we will allocate memory from the
-	 * last full section, which should be mapped.
-	 */
-	if (memblock_limit)
-		memblock_limit = round_down(memblock_limit, SECTION_SIZE);
-	if (!memblock_limit)
-		memblock_limit = arm_lowmem_limit;
-
-	memblock_set_current_limit(memblock_limit);
 }
 
 static inline void prepare_page_table(void)
@@ -1331,6 +1297,7 @@ static void __init map_lowmem(void)
 	struct memblock_region *reg;
 	phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
 	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+	phys_addr_t section_block_limit = 0;
 
 	/* Map all the lowmem memory banks. */
 	for_each_memblock(memory, reg) {
@@ -1384,6 +1351,19 @@ static void __init map_lowmem(void)
 				create_mapping(&map);
 			}
 		}
+
+		/*
+		 * The first memblock MUST be section-size-aligned. Otherwise
+		 * there is no valid low memory mapping to create 2nd level
+		 * page tables.
+		 * After the first mapping is created, other 2nd level
+		 * page tables can be created from the memory allocated
+		 * from the first memblock.
+		 */
+		if (!section_memblock_limit) {
+			section_memblock_limit = end;
+			memblock_set_current_limit(section_memblock_limit);
+		}
 	}
 }
 
-- 
1.7.10.4
