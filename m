From: anup.patel@linaro.org (Anup Patel)
Date: Sat, 14 Sep 2013 16:38:36 +0530
Subject: [PATCH v2 3/4] ARM/ARM64: KVM: Implement KVM_ARM_PREFERRED_TARGET
 ioctl
In-Reply-To: <1379156917-17497-1-git-send-email-anup.patel@linaro.org>
References: <1379156917-17497-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1379156917-17497-4-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For implementing CPU=host, we need a mechanism for querying
preferred VCPU target type on underlying Host.

This patch implements KVM_ARM_PREFERRED_TARGET ioctl which
return struct kvm_vcpu_init instance to user space for KVM ARM
and KVM ARM64 containing information about preferred VCPU
target type and optional VCPU features available for it.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/arm.c       |   12 ++++++++++++
 include/uapi/linux/kvm.h |    1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..192212c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -713,7 +713,19 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			return -EFAULT;
 
 		return kvm_vcpu_set_target(vcpu, &init);
+	}
+	case KVM_ARM_PREFERRED_TARGET: {
+		int err;
+		struct kvm_vcpu_init init;
+
+		err = kvm_vcpu_preferred_target(&init);
+		if (err)
+			return err;
 
+		if (copy_to_user(argp, &init, sizeof(init)))
+			return -EFAULT;
+
+		return 0;
 	}
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 99c2533..e32e776 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1012,6 +1012,7 @@ struct kvm_s390_ucas_mapping {
 /* VM is being stopped by host */
 #define KVM_KVMCLOCK_CTRL	  _IO(KVMIO,   0xad)
 #define KVM_ARM_VCPU_INIT	  _IOW(KVMIO,  0xae, struct kvm_vcpu_init)
+#define KVM_ARM_PREFERRED_TARGET  _IOR(KVMIO,  0xaf, struct kvm_vcpu_init)
 #define KVM_GET_REG_LIST	  _IOWR(KVMIO, 0xb0, struct kvm_reg_list)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
-- 
1.7.9.5
