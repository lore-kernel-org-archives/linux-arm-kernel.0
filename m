From: labbott@redhat.com (Laura Abbott)
Date: Tue,  3 Jan 2017 12:56:50 -0800
Subject: [PATCH 2/2] arm: Adjust memory boundaries after reservations
In-Reply-To: <1483477010-18986-1-git-send-email-labbott@redhat.com>
References: <1483477010-18986-1-git-send-email-labbott@redhat.com>
Message-ID: <1483477010-18986-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


adjust_lowmem_bounds is responsible for setting up the boundary for
lowmem/hihgmme. This needs to be setup before memblock reservations can
occur. At the time memblock reservations can occur, memory can also be
removed from the system. The lowmem/highmem boundary and end of memory
may be affected by this but it is currently not recalculated. On some
systems this may be harmless, on o thers this may result in incorrect
ranges being passed to the main memory allocator. Correct this by
recalculating the lowmem/highmem boundary after all reservations have
been made.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm/kernel/setup.c | 8 ++++++++
 arch/arm/mm/mmu.c       | 9 ++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a8051c..4625115 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1093,8 +1093,16 @@ void __init setup_arch(char **cmdline_p)
 	setup_dma_zone(mdesc);
 	xen_early_init();
 	efi_init();
+	/*
+	 * Make sure the calcualtion for lowmem/highmem is set appropriately
+	 * before reserving/allocating any mmeory
+	 */
 	adjust_lowmem_bounds();
 	arm_memblock_init(mdesc);
+	/*
+	 * Memory may have been removed so recalculate the bounds.
+	 */
+	adjust_lowmem_bounds();
 
 	early_ioremap_reset();
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 32ecdfd..3f12a64 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1157,6 +1157,7 @@ void __init adjust_lowmem_bounds(void)
 	phys_addr_t memblock_limit = 0;
 	u64 vmalloc_limit;
 	struct memblock_region *reg;
+	phys_addr_t lowmem_limit = 0;
 
 	/*
 	 * Let's use our own (unoptimized) equivalent of __pa() that is
@@ -1173,8 +1174,8 @@ void __init adjust_lowmem_bounds(void)
 
 
 		if (reg->base < vmalloc_limit) {
-			if (block_end > arm_lowmem_limit)
-				arm_lowmem_limit = min(
+			if (block_end > lowmem_limit)
+				lowmem_limit = min(
 						(phys_addr_t)vmalloc_limit,
 						block_end);
 
@@ -1195,12 +1196,14 @@ void __init adjust_lowmem_bounds(void)
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
