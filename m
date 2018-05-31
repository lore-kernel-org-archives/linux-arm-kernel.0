From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 31 May 2018 12:08:32 -0500
Subject: [PATCH v2 2/2] arm64: cpufeature: always log KPTI setting on boot
In-Reply-To: <20180531170832.14263-1-mlangsdo@redhat.com>
References: <20180531170832.14263-1-mlangsdo@redhat.com>
Message-ID: <20180531170832.14263-3-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always log KPTI setting at boot time, whether or not KPTI was forced
by a kernel parameter.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 arch/arm64/kernel/cpufeature.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7c5d8712..2bfbbe4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -860,6 +860,7 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
+static bool __pti_enabled;
 
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int scope)
@@ -884,21 +885,26 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 
 	/* Forced? */
 	if (__kpti_forced) {
+		__pti_enabled = __kpti_forced > 0;
 		pr_info_once("kernel page table isolation forced %s by %s\n",
-			     __kpti_forced > 0 ? "ON" : "OFF", str);
-		return __kpti_forced > 0;
-	}
-
-	/* Useful for KASLR robustness */
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		return true;
+			     __pti_enabled ? "ON" : "OFF", str);
+	} else {
+		str = "default";
+		/* Useful for KASLR robustness */
+		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+			__pti_enabled = true;
+		/* Don't force KPTI for CPUs that are not vulnerable */
+		else if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+			__pti_enabled = false;
+		/* Defer to CPU feature registers */
+		else
+			__pti_enabled = !has_cpuid_feature(entry, scope);
 
-	/* Don't force KPTI for CPUs that are not vulnerable */
-	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
-		return false;
+		pr_info_once("kernel page table isolation %s by %s\n",
+			    __pti_enabled ? "ON" : "OFF", str);
+	}
 
-	/* Defer to CPU feature registers */
-	return !has_cpuid_feature(entry, scope);
+	return __pti_enabled;
 }
 
 static void
-- 
2.9.5
