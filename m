From: b18965@freescale.com (Alison Wang)
Date: Fri, 23 Sep 2016 15:13:25 +0800
Subject: [PATCH] arm/arm64: KVM: Add support for ARMv8 AArch32 execution state
Message-ID: <1474614805-18629-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8 architecture supports two execution state, AArch64 and
AArch32. To support KVM in AArch32 execution state for ARMv8, Cortex-A53
and Cortex-A72 need to be added for target-specific checks.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 arch/arm/include/asm/cputype.h | 2 ++
 arch/arm/kvm/guest.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 754f86f..4f8c632 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -75,6 +75,8 @@
 #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
 #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
+#define ARM_CPU_PART_CORTEX_A53_AARCH32	0x4100d030
+#define ARM_CPU_PART_CORTEX_A72_AARCH32	0x4100d080
 #define ARM_CPU_PART_MASK		0xff00fff0
 
 /* DEC implemented cores */
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 9aca920..462a099 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -252,6 +252,8 @@ int __attribute_const__ kvm_target_cpu(void)
 {
 	switch (read_cpuid_part()) {
 	case ARM_CPU_PART_CORTEX_A7:
+	case ARM_CPU_PART_CORTEX_A53_AARCH32:
+	case ARM_CPU_PART_CORTEX_A72_AARCH32:
 		return KVM_ARM_TARGET_CORTEX_A7;
 	case ARM_CPU_PART_CORTEX_A15:
 		return KVM_ARM_TARGET_CORTEX_A15;
-- 
2.1.0.27.g96db324
