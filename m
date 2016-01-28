From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Jan 2016 11:32:16 +0000
Subject: [PATCH 5/6] arm64: cpufeature: Track 32bit EL0 support
In-Reply-To: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453980737-6126-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep track of the support for 32bit EL0.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    8 +++++++-
 arch/arm64/kernel/cpufeature.c      |   11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 98f83d7..46c6f4c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,8 +30,9 @@
 #define ARM64_HAS_LSE_ATOMICS			5
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
+#define ARM64_HAS_32BIT_EL0			8
 
-#define ARM64_NCAPS				8
+#define ARM64_NCAPS				9
 
 #ifndef __ASSEMBLY__
 
@@ -187,6 +188,11 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
+static inline bool system_supports_32bit_el0(void)
+{
+	return cpus_have_cap(ARM64_HAS_32BIT_EL0);
+}
+
 static inline bool system_supports_mixed_endian_el0(void)
 {
 	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 853e575..8deaa20 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -675,6 +675,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+#ifdef CONFIG_COMPAT
+	{
+		.desc = "32 bit EL0",
+		.capability = ARM64_HAS_32BIT_EL0,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_EL0_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
+	},
+#endif
 	{},
 };
 
-- 
1.7.9.5
