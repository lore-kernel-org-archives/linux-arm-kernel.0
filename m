From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 31 Mar 2016 18:27:31 +0100
Subject: [PATCH v3 3/7] arm64: Add helpers for detecting AArch32 support at EL0
In-Reply-To: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459445255-15653-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a helper to extract the support for AArch32 at EL0

Tested-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    7 +++++++
 arch/arm64/include/asm/sysreg.h     |    1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b9b6494..7f64285 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -170,6 +170,13 @@ static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
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
index 1287416..1a5f602 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -115,6 +115,7 @@
 #define ID_AA64PFR0_ASIMD_SUPPORTED	0x0
 #define ID_AA64PFR0_EL1_64BIT_ONLY	0x1
 #define ID_AA64PFR0_EL0_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
 
 /* id_aa64mmfr0 */
 #define ID_AA64MMFR0_TGRAN4_SHIFT	28
-- 
1.7.9.5
