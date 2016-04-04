From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:21 +0200
Subject: [PATCH 5/8] arm64/kernel: refer to idmap_pg_dir and swapper_pg_dir
 directly
In-Reply-To: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459781544-14310-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of keeping their addresses in globals in x25 and x26 in head.S,
just refer to idmap_pg_dir or swapper_pg_dir directly using adrp
instructions when needed. This reduces the number of callee saved register
with file scope, which should increase maintainability.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 28 +++++++++-----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2a1b3ba1d81c..9201cddb53bc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -215,7 +215,7 @@ ENTRY(stext)
 	mov	x23, xzr			// KASLR offset, defaults to 0
 	adrp	x24, __PHYS_OFFSET
 	bl	set_cpu_boot_mode_flag
-	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
+	bl	__create_page_tables
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
 	 * details.
@@ -313,23 +313,21 @@ ENDPROC(preserve_boot_args)
  *     been enabled
  */
 __create_page_tables:
-	adrp	x25, idmap_pg_dir
-	adrp	x26, swapper_pg_dir
 	mov	x28, lr
 
 	/*
 	 * Invalidate the idmap and swapper page tables to avoid potential
 	 * dirty cache lines being evicted.
 	 */
-	mov	x0, x25
-	add	x1, x26, #SWAPPER_DIR_SIZE
+	adrp	x0, idmap_pg_dir
+	adrp	x1, swapper_pg_dir + SWAPPER_DIR_SIZE
 	bl	__inval_cache_range
 
 	/*
 	 * Clear the idmap and swapper page tables.
 	 */
-	mov	x0, x25
-	add	x6, x26, #SWAPPER_DIR_SIZE
+	adrp	x0, idmap_pg_dir
+	adrp	x6, swapper_pg_dir + SWAPPER_DIR_SIZE
 1:	stp	xzr, xzr, [x0], #16
 	stp	xzr, xzr, [x0], #16
 	stp	xzr, xzr, [x0], #16
@@ -342,7 +340,7 @@ __create_page_tables:
 	/*
 	 * Create the identity mapping.
 	 */
-	mov	x0, x25				// idmap_pg_dir
+	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
 #ifndef CONFIG_ARM64_VA_BITS_48
@@ -392,7 +390,7 @@ __create_page_tables:
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
-	mov	x0, x26				// swapper_pg_dir
+	adrp	x0, swapper_pg_dir
 	ldr	x5, =KIMAGE_VADDR
 	add	x5, x5, x23			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
@@ -406,8 +404,8 @@ __create_page_tables:
 	 * accesses (MMU disabled), invalidate the idmap and swapper page
 	 * tables again to remove any speculatively loaded cache lines.
 	 */
-	mov	x0, x25
-	add	x1, x26, #SWAPPER_DIR_SIZE
+	adrp	x0, idmap_pg_dir
+	adrp	x1, swapper_pg_dir + SWAPPER_DIR_SIZE
 	dmb	sy
 	bl	__inval_cache_range
 
@@ -696,8 +694,6 @@ ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
-	adrp	x25, idmap_pg_dir
-	adrp	x26, swapper_pg_dir
 	bl	__cpu_setup			// initialise processor
 
 	ldr	x27, .L__secondary_switched
@@ -760,8 +756,10 @@ __enable_mmu:
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
 	update_early_cpu_boot_status 0, x1, x2
-	msr	ttbr0_el1, x25			// load TTBR0
-	msr	ttbr1_el1, x26			// load TTBR1
+	adrp	x4, idmap_pg_dir
+	adrp	x5, swapper_pg_dir
+	msr	ttbr0_el1, x4			// load TTBR0
+	msr	ttbr1_el1, x5			// load TTBR1
 	isb
 	msr	sctlr_el1, x0
 	isb
-- 
2.5.0
