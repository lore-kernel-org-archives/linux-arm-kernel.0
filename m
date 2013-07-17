From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 17 Jul 2013 13:41:58 +0530
Subject: [PATCH V3] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
Message-ID: <1374048718-9455-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows us to have X-Gene guest VCPU when using KVM arm64
on APM X-Gene host.

We add KVM_ARM_TARGET_XGENE_POTENZA for X-Gene Potenza compatible
guest VCPU and we return KVM_ARM_TARGET_XGENE_POTENZA in kvm_target_cpu()
when running on X-Gene host with Potenza core.

V3:
 - Reduce multiple "return -EINVAL" in kvm_target_cpu()

V2:
 - Renamed KVM_ARM_TARGET_XGENE_V8 to KVM_ARM_TARGET_XGENE_POTENZA

V1:
 - Initial patch with target named as KVM_ARM_TARGET_XGENE_V8

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/uapi/asm/kvm.h    |    3 ++-
 arch/arm64/kvm/guest.c               |   36 ++++++++++++++++++++++------------
 arch/arm64/kvm/sys_regs_generic_v8.c |    3 +++
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 5031f42..d9f026b 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -55,8 +55,9 @@ struct kvm_regs {
 #define KVM_ARM_TARGET_AEM_V8		0
 #define KVM_ARM_TARGET_FOUNDATION_V8	1
 #define KVM_ARM_TARGET_CORTEX_A57	2
+#define KVM_ARM_TARGET_XGENE_POTENZA	3
 
-#define KVM_ARM_NUM_TARGETS		3
+#define KVM_ARM_NUM_TARGETS		4
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
 #define KVM_ARM_DEVICE_TYPE_SHIFT	0
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2c3ff67..143d179 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -207,20 +207,32 @@ int __attribute_const__ kvm_target_cpu(void)
 	unsigned long implementor = read_cpuid_implementor();
 	unsigned long part_number = read_cpuid_part_number();
 
-	if (implementor != ARM_CPU_IMP_ARM)
-		return -EINVAL;
-
-	switch (part_number) {
-	case ARM_CPU_PART_AEM_V8:
-		return KVM_ARM_TARGET_AEM_V8;
-	case ARM_CPU_PART_FOUNDATION:
-		return KVM_ARM_TARGET_FOUNDATION_V8;
-	case ARM_CPU_PART_CORTEX_A57:
-		/* Currently handled by the generic backend */
-		return KVM_ARM_TARGET_CORTEX_A57;
+	switch (implementor) {
+	case ARM_CPU_IMP_ARM:
+		switch (part_number) {
+		case ARM_CPU_PART_AEM_V8:
+			return KVM_ARM_TARGET_AEM_V8;
+		case ARM_CPU_PART_FOUNDATION:
+			return KVM_ARM_TARGET_FOUNDATION_V8;
+		case ARM_CPU_PART_CORTEX_A57:
+			return KVM_ARM_TARGET_CORTEX_A57;
+		default:
+	 		break;
+		}
+		break;
+	case ARM_CPU_IMP_APM:
+		switch (part_number) {
+		case APM_CPU_PART_POTENZA:
+			return KVM_ARM_TARGET_XGENE_POTENZA;
+		default:
+	 		break;
+		}
+		break;
 	default:
-		return -EINVAL;
+ 		break;
 	}
+
+	return -EINVAL;
 }
 
 int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index 4268ab9..8fe6f76 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -90,6 +90,9 @@ static int __init sys_reg_genericv8_init(void)
 					  &genericv8_target_table);
 	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_CORTEX_A57,
 					  &genericv8_target_table);
+	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_XGENE_POTENZA,
+					  &genericv8_target_table);
+
 	return 0;
 }
 late_initcall(sys_reg_genericv8_init);
-- 
1.7.9.5
