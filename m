From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Mon, 28 Aug 2017 18:38:18 +0800
Subject: [PATCH v6 4/7] arm64: kvm: support user space to query RAS extension
 feature
In-Reply-To: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1503916701-13516-5-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ARMV8.2 RAS extension, a virtual SError exception syndrome
register(VSESR_EL2) is added.  This value may be specified from
userspace. Userspace will want to check if the CPU has the RAS
extension. If it has, it wil specify the virtual SError syndrome
value, otherwise it will not be set. This patch adds support for
querying the availability of this extension.

change since v5:
1. modify some patch description

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/kvm/reset.c   | 3 +++
 include/uapi/linux/kvm.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 3256b9228e75..b7313ee028e9 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -77,6 +77,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PMU_V3:
 		r = kvm_arm_support_pmu_v3();
 		break;
+	case KVM_CAP_ARM_RAS_EXTENSION:
+		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
+		break;
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
 		r = 1;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6cd63c18708a..5a2a338cae57 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_ARM_RAS_EXTENSION 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.1
