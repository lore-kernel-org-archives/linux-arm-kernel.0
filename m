From: stanislav.kholmanskikh@oracle.com (Stanislav Kholmanskikh)
Date: Fri, 24 Aug 2018 14:40:07 +0300
Subject: [PATCH] arm64: implement x86-compatible KPTI cmdline options
Message-ID: <1535110807-9104-1-git-send-email-stanislav.kholmanskikh@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both x86 and arm64 have KPTI. On both the archs the KPTI state
can be controlled via kernel cmdline, but using different options.
For x86 there are 'pti' and 'nopti', for arm64 - the undocumented 'kpti'
option.

Having two distinct options for one feature seems to be unnecessary,
and may complicate things a bit in mixed environments, so unification
here seems to be a good idea.

I think x86 is a better candidate to serve as the common basis, since
a) its options are already documented, b) it has KPTI merged earlier,
c) it's more popular platform.

This patch implements 'pti' and 'nopti' for arm64, keeping 'kpti'
for backwards compatibility.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    4 +-
 arch/arm64/kernel/cpufeature.c                  |   41 +++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bffb0ca..f7edd83 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3492,7 +3492,7 @@
 	pt.		[PARIDE]
 			See Documentation/blockdev/paride.txt.
 
-	pti=		[X86_64] Control Page Table Isolation of user and
+	pti=		[X86_64,ARM64] Control Page Table Isolation of user and
 			kernel address spaces.  Disabling this feature
 			removes hardening, but improves performance of
 			system calls and interrupts.
@@ -3504,7 +3504,7 @@
 
 			Not specifying this option is equivalent to pti=auto.
 
-	nopti		[X86_64]
+	nopti		[X86_64,ARM64]
 			Equivalent to pti=off
 
 	pty.legacy_count=
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 611e892..cdc2873 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -926,6 +926,14 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	return;
 }
 
+/*
+ * Originally on ARM64 KPTI was controlled by the 'kpti' command
+ * line option. While serving the same purpose its name and syntax
+ * was different from X86. Later to remove the unnecessary diversity
+ * of ways to control KPTI on the two archs X86-compatible options
+ * were introduced.
+ * This option is only kept for backwards compatibility.
+ */
 static int __init parse_kpti(char *str)
 {
 	bool enabled;
@@ -938,6 +946,39 @@ static int __init parse_kpti(char *str)
 	return 0;
 }
 early_param("kpti", parse_kpti);
+
+/* X86-compatible options ('pti', 'nopti') for KPTI control */
+static int __init parse_pti(char *str)
+{
+	int l;
+
+	if (!str)
+		return -EINVAL;
+
+	l = strlen(str);
+	if (l == 2 && !strncmp(str, "on", l))
+		__kpti_forced = 1;
+	else if (l == 3 && !strncmp(str, "off", l))
+		__kpti_forced = -1;
+	else if (l == 4 && !strncmp(str, "auto", l))
+		__kpti_forced = 0;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("pti", parse_pti);
+
+static int __init parse_nopti(char *str)
+{
+	if (str)
+		return -EINVAL;
+
+	__kpti_forced = -1;
+
+	return 0;
+}
+early_param("nopti", parse_nopti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-- 
1.7.1
