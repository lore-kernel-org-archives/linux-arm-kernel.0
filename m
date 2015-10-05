From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:02:03 +0100
Subject: [PATCH v2 14/22] arm64: Cleanup HWCAP handling
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-15-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend struct arm64_cpu_capabilities to handle the HWCAP detection
and make use of the system wide value for the feature register.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    2 +
 arch/arm64/include/asm/hwcap.h      |    8 ++
 arch/arm64/kernel/cpufeature.c      |  153 ++++++++++++++++++-----------------
 3 files changed, 91 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1234c9c..38400dc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -82,6 +82,8 @@ struct arm64_cpu_capabilities {
 			u32 sys_reg;
 			int field_pos;
 			int min_field_value;
+			int hwcap_type;
+			unsigned long hwcap;
 		};
 	};
 };
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 0ad7351..400b80b 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -52,6 +52,14 @@
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
 #endif
 
+enum {
+	CAP_HWCAP = 1,
+#ifdef CONFIG_COMPAT
+	CAP_COMPAT_HWCAP,
+	CAP_COMPAT_HWCAP2,
+#endif
+};
+
 extern unsigned long elf_hwcap;
 #endif
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1278752..5313413 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -632,6 +632,79 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{},
 };
 
+#define HWCAP_CAP(reg, field, min_value, type, cap)		\
+	{							\
+		.desc = #cap,					\
+		.matches = has_cpuid_feature,			\
+		.sys_reg = reg,					\
+		.field_pos = field,				\
+		.min_field_value = min_value,			\
+		.hwcap_type = type,				\
+		.hwcap = cap,					\
+	}
+
+static const struct arm64_cpu_capabilities arm64_hwcaps[] = {
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, 2, CAP_HWCAP, HWCAP_PMULL),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, 1, CAP_HWCAP, HWCAP_AES),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA1_SHIFT, 1, CAP_HWCAP, HWCAP_SHA1),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, 1, CAP_HWCAP, HWCAP_SHA2),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, 1, CAP_HWCAP, HWCAP_CRC32),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, 2, CAP_HWCAP, HWCAP_ATOMICS),
+#ifdef CONFIG_COMPAT
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA2_SHIFT, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA2),
+	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_CRC32_SHIFT, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_CRC32),
+#endif
+};
+
+static void cap_set_hwcap(const struct arm64_cpu_capabilities * cap)
+{
+	switch(cap->hwcap_type) {
+	case CAP_HWCAP:
+		elf_hwcap |= cap->hwcap;
+		break;
+#ifdef CONFIG_COMPAT
+	case CAP_COMPAT_HWCAP:
+		compat_elf_hwcap |= (u32)cap->hwcap;
+		break;
+	case CAP_COMPAT_HWCAP2:
+		compat_elf_hwcap2 |= (u32)cap->hwcap;
+		break;
+#endif
+	default:
+		BUG();
+		break;
+	}
+}
+
+static bool cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
+{
+	switch(cap->hwcap_type) {
+	case CAP_HWCAP:
+		return !!(elf_hwcap & cap->hwcap);
+#ifdef CONFIG_COMPAT
+	case CAP_COMPAT_HWCAP:
+		return !!(compat_elf_hwcap & (u32)cap->hwcap);
+	case CAP_COMPAT_HWCAP2:
+		return !!(compat_elf_hwcap2 & (u32)cap->hwcap);
+#endif
+	default:
+		BUG();
+		return false;
+	}
+}
+
+void check_cpu_hwcaps(void)
+{
+	int i;
+	const struct arm64_cpu_capabilities *hwcaps = arm64_hwcaps;
+	for(i = 0; i < ARRAY_SIZE(arm64_hwcaps); i ++)
+		if (hwcaps[i].matches(&hwcaps[i]))
+			cap_set_hwcap(&hwcaps[i]);
+}
+
 void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
@@ -739,6 +812,13 @@ void cpu_enable_features(void)
 		if (caps[i].enable)
 			caps[i].enable(NULL);
 	}
+
+	for(i =0, caps = arm64_hwcaps; caps[i].desc; i++) {
+		if (!cpus_have_hwcap(&caps[i]))
+			continue;
+		if (!feature_matches(read_cpu_sysreg(caps[i].sys_reg), &caps[i]))
+			fail_incapable_cpu("arm64_hwcaps", &caps[i]);
+	}
 }
 
 static int cpu_feature_hotplug_notify(struct notifier_block *nb,
@@ -773,12 +853,11 @@ bool system_supports_mixed_endian_el0(void)
 
 void __init setup_cpu_features(void)
 {
-	u64 features;
-	s64 block;
 	u32 cwg;
 	int cls;
 
 	check_cpu_features();
+	check_cpu_hwcaps();
 	/*
 	 * Check for sane CTR_EL0.CWG value.
 	 */
@@ -790,74 +869,4 @@ void __init setup_cpu_features(void)
 	if (L1_CACHE_BYTES < cls)
 		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
 			L1_CACHE_BYTES, cls);
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
 }
-- 
1.7.9.5
