From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Dec 2017 14:19:37 -0800
Subject: [PATCH v3] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
Message-ID: <20171213221937.28065-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kryo CPUs are also affected by the Falkor 1003 errata, so
we need to do the same workaround on Kryo CPUs. The MIDR is
slightly more complicated here, where the PART number is not
always the same when looking at all the bits from 15 to 4. Drop
the lower 8 bits and just look at the top 4 to see if it's '2'
and then consider those as Kryo CPUs. This covers all the
combinations without having to list them all out.

Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v2:
 * Dropped the new cap bit, rebased onto for-next/core in arm64 tree

 Documentation/arm64/silicon-errata.txt |  2 +-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 304bf22bb83c..b9d93e981a05 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -72,6 +72,6 @@ stable kernels.
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 | Hisilicon      | Hip07           | #161600802      | HISILICON_ERRATUM_161600802 |
 |                |                 |                 |                             |
-| Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
+| Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
