From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:35:58 +0200
Subject: [PATCH v2 1/9] arm64: kernel: get rid of x25 and x26 with 'global'
 scope
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, x25 and x26 hold the physical addresses of idmap_pg_dir
and swapper_pg_dir, respectively, when running early boot code. But
having registers with 'global' scope in files that contain different
sections with different lifetimes, and that are called by different
CPUs at different times is a bit messy, especially since stashing the
values does not buy us anything in terms of code size or clarity.

So simply replace each reference to x25 or x26 with an adrp instruction
referring to idmap_pg_dir or swapper_pg_dir directly.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 28 +++++++++-----------
 arch/arm64/kernel/sleep.S |  2 --
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b77f58355da1..219676253dbc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -214,7 +214,7 @@ ENTRY(stext)
 	adrp	x24, __PHYS_OFFSET
 	and	x23, x24, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
-	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
+	bl	__create_page_tables
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
 	 * details.
@@ -311,23 +311,21 @@ ENDPROC(preserve_boot_args)
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
@@ -340,7 +338,7 @@ __create_page_tables:
 	/*
 	 * Create the identity mapping.
 	 */
-	mov	x0, x25				// idmap_pg_dir
+	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
 #ifndef CONFIG_ARM64_VA_BITS_48
@@ -390,7 +388,7 @@ __create_page_tables:
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
-	mov	x0, x26				// swapper_pg_dir
+	adrp	x0, swapper_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
@@ -405,8 +403,8 @@ __create_page_tables:
 	 * accesses (MMU disabled), invalidate the idmap and swapper page
 	 * tables again to remove any speculatively loaded cache lines.
 	 */
-	mov	x0, x25
-	add	x1, x26, #SWAPPER_DIR_SIZE
+	adrp	x0, idmap_pg_dir
+	adrp	x1, swapper_pg_dir + SWAPPER_DIR_SIZE
 	dmb	sy
 	bl	__inval_cache_range
 
@@ -666,8 +664,6 @@ secondary_startup:
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
-	adrp	x25, idmap_pg_dir
-	adrp	x26, swapper_pg_dir
 	bl	__cpu_setup			// initialise processor
 
 	adr_l	x27, __secondary_switch		// address to jump to after enabling the MMU
@@ -731,8 +727,10 @@ ENTRY(__enable_mmu)
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
 	update_early_cpu_boot_status 0, x1, x2
-	msr	ttbr0_el1, x25			// load TTBR0
-	msr	ttbr1_el1, x26			// load TTBR1
+	adrp	x1, idmap_pg_dir
+	adrp	x2, swapper_pg_dir
+	msr	ttbr0_el1, x1			// load TTBR0
+	msr	ttbr1_el1, x2			// load TTBR1
 	isb
 	msr	sctlr_el1, x0
 	isb
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index ccf79d849e0a..182129b60fdf 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -102,8 +102,6 @@ ENTRY(cpu_resume)
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
 	adr_l	x27, _resume_switched	/* __enable_mmu will branch here */
-	adrp	x25, idmap_pg_dir
-	adrp	x26, swapper_pg_dir
 	b	__cpu_setup
 ENDPROC(cpu_resume)
 
-- 
2.7.4
