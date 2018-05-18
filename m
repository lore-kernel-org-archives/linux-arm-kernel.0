From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 18 May 2018 10:46:05 +0100
Subject: [PATCH v3 3/3] arm64: Introduce command line parameter to disable CNP
In-Reply-To: <1526636765-11289-1-git-send-email-vladimir.murzin@arm.com>
References: <1526636765-11289-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1526636765-11289-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases when activating of Common Not Private (CNP) feature
might not be desirable; this patch allows to forcefully disable CNP
even it is supported by hardware.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/arm64/kernel/cpufeature.c                  | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..181ecca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2603,6 +2603,10 @@
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
 
+	nocnp		[ARM64]
+			Disable CNP (Common not Private translations)
+			even if it is supported by processor.
+
 	nodelayacct	[KNL] Disable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 78de218..80fe8fa 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -826,6 +826,15 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int _
 		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
 }
 
+static bool nocnp;
+
+static int __init early_nocnp(char *p)
+{
+	nocnp = true;
+	return 0;
+}
+early_param("nocnp", early_nocnp);
+
 static bool __maybe_unused
 has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 {
@@ -833,7 +842,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	if (elfcorehdr_size)
 		return false;
 #endif
-	return has_cpuid_feature(entry, scope);
+	return has_cpuid_feature(entry, scope) && !nocnp;
 }
 
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
-- 
2.0.0
