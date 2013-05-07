From: andre.przywara@linaro.org (Andre Przywara)
Date: Tue,  7 May 2013 14:55:13 +0200
Subject: [PATCH] ARM: KVM: prevent NULL pointer dereference with KVM ioctl
Message-ID: <1367931313-14839-1-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM KVM VCPU ioctls require the vCPU to be properly initialized
with the KVM_ARM_VCPU_INIT ioctl before being used with further
requests. KVM_RUN checks whether this initialization has been
done, but other ioctls do not.
Namely KVM_GET_REG_LIST will dereference an array with index -1
without initialization and thus leads to a kernel oops.
Fix this by adding checks before executing the ioctl handlers.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 arch/arm/kvm/arm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c1fe498..0c571ff 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -893,6 +893,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
+
+		/* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
+		if (unlikely(vcpu->arch.target < 0))
+			return -ENOEXEC;
+
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			return -EFAULT;
 		if (ioctl == KVM_SET_ONE_REG)
@@ -905,6 +910,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_reg_list reg_list;
 		unsigned n;
 
+		/* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
+		if (unlikely(vcpu->arch.target < 0))
+			return -ENOEXEC;
+
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
 			return -EFAULT;
 		n = reg_list.n;
-- 
1.7.12.1
