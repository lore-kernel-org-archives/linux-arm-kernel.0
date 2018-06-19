From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 19 Jun 2018 11:18:22 +0100
Subject: [PATCH v5 3/3] arm64: Introduce command line parameter to disable CNP
In-Reply-To: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
References: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1529403502-2843-4-git-send-email-vladimir.murzin@arm.com>
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
index efc7aa7..4abc485 100644
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
index e0129f2..270fb3b 100644
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
@@ -872,7 +881,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	 if (elfcorehdr_size)
 		return false;
 #endif
-	return has_cpuid_feature(entry, scope);
+	return has_cpuid_feature(entry, scope) && !nocnp;
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-- 
2.0.0
