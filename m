From: labbott@redhat.com (Laura Abbott)
Date: Mon,  9 Jan 2017 17:18:33 -0800
Subject: [PATCHv3 2/2] arm: Adjust memory boundaries after reservations
In-Reply-To: <1484011113-8223-1-git-send-email-labbott@redhat.com>
References: <1484011113-8223-1-git-send-email-labbott@redhat.com>
Message-ID: <1484011113-8223-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adjust_lowmem_bounds is responsible for setting up the boundary for
lowmem/highmem. This needs to be setup before memblock reservations can
occur. At the time memblock reservations can occur, memory can also be
removed from the system. The lowmem/highmem boundary and end of memory
may be affected by this but it is currently not recalculated. On some
systems this may be harmless, on others this may result in incorrect
ranges being passed to the main memory allocator. Correct this by
recalculating the lowmem/highmem boundary after all reservations have
been made.

Tested-by: Magnus Lilja <lilja.magnus@gmail.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Typos and style fixes
---
 arch/arm/kernel/setup.c | 6 ++++++
 arch/arm/mm/mmu.c       | 9 ++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a8051c..f4e5450 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1093,8 +1093,14 @@ void __init setup_arch(char **cmdline_p)
 	setup_dma_zone(mdesc);
 	xen_early_init();
 	efi_init();
+	/*
+	 * Make sure the calculation for lowmem/highmem is set appropriately
+	 * before reserving/allocating any mmeory
+	 */
 	adjust_lowmem_bounds();
 	arm_memblock_init(mdesc);
+	/* Memory may have been removed so recalculate the bounds. */
+	adjust_lowmem_bounds();
 
 	early_ioremap_reset();
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b8f70a3..5cbfd9f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1157,6 +1157,7 @@ void __init adjust_lowmem_bounds(void)
 	phys_addr_t memblock_limit = 0;
 	u64 vmalloc_limit;
 	struct memblock_region *reg;
+	phys_addr_t lowmem_limit = 0;
 
 	/*
 	 * Let's use our own (unoptimized) equivalent of __pa() that is
@@ -1172,14 +1173,14 @@ void __init adjust_lowmem_bounds(void)
 		phys_addr_t block_end = reg->base + reg->size;
 
 		if (reg->base < vmalloc_limit) {
-			if (block_end > arm_lowmem_limit)
+			if (block_end > lowmem_limit)
 				/*
 				 * Compare as u64 to ensure vmalloc_limit does
 				 * not get truncated. block_end should always
 				 * fit in phys_addr_t so there should be no
 				 * issue with assignment.
 				 */
-				arm_lowmem_limit = min_t(u64,
+				lowmem_limit = min_t(u64,
 							 vmalloc_limit,
 							 block_end);
 
@@ -1200,12 +1201,14 @@ void __init adjust_lowmem_bounds(void)
 				if (!IS_ALIGNED(block_start, PMD_SIZE))
 					memblock_limit = block_start;
 				else if (!IS_ALIGNED(block_end, PMD_SIZE))
-					memblock_limit = arm_lowmem_limit;
+					memblock_limit = lowmem_limit;
 			}
 
 		}
 	}
 
+	arm_lowmem_limit = lowmem_limit;
+
 	high_memory = __va(arm_lowmem_limit - 1) + 1;
 
 	/*
-- 
2.7.4
