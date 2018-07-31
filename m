From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 31 Jul 2018 14:08:58 +0100
Subject: [PATCH v6 3/3] arm64: Introduce command line parameter to disable CNP
In-Reply-To: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
References: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1533042538-26184-4-git-send-email-vladimir.murzin@arm.com>
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
index 533ff5c..de7027f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2648,6 +2648,10 @@
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
 
+	nocnp		[ARM64]
+			Disable CNP (Common not Private translations)
+			even if it is supported by processor.
+
 	nodelayacct	[KNL] Disable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 53d495f..4ce427e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -860,6 +860,15 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 	return read_sanitised_ftr_reg(SYS_CTR_EL0) & BIT(CTR_DIC_SHIFT);
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
@@ -871,7 +880,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	 if (is_kdump_kernel())
 		return false;
 
-	return has_cpuid_feature(entry, scope);
+	return has_cpuid_feature(entry, scope) && !nocnp;
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-- 
2.0.0
