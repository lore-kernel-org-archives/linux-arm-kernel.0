From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Nov 2017 15:03:53 -0800
Subject: [PATCH v2] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
Message-ID: <20171129230353.11809-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kryo CPUs are also affected by the Falkor 1003 errata, so
we need to do the same workaround on Kryo CPUs. The MIDR is
slightly more complicated here, where the PART number is not
always the same when looking at all the bits from 15 to 4. Drop
the lower 8 bits and just look at the top 4 to see if it's '2'
and then consider those as Kryo CPUs. This covers all the
combinations without having to list them all out.

Introduce a new hardware cap bit for the combination of hardware
PAN support and this errata so that we can disable support for
software PAN at runtime if this errata is present and the CPU
doesn't support HW PAN. This happens on some Kryo CPUs where the
HW PAN feature isn't supported but we can't prevent software PAN
from being selected in the configuration. Previously, Falkor CPUs
were all known to have HW PAN support, so we didn't need to worry
about this case.

Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/arm64/silicon-errata.txt |  2 +-
 arch/arm64/include/asm/asm-uaccess.h   |  4 ++--
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cpufeature.h    |  2 +-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 21 +++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 17 +++++++++++++++++
 arch/arm64/kernel/entry.S              |  4 ++--
 8 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 66e8ce14d23d..cd7d997063f6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -71,6 +71,6 @@ stable kernels.
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 |                |                 |                 |                             |
-| Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
+| Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index b3da6c886835..35650d1394f4 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -26,13 +26,13 @@
 	.endm
 
 	.macro	uaccess_ttbr0_disable, tmp1
-alternative_if_not ARM64_HAS_PAN
+alternative_if_not ARM64_HAS_PAN_OR_FALKOR_E1003
 	__uaccess_ttbr0_disable \tmp1
 alternative_else_nop_endif
 	.endm
 
 	.macro	uaccess_ttbr0_enable, tmp1, tmp2
-alternative_if_not ARM64_HAS_PAN
+alternative_if_not ARM64_HAS_PAN_OR_FALKOR_E1003
 	save_and_disable_irq \tmp2		// avoid preemption
 	__uaccess_ttbr0_enable \tmp1
 	restore_irq \tmp2
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8da621627d7c..c2938408b441 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -40,7 +40,8 @@
 #define ARM64_WORKAROUND_858921			19
 #define ARM64_WORKAROUND_CAVIUM_30115		20
 #define ARM64_HAS_DCPOP				21
+#define ARM64_HAS_PAN_OR_FALKOR_E1003		22
 
-#define ARM64_NCAPS				22
+#define ARM64_NCAPS				23
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 428ee1f2468c..9b2957e4792a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -259,7 +259,7 @@ static inline bool system_supports_fpsimd(void)
 static inline bool system_uses_ttbr0_pan(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN) &&
-		!cpus_have_const_cap(ARM64_HAS_PAN);
+		!cpus_have_const_cap(ARM64_HAS_PAN_OR_FALKOR_E1003);
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 235e77d98261..b5afa6668646 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -91,6 +91,7 @@
 #define BRCM_CPU_PART_VULCAN		0x516
 
 #define QCOM_CPU_PART_FALKOR_V1		0x800
+#define QCOM_CPU_PART_KRYO		0x200
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
@@ -99,6 +100,7 @@
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
+#define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0e27f86ee709..e4c78630a730 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -30,6 +30,20 @@ is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 				       entry->midr_range_max);
 }
 
+static bool __maybe_unused
+is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u32 model;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	model = read_cpuid_id();
+	model &= MIDR_IMPLEMENTOR_MASK | (0xf00 << MIDR_PARTNUM_SHIFT) |
+		 MIDR_ARCHITECTURE_MASK;
+
+	return model == entry->midr_model;
+}
+
 static bool
 has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 				int scope)
@@ -169,6 +183,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   MIDR_CPU_VAR_REV(0, 0),
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
+	{
+		.desc = "Qualcomm Technologies Kryo erratum 1003",
+		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.midr_model = MIDR_QCOM_KRYO,
+		.matches = is_kryo_midr,
+	},
 #endif
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
 	{
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 21e2c95d24e7..b3a9180294ca 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -100,6 +100,8 @@ EXPORT_SYMBOL(cpu_hwcap_keys);
 /* meta feature for alternatives */
 static bool __maybe_unused
 cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
+static bool __maybe_unused
+cpufeature_pan_or_falkor_e1003(const struct arm64_cpu_capabilities *entry, int __unused);
 
 
 /*
@@ -860,6 +862,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = cpufeature_pan_not_uao,
 	},
 #endif /* CONFIG_ARM64_PAN */
+#if defined(CONFIG_QCOM_FALKOR_ERRATUM_1003) || defined(CONFIG_ARM64_PAN)
+	{
+		.capability = ARM64_HAS_PAN_OR_FALKOR_E1003,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = cpufeature_pan_or_falkor_e1003,
+	},
+#endif
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
@@ -1211,6 +1220,14 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 	return (cpus_have_const_cap(ARM64_HAS_PAN) && !cpus_have_const_cap(ARM64_HAS_UAO));
 }
 
+static bool __maybe_unused
+cpufeature_pan_or_falkor_e1003(const struct arm64_cpu_capabilities *entry,
+			 int __unused)
+{
+	return cpus_have_const_cap(ARM64_HAS_PAN) ||
+	       cpus_have_const_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003);
+}
+
 /*
  * We emulate only the following system register space.
  * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e1c59d4008a8..0e34d5301503 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -179,7 +179,7 @@
 	 * feature as all TTBR0_EL1 accesses are disabled, not just those to
 	 * user mappings.
 	 */
-alternative_if ARM64_HAS_PAN
+alternative_if ARM64_HAS_PAN_OR_FALKOR_E1003
 	b	1f				// skip TTBR0 PAN
 alternative_else_nop_endif
 
@@ -238,7 +238,7 @@ alternative_else_nop_endif
 	 * Restore access to TTBR0_EL1. If returning to EL0, no need for SPSR
 	 * PAN bit checking.
 	 */
-alternative_if ARM64_HAS_PAN
+alternative_if ARM64_HAS_PAN_OR_FALKOR_E1003
 	b	2f				// skip TTBR0 PAN
 alternative_else_nop_endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
