From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:04 +0000
Subject: [PATCH 03/13] arm64: Convert hcalls to use ISS field
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <2d8dd1ea41dc51878dd4ce75de00eaec2518a76b.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow for additional hcalls to be defined and to make the arm64 hcall API
more consistent across exception vector routines change the hcall implementations
to use the ISS field of the ESR_EL2 register to specify the hcall type.

The existing arm64 hcall implementations are limited in that they only allow
for two distinct hcalls; with the x0 register either zero, or not zero.  Also,
the API of the hyp-stub exception vector routines and the KVM exception vector
routines differ; hyp-stub uses a non-zero value in x0 to implement
__hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.

Define three new preprocessor macros HVC_GET_VECTORS, HVC_SET_VECTORS and
HVC_KVM_CALL_HYP and to be used as hcall type specifiers and convert the
existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
to use these new macros when executing and HVC call.  Also change the
corresponding hyp-stub and KVM el1_sync exception vector routines to use these
new macros.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/virt.h | 20 ++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 38 ++++++++++++++++++++++++++------------
 arch/arm64/kvm/hyp.S          | 19 ++++++++++++-------
 3 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7a5df52..894fe53 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -21,6 +21,26 @@
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
+/*
+ * HVC_GET_VECTORS - Return the value of the vbar_el2 register.
+ */
+
+#define HVC_GET_VECTORS 1
+
+/*
+ * HVC_SET_VECTORS - Set the value of the vbar_el2 register.
+ *
+ * @x0: Physical address of the new vector table.
+ */
+
+#define HVC_SET_VECTORS 2
+
+/*
+ * HVC_KVM_CALL_HYP - Execute kvm_call_hyp routine.
+ */
+
+#define HVC_KVM_CALL_HYP 3
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 2d960a9..9ab5f70 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -54,16 +54,29 @@ ENDPROC(__hyp_stub_vectors)
 
 #define ESR_EL2_EC_SHIFT	26
 #define ESR_EL2_EC_HVC64	0x16
+#define ESR_EL2_ISS		0xffff
 
 el1_sync:
-	mrs	x1, esr_el2
-	lsr	x1, x1, #ESR_EL2_EC_SHIFT
-	cmp	x1, #ESR_EL2_EC_HVC64
-	b.ne	2f				// Not an HVC trap
-	cbz	x0, 1f
-	msr	vbar_el2, x0			// Set vbar_el2
+	mrs	x10, esr_el2
+	lsr	x9, x10, #ESR_EL2_EC_SHIFT	// x9=EC
+	and	x10, x10, #ESR_EL2_ISS		// x10=ISS
+
+	cmp     x9, #ESR_EL2_EC_HVC64
+	b.ne    2f                              // Not a host HVC trap
+
+	mrs     x9, vttbr_el2
+	cbnz    x9, 2f                          // Not a host HVC trap
+
+	cmp	x10, #HVC_GET_VECTORS
+	b.ne	1f
+	mrs	x0, vbar_el2
 	b	2f
-1:	mrs	x0, vbar_el2			// Return vbar_el2
+
+1:	cmp	x10, #HVC_SET_VECTORS
+	b.ne	1f
+	msr	vbar_el2, x0
+
+1:
 2:	eret
 ENDPROC(el1_sync)
 
@@ -103,11 +116,12 @@ ENDPROC(\label)
  * initialisation entry point.
  */
 
-ENTRY(__hyp_get_vectors)
-	mov	x0, xzr
-	// fall through
 ENTRY(__hyp_set_vectors)
-	hvc	#0
+	hvc	#HVC_SET_VECTORS
 	ret
-ENDPROC(__hyp_get_vectors)
 ENDPROC(__hyp_set_vectors)
+
+ENTRY(__hyp_get_vectors)
+	hvc	#HVC_GET_VECTORS
+	ret
+ENDPROC(__hyp_get_vectors)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b72aa9f..3972ee9 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -26,6 +26,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/virt.h>
 
 #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
 #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
@@ -1105,12 +1106,9 @@ __hyp_panic_str:
  * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
  * passed in r0 and r1.
  *
- * A function pointer with a value of 0 has a special meaning, and is
- * used to implement __hyp_get_vectors in the same way as in
- * arch/arm64/kernel/hyp_stub.S.
  */
 ENTRY(kvm_call_hyp)
-	hvc	#0
+	hvc	#HVC_KVM_CALL_HYP
 	ret
 ENDPROC(kvm_call_hyp)
 
@@ -1140,6 +1138,7 @@ el1_sync:					// Guest trapped into EL2
 	push	x2, x3
 
 	mrs	x1, esr_el2
+	and	x0, x1, #ESR_EL2_ISS
 	lsr	x2, x1, #ESR_EL2_EC_SHIFT
 
 	cmp	x2, #ESR_EL2_EC_HVC64
@@ -1149,15 +1148,19 @@ el1_sync:					// Guest trapped into EL2
 	cbnz	x3, el1_trap			// called HVC
 
 	/* Here, we're pretty sure the host called HVC. */
+	mov	x10, x0
 	pop	x2, x3
 	pop	x0, x1
 
-	/* Check for __hyp_get_vectors */
-	cbnz	x0, 1f
+	cmp	x10, #HVC_GET_VECTORS
+	b.ne	1f
 	mrs	x0, vbar_el2
 	b	2f
 
-1:	push	lr, xzr
+1:	cmp	x10, #HVC_KVM_CALL_HYP
+	b.ne	1f
+
+	push	lr, xzr
 
 	/*
 	 * Compute the function address in EL2, and shuffle the parameters.
@@ -1170,6 +1173,8 @@ el1_sync:					// Guest trapped into EL2
 	blr	lr
 
 	pop	lr, xzr
+
+1:
 2:	eret
 
 el1_trap:
-- 
1.9.1
