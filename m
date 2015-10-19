From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:24:52 +0100
Subject: [PATCHv4 15/24] arm64/HWCAP: Use system wide safe values
In-Reply-To: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445261101-22344-16-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend struct arm64_cpu_capabilities to handle the HWCAP detection
and make use of the system wide value of the feature registers for
a reliable set of HWCAPs.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    2 +
 arch/arm64/include/asm/hwcap.h      |    8 ++
 arch/arm64/kernel/cpufeature.c      |  163 +++++++++++++++++++----------------
 3 files changed, 101 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 97b4d64..dc00813 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -81,6 +81,8 @@ struct arm64_cpu_capabilities {
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
index a6a4acb..73ceccc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -628,6 +628,89 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
+	{},
+};
+
+static void cap_set_hwcap(const struct arm64_cpu_capabilities *cap)
+{
+	switch (cap->hwcap_type) {
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
+		WARN_ON(1);
+		break;
+	}
+}
+
+/* Check if we have a particular HWCAP enabled */
+static bool cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
+{
+	bool rc;
+
+	switch (cap->hwcap_type) {
+	case CAP_HWCAP:
+		rc = (elf_hwcap & cap->hwcap) != 0;
+		break;
+#ifdef CONFIG_COMPAT
+	case CAP_COMPAT_HWCAP:
+		rc = (compat_elf_hwcap & (u32)cap->hwcap) != 0;
+		break;
+	case CAP_COMPAT_HWCAP2:
+		rc = (compat_elf_hwcap2 & (u32)cap->hwcap) != 0;
+		break;
+#endif
+	default:
+		WARN_ON(1);
+		rc = false;
+	}
+
+	return rc;
+}
+
+static void setup_cpu_hwcaps(void)
+{
+	int i;
+	const struct arm64_cpu_capabilities *hwcaps = arm64_hwcaps;
+
+	for (i = 0; hwcaps[i].desc; i++)
+		if (hwcaps[i].matches(&hwcaps[i]))
+			cap_set_hwcap(&hwcaps[i]);
+}
+
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
@@ -770,6 +853,13 @@ void verify_local_cpu_capabilities(void)
 		if (caps[i].enable)
 			caps[i].enable(NULL);
 	}
+
+	for (i = 0, caps = arm64_hwcaps; caps[i].desc; i++) {
+		if (!cpus_have_hwcap(&caps[i]))
+			continue;
+		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i]))
+			fail_incapable_cpu("arm64_hwcaps", &caps[i]);
+	}
 }
 
 #else	/* !CONFIG_HOTPLUG_CPU */
@@ -786,13 +876,12 @@ static void setup_feature_capabilities(void)
 
 void __init setup_cpu_features(void)
 {
-	u64 features;
-	s64 block;
 	u32 cwg;
 	int cls;
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
+	setup_cpu_hwcaps();
 
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
@@ -808,74 +897,4 @@ void __init setup_cpu_features(void)
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
