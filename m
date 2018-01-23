From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:28:04 +0000
Subject: [PATCH 11/16] arm64: errata: Clean up midr range helpers
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-12-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are about to introduce generic MIDR range helpers. Clean
up the existing helpers in errat handling, preparing them
to use generic version.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 76 +++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 550ac8a0854b..054b17009f41 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -179,14 +179,23 @@ static int qcom_enable_link_stack_sanitization(
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
-#define MIDR_RANGE(model, min, max) \
+#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max) \
 	.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
-	.midr_range_min = min, \
-	.midr_range_max = max
+	.midr_range_min = MIDR_CPU_VAR_REV(v_min, r_min), \
+	.midr_range_max = MIDR_CPU_VAR_REV(v_max, r_max)
 
-#define MIDR_ALL_VERSIONS(model) \
+/* Errata affecting a range of revisions of  given model variant */
+#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max) \
+	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
+
+/* Errata affecting a single variant/revision of a model */
+#define ERRATA_MIDR(model, var, rev)	\
+	ERRATA_MIDR_RANGE(model, var, rev, var, rev)
+
+/* Errata affecting all variants/revisions of a given a model */
+#define ERRATA_MIDR_ALL_VERSIONS(model) \
 	.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
@@ -201,7 +210,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[012] */
 		.desc = "ARM errata 826319, 827319, 824069",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x2),
 		.enable = cpu_enable_cache_maint_trap,
 	},
 #endif
@@ -210,7 +219,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[01] */
 		.desc = "ARM errata 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x01),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x01),
 		.enable = cpu_enable_cache_maint_trap,
 	},
 #endif
@@ -219,9 +228,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 832075",
 		.capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
-		MIDR_RANGE(MIDR_CORTEX_A57,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(1, 2)),
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A57,
+				  0, 0,
+				  1, 2),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_834220
@@ -229,9 +238,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 834220",
 		.capability = ARM64_WORKAROUND_834220,
-		MIDR_RANGE(MIDR_CORTEX_A57,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(1, 2)),
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A57,
+				  0, 0,
+				  1, 2),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
@@ -239,7 +248,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[01234] */
 		.desc = "ARM erratum 845719",
 		.capability = ARM64_WORKAROUND_845719,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x04),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x4),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
@@ -247,7 +256,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, pass 1.x */
 		.desc = "Cavium erratum 23154",
 		.capability = ARM64_WORKAROUND_CAVIUM_23154,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
+		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0x0, 0x0, 0x01),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
@@ -255,15 +264,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(1, 1)),
+		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
+				  0, 0,
+				  1, 1),
 	},
 	{
 	/* Cavium ThunderX, T81 pass 1.0 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
+		ERRATA_MIDR(MIDR_THUNDERX_81XX, 0x0, 0x0),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_30115
@@ -271,20 +280,21 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 2),
+		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
+				      0x0, 0x0,
+				      0x1, 0x2),
 	},
 	{
 	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x02),
+		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0x0, 0x0, 0x02),
 	},
 	{
 	/* Cavium ThunderX, T83 pass 1.0 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		MIDR_RANGE(MIDR_THUNDERX_83XX, 0x00, 0x00),
+		ERRATA_MIDR(MIDR_THUNDERX_83XX, 0x0, 0x0),
 	},
 #endif
 	{
@@ -298,9 +308,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Falkor erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		MIDR_RANGE(MIDR_QCOM_FALKOR_V1,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(0, 0)),
+		ERRATA_MIDR(MIDR_QCOM_FALKOR_V1, 0, 0),
 	},
 	{
 		.desc = "Qualcomm Technologies Kryo erratum 1003",
@@ -314,9 +322,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Falkor erratum 1009",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
-		MIDR_RANGE(MIDR_QCOM_FALKOR_V1,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(0, 0)),
+		ERRATA_MIDR(MIDR_QCOM_FALKOR_V1, 0, 0),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -324,38 +330,38 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A73 all versions */
 		.desc = "ARM erratum 858921",
 		.capability = ARM64_WORKAROUND_858921,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 	},
 #endif
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
 		.enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 		.enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		.enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 		.enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 		.enable = qcom_enable_link_stack_sanitization,
 	},
 	{
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
-		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 	},
 #endif
 	{
-- 
2.13.6
