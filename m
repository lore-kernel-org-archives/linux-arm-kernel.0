From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Oct 2013 08:12:58 +0100
Subject: [PATCH] Simple NX lowmem mappings
Message-ID: <20131024071258.GB16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch has similar functionality to Laura's patch set earlier this
month, except I've just done the basic change - we don't increase the
size of the kernel for this, so there should be no kernel size related
problems with this.  We mark sections which do not overlap any kernel
text as non-executable.  

8<====
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: Implement basic NX support for kernel lowmem mappings

Add basic NX support for kernel lowmem mappings.  We mark any section
which does not overlap kernel text as non-executable, preventing it
from being used to write code and then execute directly from there.

This does not change the alignment of the sections, so the kernel
image doesn't grow significantly via this change, so we can do this
without needing a config option.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/map.h |   27 ++++++++++--------
 arch/arm/mm/mmu.c               |   55 +++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2fe141f..d43f100 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -22,18 +22,21 @@ struct map_desc {
 };
 
 /* types 0-3 are defined in asm/io.h */
-#define MT_UNCACHED		4
-#define MT_CACHECLEAN		5
-#define MT_MINICLEAN		6
-#define MT_LOW_VECTORS		7
-#define MT_HIGH_VECTORS		8
-#define MT_MEMORY		9
-#define MT_ROM			10
-#define MT_MEMORY_NONCACHED	11
-#define MT_MEMORY_DTCM		12
-#define MT_MEMORY_ITCM		13
-#define MT_MEMORY_SO		14
-#define MT_MEMORY_DMA_READY	15
+enum {
+	MT_UNCACHED = 4,
+	MT_CACHECLEAN,
+	MT_MINICLEAN,
+	MT_LOW_VECTORS,
+	MT_HIGH_VECTORS,
+	MT_MEMORY,
+	MT_MEMORY_NX,
+	MT_ROM,
+	MT_MEMORY_NONCACHED,
+	MT_MEMORY_DTCM,
+	MT_MEMORY_ITCM,
+	MT_MEMORY_SO,
+	MT_MEMORY_DMA_READY,
+};
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 53cdbd3..e8f0f94 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/sections.h>
 #include <asm/cachetype.h>
+#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
@@ -291,6 +292,13 @@ static struct mem_type mem_types[] = {
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_MEMORY_NX] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+			     L_PTE_XN,
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
+		.domain    = DOMAIN_KERNEL,
+	},
 	[MT_ROM] = {
 		.prot_sect = PMD_TYPE_SECT,
 		.domain    = DOMAIN_KERNEL,
@@ -408,6 +416,9 @@ static void __init build_mem_type_table(void)
 			mem_types[MT_DEVICE_NONSHARED].prot_sect |= PMD_SECT_XN;
 			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_XN;
 			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_XN;
+
+			/* Also setup NX memory mapping */
+			mem_types[MT_MEMORY_NX].prot_sect |= PMD_SECT_XN;
 		}
 		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
 			/*
@@ -487,6 +498,8 @@ static void __init build_mem_type_table(void)
 			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
 			mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_MEMORY_NX].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_NX].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY_DMA_READY].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
 			mem_types[MT_MEMORY_NONCACHED].prot_pte |= L_PTE_SHARED;
@@ -543,6 +556,8 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
 	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
+	mem_types[MT_MEMORY_NX].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY_NX].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_DMA_READY].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
@@ -1294,6 +1309,8 @@ static void __init kmap_init(void)
 static void __init map_lowmem(void)
 {
 	struct memblock_region *reg;
+	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
+	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
 
 	/* Map all the lowmem memory banks. */
 	for_each_memblock(memory, reg) {
@@ -1306,12 +1323,40 @@ static void __init map_lowmem(void)
 		if (start >= end)
 			break;
 
-		map.pfn = __phys_to_pfn(start);
-		map.virtual = __phys_to_virt(start);
-		map.length = end - start;
-		map.type = MT_MEMORY;
+		if (end < kernel_x_start || start >= kernel_x_end) {
+			map.pfn = __phys_to_pfn(start);
+			map.virtual = __phys_to_virt(start);
+			map.length = end - start;
+			map.type = MT_MEMORY;
 
-		create_mapping(&map);
+			create_mapping(&map);
+		} else {
+			/* This better cover the entire kernel */
+			if (start < kernel_x_start) {
+				map.pfn = __phys_to_pfn(start);
+				map.virtual = __phys_to_virt(start);
+				map.length = kernel_x_start - start;
+				map.type = MT_MEMORY_NX;
+
+				create_mapping(&map);
+			}
+
+			map.pfn = __phys_to_pfn(kernel_x_start);
+			map.virtual = __phys_to_virt(kernel_x_start);
+			map.length = kernel_x_end - kernel_x_start;
+			map.type = MT_MEMORY;
+
+			create_mapping(&map);
+
+			if (kernel_x_end < end) {
+				map.pfn = __phys_to_pfn(kernel_x_end);
+				map.virtual = __phys_to_virt(kernel_x_end);
+				map.length = end - kernel_x_end;
+				map.type = MT_MEMORY_NX;
+
+				create_mapping(&map);
+			}
+		}
 	}
 }
 
