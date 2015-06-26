From: tchalamarla@caviumnetworks.com (Tirumalesh Chalamarla)
Date: Fri, 26 Jun 2015 12:51:24 -0700
Subject: [PATCH] arm64: KVM: Enable minimalistic support for Thunder
Message-ID: <1435348284-32132-1-git-send-email-tchalamarla@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow KVM to run on Thunder implementations, add the
minimal support required.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 arch/arm64/include/asm/cputype.h     | 3 +++
 arch/arm64/include/uapi/asm/kvm.h    | 3 ++-
 arch/arm64/kvm/guest.c               | 6 ++++++
 arch/arm64/kvm/sys_regs_generic_v8.c | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index a84ec60..f603dcd 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -63,6 +63,7 @@
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
 #define ARM_CPU_IMP_ARM		0x41
+#define ARM_CPU_IMP_CAVIUM		0x43
 #define ARM_CPU_IMP_APM		0x50
 
 #define ARM_CPU_PART_AEM_V8	0xD0F
@@ -72,6 +73,8 @@
 
 #define APM_CPU_PART_POTENZA	0x000
 
+#define ARM_CPU_PART_THUNDER	0x0A1
+
 #define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
 #define ID_AA64MMFR0_BIGENDEL0_MASK	(0xf << ID_AA64MMFR0_BIGENDEL0_SHIFT)
 #define ID_AA64MMFR0_BIGENDEL0(mmfr0)	\
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d268320..6c4c556 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -59,8 +59,9 @@ struct kvm_regs {
 #define KVM_ARM_TARGET_CORTEX_A57	2
 #define KVM_ARM_TARGET_XGENE_POTENZA	3
 #define KVM_ARM_TARGET_CORTEX_A53	4
+#define KVM_ARM_TARGET_CAVIUM_THUNDER	5
 
-#define KVM_ARM_NUM_TARGETS		5
+#define KVM_ARM_NUM_TARGETS		6
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
 #define KVM_ARM_DEVICE_TYPE_SHIFT	0
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 9535bd5..3751f37 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -291,6 +291,12 @@ int __attribute_const__ kvm_target_cpu(void)
 			return KVM_ARM_TARGET_XGENE_POTENZA;
 		};
 		break;
+	case ARM_CPU_IMP_CAVIUM:
+		switch (part_number) {
+		case ARM_CPU_PART_THUNDER:
+			return KVM_ARM_TARGET_CAVIUM_THUNDER;
+		};
+		break;
 	};
 
 	return -EINVAL;
diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index 475fd29..0e48ee8 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -94,6 +94,8 @@ static int __init sys_reg_genericv8_init(void)
 					  &genericv8_target_table);
 	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_XGENE_POTENZA,
 					  &genericv8_target_table);
+	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_CAVIUM_THUNDER,
+					  &genericv8_target_table);
 
 	return 0;
 }
-- 
2.1.0
