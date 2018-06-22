From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 13:49:49 +0100
Subject: [PATCH 4/8] KVM: arm64/sve: Fix SVE trap restoration for non-current
 tasks
In-Reply-To: <20180622124953.12355-1-marc.zyngier@arm.com>
References: <20180622124953.12355-1-marc.zyngier@arm.com>
Message-ID: <20180622124953.12355-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

Commit e6b673b ("KVM: arm64: Optimise FPSIMD handling to reduce
guest/host thrashing") attempts to restore the configuration of
userspace SVE trapping via a call to fpsimd_bind_task_to_cpu(), but
the logic for determining when to do this is not correct.

The patch makes the errnoenous assumption that the only task that
may try to enter userspace with the currently loaded FPSIMD/SVE
register content is current.  This may not be the case however:  if
some other user task T is scheduled on the CPU during the execution
of the KVM run loop, and the vcpu does not try to use the registers
in the meantime, then T's state may be left there intact.  If T
happens to be the next task to enter userspace on this CPU then the
hooks for reloading the register state and configuring traps will
be skipped.

(Also, current never has SVE state at this point anyway and should
always have the trap enabled, as a side-effect of the ioctl()
syscall needed to reach the KVM run loop in the first place.)

This patch instead restores the state of the EL0 trap from the
state observed at the most recent vcpu_load(), ensuring that the
trap is set correctly for the loaded context (if any).

Fixes: e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/fpsimd.c           | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index fda9a8ca48be..fe8777b12f86 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -306,6 +306,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
 #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
 #define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
+#define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
 
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index f9d09318b8db..98d19d1afa50 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_mmu.h>
+#include <asm/sysreg.h>
 
 /*
  * Called on entry to KVM_RUN unless this vcpu previously ran at least
@@ -61,10 +62,16 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(!current->mm);
 
-	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED | KVM_ARM64_HOST_SVE_IN_USE);
+	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
+			      KVM_ARM64_HOST_SVE_IN_USE |
+			      KVM_ARM64_HOST_SVE_ENABLED);
 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
+
 	if (test_thread_flag(TIF_SVE))
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_IN_USE;
+
+	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
+		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
 }
 
 /*
@@ -103,9 +110,18 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		/* Clean guest FP state to memory and invalidate cpu view */
 		fpsimd_save();
 		fpsimd_flush_cpu_state();
-	} else if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		/* Ensure user trap controls are correctly restored */
-		fpsimd_bind_task_to_cpu();
+	} else if (system_supports_sve()) {
+		/*
+		 * The FPSIMD/SVE state in the CPU has not been touched, and we
+		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
+		 * reset to CPACR_EL1_DEFAULT by the Hyp code, disabling SVE
+		 * for EL0.  To avoid spurious traps, restore the trap state
+		 * seen by kvm_arch_vcpu_load_fp():
+		 */
+		if (vcpu->arch.flags & KVM_ARM64_HOST_SVE_ENABLED)
+			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
+		else
+			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
 	local_irq_restore(flags);
-- 
2.17.1
