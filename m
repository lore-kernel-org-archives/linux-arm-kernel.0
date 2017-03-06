From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 14:24:52 +0000
Subject: [PATCH v3 19/25] arm/arm64: KVM: Use __hyp_reset_vectors() directly
In-Reply-To: <20170306142458.8875-1-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
Message-ID: <20170306142458.8875-20-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__cpu_reset_hyp_mode doesn't need to be passed any argument now,
as the hyp-stub implementations are self-contained, and is now
reduced to just calling __hyp_reset_vectors(). Let's drop the
wrapper and use the stub hypercall directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 6 ------
 arch/arm/kvm/arm.c                | 3 +--
 arch/arm64/include/asm/kvm_host.h | 6 ------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index d75638beca4e..1590cd6849b0 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -271,12 +271,6 @@ static inline void __cpu_init_stage2(void)
 	kvm_call_hyp(__init_stage2_translation);
 }
 
-static inline void __cpu_reset_hyp_mode(unsigned long vector_ptr,
-					phys_addr_t phys_idmap_start)
-{
-	__hyp_reset_vectors();
-}
-
 static inline int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	return 0;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c9a2103faeb9..c07284044b1e 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1126,8 +1126,7 @@ static void cpu_hyp_reinit(void)
 static void cpu_hyp_reset(void)
 {
 	if (!is_kernel_in_hyp_mode())
-		__cpu_reset_hyp_mode(hyp_default_vectors,
-				     kvm_get_idmap_start());
+		__hyp_reset_vectors();
 }
 
 static void _kvm_arch_hardware_enable(void *discard)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b8b6665dabbd..9a3d7b93944d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -363,12 +363,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
-static inline void __cpu_reset_hyp_mode(unsigned long vector_ptr,
-					phys_addr_t phys_idmap_start)
-{
-	__hyp_reset_vectors();
-}
-
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
-- 
2.11.0
