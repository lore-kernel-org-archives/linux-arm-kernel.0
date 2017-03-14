From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 14 Mar 2017 18:13:25 +0000
Subject: [PATCH 1/3] arm64: v8.3: Support for Javascript conversion instruction
In-Reply-To: <1489515207-9233-1-git-send-email-suzuki.poulose@arm.com>
References: <1489515207-9233-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1489515207-9233-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.3 adds support for a new instruction to perform conversion
from double precision floating point to integer  to match the
architected behaviour of the equivalent Javascript conversion.
Expose the availability via HWCAP and MRS emulation.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/cpu-feature-registers.txt | 8 ++++++++
 arch/arm64/include/asm/sysreg.h               | 3 +++
 arch/arm64/include/uapi/asm/hwcap.h           | 1 +
 arch/arm64/kernel/cpufeature.c                | 8 +++++++-
 arch/arm64/kernel/cpuinfo.c                   | 1 +
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index 61ca21e..5b279dc 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -169,6 +169,14 @@ infrastructure:
    as available on the CPU where it is fetched and is not a system
    wide safe value.
 
+  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
+
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | JSCVT                        | [15-12] |    y    |
+     x--------------------------------------------------x
+
 Appendix I: Example
 ---------------------------
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ac24b6e..cbb3143 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -156,6 +156,9 @@
 #define ID_AA64ISAR0_SHA1_SHIFT		8
 #define ID_AA64ISAR0_AES_SHIFT		4
 
+/* id_aa64isar1 */
+#define ID_AA64ISAR1_JSCVT_SHIFT	12
+
 /* id_aa64pfr0 */
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 61c263c..391a876 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -32,5 +32,6 @@
 #define HWCAP_ASIMDHP		(1 << 10)
 #define HWCAP_CPUID		(1 << 11)
 #define HWCAP_ASIMDRDM		(1 << 12)
+#define HWCAP_JSCVT		(1 << 13)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e8..af88910 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -97,6 +97,11 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_JSCVT_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
@@ -314,7 +319,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
 	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
-	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_raz),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
@@ -888,6 +893,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_JSCVT),
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 5b22c68..95cfd33 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -65,6 +65,7 @@ static const char *const hwcap_str[] = {
 	"asimdhp",
 	"cpuid",
 	"asimdrdm",
+	"jscvt",
 	NULL
 };
 
-- 
2.7.4
