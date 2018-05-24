From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 24 May 2018 14:09:31 -0500
Subject: [PATCH 3/4] arm64: cpufeature: add debugfs interface for KPTI
In-Reply-To: <20180524190932.32118-1-mlangsdo@redhat.com>
References: <20180524190932.32118-1-mlangsdo@redhat.com>
Message-ID: <20180524190932.32118-4-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a debugfs interface to check if KPTI is enabled or disabled:
  cat /sys/kernel/debug/arm64/pti_enabled

Slightly rework unmap_kernel_at_el0 logic to simplify calculating if
KPTI is enabled.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 arch/arm64/kernel/cpufeature.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7c5d8712..697a6ef 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <linux/stop_machine.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/debugfs.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
@@ -860,6 +861,7 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
+static bool __pti_enabled;
 
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int scope)
@@ -884,21 +886,21 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 
 	/* Forced? */
 	if (__kpti_forced) {
+		__pti_enabled = __kpti_forced > 0;
 		pr_info_once("kernel page table isolation forced %s by %s\n",
-			     __kpti_forced > 0 ? "ON" : "OFF", str);
-		return __kpti_forced > 0;
+			     __pti_enabled ? "ON" : "OFF", str);
 	}
-
 	/* Useful for KASLR robustness */
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		return true;
-
+	else if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		__pti_enabled = true;
 	/* Don't force KPTI for CPUs that are not vulnerable */
-	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
-		return false;
-
+	else if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+		__pti_enabled = false;
 	/* Defer to CPU feature registers */
-	return !has_cpuid_feature(entry, scope);
+	else
+		__pti_enabled = !has_cpuid_feature(entry, scope);
+
+	return __pti_enabled;
 }
 
 static void
@@ -947,6 +949,14 @@ static int __init force_nokpti(char *arg)
 	return 0;
 }
 early_param("nopti", force_nokpti);
+
+static int __init create_kpti_enabled(void)
+{
+	debugfs_create_bool("pti_enabled", S_IRUSR,
+			   arch_debugfs_dir, &__pti_enabled);
+	return 0;
+}
+late_initcall(create_kpti_enabled);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-- 
2.9.5
