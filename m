From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 15 May 2015 15:27:07 +0100
Subject: [PATCH v4 04/12] KVM: arm: guest debug,
 add stub KVM_SET_GUEST_DEBUG ioctl
In-Reply-To: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1431700035-23479-5-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a stub function to support the KVM_SET_GUEST_DEBUG
ioctl. Any unsupported flag will return -EINVAL. For now, only
KVM_GUESTDBG_ENABLE is supported, although it won't have any effects.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>.
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

---
v2
  - simplified form of the ioctl (stuff will go into setup_debug)
v3
 - KVM_GUESTDBG_VALID->KVM_GUESTDBG_VALID_MASK
 - move mask check to the top of function
 - add ioctl doc header
 - split capability into separate patch
 - tweaked commit wording w.r.t return of -EINVAL
v4
 - add r-b-tag

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c34c32d..ba635c7 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2645,7 +2645,7 @@ handled.
 4.87 KVM_SET_GUEST_DEBUG
 
 Capability: KVM_CAP_SET_GUEST_DEBUG
-Architectures: x86, s390, ppc
+Architectures: x86, s390, ppc, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_guest_debug (in)
 Returns: 0 on success; -1 on error
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d9631ec..52a1d4d38 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -302,10 +302,31 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arm_set_running_vcpu(NULL);
 }
 
+#define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE)
+
+/**
+ * kvm_arch_vcpu_ioctl_set_guest_debug - set up guest debugging
+ * @kvm:	pointer to the KVM struct
+ * @kvm_guest_debug: the ioctl data buffer
+ *
+ * This sets up and enables the VM for guest debugging. Userspace
+ * passes in a control flag to enable different debug types and
+ * potentially other architecture specific information in the rest of
+ * the structure.
+ */
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
-	return -EINVAL;
+	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
+		return -EINVAL;
+
+	if (dbg->control & KVM_GUESTDBG_ENABLE) {
+		vcpu->guest_debug = dbg->control;
+	} else {
+		/* If not enabled clear all flags */
+		vcpu->guest_debug = 0;
+	}
+	return 0;
 }
 
 
-- 
2.3.5
