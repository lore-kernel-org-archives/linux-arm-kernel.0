From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:22 +0200
Subject: [PATCH 6/8] arm64/kernel: pass virtual entry point as __enable_mmu()
 argument
In-Reply-To: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459781544-14310-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of keeping the virtual entry point to be invoked by __enable_mmu
in a callee saved register with file scope, simply pass it as the second
argument. This makes the code easier to maintain.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 27 ++++++++++----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9201cddb53bc..d28fc345bec3 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -222,10 +222,10 @@ ENTRY(stext)
 	 * On return, the CPU will be ready for the MMU to be turned on and
 	 * the TCR will have been set.
 	 */
-	ldr	x27, 0f				// address to jump to after
+	bl	__cpu_setup			// initialise processor
+	ldr	x1, 0f				// address to jump to after
 						// MMU has been enabled
-	adr_l	lr, __enable_mmu		// return (PIC) address
-	b	__cpu_setup			// initialise processor
+	b	__enable_mmu
 ENDPROC(stext)
 	.align	3
 0:	.quad	__mmap_switched - (_head - TEXT_OFFSET) + KIMAGE_VADDR
@@ -696,7 +696,7 @@ ENTRY(secondary_startup)
 	 */
 	bl	__cpu_setup			// initialise processor
 
-	ldr	x27, .L__secondary_switched
+	ldr	x1, .L__secondary_switched
 	b	__enable_mmu
 ENDPROC(secondary_startup)
 
@@ -741,7 +741,7 @@ ENTRY(__early_cpu_boot_status)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
- *  x27 = *virtual* address to jump to upon completion
+ *  x1  = *virtual* address to jump to upon completion
  *
  * Other registers depend on the function called upon completion.
  *
@@ -751,11 +751,11 @@ ENTRY(__early_cpu_boot_status)
 	.section	".idmap.text", "ax"
 __enable_mmu:
 	mrs	x22, sctlr_el1			// preserve old SCTLR_EL1 value
-	mrs	x1, ID_AA64MMFR0_EL1
-	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
+	mrs	x2, ID_AA64MMFR0_EL1
+	ubfx	x3, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp	x3, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
-	update_early_cpu_boot_status 0, x1, x2
+	update_early_cpu_boot_status 0, x2, x3
 	adrp	x4, idmap_pg_dir
 	adrp	x5, swapper_pg_dir
 	msr	ttbr0_el1, x4			// load TTBR0
@@ -771,9 +771,10 @@ __enable_mmu:
 	ic	iallu
 	dsb	nsh
 	isb
+	mov	x20, x1				// preserve branch target
 #ifdef CONFIG_RANDOMIZE_BASE
 	mov	x19, x0				// preserve new SCTLR_EL1 value
-	blr	x27
+	blr	x1
 
 	/*
 	 * If we return here, we have a KASLR displacement in x23 which we need
@@ -789,14 +790,14 @@ __enable_mmu:
 	ic	iallu				// flush instructions fetched
 	dsb	nsh				// via old mapping
 	isb
-	add	x27, x27, x23			// relocated __mmap_switched
+	add	x20, x20, x23			// relocated __mmap_switched
 #endif
-	br	x27
+	br	x20
 ENDPROC(__enable_mmu)
 
 __no_granule_support:
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
-	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x1, x2
+	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x2, x3
 1:
 	wfe
 	wfi
-- 
2.5.0
