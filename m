From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 18:26:32 +0100
Subject: [PATCH 2/2] arm64: Use static keys for CPU features
In-Reply-To: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
References: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1472145992-10660-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds static keys transparently for all the cpu_hwcaps
features by implementing an array of default-false static keys and
enabling them when detected. The cpus_have_cap() check uses the static
keys if the feature being checked is a constant, otherwise the compiler
generates the bitmap test.

Because of the early call to static_branch_enable() via
check_local_cpu_errata() -> update_cpu_capabilities(), the jump labels
are initialised in cpuinfo_store_boot_cpu().

Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 14 +++++++++++---
 arch/arm64/kernel/cpufeature.c      |  3 +++
 arch/arm64/kernel/cpuinfo.c         |  6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7099f26e3702..c9dfb1e4c435 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_CPUFEATURE_H
 #define __ASM_CPUFEATURE_H
 
+#include <linux/jump_label.h>
+
 #include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
@@ -109,6 +111,7 @@ struct arm64_cpu_capabilities {
 };
 
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
+extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 
 bool this_cpu_has_cap(unsigned int cap);
 
@@ -121,16 +124,21 @@ static inline bool cpus_have_cap(unsigned int num)
 {
 	if (num >= ARM64_NCAPS)
 		return false;
-	return test_bit(num, cpu_hwcaps);
+	if (__builtin_constant_p(num))
+		return static_branch_unlikely(&cpu_hwcap_keys[num]);
+	else
+		return test_bit(num, cpu_hwcaps);
 }
 
 static inline void cpus_set_cap(unsigned int num)
 {
-	if (num >= ARM64_NCAPS)
+	if (num >= ARM64_NCAPS) {
 		pr_warn("Attempt to set an illegal CPU capability (%d >= %d)\n",
 			num, ARM64_NCAPS);
-	else
+	} else {
 		__set_bit(num, cpu_hwcaps);
+		static_branch_enable(&cpu_hwcap_keys[num]);
+	}
 }
 
 static inline int __attribute_const__
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 62272eac1352..919b2d0d68ae 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -46,6 +46,9 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
+DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
+EXPORT_SYMBOL(cpu_hwcap_keys);
+
 #define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
 	{						\
 		.sign = SIGNED,				\
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index ed1b84fe6925..6a141e399daf 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -377,6 +377,12 @@ void cpuinfo_store_cpu(void)
 void __init cpuinfo_store_boot_cpu(void)
 {
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
+
+	/*
+	 * Initialise the static keys early as they may be enabled by
+	 * check_local_cpu_errata() -> update_cpu_capabilities().
+	 */
+	jump_label_init();
 	__cpuinfo_store_cpu(info);
 
 	boot_cpu_data = *info;
