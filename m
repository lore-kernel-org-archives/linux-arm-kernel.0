From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 11 Sep 2013 18:29:52 +0530
Subject: [PATCH 1/2] ARM/ARM64: KVM: Implement KVM_ARM_SUITABLE_TARGET ioctl
In-Reply-To: <1378904393-29101-1-git-send-email-anup.patel@linaro.org>
References: <1378904393-29101-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1378904393-29101-2-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For implementing CPU=host, we need a mechanism for querying
VCPU target type suitable to underlying Host.

This patch implements KVM_ARM_SUITABLE_TARGET ioctl which
return output of kvm_arm_target() to user space for KVM ARM
and KVM ARM64.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/arm.c       |    2 ++
 include/uapi/linux/kvm.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..4bdc2e1 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -715,6 +715,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		return kvm_vcpu_set_target(vcpu, &init);
 
 	}
+	case KVM_ARM_SUITABLE_TARGET:
+		return kvm_target_cpu();
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 99c2533..8285daa 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1012,6 +1012,7 @@ struct kvm_s390_ucas_mapping {
 /* VM is being stopped by host */
 #define KVM_KVMCLOCK_CTRL	  _IO(KVMIO,   0xad)
 #define KVM_ARM_VCPU_INIT	  _IOW(KVMIO,  0xae, struct kvm_vcpu_init)
+#define KVM_ARM_SUITABLE_TARGET	  _IO(KVMIO,   0xaf)
 #define KVM_GET_REG_LIST	  _IOWR(KVMIO, 0xb0, struct kvm_reg_list)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
-- 
1.7.9.5
