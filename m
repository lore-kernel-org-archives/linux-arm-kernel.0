From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  4 May 2018 17:05:32 +0100
Subject: [PATCH v5 11/14] KVM: arm64: Remove eager host SVE state saving
In-Reply-To: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
References: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1525449935-31424-12-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the host SVE context can be saved on demand from Hyp,
there is no longer any need to save this state in advance before
entering the guest.

This patch removes the relevant call to
kvm_fpsimd_flush_cpu_state().

Since the problem that function was intended to solve now no longer
exists, the function and its dependencies are also deleted.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  3 ---
 arch/arm64/include/asm/kvm_host.h | 10 ----------
 arch/arm64/kernel/fpsimd.c        | 21 ---------------------
 virt/kvm/arm/arm.c                |  3 ---
 4 files changed, 37 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 4cac8d1..39f051f 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -311,9 +311,6 @@ static inline void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_park_fp(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu) {}
 
-/* All host FP/SIMD state is restored on guest exit, so nothing to save: */
-static inline void kvm_fpsimd_flush_cpu_state(void) {}
-
 static inline void kvm_arm_vhe_guest_enter(void) {}
 static inline void kvm_arm_vhe_guest_exit(void) {}
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 811097e..85ae6ab 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -438,16 +438,6 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	return kvm_arch_vcpu_run_map_fp(vcpu);
 }
 
-/*
- * All host FP/SIMD state is restored on guest exit, so nothing needs
- * doing here except in the SVE case:
-*/
-static inline void kvm_fpsimd_flush_cpu_state(void)
-{
-	if (system_supports_sve())
-		sve_flush_cpu_state();
-}
-
 static inline void kvm_arm_vhe_guest_enter(void)
 {
 	local_daif_mask();
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 152d834..3fc3449 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -120,7 +120,6 @@
  */
 struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
-	bool sve_in_use;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -1020,7 +1019,6 @@ static void fpsimd_bind_to_cpu(void)
 		this_cpu_ptr(&fpsimd_last_state);
 
 	last->st = &current->thread.uw.fpsimd_state;
-	last->sve_in_use = test_thread_flag(TIF_SVE);
 	current->thread.fpsimd_cpu = smp_processor_id();
 }
 
@@ -1032,7 +1030,6 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st)
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
 	last->st = st;
-	last->sve_in_use = false;
 }
 
 /*
@@ -1092,24 +1089,6 @@ void fpsimd_flush_cpu_state(void)
 	__this_cpu_write(fpsimd_last_state.st, NULL);
 }
 
-/*
- * Invalidate any task SVE state currently held in this CPU's regs.
- *
- * This is used to prevent the kernel from trying to reuse SVE register data
- * that is detroyed by KVM guest enter/exit.  This function should go away when
- * KVM SVE support is implemented.  Don't use it for anything else.
- */
-#ifdef CONFIG_ARM64_SVE
-void sve_flush_cpu_state(void)
-{
-	struct fpsimd_last_state_struct const *last =
-		this_cpu_ptr(&fpsimd_last_state);
-
-	if (last->st && last->sve_in_use)
-		fpsimd_flush_cpu_state();
-}
-#endif /* CONFIG_ARM64_SVE */
-
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 DEFINE_PER_CPU(bool, kernel_neon_busy);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a7be7bf..8bede26 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -698,9 +698,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 */
 		preempt_disable();
 
-		/* Flush FP/SIMD state that can't survive guest entry/exit */
-		kvm_fpsimd_flush_cpu_state();
-
 		kvm_pmu_flush_hwstate(vcpu);
 
 		local_irq_disable();
-- 
2.1.4
