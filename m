From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:41 +0800
Subject: [PATCH 19/29] arm64: Take into account ID_AA64PFR0_EL1.CSV3
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-20-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 179a56f6f9fb upstream.

For non-KASLR kernels where the KPTI behaviour has not been overridden
on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
or not we should unmap the kernel whilst running at EL0.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	skip cpu features like SVE etc.
	and use 5 paramaters function ARM64_FTR_BITS()
	replace read_sanitised_ftr_reg with old name read_system_reg
	arch/arm64/include/asm/sysreg.h
	arch/arm64/kernel/cpufeature.c
---
 arch/arm64/include/asm/sysreg.h | 1 +
 arch/arm64/kernel/cpufeature.c  | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7393cc7..7cb7f7c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -117,6 +117,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 74b168c..3ec6517 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -98,6 +98,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	/* Linux doesn't care about the EL3 */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64PFR0_EL3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL2_SHIFT, 4, 0),
@@ -752,6 +753,8 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+
 	/* Forced on command line? */
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by command line option\n",
@@ -763,7 +766,9 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	return false;
+	/* Defer to CPU feature registers */
+	return !cpuid_feature_extract_unsigned_field(pfr0,
+						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
 static int __init parse_kpti(char *str)
@@ -865,6 +870,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
+		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = unmap_kernel_at_el0,
-- 
2.7.4
