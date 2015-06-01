From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Jun 2015 13:40:33 +0200
Subject: [PATCH for-v4.2 3/4] arm64: reduce ID map to a single page
In-Reply-To: <1433158834-25238-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1433158834-25238-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1433158834-25238-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ea8c2e112445 ("arm64: Extend the idmap to the whole kernel
image") changed the early page table code so that the entire kernel
Image is covered by the identity map. This allows functions that
need to enable or disable the MMU to reside anywhere in the kernel
Image.

However, this change has the unfortunate side effect that the Image
cannot cross a physical 512 MB alignment boundary anymore, since the
early page table code cannot deal with the Image crossing a /virtual/
512 MB alignment boundary.

So instead, reduce the ID map to a single page, that is populated by
the contents of the .idmap.text section. Only three functions reside
there at the moment: __enable_mmu(), cpu_resume_mmu() and cpu_reset().
If new code is introduced that needs to manipulate the MMU state, it
should be added to this section as well.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S        | 13 +++++++------
 arch/arm64/kernel/sleep.S       |  2 ++
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++++++-
 arch/arm64/mm/proc.S            |  3 ++-
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 30cffc5e7402..c0ff3ce4299e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -361,7 +361,7 @@ __create_page_tables:
 	 * Create the identity mapping.
 	 */
 	mov	x0, x25				// idmap_pg_dir
-	adrp	x3, KERNEL_START		// __pa(KERNEL_START)
+	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
 #ifndef CONFIG_ARM64_VA_BITS_48
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
@@ -384,11 +384,11 @@ __create_page_tables:
 
 	/*
 	 * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
-	 * entire kernel image can be ID mapped. As T0SZ == (64 - #bits used),
+	 * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
 	 * this number conveniently equals the number of leading zeroes in
-	 * the physical address of KERNEL_END.
+	 * the physical address of __idmap_text_end.
 	 */
-	adrp	x5, KERNEL_END
+	adrp	x5, __idmap_text_end
 	clz	x5, x5
 	cmp	x5, TCR_T0SZ(VA_BITS)	// default T0SZ small enough?
 	b.ge	1f			// .. then skip additional level
@@ -403,8 +403,8 @@ __create_page_tables:
 #endif
 
 	create_pgd_entry x0, x3, x5, x6
-	mov	x5, x3				// __pa(KERNEL_START)
-	adr_l	x6, KERNEL_END			// __pa(KERNEL_END)
+	mov	x5, x3				// __pa(__idmap_text_start)
+	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
@@ -632,6 +632,7 @@ ENDPROC(__secondary_switched)
  *
  * other registers depend on the function called upon completion
  */
+	.section	".idmap.text", "ax"
 __enable_mmu:
 	ldr	x5, =vectors
 	msr	vbar_el1, x5
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index ede186cdd452..811e61a2d847 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -130,12 +130,14 @@ ENDPROC(__cpu_suspend_enter)
 /*
  * x0 must contain the sctlr value retrieved from restored context
  */
+	.pushsection	".idmap.text", "ax"
 ENTRY(cpu_resume_mmu)
 	ldr	x3, =cpu_resume_after_mmu
 	msr	sctlr_el1, x0		// restore sctlr_el1
 	isb
 	br	x3			// global jump to virtual address
 ENDPROC(cpu_resume_mmu)
+	.popsection
 cpu_resume_after_mmu:
 	mov	x0, #0			// return zero on success
 	ldp	x19, x20, [sp, #16]
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index a2c29865c3fe..98073332e2d0 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -38,6 +38,12 @@ jiffies = jiffies_64;
 	*(.hyp.text)					\
 	VMLINUX_SYMBOL(__hyp_text_end) = .;
 
+#define IDMAP_TEXT					\
+	. = ALIGN(SZ_4K);				\
+	VMLINUX_SYMBOL(__idmap_text_start) = .;		\
+	*(.idmap.text)					\
+	VMLINUX_SYMBOL(__idmap_text_end) = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -95,6 +101,7 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			HYPERVISOR_TEXT
+			IDMAP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -167,11 +174,13 @@ SECTIONS
 }
 
 /*
- * The HYP init code can't be more than a page long,
+ * The HYP init code and ID map text can't be longer than a page each,
  * and should not cross a page boundary.
  */
 ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"HYP init code too big or misaligned")
+ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
+	"ID map text too big or misaligned")
 
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index cdd754e19b9b..a265934ab0af 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -67,7 +67,7 @@ ENDPROC(cpu_cache_off)
  *
  *	- loc   - location to jump to for soft reset
  */
-	.align	5
+	.pushsection	".idmap.text", "ax"
 ENTRY(cpu_reset)
 	mrs	x1, sctlr_el1
 	bic	x1, x1, #1
@@ -75,6 +75,7 @@ ENTRY(cpu_reset)
 	isb
 	ret	x0
 ENDPROC(cpu_reset)
+	.popsection
 
 ENTRY(cpu_soft_restart)
 	/* Save address of cpu_reset() and reset address */
-- 
1.9.1
