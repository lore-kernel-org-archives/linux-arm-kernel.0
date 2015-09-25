From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 25 Sep 2015 23:41:17 +0200
Subject: [PATCH v3 4/4] KVM: arm/arm64: implement kvm_arm_[halt,resume]_guest
In-Reply-To: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
References: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1443217277-13173-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduce kvm_arm_halt_guest and resume functions. They
will be used for IRQ forward state change.

Halt is synchronous and prevents the guest from being re-entered.
We use the same mechanism put in place for PSCI former pause,
now renamed power_off. A new flag is introduced in arch vcpu state,
pause, only meant to be used by those functions.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

---
v2 -> v3:
- change the comment associated to the pause flag into:
  Don't run the guest (internal implementation need)
- add Christoffer's R-b

v1 -> v2:
- check pause in kvm_arch_vcpu_runnable
- we cannot use kvm_vcpu_block since this latter would exit on
  IRQ/FIQ and this is not what we want
---
 arch/arm/include/asm/kvm_host.h   |  3 +++
 arch/arm/kvm/arm.c                | 35 +++++++++++++++++++++++++++++++----
 arch/arm64/include/asm/kvm_host.h |  3 +++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 1931a25..efbb812 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -128,6 +128,9 @@ struct kvm_vcpu_arch {
 	/* vcpu power-off state */
 	bool power_off;
 
+	 /* Don't run the guest (internal implementation need) */
+	bool pause;
+
 	/* IO related fields */
 	struct kvm_decode mmio_decode;
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4eb59e3..0308092 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -353,7 +353,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	return ((!!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v))
-		&& !v->arch.power_off);
+		&& !v->arch.power_off && !v->arch.pause);
 }
 
 /* Just ensure a guest exit from a particular CPU */
@@ -479,11 +479,38 @@ bool kvm_arch_intc_initialized(struct kvm *kvm)
 	return vgic_initialized(kvm);
 }
 
+static void kvm_arm_halt_guest(struct kvm *kvm) __maybe_unused;
+static void kvm_arm_resume_guest(struct kvm *kvm) __maybe_unused;
+
+static void kvm_arm_halt_guest(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		vcpu->arch.pause = true;
+	force_vm_exit(cpu_all_mask);
+}
+
+static void kvm_arm_resume_guest(struct kvm *kvm)
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
 static void vcpu_sleep(struct kvm_vcpu *vcpu)
 {
 	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.power_off);
+	wait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
+				       (!vcpu->arch.pause)));
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
@@ -533,7 +560,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		update_vttbr(vcpu->kvm);
 
-		if (vcpu->arch.power_off)
+		if (vcpu->arch.power_off || vcpu->arch.pause)
 			vcpu_sleep(vcpu);
 
 		/*
@@ -561,7 +588,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		}
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
-			vcpu->arch.power_off) {
+			vcpu->arch.power_off || vcpu->arch.pause) {
 			local_irq_enable();
 			kvm_timer_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d89ec1b..d19dfd6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -151,6 +151,9 @@ struct kvm_vcpu_arch {
 	/* vcpu power-off state */
 	bool power_off;
 
+	/* Don't run the guest (internal implementation need) */
+	bool pause;
+
 	/* IO related fields */
 	struct kvm_decode mmio_decode;
 
-- 
1.9.1
