From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:36:00 +0200
Subject: [PATCH v2 3/9] arm64: kernel: use ordinary return/argument register
 for el2_setup()
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function el2_setup() passes its return value in register w20, and
in the two cases where the caller actually cares about this return value,
it is passed into set_cpu_boot_mode_flag() [almost] directly, which
expects its input in w20 as well.

So there is no reason to use a 'special' callee saved register here, but
we can simply follow the PCS for return value and first argument,
respectively.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 219676253dbc..2871271123e7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -210,7 +210,7 @@ efi_header_end:
 
 ENTRY(stext)
 	bl	preserve_boot_args
-	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	adrp	x24, __PHYS_OFFSET
 	and	x23, x24, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
@@ -488,7 +488,7 @@ CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
 CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
 CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	sctlr_el1, x0
-	mov	w20, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
+	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	isb
 	ret
 
@@ -584,7 +584,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 
 	cbz	x2, install_el2_stub
 
-	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
+	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	isb
 	ret
 
@@ -599,7 +599,7 @@ install_el2_stub:
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, x0
 	msr	elr_el2, lr
-	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
+	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
 ENDPROC(el2_setup)
 
@@ -609,10 +609,10 @@ ENDPROC(el2_setup)
  */
 set_cpu_boot_mode_flag:
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
@@ -637,7 +637,7 @@ ENTRY(__boot_cpu_mode)
 	 * cores are held until we're ready for them to initialise.
 	 */
 ENTRY(secondary_holding_pen)
-	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
 	mov_q	x1, MPIDR_HWID_BITMASK
-- 
2.7.4
