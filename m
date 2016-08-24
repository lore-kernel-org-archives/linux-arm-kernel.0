From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:36:01 +0200
Subject: [PATCH v2 4/9] arm64: head.S: move KASLR processing out of
 __enable_mmu()
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KASLR processing in __enable_mmu() is only used by the primary boot
path, and complements the processing that takes place in __primary_switch().
Move the two parts together, to make the code easier to understand.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 66 ++++++++++++--------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2871271123e7..d390feb92730 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -222,9 +222,7 @@ ENTRY(stext)
 	 * the TCR will have been set.
 	 */
 	bl	__cpu_setup			// initialise processor
-	adr_l	x27, __primary_switch		// address to jump to after
-						// MMU has been enabled
-	b	__enable_mmu
+	b	__primary_switch
 ENDPROC(stext)
 
 /*
@@ -453,7 +451,7 @@ __primary_switched:
 	cbz	x0, 0f				// KASLR disabled? just proceed
 	orr	x23, x23, x0			// record KASLR offset
 	ret	x28				// we must enable KASLR, return
-						// to __enable_mmu()
+						// to __primary_switch()
 0:
 #endif
 	b	start_kernel
@@ -721,7 +719,6 @@ ENTRY(__early_cpu_boot_status)
  */
 	.section	".idmap.text", "ax"
 ENTRY(__enable_mmu)
-	mrs	x22, sctlr_el1			// preserve old SCTLR_EL1 value
 	mrs	x1, ID_AA64MMFR0_EL1
 	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
@@ -742,25 +739,6 @@ ENTRY(__enable_mmu)
 	ic	iallu
 	dsb	nsh
 	isb
-#ifdef CONFIG_RANDOMIZE_BASE
-	mov	x19, x0				// preserve new SCTLR_EL1 value
-	blr	x27
-
-	/*
-	 * If we return here, we have a KASLR displacement in x23 which we need
-	 * to take into account by discarding the current kernel mapping and
-	 * creating a new one.
-	 */
-	msr	sctlr_el1, x22			// disable the MMU
-	isb
-	bl	__create_page_tables		// recreate kernel mapping
-
-	msr	sctlr_el1, x19			// re-enable the MMU
-	isb
-	ic	iallu				// flush instructions fetched
-	dsb	nsh				// via old mapping
-	isb
-#endif
 	br	x27
 ENDPROC(__enable_mmu)
 
@@ -770,11 +748,11 @@ __no_granule_support:
 1:
 	wfe
 	wfi
-	b 1b
+	b	1b
 ENDPROC(__no_granule_support)
 
-__primary_switch:
 #ifdef CONFIG_RELOCATABLE
+__relocate_kernel:
 	/*
 	 * Iterate over each entry in the relocation table, and apply the
 	 * relocations in place.
@@ -796,8 +774,42 @@ __primary_switch:
 	add	x13, x13, x23			// relocate
 	str	x13, [x11, x23]
 	b	0b
+1:	ret
+ENDPROC(__relocate_kernel)
+#endif
 
-1:
+__primary_switch:
+#ifdef CONFIG_RANDOMIZE_BASE
+	mov	x19, x0				// preserve new SCTLR_EL1 value
+	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
+#endif
+
+	adr	x27, 0f
+	b	__enable_mmu
+0:
+#ifdef CONFIG_RELOCATABLE
+	bl	__relocate_kernel
+#ifdef CONFIG_RANDOMIZE_BASE
+	ldr	x8, =__primary_switched
+	blr	x8
+
+	/*
+	 * If we return here, we have a KASLR displacement in x23 which we need
+	 * to take into account by discarding the current kernel mapping and
+	 * creating a new one.
+	 */
+	msr	sctlr_el1, x20			// disable the MMU
+	isb
+	bl	__create_page_tables		// recreate kernel mapping
+
+	msr	sctlr_el1, x19			// re-enable the MMU
+	isb
+	ic	iallu				// flush instructions fetched
+	dsb	nsh				// via old mapping
+	isb
+
+	bl	__relocate_kernel
+#endif
 #endif
 	ldr	x8, =__primary_switched
 	br	x8
-- 
2.7.4
