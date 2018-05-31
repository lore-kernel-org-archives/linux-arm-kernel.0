From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 31 May 2018 12:08:31 -0500
Subject: [PATCH v2 1/2] arm64: capabilities: add nopti command line argument
In-Reply-To: <20180531170832.14263-1-mlangsdo@redhat.com>
References: <20180531170832.14263-1-mlangsdo@redhat.com>
Message-ID: <20180531170832.14263-2-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The x86 kernel and the documentation use 'nopti' as the kernel command
line argument to disable kernel page table isolation, so add nopti to
the arm64 kernel for compatibility.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 19 +++++++++++++++----
 arch/arm64/kernel/cpufeature.c                  | 11 ++++++++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2040d4..cf0c728 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3342,8 +3342,8 @@
 	pt.		[PARIDE]
 			See Documentation/blockdev/paride.txt.
 
-	pti=		[X86_64] Control Page Table Isolation of user and
-			kernel address spaces.  Disabling this feature
+	pti=		[X86_64] Control Page Table Isolation of user
+			and kernel address spaces.  Disabling this feature
 			removes hardening, but improves performance of
 			system calls and interrupts.
 
@@ -3354,8 +3354,19 @@
 
 			Not specifying this option is equivalent to pti=auto.
 
-	nopti		[X86_64]
-			Equivalent to pti=off
+        kpti=           [ARM64] Control Page Table Isolation of user
+                        and kernel address spaces.  Disabling this feature
+                        removes hardening, but improves performance of
+                        system calls and interrupts.
+
+                        on   - unconditionally enable
+                        off  - unconditionally disable
+
+                        Not specifying this option will enable kpti on all
+			systems that support it.
+
+	nopti		[X86_64, ARM64]
+			Equivalent to pti=off on X86_64 or kpti=off on ARM64
 
 	pty.legacy_count=
 			[KNL] Number of legacy pty's. Overwrites compiled-in
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9d1b06d..7c5d8712 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -934,10 +934,19 @@ static int __init parse_kpti(char *str)
 	if (ret)
 		return ret;
 
-	__kpti_forced = enabled ? 1 : -1;
+	if (!__kpti_forced)
+		__kpti_forced = enabled ? 1 : -1;
 	return 0;
 }
 __setup("kpti=", parse_kpti);
+
+/* for compatibility with documentation and x86 nopti command line arg */
+static int __init force_nokpti(char *arg)
+{
+	__kpti_forced = -1;
+	return 0;
+}
+early_param("nopti", force_nokpti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-- 
2.9.5
