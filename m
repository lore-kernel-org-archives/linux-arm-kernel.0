From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:20 +0200
Subject: [PATCH 4/8] arm64/kernel: use ordinary calling convention for EL2
 setup
In-Reply-To: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459781544-14310-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the return value of el2_setup() is almost immediately passed to
set_cpu_boot_mode_flag() in all cases, there is no need to use a callee
saved register w20, but we can use simply use w0 instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index f441fc73a7a2..2a1b3ba1d81c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -211,7 +211,7 @@ section_table:
 
 ENTRY(stext)
 	bl	preserve_boot_args
-	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	mov	x23, xzr			// KASLR offset, defaults to 0
 	adrp	x24, __PHYS_OFFSET
 	bl	set_cpu_boot_mode_flag
@@ -530,7 +530,7 @@ CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
 CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
 CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	sctlr_el1, x0
-	mov	w20, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
+	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	isb
 	ret
 
@@ -616,7 +616,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 
 	cbz	x2, install_el2_stub
 
-	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
+	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	isb
 	ret
 
@@ -631,20 +631,20 @@ install_el2_stub:
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, x0
 	msr	elr_el2, lr
-	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
+	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
 ENDPROC(el2_setup)
 
 /*
  * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
- * in x20. See arch/arm64/include/asm/virt.h for more info.
+ * in x0. See arch/arm64/include/asm/virt.h for more info.
  */
 ENTRY(set_cpu_boot_mode_flag)
 	adr_l	x1, __boot_cpu_mode
-	cmp	w20, #BOOT_CPU_MODE_EL2
+	cmp	w0, #BOOT_CPU_MODE_EL2
 	b.ne	1f
 	add	x1, x1, #4
-1:	str	w20, [x1]			// This CPU has booted in EL1
+1:	str	w0, [x1]			// This CPU has booted in EL1
 	dmb	sy
 	dc	ivac, x1			// Invalidate potentially stale cache line
 	ret
@@ -669,7 +669,7 @@ ENTRY(__boot_cpu_mode)
 	 * cores are held until we're ready for them to initialise.
 	 */
 ENTRY(secondary_holding_pen)
-	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
 	ldr     x1, =MPIDR_HWID_BITMASK
-- 
2.5.0
