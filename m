From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Mar 2015 15:55:49 +0100
Subject: [RFC v5 11/13] kvm: arm/arm64: implement kvm_arch_halt_guest and
 kvm_arch_resume_guest
In-Reply-To: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
References: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1426776951-24901-12-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines __KVM_HAVE_ARCH_HALT_GUEST and implements
kvm_arch_halt_guest and kvm_arch_resume_guest for ARM.

On halt, the guest is forced to exit and prevented from being
re-entered.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v4 -> v5: add arm64 support
- also defines __KVM_HAVE_ARCH_HALT_GUEST for arm64
- add pause field
---
 arch/arm/include/asm/kvm_host.h   |  4 ++++
 arch/arm/kvm/arm.c                | 32 +++++++++++++++++++++++++++++---
 arch/arm64/include/asm/kvm_host.h |  4 ++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 79a919c..b829f93 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -28,6 +28,7 @@
 #include <kvm/arm_arch_timer.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define __KVM_HAVE_ARCH_HALT_GUEST
 
 #if defined(CONFIG_KVM_ARM_MAX_VCPUS)
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
@@ -132,6 +133,9 @@ struct kvm_vcpu_arch {
 	/* vcpu power-off state */
 	bool power_off;
 
+	/* Don't run the guest */
+	bool pause;
+
 	/* IO related fields */
 	struct kvm_decode mmio_decode;
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 08e12dc..ebc0b55 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -454,11 +454,36 @@ bool kvm_arch_intc_initialized(struct kvm *kvm)
 	return vgic_initialized(kvm);
 }
 
+void kvm_arch_halt_guest(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		vcpu->arch.pause = true;
+	force_vm_exit(cpu_all_mask);
+}
+
+void kvm_arch_resume_guest(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+
+		vcpu->arch.pause = false;
+		wake_up_interruptible(wq);
+	}
+}
+
+
 static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
 	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.power_off);
+	wait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
+				       (!vcpu->arch.pause)));
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
@@ -508,7 +533,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		update_vttbr(vcpu->kvm);
 
-		if (vcpu->arch.power_off)
+		if (vcpu->arch.power_off || vcpu->arch.pause)
 			vcpu_pause(vcpu);
 
 		kvm_vgic_flush_hwstate(vcpu);
@@ -526,7 +551,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			run->exit_reason = KVM_EXIT_INTR;
 		}
 
-		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
+		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
+		    vcpu->arch.pause) {
 			kvm_timer_sync_hwstate(vcpu);
 			local_irq_enable();
 			kvm_timer_finish_sync(vcpu);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a713b0c..ffcc698 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -29,6 +29,7 @@
 #include <asm/kvm_mmio.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define __KVM_HAVE_ARCH_HALT_GUEST
 
 #if defined(CONFIG_KVM_ARM_MAX_VCPUS)
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
@@ -125,6 +126,9 @@ struct kvm_vcpu_arch {
 	/* vcpu power-off state */
 	bool power_off;
 
+	/* Don't run the guest */
+	bool pause;
+
 	/* IO related fields */
 	struct kvm_decode mmio_decode;
 
-- 
1.9.1
