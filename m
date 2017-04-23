From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:51 +0200
Subject: [PULL 41/79] arm64: hyp-stub: Implement HVC_RESET_VECTORS stub
 hypercall
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-42-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Let's define a new stub hypercall that resets the HYP configuration
to its default: hyp-stub vectors, and MMU disabled.

Of course, for the hyp-stub itself, this is a trivial no-op.
Hypervisors will have a bit more work to do.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/include/asm/virt.h |  9 +++++++++
 arch/arm64/kernel/hyp-stub.S  | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 1569c3a..435514c 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -44,6 +44,14 @@
  */
 #define HVC_SOFT_RESTART 2
 
+/*
+ * HVC_RESET_VECTORS - Restore the vectors to the original HYP stubs
+ */
+#define HVC_RESET_VECTORS 3
+
+/* Max number of HYP stub hypercalls */
+#define HVC_STUB_HCALL_NR 4
+
 /* Error returned when an invalid stub number is passed into x0 */
 #define HVC_STUB_ERR	0xbadca11
 
@@ -70,6 +78,7 @@ extern u32 __boot_cpu_mode[2];
 
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 phys_addr_t __hyp_get_vectors(void);
+void __hyp_reset_vectors(void);
 
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index f53e8b8..8226fd9 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -73,8 +73,11 @@ el1_sync:
 	mov	x1, x3
 	br	x4				// no return
 
+3:	cmp	x0, #HVC_RESET_VECTORS
+	beq	9f				// Nothing to reset!
+
 	/* Someone called kvm_call_hyp() against the hyp-stub... */
-3:	ldr	x0, =HVC_STUB_ERR
+	ldr	x0, =HVC_STUB_ERR
 
 9:	eret
 ENDPROC(el1_sync)
@@ -127,3 +130,9 @@ ENTRY(__hyp_set_vectors)
 	hvc	#0
 	ret
 ENDPROC(__hyp_set_vectors)
+
+ENTRY(__hyp_reset_vectors)
+	mov	x0, #HVC_RESET_VECTORS
+	hvc	#0
+	ret
+ENDPROC(__hyp_reset_vectors)
-- 
2.9.0
