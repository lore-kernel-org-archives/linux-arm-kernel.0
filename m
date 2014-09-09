From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:05 +0000
Subject: [PATCH 13/13] arm64/kexec: Add kexec_ignore_compat_check param
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <99f09410a26c001efd06c270aa2e348d6cac6b01.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new kernel command line parameter kexec_ignore_compat_check which
specifies whether or not to ignore arm64 kexec compatibility checks.

For some systems the compatibility checks may be too restrictive, and setting
this parameter could allow those systems to kexec to kernel images that would
not pass the compatibility checks.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 Documentation/kernel-parameters.txt | 13 +++++++++++++
 arch/arm64/kernel/machine_kexec.c   | 19 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5ae8608..c70f4b8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1529,6 +1529,19 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			use the HighMem zone if it exists, and the Normal
 			zone if it does not.
 
+	kexec_ignore_compat_check [KEXEC,ARM64]
+			This parameter specifies whether or not to ignore arm64
+			kexec compatibility checks.  The default is to honor the
+			checks.  Set this parameter to ignore all kexec
+			compatibility checks on arm64 systems.  Setting this
+			could cause the system to become unstable after a kexec
+			re-boot.  If unsure, do not set.
+
+			For some systems the compatibility checks may be too
+			restrictive, and setting this parameter could allow
+			those systems to kexec to kernel images that would not
+			pass the compatibility checks.
+
 	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
 			Format: <Controller#>[,poll interval]
 			The controller # is the number of the ehci usb debug
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 043a3bc..45c2db2 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -36,6 +36,20 @@ extern unsigned long kexec_dtb_addr;
 extern unsigned long kexec_kimage_head;
 extern unsigned long kexec_kimage_start;
 
+/*
+ * kexec_ignore_compat_check - Set to ignore kexec compatibility checks.
+ */
+
+static int __read_mostly kexec_ignore_compat_check;
+
+static int __init setup_kexec_ignore_compat_check(char *__unused)
+{
+	kexec_ignore_compat_check = 1;
+	return 1;
+}
+
+__setup("kexec_ignore_compat_check", setup_kexec_ignore_compat_check);
+
 /**
  * struct kexec_boot_info - Boot info needed by the local kexec routines.
  */
@@ -410,7 +424,8 @@ static int kexec_compat_check(const struct kexec_ctx *ctx)
 			if (cp_1->hwid != cp_2->hwid)
 				continue;
 
-			if (!kexec_cpu_check(cp_1, cp_2))
+			if (!kexec_cpu_check(cp_1, cp_2) &&
+				!kexec_ignore_compat_check)
 				return -EINVAL;
 
 			to_process--;
@@ -506,7 +521,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	result = kexec_compat_check(ctx);
 
-	if (result)
+	if (result && !kexec_ignore_compat_check)
 		goto on_error;
 
 	kexec_dtb_addr = dtb_seg->mem;
-- 
1.9.1
