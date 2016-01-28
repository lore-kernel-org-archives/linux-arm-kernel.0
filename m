From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Jan 2016 11:32:14 +0000
Subject: [PATCH 3/6] arm64: Add helpers for detecting AArch32 support at EL0
In-Reply-To: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453980737-6126-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a helper to extract the support for AArch32 at EL0

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    7 +++++++
 arch/arm64/include/asm/sysreg.h     |    1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5444a77..98f83d7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -165,6 +165,13 @@ static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
 		cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
 }
 
+static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
+{
+	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL0_SHIFT);
+
+	return val == ID_AA64PFR0_EL0_32BIT_64BIT;
+}
+
 void __init setup_cpu_features(void);
 
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4aeebec..76d2f3e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -111,6 +111,7 @@
 #define ID_AA64PFR0_ASIMD_SUPPORTED	0x0
 #define ID_AA64PFR0_EL1_64BIT_ONLY	0x1
 #define ID_AA64PFR0_EL0_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
 
 /* id_aa64mmfr0 */
 #define ID_AA64MMFR0_TGRAN4_SHIFT	28
-- 
1.7.9.5
