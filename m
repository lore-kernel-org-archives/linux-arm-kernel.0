From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Jun 2018 16:47:26 +0100
Subject: [PATCH v2 4/4] KVM: arm64: Avoid mistaken attempts to save SVE state
 for vcpus
In-Reply-To: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
References: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1529077646-2848-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e6b673b ("KVM: arm64: Optimise FPSIMD handling to reduce
guest/host thrashing") uses fpsimd_save() to save the FPSIMD state
for a vcpu when scheduling the vcpu out.  However, currently
current's value of TIF_SVE is restored before calling fpsimd_save()
which means that fpsimd_save() may erroneously attempt to save SVE
state from the vcpu.  This enables current's vector state to be
polluted with guest data.  current->thread.sve_state may be
unallocated or not large enough, so this can also trigger a NULL
dereference or buffer overrun.

Instead of this, TIF_SVE should be configured properly for the
guest when calling fpsimd_save() with the vcpu context loaded.

This patch ensures this by delaying restoration of current's
TIF_SVE until after the call to fpsimd_save().

Fixes: e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/fpsimd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 98d19d1..aac7808 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -103,9 +103,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
-	update_thread_flag(TIF_SVE,
-			   vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE);
-
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		/* Clean guest FP state to memory and invalidate cpu view */
 		fpsimd_save();
@@ -124,5 +121,8 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
+	update_thread_flag(TIF_SVE,
+			   vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE);
+
 	local_irq_restore(flags);
 }
-- 
2.1.4
