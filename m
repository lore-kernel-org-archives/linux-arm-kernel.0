From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 23 Jan 2011 06:56:40 +0800
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing in mdesc->map_io()
Message-ID: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@linaro.org>

Provided that the only place initializing the fixed IO mapping is
in mdesc->map_io(), the VMALLOC_END can actually be calculated by
first invoking the function without actually doing the map.

The original idea of auto-calculating the VMALLOC_END came from
Nicolas Pitre.

Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/include/asm/pgtable.h |    6 ++++-
 arch/arm/mm/init.c             |    1 -
 arch/arm/mm/mmu.c              |   44 ++++++++++++++++++++++++++++-----------
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ebcb643..276972f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -21,7 +21,6 @@
 #else
 
 #include <asm/memory.h>
-#include <mach/vmalloc.h>
 #include <asm/pgtable-hwdef.h>
 
 /*
@@ -41,6 +40,11 @@
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #endif
 
+#ifndef __ASSEMBLY__
+extern unsigned long vmalloc_end;
+#endif
+#define VMALLOC_END		(vmalloc_end)
+
 /*
  * Hardware-wise, we have a two level page table structure, where the first
  * level has 4096 entries, and the second level has 256 entries.  Each entry
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5164069..da870df 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -614,7 +614,6 @@ void __init mem_init(void)
 	 * be detected at build time already.
 	 */
 #ifdef CONFIG_MMU
-	BUILD_BUG_ON(VMALLOC_END			> CONSISTENT_BASE);
 	BUG_ON(VMALLOC_END				> CONSISTENT_BASE);
 
 	BUILD_BUG_ON(TASK_SIZE				> MODULES_VADDR);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 3c67e92..98cdb35 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -703,6 +703,12 @@ static void __init create_mapping(struct map_desc *md)
 	} while (pgd++, addr != end);
 }
 
+unsigned long vmalloc_end = 0xff000000ul;
+EXPORT_SYMBOL(vmalloc_end);
+
+static int __initdata probe_vmalloc_end;
+static unsigned long vmalloc_reserve = SZ_128M;
+
 /*
  * Create the architecture specific mappings
  */
@@ -710,11 +716,16 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 {
 	int i;
 
-	for (i = 0; i < nr; i++)
-		create_mapping(io_desc + i);
+	for (i = 0; i < nr; i++) {
+		if (probe_vmalloc_end) {
+			/* align vmalloc_end to PGDIR_SIZE */
+			if (io_desc->virtual < vmalloc_end)
+				vmalloc_end = io_desc->virtual & PGDIR_MASK;
+		} else
+			create_mapping(io_desc + i);
+	}
 }
 
-static void * __initdata vmalloc_min = (void *)(VMALLOC_END - SZ_128M);
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
@@ -723,7 +734,7 @@ static void * __initdata vmalloc_min = (void *)(VMALLOC_END - SZ_128M);
  */
 static int __init early_vmalloc(char *arg)
 {
-	unsigned long vmalloc_reserve = memparse(arg, NULL);
+	vmalloc_reserve = memparse(arg, NULL);
 
 	if (vmalloc_reserve < SZ_16M) {
 		vmalloc_reserve = SZ_16M;
@@ -731,15 +742,6 @@ static int __init early_vmalloc(char *arg)
 			"vmalloc area too small, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
-
-	if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
-		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
-		printk(KERN_WARNING
-			"vmalloc area is too big, limiting to %luMB\n",
-			vmalloc_reserve >> 20);
-	}
-
-	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve);
 	return 0;
 }
 early_param("vmalloc", early_vmalloc);
@@ -749,6 +751,16 @@ static phys_addr_t lowmem_limit __initdata = 0;
 static void __init sanity_check_meminfo(void)
 {
 	int i, j, highmem = 0;
+	void *vmalloc_min;
+
+	if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
+		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
+		printk(KERN_WARNING
+			"vmalloc area is too big, limiting to %luMB\n",
+			vmalloc_reserve >> 20);
+	}
+
+	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve);
 
 	lowmem_limit = __pa(vmalloc_min - 1) + 1;
 	memblock_set_current_limit(lowmem_limit);
@@ -1026,6 +1038,12 @@ void __init paging_init(struct machine_desc *mdesc)
 {
 	void *zero_page;
 
+	if (mdesc->map_io) {
+		probe_vmalloc_end = 1;
+		mdesc->map_io();
+		probe_vmalloc_end = 0;
+	}
+
 	build_mem_type_table();
 	sanity_check_meminfo();
 	prepare_page_table();
-- 
1.7.1
