From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Dec 2013 11:15:46 +0000
Subject: [PATCH 14/15] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
In-Reply-To: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
References: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1388229347-24185-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

This patch allows us to have X-Gene guest VCPU when using KVM arm64
on APM X-Gene host.

We add KVM_ARM_TARGET_XGENE_POTENZA for X-Gene Potenza compatible
guest VCPU and we return KVM_ARM_TARGET_XGENE_POTENZA in kvm_target_cpu()
when running on X-Gene host with Potenza core.

[maz: sanitized the commit log]

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/uapi/asm/kvm.h    |  3 ++-
 arch/arm64/kvm/guest.c               | 32 +++++++++++++++++++-------------
 arch/arm64/kvm/sys_regs_generic_v8.c |  3 +++
 3 files changed, 24 insertions(+), 14 deletions(-)

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
index 3f0731e..0874557 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -207,20 +207,26 @@ int __attribute_const__ kvm_target_cpu(void)
 	unsigned long implementor = read_cpuid_implementor();
 	unsigned long part_number = read_cpuid_part_number();
 
-	if (implementor != ARM_CPU_IMP_ARM)
-		return -EINVAL;
+	switch (implementor) {
+	case ARM_CPU_IMP_ARM:
+		switch (part_number) {
+		case ARM_CPU_PART_AEM_V8:
+			return KVM_ARM_TARGET_AEM_V8;
+		case ARM_CPU_PART_FOUNDATION:
+			return KVM_ARM_TARGET_FOUNDATION_V8;
+		case ARM_CPU_PART_CORTEX_A57:
+			return KVM_ARM_TARGET_CORTEX_A57;
+		};
+		break;
+	case ARM_CPU_IMP_APM:
+		switch (part_number) {
+		case APM_CPU_PART_POTENZA:
+			return KVM_ARM_TARGET_XGENE_POTENZA;
+		};
+		break;
+	};
 
-	switch (part_number) {
-	case ARM_CPU_PART_AEM_V8:
-		return KVM_ARM_TARGET_AEM_V8;
-	case ARM_CPU_PART_FOUNDATION:
-		return KVM_ARM_TARGET_FOUNDATION_V8;
-	case ARM_CPU_PART_CORTEX_A57:
-		/* Currently handled by the generic backend */
-		return KVM_ARM_TARGET_CORTEX_A57;
-	default:
-		return -EINVAL;
-	}
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
1.8.5.1
