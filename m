From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 14 Aug 2017 11:38:54 +0100
Subject: [RFC PATCH 3/3] arm64: Introduce command line parameter to disable CNP
In-Reply-To: <1502707134-10853-1-git-send-email-vladimir.murzin@arm.com>
References: <1502707134-10853-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1502707134-10853-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases when activating of Common Not Private (CNP) feature
might not be desirable; this patch allows to forcefully disable CNP
even it is supported by hardware.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/arm64/kernel/cpufeature.c                  | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9c171c..063f523 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2549,6 +2549,10 @@
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
 
+	nocnp		[ARM64]
+			Disable CNP (Common not Private translations)
+			even if it is supported by processor.
+
 	nodelayacct	[KNL] Disable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6beeaa2..eb1ae26 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -770,6 +770,24 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int _
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
+static bool has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	if (!has_cpuid_feature(entry, scope))
+		return false;
+
+	return nocnp ? false : true;
+}
+
+
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	return is_kernel_in_hyp_mode();
@@ -894,7 +912,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Common not Private translations",
 		.capability = ARM64_HAS_CNP,
 		.def_scope = SCOPE_SYSTEM,
-		.matches = has_cpuid_feature,
+		.matches = has_useable_cnp,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_CNP_SHIFT,
-- 
2.0.0
