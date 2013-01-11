From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 11 Jan 2013 15:51:39 -0500
Subject: [PATCH] KVM: ARM: Change psci_call return value to bool
Message-ID: <1357937499-3946-1-git-send-email-c.dall@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid either using -1 or -EINVAL in return from kvm_psci_call change
the function to return a bool like the coprocessor handling functions
do.  Also clearly document this on on the function.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_psci.h |    2 +-
 arch/arm/kvm/arm.c              |    2 +-
 arch/arm/kvm/psci.c             |   21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
index 992d7f1..9a83d98 100644
--- a/arch/arm/include/asm/kvm_psci.h
+++ b/arch/arm/include/asm/kvm_psci.h
@@ -18,6 +18,6 @@
 #ifndef __ARM_KVM_PSCI_H__
 #define __ARM_KVM_PSCI_H__
 
-int kvm_psci_call(struct kvm_vcpu *vcpu);
+bool kvm_psci_call(struct kvm_vcpu *vcpu);
 
 #endif /* __ARM_KVM_PSCI_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4d5ed244..d3f1877 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -498,7 +498,7 @@ static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (!kvm_psci_call(vcpu))
+	if (kvm_psci_call(vcpu))
 		return 1;
 
 	kvm_inject_undefined(vcpu);
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 4a1c4f0..6be3687 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -21,6 +21,11 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_psci.h>
 
+/*
+ * This is an implementation of the Power State Coordination Interface
+ * as described in ARM document number ARM DEN 0022A.
+ */
+
 static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 {
 	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
@@ -63,7 +68,17 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	return KVM_PSCI_RET_SUCCESS;
 }
 
-int kvm_psci_call(struct kvm_vcpu *vcpu)
+/**
+ * kvm_psci_call - handle PSCI call if r0 value is in range
+ * @vcpu: Pointer to the VCPU struct
+ *
+ * Handle PSCI calls from guests through traps from HVC or SMC instructions.
+ * The calling convention is similar to SMC calls to the secure world where
+ * the function number is placed in r0 and this function returns true if the
+ * function number specified in r0 is withing the PSCI range, and false
+ * otherwise.
+ */
+bool kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
 	unsigned long val;
@@ -82,9 +97,9 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 		break;
 
 	default:
-		return -1;
+		return false;
 	}
 
 	*vcpu_reg(vcpu, 0) = val;
-	return 0;
+	return true;
 }
-- 
1.7.9.5
