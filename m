From: geoff@infradead.org (Geoff Levand)
Date: Thu, 14 Apr 2016 21:21:36 +0000
Subject: [PATCH v16 05/20] arm64: hyp/kvm: Extend hyp-stub API to allow
 function calls at EL2
In-Reply-To: <cover.1460668521.git.geoff@infradead.org>
References: <cover.1460668521.git.geoff@infradead.org>
Message-ID: <dc18b28bd2b56026fdc34b6b4282ad4d530d8639.1460668521.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing arm64 hcall implementations are limited in that they only
allow for two distinct hcalls; with the x0 register either zero or not
zero.  Also, the API of the hyp-stub exception vector routines and the
KVM exception vector routines differ; hyp-stub uses a non-zero value in
x0 to implement __hyp_set_vectors, whereas KVM uses it to implement
kvm_call_hyp.

To allow for additional hcalls to be defined and to make the arm64 hcall
API more consistent across exception vector routines, change the hcall
implementations to reserve all x0 values below PAGE_SIZE for hcalls such
as {s,g}et_vectors().

Define two new preprocessor macros HVC_GET_VECTORS, and HVC_SET_VECTORS
to be used as hcall type specifiers and convert the existing
__hyp_get_vectors() and __hyp_set_vectors() routines to use these new
macros when executing an HVC call.  Also, change the corresponding
hyp-stub and KVM el1_sync exception vector routines to use these new
macros.

Signed-off-by: Geoff Levand <geoff@infradead.org>
[Merged two hcall patches, moved immediate value from esr to x0, use lr
 as a scratch register]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/virt.h  | 16 ++++++++++++++++
 arch/arm64/kernel/hyp-stub.S   | 33 +++++++++++++++++++++++----------
 arch/arm64/kvm/hyp.S           |  4 ++--
 arch/arm64/kvm/hyp/hyp-entry.S |  4 ++--
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 23e9c6f..d406d2e 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -18,6 +18,22 @@
 #ifndef __ASM__VIRT_H
 #define __ASM__VIRT_H
 
+/*
+ * The arm64 hcall implementation uses x0 to specify the hcall type. A value
+ * less than PAGE_SIZE indicates a special hcall, such as get/set vector.
+ * Any other value is used as a pointer to the function to call.
+ */
+
+/* HVC_GET_VECTORS - Return the value of the vbar_el2 register. */
+#define HVC_GET_VECTORS 0
+
+/*
+ * HVC_SET_VECTORS - Set the value of the vbar_el2 register.
+ *
+ * @x0: Physical address of the new vector table.
+ */
+#define HVC_SET_VECTORS 1
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 7eab8ac..6bba25c 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -22,6 +22,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/assembler.h>
+#include <asm/kvm_arm.h>
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
@@ -53,15 +54,25 @@ ENDPROC(__hyp_stub_vectors)
 	.align 11
 
 el1_sync:
-	mrs	x1, esr_el2
-	lsr	x1, x1, #26
-	cmp	x1, #0x16
-	b.ne	2f				// Not an HVC trap
-	cbz	x0, 1f
-	msr	vbar_el2, x0			// Set vbar_el2
-	b	2f
-1:	mrs	x0, vbar_el2			// Return vbar_el2
-2:	eret
+	mrs	x30, esr_el2
+	lsr	x30, x30, #ESR_ELx_EC_SHIFT
+
+	cmp	x30, #ESR_ELx_EC_HVC64
+	b.ne	9f				// Not an HVC trap
+
+	cmp	x0, #HVC_GET_VECTORS
+	b.ne	1f
+	mrs	x0, vbar_el2
+	b	9f
+
+1:	cmp	x0, #HVC_SET_VECTORS
+	b.ne	2f
+	msr	vbar_el2, x1
+	b	9f
+
+2:	do_el2_call
+
+9:	eret
 ENDPROC(el1_sync)
 
 .macro invalid_vector	label
@@ -102,7 +113,7 @@ ENDPROC(\label)
 
 ENTRY(__hyp_get_vectors)
 	str	lr, [sp, #-16]!
-	mov	x0, xzr
+	mov	x0, #HVC_GET_VECTORS
 	hvc	#0
 	ldr	lr, [sp], #16
 	ret
@@ -110,6 +121,8 @@ ENDPROC(__hyp_get_vectors)
 
 ENTRY(__hyp_set_vectors)
 	str	lr, [sp, #-16]!
+	mov	x1, x0
+	mov	x0, #HVC_SET_VECTORS
 	hvc	#0
 	ldr	lr, [sp], #16
 	ret
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 4ee5612..ba34494 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -35,8 +35,8 @@
  * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
  * passed in x0.
  *
- * A function pointer with a value of 0 has a special meaning, and is
- * used to implement __hyp_get_vectors in the same way as in
+ * A function pointer with a value less than PAGE_SIZE has a special meaning,
+ * and is used to implement __hyp_get_vectors in the same way as in
  * arch/arm64/kernel/hyp_stub.S.
  * HVC behaves as a 'bl' call and will clobber lr.
  */
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 2cee779..c8ad21c 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -71,8 +71,8 @@ alternative_endif
 	/* Here, we're pretty sure the host called HVC. */
 	restore_x0_to_x3
 
-	/* Check for __hyp_get_vectors */
-	cbnz	x0, 1f
+	cmp	x0, #HVC_GET_VECTORS
+	b.ne	1f
 	mrs	x0, vbar_el2
 	b	2f
 
-- 
2.5.0
