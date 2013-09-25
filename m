From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 25 Sep 2013 14:56:02 +0530
Subject: [PATCH v4 3/4] ARM/ARM64: KVM: Implement KVM_ARM_PREFERRED_TARGET
 ioctl
In-Reply-To: <1380101163-20028-1-git-send-email-anup.patel@linaro.org>
References: <1380101163-20028-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1380101163-20028-4-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For implementing CPU=host, we need a mechanism for querying
preferred VCPU target type on underlying Host.

This patch implements KVM_ARM_PREFERRED_TARGET vm ioctl which
returns struct kvm_vcpu_init instance containing information
about preferred VCPU target type and target specific features
available for it.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/arm.c       |   13 +++++++++++++
 include/uapi/linux/kvm.h |    1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..cc5adb9 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -797,6 +797,19 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			return -EFAULT;
 		return kvm_vm_ioctl_set_device_addr(kvm, &dev_addr);
 	}
+	case KVM_ARM_PREFERRED_TARGET: {
+		int err;
+		struct kvm_vcpu_init init;
+
+		err = kvm_vcpu_preferred_target(&init);
+		if (err)
+			return err;
+
+		if (copy_to_user(argp, &init, sizeof(init)))
+			return -EFAULT;
+
+		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
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
