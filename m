From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 17 Nov 2017 16:38:54 +0000
Subject: [RFC PATCH 3/4] arm64/sve: KVM: Ensure user SVE use traps after vcpu
 execution
In-Reply-To: <1510936735-6762-1-git-send-email-Dave.Martin@arm.com>
References: <1510936735-6762-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1510936735-6762-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, SVE use can remain untrapped if a KVM vcpu thread is
preempted inside the kernel and we then switch back to some user
thread.

This patch ensures that SVE traps for userspace are enabled before
switching away from the vcpu thread.

In an attempt to preserve some clarity about why and when this is
needed, kvm_fpsimd_flush_cpu_state() is used as a hook for doing
this.  This means that this function needs to be called after
exiting the vcpu instead of before entry: this patch moves the call
as appropriate.  As a side-effect, this will avoid the call if vcpu
entry is shortcircuited by a signal etc.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 2 ++
 virt/kvm/arm/arm.c         | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3dc8058..3b135eb 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1083,6 +1083,8 @@ void sve_flush_cpu_state(void)
 
 	if (last->st && last->sve_in_use)
 		fpsimd_flush_cpu_state();
+
+	sve_user_disable();
 }
 #endif /* CONFIG_ARM64_SVE */
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 772bf74..554b157 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -651,9 +651,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 */
 		preempt_disable();
 
-		/* Flush FP/SIMD state that can't survive guest entry/exit */
-		kvm_fpsimd_flush_cpu_state();
-
 		kvm_pmu_flush_hwstate(vcpu);
 
 		local_irq_disable();
@@ -754,6 +751,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		guest_exit();
 		trace_kvm_exit(ret, kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
 
+		/* Flush FP/SIMD state that can't survive guest entry/exit */
+		kvm_fpsimd_flush_cpu_state();
+
 		preempt_enable();
 
 		ret = handle_exit(vcpu, run, ret);
-- 
2.1.4
