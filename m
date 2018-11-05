From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Nov 2018 11:55:13 +0000
Subject: [PATCH 3/7] arm64: capabilities: Merge duplicate entries for Qualcomm
 erratum 1003
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1541418917-14219-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicate entries for Qualcomm erratum 1003. Since the entries
are not purely based on generic MIDR checks, use the multi_cap_entry
type to merge the entries.

Cc: Christopher Covington <cov@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 7242e4c..64525b2 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -592,6 +592,19 @@ static const struct midr_range cavium_erratum_30115_cpus[] = {
 };
 #endif
 
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
+static const struct arm64_cpu_capabilities qcom_erratum_1003_list[] = {
+	{
+		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
+	},
+	{
+		.midr_range.model = MIDR_QCOM_KRYO,
+		.matches = is_kryo_midr,
+	},
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -676,16 +689,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	},
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
 	{
-		.desc = "Qualcomm Technologies Falkor erratum 1003",
+		.desc = "Qualcomm Technologies Falkor/Kryo erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
-	},
-	{
-		.desc = "Qualcomm Technologies Kryo erratum 1003",
-		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
-		.midr_range.model = MIDR_QCOM_KRYO,
-		.matches = is_kryo_midr,
+		.matches = multi_entry_cap_matches,
+		.match_list = qcom_erratum_1003_list,
 	},
 #endif
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
-- 
2.7.4
