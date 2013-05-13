From: andre.przywara@linaro.org (Andre Przywara)
Date: Tue, 14 May 2013 00:25:08 +0200
Subject: [PATCH v3] ARM: KVM: prevent NULL pointer dereferences with KVM VCPU
 ioctl
Message-ID: <1368483908-22274-1-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM KVM VCPU ioctls require the vCPU to be properly initialized
with the KVM_ARM_VCPU_INIT ioctl before being used with further
requests. KVM_RUN checks whether this initialization has been
done, but other ioctls do not.
Namely KVM_GET_REG_LIST will dereference an array with index -1
without initialization and thus leads to a kernel oops.
Fix this by adding checks before executing the ioctl handlers.

Changes from v1:
 * moved check into a static function with a meaningful name
Changes from v2:
 * moved function into a header file and marked it as inline

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 arch/arm/include/asm/kvm_coproc.h |  9 +++++++++
 arch/arm/kvm/arm.c                | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_coproc.h b/arch/arm/include/asm/kvm_coproc.h
index 4917c2f7..80d0082 100644
--- a/arch/arm/include/asm/kvm_coproc.h
+++ b/arch/arm/include/asm/kvm_coproc.h
@@ -39,6 +39,15 @@ unsigned long kvm_arm_num_guest_msrs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_msrindices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 void kvm_coproc_table_init(void);
 
+/*
+ * Some ioctls require initialization by KVM_ARM_VCPU_INIT first, check
+ * this with this function to avoid NULL pointer dereference
+ */
+static inline int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.target >= 0;
+}
+
 struct kvm_one_reg;
 int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 37d216d..6800293 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -508,8 +508,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int ret;
 	sigset_t sigsaved;
 
-	/* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
-	if (unlikely(vcpu->arch.target < 0))
+	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
 	ret = kvm_vcpu_first_run_init(vcpu);
@@ -710,6 +709,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
+
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			return -ENOEXEC;
+
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			return -EFAULT;
 		if (ioctl == KVM_SET_ONE_REG)
@@ -722,6 +725,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_reg_list reg_list;
 		unsigned n;
 
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			return -ENOEXEC;
+
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
 			return -EFAULT;
 		n = reg_list.n;
-- 
1.7.12.1
