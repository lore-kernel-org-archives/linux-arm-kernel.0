From: james.morse@arm.com (James Morse)
Date: Fri,  1 Apr 2016 17:53:37 +0100
Subject: [PATCH v7 13/16] arm64: head.S: el2_setup() to accept sctlr_el1 as an
 argument
In-Reply-To: <1459529620-22150-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
Message-ID: <1459529620-22150-14-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

el2_setup() doesn't just configure el2, it configures el1 too. This
means we can't use it to re-configure el2 after resume from hibernate,
as we will be returned to el1 with the MMU turned off.

Split the sctlr_el1 setting code up, so that el2_setup() accepts an
initial value as an argument. This value will be ignored if el2_setup()
is called at el1: the running value will be preserved with endian
correction.

Hibernate can now call el2_setup() to re-configure el2, passing the
current sctlr_el1 as an argument.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 ++++++++++
 arch/arm64/kernel/head.S           | 19 ++++++++++++-------
 arch/arm64/kernel/sleep.S          |  1 +
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index a04fd7a9c102..627d66efec68 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -311,6 +311,16 @@ lr	.req	x30		// link register
 	.endm
 
 /*
+ * Generate the initial sctlr_el1 value for el2_setup to set if we boot at EL2.
+ */
+	.macro init_sctlr_el1 reg
+		mov	\reg, #0x0800		// Set/clear RES{1,0} bits
+CPU_BE(		movk	\reg, #0x33d0, lsl #16)	// Set EE and E0E on BE systems
+CPU_LE(		movk	\reg, #0x30d0, lsl #16)	// Clear EE and E0E on LE systems
+	.endm
+
+/*
+
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1217262b5210..097986152203 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -208,6 +208,7 @@ section_table:
 
 ENTRY(stext)
 	bl	preserve_boot_args
+	init_sctlr_el1	x0
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
 	mov	x23, xzr			// KASLR offset, defaults to 0
 	adrp	x24, __PHYS_OFFSET
@@ -514,8 +515,12 @@ ENTRY(kimage_vaddr)
  *
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
  * booted in EL1 or EL2 respectively.
+ *
+ * If booted in EL2, SCTLR_EL1 will be initialised with the value in x0
+ * (otherwise the existing value will be preserved, with endian correction).
  */
 ENTRY(el2_setup)
+	mov	x1, x0				// preserve passed-in sctlr_el1
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.ne	1f
@@ -524,7 +529,7 @@ CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
 CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
 	msr	sctlr_el2, x0
 	b	2f
-1:	mrs	x0, sctlr_el1
+1:	mrs	x0, sctlr_el1			// ignore passed-in sctlr_el1
 CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
 CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	sctlr_el1, x0
@@ -578,6 +583,10 @@ set_hcr:
 
 3:
 #endif
+	/* use sctlr_el1 value we were provided with */
+CPU_BE(	orr	x1, x1, #(3 << 24)	)	// Set the EE and E0E bits for EL1
+CPU_LE(	bic	x1, x1, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
+	msr	sctlr_el1, x1
 
 	/* Populate ID registers. */
 	mrs	x0, midr_el1
@@ -585,12 +594,6 @@ set_hcr:
 	msr	vpidr_el2, x0
 	msr	vmpidr_el2, x1
 
-	/* sctlr_el1 */
-	mov	x0, #0x0800			// Set/clear RES{1,0} bits
-CPU_BE(	movk	x0, #0x33d0, lsl #16	)	// Set EE and E0E on BE systems
-CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
-	msr	sctlr_el1, x0
-
 	/* Coprocessor traps. */
 	mov	x0, #0x33ff
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
@@ -667,6 +670,7 @@ ENTRY(__boot_cpu_mode)
 	 * cores are held until we're ready for them to initialise.
 	 */
 ENTRY(secondary_holding_pen)
+	init_sctlr_el1	x0
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
@@ -685,6 +689,7 @@ ENDPROC(secondary_holding_pen)
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
 ENTRY(secondary_entry)
+	init_sctlr_el1	x0
 	bl	el2_setup			// Drop to EL1
 	bl	set_cpu_boot_mode_flag
 	b	secondary_startup
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 7916facff5e7..386a270a9998 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -98,6 +98,7 @@ ENDPROC(__cpu_suspend_enter)
 	.ltorg
 
 ENTRY(cpu_resume)
+	init_sctlr_el1	x0
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
-- 
2.8.0.rc3
