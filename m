From: james.morse@arm.com (James Morse)
Date: Mon, 15 Jan 2018 19:39:00 +0000
Subject: [PATCH v6 07/13] KVM: arm/arm64: mask/unmask daif around VHE guests
In-Reply-To: <20180115193906.30053-1-james.morse@arm.com>
References: <20180115193906.30053-1-james.morse@arm.com>
Message-ID: <20180115193906.30053-8-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-VHE systems take an exception to EL2 in order to world-switch into the
guest. When returning from the guest KVM implicitly restores the DAIF
flags when it returns to the kernel at EL1.

With VHE none of this exception-level jumping happens, so KVMs
world-switch code is exposed to the host kernel's DAIF values, and KVM
spills the guest-exit DAIF values back into the host kernel.
On entry to a guest we have Debug and SError exceptions unmasked, KVM
has switched VBAR but isn't prepared to handle these. On guest exit
Debug exceptions are left disabled once we return to the host and will
stay this way until we enter user space.

Add a helper to mask/unmask DAIF around VHE guests. The unmask can only
happen after the hosts VBAR value has been synchronised by the isb in
__vhe_hyp_call (via kvm_call_hyp()). Masking could be as late as
setting KVMs VBAR value, but is kept here for symmetry.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
This isn't backportable because of the 'daif' helpers, I will produce a
backport once its merged.

Changes since v4:
 * Added empty declarations for 32bit. (how did I miss that?)

v5 of this patch missed a Reviewed-by, which comes from here:
https://patchwork.kernel.org/patch/10017467/

 arch/arm/include/asm/kvm_host.h   |  2 ++
 arch/arm64/include/asm/kvm_host.h | 10 ++++++++++
 virt/kvm/arm/arm.c                |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index a9f7d3f47134..b86fc4162539 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -301,4 +301,6 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 /* All host FP/SIMD state is restored on guest exit, so nothing to save: */
 static inline void kvm_fpsimd_flush_cpu_state(void) {}
 
+static inline void kvm_arm_vhe_guest_enter(void) {}
+static inline void kvm_arm_vhe_guest_exit(void) {}
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7ee72b402907..dcdd08edf5a5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/kvm_types.h>
 #include <asm/cpufeature.h>
+#include <asm/daifflags.h>
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
@@ -398,4 +399,13 @@ static inline void kvm_fpsimd_flush_cpu_state(void)
 		sve_flush_cpu_state();
 }
 
+static inline void kvm_arm_vhe_guest_enter(void)
+{
+	local_daif_mask();
+}
+
+static inline void kvm_arm_vhe_guest_exit(void)
+{
+	local_daif_restore(DAIF_PROCCTX_NOIRQ);
+}
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 2fc6009a766c..38e81631fc91 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -704,9 +704,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 */
 		trace_kvm_entry(*vcpu_pc(vcpu));
 		guest_enter_irqoff();
+		if (has_vhe())
+			kvm_arm_vhe_guest_enter();
 
 		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
 
+		if (has_vhe())
+			kvm_arm_vhe_guest_exit();
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
 		/*
-- 
2.15.1
