From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 13 Mar 2015 17:02:52 +0000
Subject: [PATCH v3 1/5] arm/arm64: KVM: export VCPU power state via MP_STATE
 ioctl
In-Reply-To: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
References: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1426266176-14933-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To cleanly restore an SMP VM we need to ensure that the current pause
state of each vcpu is correctly recorded. Things could get confused if
the CPU starts running after migration restore completes when it was
paused before it state was captured.

We use the existing KVM_GET/SET_MP_STATE ioctl to do this. The arm/arm64
interface is a lot simpler as the only valid states are
KVM_MP_STATE_RUNNABLE and KVM_MP_STATE_STOPPED.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---

v3
  - use KVM_MP_STATE_STOPPED instead of KVM_MP_STATE_HALTED
  - reduce textual churn on API document

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index b112efc..28fd46f 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -997,7 +997,7 @@ for vm-wide capabilities.
 4.38 KVM_GET_MP_STATE
 
 Capability: KVM_CAP_MP_STATE
-Architectures: x86, s390
+Architectures: x86, s390, arm, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_mp_state (out)
 Returns: 0 on success; -1 on error
@@ -1011,7 +1011,7 @@ uniprocessor guests).
 
 Possible values are:
 
- - KVM_MP_STATE_RUNNABLE:        the vcpu is currently running [x86]
+ - KVM_MP_STATE_RUNNABLE:        the vcpu is currently running [x86,arm/arm64]
  - KVM_MP_STATE_UNINITIALIZED:   the vcpu is an application processor (AP)
                                  which has not yet received an INIT signal [x86]
  - KVM_MP_STATE_INIT_RECEIVED:   the vcpu has received an INIT signal, and is
@@ -1020,7 +1020,7 @@ Possible values are:
                                  is waiting for an interrupt [x86]
  - KVM_MP_STATE_SIPI_RECEIVED:   the vcpu has just received a SIPI (vector
                                  accessible via KVM_GET_VCPU_EVENTS) [x86]
- - KVM_MP_STATE_STOPPED:         the vcpu is stopped [s390]
+ - KVM_MP_STATE_STOPPED:         the vcpu is stopped [s390,arm/arm64]
  - KVM_MP_STATE_CHECK_STOP:      the vcpu is in a special error state [s390]
  - KVM_MP_STATE_OPERATING:       the vcpu is operating (running or halted)
                                  [s390]
@@ -1031,11 +1031,15 @@ On x86, this ioctl is only useful after KVM_CREATE_IRQCHIP. Without an
 in-kernel irqchip, the multiprocessing state must be maintained by userspace on
 these architectures.
 
+For arm/arm64:
+
+The only states that are valid are KVM_MP_STATE_STOPPED and
+KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
 
 4.39 KVM_SET_MP_STATE
 
 Capability: KVM_CAP_MP_STATE
-Architectures: x86, s390
+Architectures: x86, s390, arm, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_mp_state (in)
 Returns: 0 on success; -1 on error
@@ -1047,6 +1051,10 @@ On x86, this ioctl is only useful after KVM_CREATE_IRQCHIP. Without an
 in-kernel irqchip, the multiprocessing state must be maintained by userspace on
 these architectures.
 
+For arm/arm64:
+
+The only states that are valid are KVM_MP_STATE_STOPPED and
+KVM_MP_STATE_RUNNABLE which reflect if the vcpu should be paused or not.
 
 4.40 KVM_SET_IDENTITY_MAP_ADDR
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5560f74..38721d2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -183,6 +183,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PSCI:
 	case KVM_CAP_ARM_PSCI_0_2:
 	case KVM_CAP_READONLY_MEM:
+	case KVM_CAP_MP_STATE:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
@@ -313,13 +314,29 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	return -EINVAL;
+	if (vcpu->arch.pause)
+		mp_state->mp_state = KVM_MP_STATE_STOPPED;
+	else
+		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
+
+	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	return -EINVAL;
+	switch (mp_state->mp_state) {
+	case KVM_MP_STATE_RUNNABLE:
+		vcpu->arch.pause = false;
+		break;
+	case KVM_MP_STATE_STOPPED:
+		vcpu->arch.pause = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.3.2
