From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  8 Nov 2017 11:00:29 -0800
Subject: [PATCH] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
Message-ID: <20171108190029.19835-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kryo CPUs are also affected by the Falkor 1003 errata, so
we need to do the same workaround on Kryo CPUs. The MIDR is
slightly more complicated here, where the PART number is not
always the same when looking at all the bits from 15 to 4. Drop
the lower 8 bits and just look at the top 4 to see if it's '2'
and then consider those as Kryo CPUs. This covers all the
combinations without having to list them all out.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

We may need to introduce another Kconfig option to block software PAN
from being enabled when this errata is enabled (and then have software PAN
depend on this new config being false). That's because some Kryo CPUs don't
support HW PAN while others do. That's seems to be the best compromise,
similar to what was mentioned in this thread[1].

Otherwise, I can take a look at updating the software PAN implementation
to handle this errata, but that is probably a dead-end?

[1] https://lkml.org/lkml/2017/2/1/591

 Documentation/arm64/silicon-errata.txt |  2 +-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

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
