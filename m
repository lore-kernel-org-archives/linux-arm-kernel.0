From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:27 +0100
Subject: [PATCH 11/58] KVM: arm/arm64: replace pause checks with vcpu request
 checks
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-12-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jones <drjones@redhat.com>

The current use of KVM_REQ_VCPU_EXIT for pause is fine.  Even the
requester clearing the request is OK, as this is the special case
where the sole requesting thread and receiving VCPU are executing
synchronously (see "Clearing Requests" in
Documentation/virtual/kvm/vcpu-requests.rst) However, that's about
to change, so let's ensure only the receiving VCPU clears the
request. Additionally, by guaranteeing KVM_REQ_VCPU_EXIT is always
set when pause is, we can avoid checking pause directly in VCPU RUN.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/arm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 138212605ad9..21a4db90073f 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -546,7 +546,6 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		vcpu->arch.pause = false;
-		kvm_clear_request(KVM_REQ_VCPU_EXIT, vcpu);
 		swake_up(kvm_arch_vcpu_wq(vcpu));
 	}
 }
@@ -557,6 +556,11 @@ static void vcpu_sleep(struct kvm_vcpu *vcpu)
 
 	swait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
 				       (!vcpu->arch.pause)));
+
+	if (vcpu->arch.pause) {
+		/* Awaken to handle a signal, request we sleep again later. */
+		kvm_make_request(KVM_REQ_VCPU_EXIT, vcpu);
+	}
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
@@ -564,6 +568,14 @@ static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
 	return vcpu->arch.target >= 0;
 }
 
+static void check_vcpu_requests(struct kvm_vcpu *vcpu)
+{
+	if (kvm_request_pending(vcpu)) {
+		if (kvm_check_request(KVM_REQ_VCPU_EXIT, vcpu))
+			vcpu_sleep(vcpu);
+	}
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -609,7 +621,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		update_vttbr(vcpu->kvm);
 
-		if (vcpu->arch.power_off || vcpu->arch.pause)
+		check_vcpu_requests(vcpu);
+
+		if (vcpu->arch.power_off)
 			vcpu_sleep(vcpu);
 
 		/*
@@ -649,7 +663,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
 		    kvm_request_pending(vcpu) ||
-		    vcpu->arch.power_off || vcpu->arch.pause) {
+		    vcpu->arch.power_off) {
 			vcpu->mode = OUTSIDE_GUEST_MODE;
 			local_irq_enable();
 			kvm_pmu_sync_hwstate(vcpu);
-- 
2.11.0
