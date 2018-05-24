From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 24 May 2018 14:09:32 -0500
Subject: [PATCH 4/4] arm64: cpufeature: always log KPTI setting on boot
In-Reply-To: <20180524190932.32118-1-mlangsdo@redhat.com>
References: <20180524190932.32118-1-mlangsdo@redhat.com>
Message-ID: <20180524190932.32118-5-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always log KPTI setting at boot time, whether or not KPTI was forced
by a kernel parameter.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 arch/arm64/kernel/cpufeature.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 697a6ef..e50bf3c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -889,16 +889,20 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		__pti_enabled = __kpti_forced > 0;
 		pr_info_once("kernel page table isolation forced %s by %s\n",
 			     __pti_enabled ? "ON" : "OFF", str);
+	} else {
+		/* Useful for KASLR robustness */
+		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+			__pti_enabled = true;
+		/* Don't force KPTI for CPUs that are not vulnerable */
+		else if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+			__pti_enabled = false;
+		/* Defer to CPU feature registers */
+		else
+			__pti_enabled = !has_cpuid_feature(entry, scope);
+
+		pr_info_once("kernel page table isolation %s by %s\n",
+			    __pti_enabled ? "ON" : "OFF", str);
 	}
-	/* Useful for KASLR robustness */
-	else if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		__pti_enabled = true;
-	/* Don't force KPTI for CPUs that are not vulnerable */
-	else if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
-		__pti_enabled = false;
-	/* Defer to CPU feature registers */
-	else
-		__pti_enabled = !has_cpuid_feature(entry, scope);
 
 	return __pti_enabled;
 }
-- 
2.9.5
