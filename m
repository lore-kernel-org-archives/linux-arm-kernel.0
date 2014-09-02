From: achandran@mvista.com (Arun Chandran)
Date: Tue,  2 Sep 2014 20:09:24 +0530
Subject: [RFC PATCH v1] Arm64: introduce __hyp_func_call
Message-ID: <1409668765-25567-1-git-send-email-achandran@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a mechanism to __hyp_stub_vectors to allow a hypercall to
call a function at EL2. It is needed for users who want to
run a part of code with EL2 permissions. The current usecase is for
KVM and kexec.

For kexec we need to move the final CPU up to the mode it started
in before we branch to the new kernel. If we don't do that

* We loose EL2 in the next boot
* Arm64 bootwrapper may not be able to put CPUs at the spin-table
  code. Bootwrapper expects the final jump from kernel to cpu-return-addr
  to be done in EL2.

KVM can use this to set/get VBAR_EL2

Signed-off-by: Arun Chandran <achandran@mvista.com>

---
* It is the codification of idea from "Mark Rutland <mark.rutland@arm.com>"
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/280026.html

* v1
  removed the #define method for __hyp_set/get_vectors
---
---
 arch/arm64/include/asm/virt.h |    2 ++
 arch/arm64/kernel/hyp-stub.S  |   80 +++++++++++++++++++++++++++++++++++------
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7a5df52..eb98e76 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -37,6 +37,8 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 phys_addr_t __hyp_get_vectors(void);
 
+void __hyp_func_call(unsigned long func_addr) __attribute__((noreturn));
+
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f33..57e519e 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -53,17 +53,24 @@ ENDPROC(__hyp_stub_vectors)
 	.align 11
 
 el1_sync:
-	mrs	x1, esr_el2
-	lsr	x1, x1, #26
-	cmp	x1, #0x16
+	mrs	x5, esr_el2
+	lsr	x5, x5, #26
+	cmp	x5, #0x16
 	b.ne	2f				// Not an HVC trap
-	cbz	x0, 1f
-	msr	vbar_el2, x0			// Set vbar_el2
-	b	2f
-1:	mrs	x0, vbar_el2			// Return vbar_el2
+
+	adr	x5, 3f
+	ldr	x5, [x5]
+	cmp	x5, x7
+	b.ne	1f
+
+	adr	x7, __hyp_func_entry		// EQ-> it is a __hyp_func_entry
+1:	blr	x7 				// Jump to the function
 2:	eret
 ENDPROC(el1_sync)
 
+	.align	3
+3:	.quad	__hyp_func_entry
+
 .macro invalid_vector	label
 \label:
 	b \label
@@ -98,13 +105,64 @@ ENDPROC(\label)
  * When you call into your shiny new hypervisor, sp_el2 will contain junk,
  * so you will need to set that to something sensible at the new hypervisor's
  * initialisation entry point.
+ *
+ * For functions like __hyp_get_vectors, __hyp_set_vectors we
+ * use a two step jumping. After switching mode to EL2 it will first
+ * goto __hyp_func_entry; then address of the next function to
+ * jump to is calculated from the vitrual address contained in x6
  */
 
 ENTRY(__hyp_get_vectors)
-	mov	x0, xzr
-	// fall through
-ENTRY(__hyp_set_vectors)
-	hvc	#0
+	mrs	x5, CurrentEL
+	cmp	x5, #CurrentEL_EL2
+	b.ne	1f
+	mrs	x0, vbar_el2			// Return vbar_el2
+	ret
+1:
+	adr	x6, __hyp_get_vectors
+	adr	x7, __hyp_func_entry
+	mov	x19, x30			// Save lr in x19 / elr_el1??
+	hvc	#0				// Hyp call
+	mov	x30, x19
 	ret
 ENDPROC(__hyp_get_vectors)
+
+ENTRY(__hyp_set_vectors)
+	mrs	x5, CurrentEL
+	cmp	x5, #CurrentEL_EL2
+	b.ne	1f
+	msr	vbar_el2, x0
+	ret
+1:
+	adr	x6, __hyp_set_vectors
+	adr	x7, __hyp_func_entry
+	mov	x19, x30			// Save lr in x19 / elr_el1??
+	hvc	#0				// Hyp call
+	mov	x30, x19
+	ret
 ENDPROC(__hyp_set_vectors)
+
+/*
+ * x5, x7 is used as temporary registers
+ * x6 contains the virtual address of funtion we need to jump into
+ */
+ENTRY(__hyp_func_entry)
+	adr	x5, 1f
+	ldr	x7, [x5]
+	sub	x5, x5, x7
+	add	x6, x6, x5
+
+	br	x6
+ENDPROC(__hyp_func_entry)
+
+	.align	3
+1:	.quad	.
+
+/*
+ * Users like kexec can call this function directly by filling
+ * x7 with the physical address of the funtion to jump into.
+ */
+ENTRY(__hyp_func_call)
+	hvc	#0
+	ret
+ENDPROC(__hyp_func_call)
-- 
1.7.9.5
