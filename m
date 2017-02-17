From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Feb 2017 15:44:25 +0000
Subject: [PATCH 16/20] ARM: KVM: Convert __cpu_reset_hyp_mode to using
 __hyp_reset_vectors
In-Reply-To: <20170217154429.5000-1-marc.zyngier@arm.com>
References: <20170217154429.5000-1-marc.zyngier@arm.com>
Message-ID: <20170217154429.5000-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are now able to use the hyp stub to reset HYP mode. Time to
kiss __kvm_hyp_reset goodbye, and use __hyp_reset_vectors.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h  | 2 --
 arch/arm/include/asm/kvm_host.h | 3 ++-
 arch/arm/kvm/init.S             | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 8ef05381984b..7ccb6f1aac5b 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -72,8 +72,6 @@ extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
 extern void __init_stage2_translation(void);
 
-extern void __kvm_hyp_reset(unsigned long);
-
 extern u64 __vgic_v3_get_ich_vtr_el2(void);
 extern void __vgic_v3_init_lrs(void);
 #endif
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index d5423ab15ed5..1962c5086897 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -277,7 +277,8 @@ static inline void __cpu_init_stage2(void)
 static inline void __cpu_reset_hyp_mode(unsigned long vector_ptr,
 					phys_addr_t phys_idmap_start)
 {
-	kvm_call_hyp((void *)virt_to_idmap(__kvm_hyp_reset), vector_ptr);
+	extern void __hyp_reset_vectors(void);
+	__hyp_reset_vectors();
 }
 
 static inline int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 438b148d47fd..0ec1a83d03ea 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -129,7 +129,6 @@ ENTRY(__kvm_handle_stub_hvc)
 
 1:	cmp	r0, #HVC_RESET_VECTORS
 	bne	1f
-ENTRY(__kvm_hyp_reset)
 	/* We're now in idmap, disable MMU */
 	mrc	p15, 4, r1, c1, c0, 0	@ HSCTLR
 	ldr	r0, =(HSCTLR_M | HSCTLR_A | HSCTLR_C | HSCTLR_I)
@@ -153,7 +152,6 @@ ENTRY(__kvm_hyp_reset)
 exit:
 	eret
 ENDPROC(__kvm_handle_stub_hvc)
-ENDPROC(__kvm_hyp_reset)
 
 	.ltorg
 .L__va2pa:
-- 
2.11.0
