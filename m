From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Apr 2015 15:51:48 +0200
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
Message-ID: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for fixmap based earlycon by moving the fixmap
initialization to an earlier stage and introducing the Kconfig symbol
that wires up the existing code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/Kconfig              |  3 +++
 arch/arm/include/asm/fixmap.h |  6 ++++++
 arch/arm/kernel/setup.c       |  2 ++
 arch/arm/mm/mmu.c             | 16 +++++++++++++---
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48ba0b12..0076330789f5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -287,6 +287,9 @@ config GENERIC_BUG
 	def_bool y
 	depends on BUG
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 config PGTABLE_LEVELS
 	int
 	default 3 if ARM_LPAE
diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 0415eae1df27..e0abd3a150ee 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
+#include <asm/pgtable.h>
+
+#define FIXMAP_PAGE_IO		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY
+
 #define FIXADDR_START		0xffc00000UL
 #define FIXADDR_END		0xfff00000UL
 #define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
@@ -11,6 +15,8 @@ enum fixed_addresses {
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
 
+	FIX_EARLYCON_MEM_BASE,
+
 	/* Support writing RO kernel text via kprobes, jump labels, etc. */
 	FIX_TEXT_POKE0,
 	FIX_TEXT_POKE1,
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6c777e908a24..2e4b3c22be4d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -80,6 +80,7 @@ extern void early_paging_init(const struct machine_desc *,
 extern void sanity_check_meminfo(void);
 extern enum reboot_mode reboot_mode;
 extern void setup_dma_zone(const struct machine_desc *desc);
+extern void early_fixmap_init(void);
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
@@ -915,6 +916,7 @@ void __init setup_arch(char **cmdline_p)
 	const struct machine_desc *mdesc;
 
 	setup_processor();
+	early_fixmap_init();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4e6ef896c619..d072726c3781 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1231,7 +1231,9 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 
 	early_trap_init(vectors);
 
-	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
+	for (addr = VMALLOC_START; addr < FIXADDR_START; addr += PMD_SIZE)
+		pmd_clear(pmd_off_k(addr));
+	for (addr = round_up(FIXADDR_END, PMD_SIZE); addr; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
@@ -1321,9 +1323,17 @@ static void __init kmap_init(void)
 	pkmap_page_table = early_pte_alloc(pmd_off_k(PKMAP_BASE),
 		PKMAP_BASE, _PAGE_KERNEL_TABLE);
 #endif
+}
+
+void __init early_fixmap_init(void)
+{
+	static u8 fixmap_pte[PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE] __page_aligned_bss;
+	pmd_t *pmd = pmd_off_k(FIXADDR_START);
+
+	if (pmd_none(*pmd))
+		__pmd_populate(pmd, __pa(fixmap_pte), _PAGE_KERNEL_TABLE);
 
-	early_pte_alloc(pmd_off_k(FIXADDR_START), FIXADDR_START,
-			_PAGE_KERNEL_TABLE);
+	BUG_ON(pmd_bad(*pmd));
 }
 
 static void __init map_lowmem(void)
-- 
1.9.1
