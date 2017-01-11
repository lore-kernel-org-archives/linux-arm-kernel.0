From: rrichter@cavium.com (Robert Richter)
Date: Wed, 11 Jan 2017 13:11:42 +0100
Subject: [PATCH] arm64: errata: Provide macro for major and minor cpu revisions
Message-ID: <20170111121143.9586-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definition of cpu ranges are hard to read if the cpu variant is not
zero. Provide MIDR_CPU_FULL_REV() macro to describe the full hardware
revision of a cpu including variant and (minor) revision.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/include/asm/cputype.h |  3 +++
 arch/arm64/kernel/cpu_errata.c   | 15 +++++++++------
 arch/arm64/kernel/cpufeature.c   |  8 +++-----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 26a68ddb11c1..983e59cbdd54 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -56,6 +56,9 @@
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
+#define MIDR_CPU_FULL_REV(var, rev) \
+	(((var)	<< MIDR_VARIANT_SHIFT) | (rev))
+
 #define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
 			     MIDR_ARCHITECTURE_MASK)
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b75e917aac46..63b61e981e2f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -79,8 +79,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 832075",
 		.capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
-		MIDR_RANGE(MIDR_CORTEX_A57, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 2),
+		MIDR_RANGE(MIDR_CORTEX_A57,
+			   MIDR_CPU_FULL_REV(0, 0),
+			   MIDR_CPU_FULL_REV(1, 2)),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_834220
@@ -88,8 +89,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 834220",
 		.capability = ARM64_WORKAROUND_834220,
-		MIDR_RANGE(MIDR_CORTEX_A57, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 2),
+		MIDR_RANGE(MIDR_CORTEX_A57,
+			   MIDR_CPU_FULL_REV(0, 0),
+			   MIDR_CPU_FULL_REV(1, 2)),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
@@ -113,8 +115,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 1),
+		MIDR_RANGE(MIDR_THUNDERX,
+			   MIDR_CPU_FULL_REV(0, 0),
+			   MIDR_CPU_FULL_REV(1, 1)),
 	},
 	{
 	/* Cavium ThunderX, T81 pass 1.0 */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fdf8f045929f..f12b13de24f4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -720,13 +720,11 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry,
 static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	u32 midr = read_cpuid_id();
-	u32 rv_min, rv_max;
 
 	/* Cavium ThunderX pass 1.x and 2.x */
-	rv_min = 0;
-	rv_max = (1 << MIDR_VARIANT_SHIFT) | MIDR_REVISION_MASK;
-
-	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX, rv_min, rv_max);
+	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
+		MIDR_CPU_FULL_REV(0, 0),
+		MIDR_CPU_FULL_REV(1, MIDR_REVISION_MASK));
 }
 
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
-- 
2.11.0
