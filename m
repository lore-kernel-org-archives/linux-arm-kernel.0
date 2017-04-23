From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:55 +0200
Subject: [PULL 45/79] arm64: KVM: Convert __cpu_reset_hyp_mode to using
 __hyp_reset_vectors
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-46-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We are now able to use the hyp stub to reset HYP mode. Time to
kiss __kvm_hyp_reset goodbye, and use __hyp_reset_vectors.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h  |  1 -
 arch/arm64/include/asm/kvm_host.h |  3 +--
 arch/arm64/kvm/hyp-init.S         |  2 --
 arch/arm64/kvm/hyp/hyp-entry.S    | 15 ---------------
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b7e4ef5..26a64d0 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -47,7 +47,6 @@ struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
-extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_vector[];
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e7705e7..0355dd1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -362,11 +362,10 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
-void __kvm_hyp_teardown(void);
 static inline void __cpu_reset_hyp_mode(unsigned long vector_ptr,
 					phys_addr_t phys_idmap_start)
 {
-	kvm_call_hyp(__kvm_hyp_teardown, phys_idmap_start);
+	__hyp_reset_vectors();
 }
 
 static inline void kvm_arch_hardware_unsetup(void) {}
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index fded932..b7a8f12 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -134,7 +134,6 @@ ENTRY(__kvm_handle_stub_hvc)
 	/*
 	 * Reset kvm back to the hyp stub.
 	 */
-ENTRY(__kvm_hyp_reset)
 	/* We're now in idmap, disable MMU */
 	mrs	x0, sctlr_el2
 	ldr	x1, =SCTLR_ELx_FLAGS
@@ -152,7 +151,6 @@ ENTRY(__kvm_hyp_reset)
 
 exit:
 	eret
-ENDPROC(__kvm_hyp_reset)
 ENDPROC(__kvm_handle_stub_hvc)
 
 	.ltorg
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 4f34c59..5170ce1 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -53,21 +53,6 @@ ENTRY(__vhe_hyp_call)
 	ret
 ENDPROC(__vhe_hyp_call)
 
-/*
- * Compute the idmap address of __kvm_hyp_reset based on the idmap
- * start passed as a parameter, and jump there.
- *
- * x0: HYP phys_idmap_start
- */
-ENTRY(__kvm_hyp_teardown)
-	mov	x4, x0
-	adr_l	x3, __kvm_hyp_reset
-
-	/* insert __kvm_hyp_reset()s offset into phys_idmap_start */
-	bfi	x4, x3, #0, #PAGE_SHIFT
-	br	x4
-ENDPROC(__kvm_hyp_teardown)
-	
 el1_sync:				// Guest trapped into EL2
 	stp	x0, x1, [sp, #-16]!
 
-- 
2.9.0
