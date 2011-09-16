From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:27 -0400
Subject: [PATCH 16/19] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-17-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

In order to remove the build time variation between different SOCs with
regards to VMALLOC_END, the iotable mappings are now allocated inside
the vmalloc region.  This allows for VMALLOC_END to be identical across
all machines.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/pgtable.h |    8 +------
 arch/arm/mm/mmu.c              |   42 +++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5750704e02..950dee3ce2 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -21,7 +21,6 @@
 #else
 
 #include <asm/memory.h>
-#include <mach/vmalloc.h>
 #include <asm/pgtable-hwdef.h>
 
 /*
@@ -31,15 +30,10 @@
  * any out-of-bounds memory accesses will hopefully be caught.
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
- *
- * Note that platforms may override VMALLOC_START, but they must provide
- * VMALLOC_END.  VMALLOC_END defines the (exclusive) limit of this space,
- * which may not overlap IO space.
  */
-#ifndef VMALLOC_START
 #define VMALLOC_OFFSET		(8*1024*1024)
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-#endif
+#define VMALLOC_END		0xff000000UL
 
 /*
  * Hardware-wise, we have a two level page table structure, where the first
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 594d677b92..6996576488 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -15,6 +15,7 @@
 #include <linux/nodemask.h>
 #include <linux/memblock.h>
 #include <linux/fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/cputype.h>
 #include <asm/sections.h>
@@ -677,9 +678,10 @@ static void __init create_mapping(struct map_desc *md)
 	}
 
 	if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
-	    md->virtual >= PAGE_OFFSET && md->virtual < VMALLOC_END) {
+	    md->virtual >= PAGE_OFFSET &&
+	    (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
 		printk(KERN_WARNING "BUG: mapping for 0x%08llx"
-		       " at 0x%08lx overlaps vmalloc space\n",
+		       " at 0x%08lx out of vmalloc space\n",
 		       (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
 	}
 
@@ -721,18 +723,29 @@ static void __init create_mapping(struct map_desc *md)
  */
 void __init iotable_init(struct map_desc *io_desc, int nr)
 {
-	int i;
+	struct map_desc *md;
+	struct vm_struct *vm;
+
+	vm = __va(memblock_alloc(sizeof(*vm) * nr, __alignof__(*vm)));
+	memset(vm, 0, sizeof(*vm) * nr);
 
-	for (i = 0; i < nr; i++)
-		create_mapping(io_desc + i);
+	for (md = io_desc; nr; md++, nr--) {
+		create_mapping(md);
+		vm->addr = (void *)(md->virtual & PAGE_MASK);
+		vm->size = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));
+		vm->phys_addr = __pfn_to_phys(md->pfn); 
+		vm->flags = VM_IOREMAP;
+		vm->caller = iotable_init;
+		vm_area_add_early(vm++);
+	}
 }
 
-static void * __initdata vmalloc_min = (void *)(VMALLOC_END - SZ_128M);
+static void * __initdata vmalloc_min = (void *)(0xf0000000UL - VMALLOC_OFFSET);
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
  * bytes. This can be used to increase (or decrease) the vmalloc
- * area - the default is 128m.
+ * area - the default is 240m.
  */
 static int __init early_vmalloc(char *arg)
 {
@@ -853,6 +866,7 @@ void __init sanity_check_meminfo(void)
 #endif
 	meminfo.nr_banks = j;
 	memblock_set_current_limit(lowmem_limit);
+	high_memory = __va(lowmem_limit - 1) + 1;
 }
 
 static inline void prepare_page_table(void)
@@ -882,10 +896,10 @@ static inline void prepare_page_table(void)
 
 	/*
 	 * Clear out all the kernel space mappings, except for the first
-	 * memory bank, up to the end of the vmalloc region.
+	 * memory bank, up to the vmalloc region.
 	 */
 	for (addr = __phys_to_virt(end);
-	     addr < VMALLOC_END; addr += PGDIR_SIZE)
+	     addr < VMALLOC_START; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
 }
 
@@ -910,8 +924,8 @@ void __init arm_mm_memblock_reserve(void)
 }
 
 /*
- * Set up device the mappings.  Since we clear out the page tables for all
- * mappings above VMALLOC_END, we will remove any debug device mappings.
+ * Set up the device mappings.  Since we clear out the page tables for all
+ * mappings below VMALLOC_END, we will remove any debug device mappings.
  * This means you have to be careful how you debug this function, or any
  * called function.  This means you can't use any function or debugging
  * method which may touch any device, otherwise the kernel _will_ crash.
@@ -977,6 +991,12 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	}
 
 	/*
+	 * Clear the vmalloc area.
+	 */
+	for (addr = VMALLOC_START; addr < VMALLOC_END; addr += PGDIR_SIZE)
+		pmd_clear(pmd_off_k(addr));
+
+	/*
 	 * Ask the machine support to map in the statically mapped devices.
 	 */
 	if (mdesc->map_io)
-- 
1.7.7-rc0
