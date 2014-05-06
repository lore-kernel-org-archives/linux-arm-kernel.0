From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 May 2014 17:58:07 -0500
Subject: [PATCH 3/3] ARM: fixmap early permanent mapping support
In-Reply-To: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
References: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399417087-24772-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This adds early permanent mapping support to fixmap early mappings.
Unlike early_ioremap mappings, permanent mappings are kept after
paging_init. Each permament mapping must be explicitly added.
Initially, the only permanent mapping is for early console.

The early pmd and ptes are still destroyed and recreated since the
attributes may change as the memory types are initialized.

Cc: Mark Salter <msalter@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/Kconfig                |  3 +++
 arch/arm/include/asm/fixmap.h   |  7 +++++++
 arch/arm/include/asm/mach/map.h |  1 +
 arch/arm/mm/early_ioremap.c     | 22 ++++++++++++++++++++++
 arch/arm/mm/mmu.c               |  6 +++---
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b33c68b..f15a096 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -188,6 +188,9 @@ config ARCH_HAS_CPUFREQ
 config ARCH_HAS_BANDGAP
 	bool
 
+config FIX_EARLYCON_MEM
+	def_bool EARLY_IOREMAP
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index e36020c..3324599 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -1,6 +1,9 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
 /*
  * Nothing too fancy for now.
  *
@@ -18,6 +21,8 @@
 #define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
 
 enum fixed_addresses {
+	FIX_EARLYCON_MEM_BASE,
+	__end_of_permanent_fixed_addresses,
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = (FIXADDR_TOP - FIXADDR_START) >> PAGE_SHIFT,
 	__end_of_fixed_addresses
@@ -44,6 +49,8 @@ enum fixed_addresses {
 extern void __early_set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags);
 
+#define __set_fixmap __early_set_fixmap
+
 #include <asm-generic/fixmap.h>
 
 #endif
diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index f98c7f3..cc5ed24 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -39,6 +39,7 @@ enum {
 };
 
 #ifdef CONFIG_MMU
+extern void create_mapping(struct map_desc *);
 extern void iotable_init(struct map_desc *, int);
 extern void vm_reserve_area_early(unsigned long addr, unsigned long size,
 				  void *caller);
diff --git a/arch/arm/mm/early_ioremap.c b/arch/arm/mm/early_ioremap.c
index 0258a20..cf143115 100644
--- a/arch/arm/mm/early_ioremap.c
+++ b/arch/arm/mm/early_ioremap.c
@@ -86,5 +86,27 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 
 void __init early_ioremap_shutdown(void)
 {
+	int i;
+
 	pmd_clear(early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)));
+
+	/* Create new entries for permanent mappings */
+	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
+		pte_t *pte;
+		struct map_desc map;
+
+		map.virtual = fix_to_virt(i);
+		pte = early_ioremap_pte(map.virtual);
+
+		/* Only i/o device mappings are supported ATM */
+		if (pte_none(*pte) ||
+		    (pte_val(*pte) & L_PTE_MT_MASK) != L_PTE_MT_DEV_SHARED)
+			continue;
+
+		map.pfn = pte_pfn(*pte);
+		map.type = MT_DEVICE;
+		map.length = PAGE_SIZE;
+
+		create_mapping(&map);
+	}
 }
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9576f87..b2187f1 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -829,7 +829,7 @@ static void __init create_36bit_mapping(struct map_desc *md,
  * offsets, and we take full advantage of sections and
  * supersections.
  */
-static void __init create_mapping(struct map_desc *md)
+void __init create_mapping(struct map_desc *md)
 {
 	unsigned long addr, length, end;
 	phys_addr_t phys;
@@ -844,7 +844,7 @@ static void __init create_mapping(struct map_desc *md)
 	}
 
 	if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
-	    md->virtual >= PAGE_OFFSET &&
+	    md->virtual >= PAGE_OFFSET && md->virtual < 0xffe00000 &&
 	    (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
 		printk(KERN_WARNING "BUG: mapping for 0x%08llx"
 		       " at 0x%08lx out of vmalloc space\n",
@@ -1271,7 +1271,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 
 	early_trap_init(vectors);
 
-	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
+	for (addr = VMALLOC_START; addr < 0xffe00000; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
-- 
1.9.1
