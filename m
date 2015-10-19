From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:24:53 +0100
Subject: [PATCHv4 16/24] arm64: Move FP/ASIMD hwcap handling to common code
In-Reply-To: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445261101-22344-17-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FP/ASIMD is detected in fpsimd_init(), which is built-in
unconditionally. Lets move the hwcap handling to the central place.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |    2 ++
 arch/arm64/kernel/fpsimd.c     |   16 +++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 73ceccc..d69af00 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -646,6 +646,8 @@ static const struct arm64_cpu_capabilities arm64_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, 1, CAP_HWCAP, HWCAP_SHA2),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, 1, CAP_HWCAP, HWCAP_CRC32),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, 2, CAP_HWCAP, HWCAP_ATOMICS),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, 0, CAP_HWCAP, HWCAP_FP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, 0, CAP_HWCAP, HWCAP_ASIMD),
 #ifdef CONFIG_COMPAT
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c56956a..4c46c54 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -332,21 +332,15 @@ static inline void fpsimd_hotplug_init(void) { }
  */
 static int __init fpsimd_init(void)
 {
-	u64 pfr = read_cpuid(ID_AA64PFR0_EL1);
-
-	if (pfr & (0xf << 16)) {
+	if (elf_hwcap & HWCAP_FP) {
+		fpsimd_pm_init();
+		fpsimd_hotplug_init();
+	} else {
 		pr_notice("Floating-point is not implemented\n");
-		return 0;
 	}
-	elf_hwcap |= HWCAP_FP;
 
-	if (pfr & (0xf << 20))
+	if (!(elf_hwcap & HWCAP_ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
-	else
-		elf_hwcap |= HWCAP_ASIMD;
-
-	fpsimd_pm_init();
-	fpsimd_hotplug_init();
 
 	return 0;
 }
-- 
1.7.9.5
