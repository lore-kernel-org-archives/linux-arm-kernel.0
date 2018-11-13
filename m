From: agraf@suse.de (Alexander Graf)
Date: Tue, 13 Nov 2018 16:29:06 +0100
Subject: [PATCH v2] arm64: Make kpti command line options x86 compatible
Message-ID: <20181113152906.55802-1-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've already stumbled over 2 cases where people got confused about how to
disable kpti on AArch64. In both cases, they used existing x86_64 options
and just applied that to an AArch64 system, expecting it to work.

I think it makes a lot of sense to have compatible kernel command line
parameters whenever we can have them be compatible.

So this patch adds the pti= and no_pti kernel command line options, mapping
them into the existing kpti= command line framework. It preserves the old
syntax to maintain compatibility with older command lines.

While at it, the patch also marks the respective options as dual-arch.

Reported-by: Richard Brown <rbrown@suse.de>
Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - Actually make it compile. Sorry for the sloppy v1.
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++---
 arch/arm64/kernel/cpufeature.c                  | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..4a1c6bcfcdb5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3522,8 +3522,8 @@
 	pt.		[PARIDE]
 			See Documentation/blockdev/paride.txt.
 
-	pti=		[X86_64] Control Page Table Isolation of user and
-			kernel address spaces.  Disabling this feature
+	pti=		[X86_64,ARM64] Control Page Table Isolation of user
+			and kernel address spaces.  Disabling this feature
 			removes hardening, but improves performance of
 			system calls and interrupts.
 
@@ -3534,7 +3534,7 @@
 
 			Not specifying this option is equivalent to pti=auto.
 
-	nopti		[X86_64]
+	nopti		[X86_64,ARM64]
 			Equivalent to pti=off
 
 	pty.legacy_count=
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af50064dea51..a67b4b563a7c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -978,13 +978,31 @@ static int __init parse_kpti(char *str)
 	bool enabled;
 	int ret = strtobool(str, &enabled);
 
-	if (ret)
+	if (ret) {
+		if (!strncmp(str, "auto", 4)) {
+			__kpti_forced = 0;
+			return 0;
+		}
 		return ret;
+	}
 
 	__kpti_forced = enabled ? 1 : -1;
 	return 0;
 }
 early_param("kpti", parse_kpti);
+
+static int __init parse_pti(char *str)
+{
+	return parse_kpti(str);
+}
+early_param("pti", parse_pti);
+
+static int __init parse_no_pti(char *p)
+{
+	__kpti_forced = -1;
+	return 0;
+}
+early_param("nopti", parse_no_pti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-- 
2.12.3
