From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 17 Jun 2015 10:00:46 +0100
Subject: [PATCH] arm64/kvm: Add generic v8 KVM target
Message-ID: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch adds a generic ARM v8 KVM target cpu type for use
by the new CPUs which eventualy ends up using the common sys_reg
table. For backward compatibility the existing targets have been
preserved. Any new target CPU that can be covered by generic v8
sys_reg tables should make use of the new generic target.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Acked-by: Marc Zyngier <Marc.Zyngier@arm.com>
---
 arch/arm64/include/uapi/asm/kvm.h    |   10 ++++++++--
 arch/arm64/kvm/guest.c               |    3 ++-
 arch/arm64/kvm/sys_regs_generic_v8.c |    2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d268320..f5de418 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -53,14 +53,20 @@ struct kvm_regs {
 	struct user_fpsimd_state fp_regs;
 };
 
-/* Supported Processor Types */
+/*
+ * Supported CPU Targets - Adding a new target type is not recommended,
+ * unless there are some special registers not supported by the
+ * genericv8 syreg table.
+ */
 #define KVM_ARM_TARGET_AEM_V8		0
 #define KVM_ARM_TARGET_FOUNDATION_V8	1
 #define KVM_ARM_TARGET_CORTEX_A57	2
 #define KVM_ARM_TARGET_XGENE_POTENZA	3
 #define KVM_ARM_TARGET_CORTEX_A53	4
+/* Generic ARM v8 target */
+#define KVM_ARM_TARGET_GENERIC_V8	5
 
-#define KVM_ARM_NUM_TARGETS		5
+#define KVM_ARM_NUM_TARGETS		6
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
 #define KVM_ARM_DEVICE_TYPE_SHIFT	0
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 9535bd5..124aa57 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -293,7 +293,8 @@ int __attribute_const__ kvm_target_cpu(void)
 		break;
 	};
 
-	return -EINVAL;
+	/* Return a default generic target */
+	return KVM_ARM_TARGET_GENERIC_V8;
 }
 
 int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index 475fd29..1e45768 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -94,6 +94,8 @@ static int __init sys_reg_genericv8_init(void)
 					  &genericv8_target_table);
 	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_XGENE_POTENZA,
 					  &genericv8_target_table);
+	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_GENERIC_V8,
+					  &genericv8_target_table);
 
 	return 0;
 }
-- 
1.7.9.5
