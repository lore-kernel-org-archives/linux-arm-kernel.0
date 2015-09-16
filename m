From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:01 +0100
Subject: [PATCH 03/22] arm64: Move cpu feature detection code
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch moves the CPU feature detection code from
 arch/arm64/kernel/{setup.c to cpufeature.c}

The plan is to consolidate all the CPU feature handling
in cpufeature.c.

Changes pr_fmt from "alternatives" to "cpu features"

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |  111 +++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/setup.c      |  107 --------------------------------------
 2 files changed, 110 insertions(+), 108 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3c9aed3..bdb3eb4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -16,13 +16,31 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#define pr_fmt(fmt) "alternatives: " fmt
+#define pr_fmt(fmt) "CPU features: " fmt
 
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 
+unsigned long elf_hwcap __read_mostly;
+EXPORT_SYMBOL_GPL(elf_hwcap);
+
+#ifdef CONFIG_COMPAT
+#define COMPAT_ELF_HWCAP_DEFAULT	\
+				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
+				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
+				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
+				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
+				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
+				 COMPAT_HWCAP_LPAE)
+unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
+unsigned int compat_elf_hwcap2 __read_mostly;
+#endif
+
+DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
+
+
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
@@ -100,3 +118,94 @@ void check_local_cpu_features(void)
 {
 	check_cpu_capabilities(arm64_features, "detected feature:");
 }
+
+void __init setup_cpu_features(void)
+{
+	u64 features;
+	s64 block;
+	u32 cwg;
+	int cls;
+
+	/*
+	 * Check for sane CTR_EL0.CWG value.
+	 */
+	cwg = cache_type_cwg();
+	cls = cache_line_size();
+	if (!cwg)
+		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
+			cls);
+	if (L1_CACHE_BYTES < cls)
+		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
+			L1_CACHE_BYTES, cls);
+
+	/*
+	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
+	 * The blocks we test below represent incremental functionality
+	 * for non-negative values. Negative values are reserved.
+	 */
+	features = read_cpuid(ID_AA64ISAR0_EL1);
+	block = cpuid_feature_extract_field(features, 4);
+	if (block > 0) {
+		switch (block) {
+		default:
+		case 2:
+			elf_hwcap |= HWCAP_PMULL;
+		case 1:
+			elf_hwcap |= HWCAP_AES;
+		case 0:
+			break;
+		}
+	}
+
+	if (cpuid_feature_extract_field(features, 8) > 0)
+		elf_hwcap |= HWCAP_SHA1;
+
+	if (cpuid_feature_extract_field(features, 12) > 0)
+		elf_hwcap |= HWCAP_SHA2;
+
+	if (cpuid_feature_extract_field(features, 16) > 0)
+		elf_hwcap |= HWCAP_CRC32;
+
+	block = cpuid_feature_extract_field(features, 20);
+	if (block > 0) {
+		switch (block) {
+		default:
+		case 2:
+			elf_hwcap |= HWCAP_ATOMICS;
+		case 1:
+			/* RESERVED */
+		case 0:
+			break;
+		}
+	}
+
+#ifdef CONFIG_COMPAT
+	/*
+	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
+	 * the AArch32 32-bit execution state.
+	 */
+	features = read_cpuid(ID_ISAR5_EL1);
+	block = cpuid_feature_extract_field(features, 4);
+	if (block > 0) {
+		switch (block) {
+		default:
+		case 2:
+			compat_elf_hwcap2 |= COMPAT_HWCAP2_PMULL;
+		case 1:
+			compat_elf_hwcap2 |= COMPAT_HWCAP2_AES;
+		case 0:
+			break;
+		}
+	}
+
+	if (cpuid_feature_extract_field(features, 8) > 0)
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA1;
+
+	if (cpuid_feature_extract_field(features, 12) > 0)
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA2;
+
+	if (cpuid_feature_extract_field(features, 16) > 0)
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_CRC32;
+#endif
+}
+
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d149c18..4c7bca8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -64,23 +64,6 @@
 #include <asm/efi.h>
 #include <asm/xen/hypervisor.h>
 
-unsigned long elf_hwcap __read_mostly;
-EXPORT_SYMBOL_GPL(elf_hwcap);
-
-#ifdef CONFIG_COMPAT
-#define COMPAT_ELF_HWCAP_DEFAULT	\
-				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
-				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
-				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
-				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
-				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
-				 COMPAT_HWCAP_LPAE)
-unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
-unsigned int compat_elf_hwcap2 __read_mostly;
-#endif
-
-DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
-
 phys_addr_t __fdt_pointer __initdata;
 
 /*
@@ -195,96 +178,6 @@ static void __init smp_build_mpidr_hash(void)
 	__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
 }
 
-void __init setup_cpu_features(void)
-{
-	u64 features;
-	s64 block;
-	u32 cwg;
-	int cls;
-
-	/*
-	 * Check for sane CTR_EL0.CWG value.
-	 */
-	cwg = cache_type_cwg();
-	cls = cache_line_size();
-	if (!cwg)
-		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
-			cls);
-	if (L1_CACHE_BYTES < cls)
-		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
-			L1_CACHE_BYTES, cls);
-
-	/*
-	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
-	 * The blocks we test below represent incremental functionality
-	 * for non-negative values. Negative values are reserved.
-	 */
-	features = read_cpuid(ID_AA64ISAR0_EL1);
-	block = cpuid_feature_extract_field(features, 4);
-	if (block > 0) {
-		switch (block) {
-		default:
-		case 2:
-			elf_hwcap |= HWCAP_PMULL;
-		case 1:
-			elf_hwcap |= HWCAP_AES;
-		case 0:
-			break;
-		}
-	}
-
-	if (cpuid_feature_extract_field(features, 8) > 0)
-		elf_hwcap |= HWCAP_SHA1;
-
-	if (cpuid_feature_extract_field(features, 12) > 0)
-		elf_hwcap |= HWCAP_SHA2;
-
-	if (cpuid_feature_extract_field(features, 16) > 0)
-		elf_hwcap |= HWCAP_CRC32;
-
-	block = cpuid_feature_extract_field(features, 20);
-	if (block > 0) {
-		switch (block) {
-		default:
-		case 2:
-			elf_hwcap |= HWCAP_ATOMICS;
-		case 1:
-			/* RESERVED */
-		case 0:
-			break;
-		}
-	}
-
-#ifdef CONFIG_COMPAT
-	/*
-	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
-	 * the AArch32 32-bit execution state.
-	 */
-	features = read_cpuid(ID_ISAR5_EL1);
-	block = cpuid_feature_extract_field(features, 4);
-	if (block > 0) {
-		switch (block) {
-		default:
-		case 2:
-			compat_elf_hwcap2 |= COMPAT_HWCAP2_PMULL;
-		case 1:
-			compat_elf_hwcap2 |= COMPAT_HWCAP2_AES;
-		case 0:
-			break;
-		}
-	}
-
-	if (cpuid_feature_extract_field(features, 8) > 0)
-		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA1;
-
-	if (cpuid_feature_extract_field(features, 12) > 0)
-		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA2;
-
-	if (cpuid_feature_extract_field(features, 16) > 0)
-		compat_elf_hwcap2 |= COMPAT_HWCAP2_CRC32;
-#endif
-}
-
 static void __init setup_processor(void)
 {
 	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
-- 
1.7.9.5
