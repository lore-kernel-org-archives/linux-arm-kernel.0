From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:37 -0500
Subject: [PATCH 19/23] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-20-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

In order to remove the build time variation between different SOCs with
regards to VMALLOC_END, the iotable mappings are now allocated inside
the vmalloc region.  This allows for VMALLOC_END to be identical across
all machines.

The value for VMALLOC_END is now set to 0xff000000 which is right where
the consistent DMA area starts.

To accommodate all static mappings on machines with possible highmem usage,
the default vmalloc area size is changed to 240 MB so that VMALLOC_START
is no higher than 0xf0000000 by default.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 Documentation/arm/memory.txt   |   11 ++++-----
 arch/arm/include/asm/pgtable.h |    8 +-----
 arch/arm/mm/mmu.c              |   48 +++++++++++++++++++++++++++------------
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 771d48d3b3..208a2d465b 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -51,15 +51,14 @@ ffc00000	ffefffff	DMA memory mapping region.  Memory returned
 ff000000	ffbfffff	Reserved for future expansion of DMA
 				mapping region.
 
-VMALLOC_END	feffffff	Free for platform use, recommended.
-				VMALLOC_END must be aligned to a 2MB
-				boundary.
-
 VMALLOC_START	VMALLOC_END-1	vmalloc() / ioremap() space.
 				Memory returned by vmalloc/ioremap will
 				be dynamically placed in this region.
-				VMALLOC_START may be based upon the value
-				of the high_memory variable.
+				Machine specific static mappings are also
+				located here through iotable_init().
+				VMALLOC_START is based upon the value
+				of the high_memory variable, and VMALLOC_END
+				is equal to 0xff000000.
 
 PAGE_OFFSET	high_memory-1	Kernel direct-mapped RAM region.
 				This maps the platforms RAM, and typically
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9451dce3a5..6cdd55cb0b 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -21,7 +21,6 @@
 #else
 
 #include <asm/memory.h>
-#include <mach/vmalloc.h>
 #include <asm/pgtable-hwdef.h>
 
 #include <asm/pgtable-2level.h>
@@ -33,15 +32,10 @@
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
 
 #define LIBRARY_TEXT_START	0x0c000000
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0aa8b7d5b2..942ca8f369 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -15,6 +15,7 @@
 #include <linux/nodemask.h>
 #include <linux/memblock.h>
 #include <linux/fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/cputype.h>
 #include <asm/sections.h>
@@ -529,13 +530,18 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
+static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
 {
-	void *ptr = __va(memblock_alloc(sz, sz));
+	void *ptr = __va(memblock_alloc(sz, align));
 	memset(ptr, 0, sz);
 	return ptr;
 }
 
+static void __init *early_alloc(unsigned long sz)
+{
+	return early_alloc_aligned(sz, sz);
+}
+
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr, unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
@@ -685,9 +691,10 @@ static void __init create_mapping(struct map_desc *md)
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
 
@@ -729,18 +736,29 @@ static void __init create_mapping(struct map_desc *md)
  */
 void __init iotable_init(struct map_desc *io_desc, int nr)
 {
-	int i;
-
-	for (i = 0; i < nr; i++)
-		create_mapping(io_desc + i);
+	struct map_desc *md;
+	struct vm_struct *vm;
+
+	vm = early_alloc_aligned(sizeof(*vm) * nr, __alignof__(*vm));
+
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
+static void * __initdata vmalloc_min =
+	(void *)(VMALLOC_END - (240 << 20) - VMALLOC_OFFSET);
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
  * bytes. This can be used to increase (or decrease) the vmalloc
- * area - the default is 128m.
+ * area - the default is 240m.
  */
 static int __init early_vmalloc(char *arg)
 {
@@ -891,10 +909,10 @@ static inline void prepare_page_table(void)
 
 	/*
 	 * Clear out all the kernel space mappings, except for the first
-	 * memory bank, up to the end of the vmalloc region.
+	 * memory bank, up to the vmalloc region.
 	 */
 	for (addr = __phys_to_virt(end);
-	     addr < VMALLOC_END; addr += PMD_SIZE)
+	     addr < VMALLOC_START; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 }
 
@@ -921,8 +939,8 @@ void __init arm_mm_memblock_reserve(void)
 }
 
 /*
- * Set up device the mappings.  Since we clear out the page tables for all
- * mappings above VMALLOC_END, we will remove any debug device mappings.
+ * Set up the device mappings.  Since we clear out the page tables for all
+ * mappings above VMALLOC_START, we will remove any debug device mappings.
  * This means you have to be careful how you debug this function, or any
  * called function.  This means you can't use any function or debugging
  * method which may touch any device, otherwise the kernel _will_ crash.
@@ -937,7 +955,7 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 */
 	vectors_page = early_alloc(PAGE_SIZE);
 
-	for (addr = VMALLOC_END; addr; addr += PMD_SIZE)
+	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
-- 
1.7.7.1.431.g10b2a
