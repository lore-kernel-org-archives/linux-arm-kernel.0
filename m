From: labbott@redhat.com (Laura Abbott)
Date: Tue, 13 Dec 2016 18:11:41 -0800
Subject: [PATCH] arm: Adjust memory boundaries after reservations
Message-ID: <1481681501-13788-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The poorly named sanity_check_meminfo is responsible for setting up the
boundary for lowmem/highmem. This needs to be set up before memblock
reservations can occur. At the time memblock reservations can occur,
memory can also be removed from the system. This can throw off the
calculation of the lowmem/highmem boundary. On some systems this may be
harmless, on others this may result in incorrect ranges being passed to
the main memory allocator. Correct this by recalcuating the
lowmem/highmem boundary after all reservations have been made.
As part of this, rename sanity_check_meminfo to actually refect what the
function is doing.

Reported-by: Magnus Lilja <lilja.magnus@gmail.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
The particular issue I reproduced for
https://marc.info/?l=linux-arm-kernel&m=148145259511248 involved the lowmem
boundary being greater than the end of ram thanks to the memblock_steal.
The re-calcuation should have no effect unless memory was actually removed
from the system. Putting it in arm_memblock_steal doesn't cover all cases
either since the devicetree memory map can also remove memory.
---
 arch/arm/kernel/setup.c | 12 ++++++++++--
 arch/arm/mm/mmu.c       | 15 +++++++++------
 arch/arm/mm/nommu.c     |  2 +-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 34e3f3c..62f91bd 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -81,7 +81,7 @@ __setup("fpe=", fpe_setup);
 extern void init_default_cache_policy(unsigned long);
 extern void paging_init(const struct machine_desc *desc);
 extern void early_paging_init(const struct machine_desc *);
-extern void sanity_check_meminfo(void);
+extern void update_memory_bounds(void);
 extern enum reboot_mode reboot_mode;
 extern void setup_dma_zone(const struct machine_desc *desc);
 
@@ -1093,8 +1093,16 @@ void __init setup_arch(char **cmdline_p)
 	setup_dma_zone(mdesc);
 	xen_early_init();
 	efi_init();
-	sanity_check_meminfo();
+	/*
+	 * We need to make sure the calculation for lowmem/highmem is set
+	 * appropriately before reserving/allocating any memory
+	 */
+	update_memory_bounds();
 	arm_memblock_init(mdesc);
+	/*
+	 * Memory may have been removed so the bounds need to be recalcuated.
+	 */
+	update_memory_bounds();
 
 	early_ioremap_reset();
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4001dd1..666e789 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1152,13 +1152,14 @@ early_param("vmalloc", early_vmalloc);
 
 phys_addr_t arm_lowmem_limit __initdata = 0;
 
-void __init sanity_check_meminfo(void)
+void __init update_memory_bounds(void)
 {
 	phys_addr_t memblock_limit = 0;
 	int highmem = 0;
 	u64 vmalloc_limit;
 	struct memblock_region *reg;
 	bool should_use_highmem = false;
+	phys_addr_t lowmem_limit = 0;
 
 	/*
 	 * Let's use our own (unoptimized) equivalent of __pa() that is
@@ -1196,18 +1197,18 @@ void __init sanity_check_meminfo(void)
 				pr_notice("Truncating RAM at %pa-%pa",
 					  &block_start, &block_end);
 				block_end = vmalloc_limit;
-				pr_cont(" to -%pa", &block_end);
+				pr_cont(" to -%pa\n", &block_end);
 				memblock_remove(vmalloc_limit, overlap_size);
 				should_use_highmem = true;
 			}
 		}
 
 		if (!highmem) {
-			if (block_end > arm_lowmem_limit) {
+			if (block_end > lowmem_limit) {
 				if (reg->size > size_limit)
-					arm_lowmem_limit = vmalloc_limit;
+					lowmem_limit = vmalloc_limit;
 				else
-					arm_lowmem_limit = block_end;
+					lowmem_limit = block_end;
 			}
 
 			/*
@@ -1227,12 +1228,14 @@ void __init sanity_check_meminfo(void)
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
 	if (should_use_highmem)
 		pr_notice("Consider using a HIGHMEM enabled kernel.\n");
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 2740967..e5bc874 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -295,7 +295,7 @@ void __init arm_mm_memblock_reserve(void)
 #endif
 }
 
-void __init sanity_check_meminfo(void)
+void __init update_memory_bounds(void)
 {
 	phys_addr_t end;
 	sanity_check_meminfo_mpu();
-- 
2.7.4
