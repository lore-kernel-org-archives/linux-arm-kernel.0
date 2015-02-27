From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Feb 2015 14:53:43 +0000
Subject: [RFC PATCH] arm64: use fixmap region for permanent FDT mapping
Message-ID: <1425048823-25206-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the FDT blob needs to be in the same naturally aligned
512 MB region as the kernel, so that it can be mapped into the
kernel virtual memory space very early on using a minimal set of
statically allocated translation tables.

Now that we have early fixmap support, we can relax this restriction,
by moving the permanent FDT mapping to the fixmap region instead.
This way, the FDT blob may be anywhere in memory.

At the same time, fix up some comments in head.S that have gone stale.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

The EFI stub is currently not guaranteed to adhere strictly to the arm64
boot protocol, as the logic that it applies to decide where to allocate
memory for the FDT is flawed. This should be fixed, but at the same time,
the FDT placement requirement can be relaxed without much trouble, so we
should consider that as an option as well IMO.

 arch/arm64/include/asm/fixmap.h |  9 +++++++++
 arch/arm64/include/asm/mmu.h    |  1 +
 arch/arm64/kernel/head.S        | 21 ++-------------------
 arch/arm64/kernel/setup.c       | 14 ++++++++------
 arch/arm64/mm/mmu.c             | 25 +++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index defa0ff98250..4ad240a60898 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -32,6 +32,15 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+
+	/*
+	 * Reserve 2 MB of virtual space for the FDT at the top of the fixmap
+	 * region. Keep this at the top so it remains 2 MB aligned.
+	 */
+#define FIX_FDT_SIZE		SZ_2M
+	FIX_FDT_END,
+	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
+
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_permanent_fixed_addresses,
 
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 3d311761e3c2..5fa4555c46e8 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -34,5 +34,6 @@ extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot);
+extern void *fixmap_remap_fdt(phys_addr_t fdt_phys);
 
 #endif
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0b3fb672640c..d464d00a9e82 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -354,11 +354,10 @@ ENDPROC(__vet_fdt)
  * required to get the kernel running. The following sections are required:
  *   - identity mapping to enable the MMU (low address, TTBR0)
  *   - first few MB of the kernel linear mapping to jump to once the MMU has
- *     been enabled, including the FDT blob (TTBR1)
- *   - pgd entry for fixed mappings (TTBR1)
+ *     been enabled
  */
 __create_page_tables:
-	pgtbl	x25, x26, x28			// idmap_pg_dir and swapper_pg_dir addresses
+	pgtbl	x25, x26, x28	// idmap_pg_dir and swapper_pg_dir addresses
 	mov	x27, lr
 
 	/*
@@ -456,22 +455,6 @@ __create_page_tables:
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
-	 * Map the FDT blob (maximum 2MB; must be within 512MB of
-	 * PHYS_OFFSET).
-	 */
-	mov	x3, x21				// FDT phys address
-	and	x3, x3, #~((1 << 21) - 1)	// 2MB aligned
-	mov	x6, #PAGE_OFFSET
-	sub	x5, x3, x24			// subtract PHYS_OFFSET
-	tst	x5, #~((1 << 29) - 1)		// within 512MB?
-	csel	x21, xzr, x21, ne		// zero the FDT pointer
-	b.ne	1f
-	add	x5, x5, x6			// __va(FDT blob)
-	add	x6, x5, #1 << 21		// 2MB for the FDT blob
-	sub	x6, x6, #1			// inclusive range
-	create_block_map x0, x7, x3, x5, x6
-1:
-	/*
 	 * Since the page tables have been populated with non-cacheable
 	 * accesses (MMU disabled), invalidate the idmap and swapper page
 	 * tables again to remove any speculatively loaded cache lines.
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index e8420f635bd4..7ea087d904ad 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -309,12 +309,14 @@ static void __init setup_processor(void)
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
-	if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys))) {
+	void *dt_virt = fixmap_remap_fdt(dt_phys);
+
+	if (!dt_phys || !early_init_dt_scan(dt_virt)) {
 		early_print("\n"
 			"Error: invalid device tree blob@physical address 0x%p (virtual address 0x%p)\n"
-			"The dtb must be 8-byte aligned and passed in the first 512MB of memory\n"
+			"The dtb must be 8-byte aligned\n"
 			"\nPlease check your bootloader.\n",
-			dt_phys, phys_to_virt(dt_phys));
+			dt_phys, dt_virt);
 
 		while (true)
 			cpu_relax();
@@ -357,6 +359,9 @@ void __init setup_arch(char **cmdline_p)
 {
 	setup_processor();
 
+	early_fixmap_init();
+	early_ioremap_init();
+
 	setup_machine_fdt(__fdt_pointer);
 
 	init_mm.start_code = (unsigned long) _text;
@@ -366,9 +371,6 @@ void __init setup_arch(char **cmdline_p)
 
 	*cmdline_p = boot_command_line;
 
-	early_fixmap_init();
-	early_ioremap_init();
-
 	parse_early_param();
 
 	/*
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c4f60393383e..fe11de1b6066 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -646,3 +646,28 @@ void __set_fixmap(enum fixed_addresses idx,
 		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
 }
+
+void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
+{
+	unsigned long dt_virt;
+
+	/*
+	 * Make sure that the FDT region can be mapped without the need to
+	 * allocate additional translation table pages.
+	 * On 4k pages, we'll use a section mapping for the 2 MB region so we
+	 * only have to be in the same PUD as the rest of the fixmap.
+	 * On 64k pages, we need to be in the same PMD as well, as the region
+	 * will be mapped using PTEs.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
+		BUILD_BUG_ON((__fix_to_virt(FIX_FDT) >> PMD_SHIFT)
+			     != (__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT));
+	else
+		BUILD_BUG_ON((__fix_to_virt(FIX_FDT) >> PUD_SHIFT)
+			     != (__fix_to_virt(FIX_BTMAP_BEGIN) >> PUD_SHIFT));
+
+	dt_virt = __fix_to_virt(FIX_FDT);
+	create_mapping(dt_phys, dt_virt, FIX_FDT_SIZE, PAGE_KERNEL);
+
+	return (void *)(dt_virt | (dt_phys & (FIX_FDT_SIZE - 1)));
+}
-- 
1.8.3.2
