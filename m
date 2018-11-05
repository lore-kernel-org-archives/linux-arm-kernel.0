From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Nov 2018 11:55:12 +0000
Subject: [PATCH 2/7] arm64: capabilities: Merge duplicate Cavium erratum
 entries
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1541418917-14219-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge duplicate entries for a single capability using the midr
range list for Cavium errata 30115 and 27456.

Cc: Andrew Pinski <apinski@cavium.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cputype.h |  2 ++
 arch/arm64/kernel/cpu_errata.c   | 50 +++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 12f93e4d..5de4f6a 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -151,6 +151,8 @@ struct midr_range {
 		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
 	}
 
+#define MIDR_REV_RANGE(m, v, r_min, r_max)	MIDR_RANGE(m, v, r_min, v, r_max)
+#define MIDR_REV(m, v, r)			MIDR_RANGE(m, v, r, v, r)
 #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
 
 static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c825bc0..7242e4c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -570,6 +570,28 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 
 #endif
 
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+static const struct midr_range cavium_erratum_27456_cpus[] = {
+	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
+	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
+	/* Cavium ThunderX, T81 pass 1.0 */
+	MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+	{},
+};
+#endif
+
+#ifdef CONFIG_CAVIUM_ERRATUM_30115
+static const struct midr_range cavium_erratum_30115_cpus[] = {
+	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
+	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 2),
+	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
+	MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
+	/* Cavium ThunderX, T83 pass 1.0 */
+	MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -633,40 +655,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 	{
-	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
-				  0, 0,
-				  1, 1),
-	},
-	{
-	/* Cavium ThunderX, T81 pass 1.0 */
-		.desc = "Cavium erratum 27456",
-		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		ERRATA_MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_27456_cpus),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_30115
 	{
-	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
-				      0, 0,
-				      1, 2),
-	},
-	{
-	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
-		.desc = "Cavium erratum 30115",
-		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
-	},
-	{
-	/* Cavium ThunderX, T83 pass 1.0 */
-		.desc = "Cavium erratum 30115",
-		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_30115_cpus),
 	},
 #endif
 	{
-- 
2.7.4
