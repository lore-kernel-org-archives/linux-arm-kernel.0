From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 06 Apr 2017 17:03:14 +0100
Subject: [PATCH v4] arm: Fix memory attribute inconsistencies when using fixmap
In-Reply-To: <CAKv+Gu_EVqqQGXauWmfhhmJZEyrPDEHDiN2T23XVPy_eR99Lsg@mail.gmail.com>
References: <1491291087-17450-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170405224245.GA17774@n2100.armlinux.org.uk>
 <1491486403.2950.3.camel@linaro.org>
 <CAKv+Gu_EVqqQGXauWmfhhmJZEyrPDEHDiN2T23XVPy_eR99Lsg@mail.gmail.com>
Message-ID: <1491494594.2950.7.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To cope with the variety in ARM architectures and configurations, the
pagetable attributes for kernel memory are generated at runtime to match
the system the kernel finds itself on. This calculated value is stored
in pgprot_kernel.

However, when early fixmap support was added for ARM (commit
a5f4c561b3b1) the attributes used for mappings were hard coded because
pgprot_kernel is not set up early enough. Unfortunately, when fixmap is
used after early boot this means the memory being mapped can have
different attributes to existing mappings, potentially leading to
unpredictable behaviour. A specific problem also exists due to the hard
coded values not include the 'shareable' attribute which means on
systems where this matters (e.g. those with multiple CPU clusters) the
cache contents for a memory location can become inconsistent between
CPUs.

To resolve these issues we change fixmap to use the same memory
attributes (from pgprot_kernel) that the rest of the kernel uses. To
enable this we need to refactor the initialisation code so
build_mem_type_table() is called early enough. Note, that relies on early
param parsing for memory type overrides passed via the kernel command
line, so we need to make sure this call is still after
parse_early_params().

Fixes: a5f4c561b3b1 ("ARM: 8415/1: early fixmap support for earlycon")
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Jon Medhurst <tixy@linaro.org>
[ardb: keep early_fixmap_init() before param parsing, for earlycon]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

v4: - Drop declaration of early_mm_init() from arch/arm/include/asm/mmu.h
      and make early_paging_init() static.

Ard's v3:
    - Unfortunately, I failed to spot an issue with earlycon when testing
      Tixy's v2. Earlycon depends on fixmap, but only for device mappings,
      which are not affected by this change. So instead, preserve the calls
      to early_fixmap_init() and early_ioremap_init() in their original
      locations, and only move build_mem_type_table() to the earliest
      possible moment in boot, which is right after early param parsing
      (which may set cachepolicy/nocache/nowb variables)

 arch/arm/include/asm/fixmap.h |  2 +-
 arch/arm/kernel/setup.c       |  4 ++--
 arch/arm/mm/mmu.c             | 16 +++++++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 5c17d2dec777..8f967d1373f6 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -41,7 +41,7 @@ static const enum fixed_addresses __end_of_fixed_addresses =
 
 #define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
 
-#define FIXMAP_PAGE_NORMAL	(FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
+#define FIXMAP_PAGE_NORMAL	(pgprot_kernel | L_PTE_XN)
 #define FIXMAP_PAGE_RO		(FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
 
 /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f4e54503afa9..32e1a9513dc7 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -80,7 +80,7 @@ __setup("fpe=", fpe_setup);
 
 extern void init_default_cache_policy(unsigned long);
 extern void paging_init(const struct machine_desc *desc);
-extern void early_paging_init(const struct machine_desc *);
+extern void early_mm_init(const struct machine_desc *);
 extern void adjust_lowmem_bounds(void);
 extern enum reboot_mode reboot_mode;
 extern void setup_dma_zone(const struct machine_desc *desc);
@@ -1088,7 +1088,7 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 #ifdef CONFIG_MMU
-	early_paging_init(mdesc);
+	early_mm_init(mdesc);
 #endif
 	setup_dma_zone(mdesc);
 	xen_early_init();
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4e016d7f37b3..347cca965783 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -414,6 +414,11 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 		     FIXADDR_END);
 	BUG_ON(idx >= __end_of_fixed_addresses);
 
+	/* we only support device mappings until pgprot_kernel has been set */
+	if (WARN_ON(pgprot_val(prot) != pgprot_val(FIXMAP_PAGE_IO) &&
+		    pgprot_val(pgprot_kernel) == 0))
+		return;
+
 	if (pgprot_val(prot))
 		set_pte_at(NULL, vaddr, pte,
 			pfn_pte(phys >> PAGE_SHIFT, prot));
@@ -1492,7 +1497,7 @@ pgtables_remap lpae_pgtables_remap_asm;
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
  */
-void __init early_paging_init(const struct machine_desc *mdesc)
+static void __init early_paging_init(const struct machine_desc *mdesc)
 {
 	pgtables_remap *lpae_pgtables_remap;
 	unsigned long pa_pgd;
@@ -1560,7 +1565,7 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 
 #else
 
-void __init early_paging_init(const struct machine_desc *mdesc)
+static void __init early_paging_init(const struct machine_desc *mdesc)
 {
 	long long offset;
 
@@ -1616,7 +1621,6 @@ void __init paging_init(const struct machine_desc *mdesc)
 {
 	void *zero_page;
 
-	build_mem_type_table();
 	prepare_page_table();
 	map_lowmem();
 	memblock_set_current_limit(arm_lowmem_limit);
@@ -1636,3 +1640,9 @@ void __init paging_init(const struct machine_desc *mdesc)
 	empty_zero_page = virt_to_page(zero_page);
 	__flush_dcache_page(NULL, empty_zero_page);
 }
+
+void __init early_mm_init(const struct machine_desc *mdesc)
+{
+	build_mem_type_table();
+	early_paging_init(mdesc);
+}
