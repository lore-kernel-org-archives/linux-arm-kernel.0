From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 01 Jul 2015 22:45:54 +0100
Subject: [PATCH] ARM: add helpful message when truncating physical memory
Message-ID: <E1ZAPpK-0003Nf-Fm@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a nmessage to suggest that HIGHMEM is enabled when physical memory
is truncated due to lack of virtual address space to map it in the low
memory mapping.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 904d1532e6d0..79de062c6077 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1072,6 +1072,7 @@ void __init sanity_check_meminfo(void)
 	int highmem = 0;
 	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
 	struct memblock_region *reg;
+	bool should_use_highmem = false;
 
 	for_each_memblock(memory, reg) {
 		phys_addr_t block_start = reg->base;
@@ -1090,6 +1091,7 @@ void __init sanity_check_meminfo(void)
 				pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
 					  &block_start, &block_end);
 				memblock_remove(reg->base, reg->size);
+				should_use_highmem = true;
 				continue;
 			}
 
@@ -1100,6 +1102,7 @@ void __init sanity_check_meminfo(void)
 					  &block_start, &block_end, &vmalloc_limit);
 				memblock_remove(vmalloc_limit, overlap_size);
 				block_end = vmalloc_limit;
+				should_use_highmem = true;
 			}
 		}
 
@@ -1134,6 +1137,9 @@ void __init sanity_check_meminfo(void)
 		}
 	}
 
+	if (should_use_highmem)
+		pr_notice("Consider using a HIGHMEM enabled kernel.\n");
+
 	high_memory = __va(arm_lowmem_limit - 1) + 1;
 
 	/*
-- 
2.1.0
