From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:43 +0100
Subject: [PATCH 25/37] KVM: arm: Add 32bit get/set events support
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-26-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

arm64's new use of KVMs get_events/set_events API calls isn't just
or RAS, it allows an SError that has been made pending by KVM as
part of its device emulation to be migrated.

Wire this up for 32bit too.

We only need to read/write the HCR_VA bit, and check that no esr has
been provided, as we don't yet support VDFSR.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt |  8 ++++----
 arch/arm/include/asm/kvm_host.h   |  5 +++++
 arch/arm/include/uapi/asm/kvm.h   | 13 +++++++++++++
 arch/arm/kvm/guest.c              | 23 +++++++++++++++++++++++
 virt/kvm/arm/arm.c                |  4 ----
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index dbbb95d5798a..4d93fd65bbbd 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -835,7 +835,7 @@ struct kvm_clock_data {
 
 Capability: KVM_CAP_VCPU_EVENTS
 Extended by: KVM_CAP_INTR_SHADOW
-Architectures: x86, arm64
+Architectures: x86, arm, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_vcpu_event (out)
 Returns: 0 on success, -1 on error
@@ -883,7 +883,7 @@ Only two fields are defined in the flags field:
 - KVM_VCPUEVENT_VALID_SMM may be set in the flags field to signal that
   smi contains a valid state.
 
-ARM64:
+ARM/ARM64:
 
 If the guest accesses a device that is being emulated by the host kernel in
 such a way that a real device would generate a physical SError, KVM may make
@@ -934,7 +934,7 @@ struct kvm_vcpu_events {
 
 Capability: KVM_CAP_VCPU_EVENTS
 Extended by: KVM_CAP_INTR_SHADOW
-Architectures: x86, arm64
+Architectures: x86, arm, arm64
 Type: vcpu ioctl
 Parameters: struct kvm_vcpu_event (in)
 Returns: 0 on success, -1 on error
@@ -961,7 +961,7 @@ shall be written into the VCPU.
 
 KVM_VCPUEVENT_VALID_SMM can only be set if KVM_CAP_X86_SMM is available.
 
-ARM64:
+ARM/ARM64:
 
 Set the pending SError exception state for this VCPU. It is not possible to
 'cancel' an Serror that has been made pending.
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 1f1fe4109b02..79906cecb091 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -216,6 +216,11 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 unsigned long kvm_call_hyp(void *hypfn, ...);
 void force_vm_exit(const cpumask_t *mask);
+int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
+			      struct kvm_vcpu_events *events);
+
+int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
+			      struct kvm_vcpu_events *events);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva(struct kvm *kvm, unsigned long hva);
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 16e006f708ca..4602464ebdfb 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -27,6 +27,7 @@
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
@@ -125,6 +126,18 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* for KVM_GET/SET_VCPU_EVENTS */
+struct kvm_vcpu_events {
+	struct {
+		__u8 serror_pending;
+		__u8 serror_has_esr;
+		/* Align it to 8 bytes */
+		__u8 pad[6];
+		__u64 serror_esr;
+	} exception;
+	__u32 reserved[12];
+};
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index a18f33edc471..2b8de885b2bf 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -261,6 +261,29 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+
+int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
+			      struct kvm_vcpu_events *events)
+{
+	events->exception.serror_pending = !!(*vcpu_hcr(vcpu) & HCR_VA);
+
+	return 0;
+}
+
+int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
+			      struct kvm_vcpu_events *events)
+{
+	bool serror_pending = events->exception.serror_pending;
+	bool has_esr = events->exception.serror_has_esr;
+
+	if (serror_pending && has_esr)
+		return -EINVAL;
+	else if (serror_pending)
+		kvm_inject_vabt(vcpu);
+
+	return 0;
+}
+
 int __attribute_const__ kvm_target_cpu(void)
 {
 	switch (read_cpuid_part()) {
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 14f8fad1c7ae..ac658bd63196 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1050,7 +1050,6 @@ static int kvm_arm_vcpu_has_attr(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
-#ifdef __KVM_HAVE_VCPU_EVENTS	/* temporary: until 32bit is wired up */
 static int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 				   struct kvm_vcpu_events *events)
 {
@@ -1076,7 +1075,6 @@ static int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 
 	return __kvm_arm_vcpu_set_events(vcpu, events);
 }
-#endif /* __KVM_HAVE_VCPU_EVENTS */
 
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
@@ -1158,7 +1156,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_arm_vcpu_has_attr(vcpu, &attr);
 		break;
 	}
-#ifdef __KVM_HAVE_VCPU_EVENTS
 	case KVM_GET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
@@ -1178,7 +1175,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_set_events(vcpu, &events);
 	}
-#endif
 	default:
 		r = -EINVAL;
 	}
-- 
2.18.0
