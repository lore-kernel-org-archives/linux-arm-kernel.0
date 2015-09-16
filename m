From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:03 +0100
Subject: [PATCH 05/22] arm64: Move /proc/cpuinfo handling code
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch moves the /proc/cpuinfo handling code:

arch/arm64/kernel/{setup.c to cpuinfo.c}

No functional changes

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpuinfo.c |  124 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c   |  123 ------------------------------------------
 2 files changed, 124 insertions(+), 123 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 8307b33..0dadb69 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -24,8 +24,11 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/personality.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
+#include <linux/seq_file.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 
 /*
@@ -45,6 +48,127 @@ static char *icache_policy_str[] = {
 
 unsigned long __icache_flags;
 
+static const char *hwcap_str[] = {
+	"fp",
+	"asimd",
+	"evtstrm",
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
+	"atomics",
+	NULL
+};
+
+#ifdef CONFIG_COMPAT
+static const char *compat_hwcap_str[] = {
+	"swp",
+	"half",
+	"thumb",
+	"26bit",
+	"fastmult",
+	"fpa",
+	"vfp",
+	"edsp",
+	"java",
+	"iwmmxt",
+	"crunch",
+	"thumbee",
+	"neon",
+	"vfpv3",
+	"vfpv3d16",
+	"tls",
+	"vfpv4",
+	"idiva",
+	"idivt",
+	"vfpd32",
+	"lpae",
+	"evtstrm"
+};
+
+static const char *compat_hwcap2_str[] = {
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
+	NULL
+};
+#endif /* CONFIG_COMPAT */
+
+static int c_show(struct seq_file *m, void *v)
+{
+	int i, j;
+
+	for_each_online_cpu(i) {
+		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
+		u32 midr = cpuinfo->reg_midr;
+
+		/*
+		 * glibc reads /proc/cpuinfo to determine the number of
+		 * online processors, looking for lines beginning with
+		 * "processor".  Give glibc what it expects.
+		 */
+		seq_printf(m, "processor\t: %d\n", i);
+
+		/*
+		 * Dump out the common processor features in a single line.
+		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
+		 * rather than attempting to parse this, but there's a body of
+		 * software which does already (at least for 32-bit).
+		 */
+		seq_puts(m, "Features\t:");
+		if (personality(current->personality) == PER_LINUX32) {
+#ifdef CONFIG_COMPAT
+			for (j = 0; compat_hwcap_str[j]; j++)
+				if (compat_elf_hwcap & (1 << j))
+					seq_printf(m, " %s", compat_hwcap_str[j]);
+
+			for (j = 0; compat_hwcap2_str[j]; j++)
+				if (compat_elf_hwcap2 & (1 << j))
+					seq_printf(m, " %s", compat_hwcap2_str[j]);
+#endif /* CONFIG_COMPAT */
+		} else {
+			for (j = 0; hwcap_str[j]; j++)
+				if (elf_hwcap & (1 << j))
+					seq_printf(m, " %s", hwcap_str[j]);
+		}
+		seq_puts(m, "\n");
+
+		seq_printf(m, "CPU implementer\t: 0x%02x\n",
+			   MIDR_IMPLEMENTOR(midr));
+		seq_printf(m, "CPU architecture: 8\n");
+		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
+		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
+		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
+	}
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < 1 ? (void *)1 : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= c_show
+};
+
 static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 {
 	unsigned int cpu = smp_processor_id();
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4c7bca8..7b651cc 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -28,7 +28,6 @@
 #include <linux/console.h>
 #include <linux/cache.h>
 #include <linux/bootmem.h>
-#include <linux/seq_file.h>
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
@@ -44,7 +43,6 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/efi.h>
-#include <linux/personality.h>
 #include <linux/psci.h>
 
 #include <asm/acpi.h>
@@ -383,124 +381,3 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
-
-static const char *hwcap_str[] = {
-	"fp",
-	"asimd",
-	"evtstrm",
-	"aes",
-	"pmull",
-	"sha1",
-	"sha2",
-	"crc32",
-	"atomics",
-	NULL
-};
-
-#ifdef CONFIG_COMPAT
-static const char *compat_hwcap_str[] = {
-	"swp",
-	"half",
-	"thumb",
-	"26bit",
-	"fastmult",
-	"fpa",
-	"vfp",
-	"edsp",
-	"java",
-	"iwmmxt",
-	"crunch",
-	"thumbee",
-	"neon",
-	"vfpv3",
-	"vfpv3d16",
-	"tls",
-	"vfpv4",
-	"idiva",
-	"idivt",
-	"vfpd32",
-	"lpae",
-	"evtstrm"
-};
-
-static const char *compat_hwcap2_str[] = {
-	"aes",
-	"pmull",
-	"sha1",
-	"sha2",
-	"crc32",
-	NULL
-};
-#endif /* CONFIG_COMPAT */
-
-static int c_show(struct seq_file *m, void *v)
-{
-	int i, j;
-
-	for_each_online_cpu(i) {
-		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
-		u32 midr = cpuinfo->reg_midr;
-
-		/*
-		 * glibc reads /proc/cpuinfo to determine the number of
-		 * online processors, looking for lines beginning with
-		 * "processor".  Give glibc what it expects.
-		 */
-		seq_printf(m, "processor\t: %d\n", i);
-
-		/*
-		 * Dump out the common processor features in a single line.
-		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
-		 * rather than attempting to parse this, but there's a body of
-		 * software which does already (at least for 32-bit).
-		 */
-		seq_puts(m, "Features\t:");
-		if (personality(current->personality) == PER_LINUX32) {
-#ifdef CONFIG_COMPAT
-			for (j = 0; compat_hwcap_str[j]; j++)
-				if (compat_elf_hwcap & (1 << j))
-					seq_printf(m, " %s", compat_hwcap_str[j]);
-
-			for (j = 0; compat_hwcap2_str[j]; j++)
-				if (compat_elf_hwcap2 & (1 << j))
-					seq_printf(m, " %s", compat_hwcap2_str[j]);
-#endif /* CONFIG_COMPAT */
-		} else {
-			for (j = 0; hwcap_str[j]; j++)
-				if (elf_hwcap & (1 << j))
-					seq_printf(m, " %s", hwcap_str[j]);
-		}
-		seq_puts(m, "\n");
-
-		seq_printf(m, "CPU implementer\t: 0x%02x\n",
-			   MIDR_IMPLEMENTOR(midr));
-		seq_printf(m, "CPU architecture: 8\n");
-		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
-		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
-		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
-	}
-
-	return 0;
-}
-
-static void *c_start(struct seq_file *m, loff_t *pos)
-{
-	return *pos < 1 ? (void *)1 : NULL;
-}
-
-static void *c_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return NULL;
-}
-
-static void c_stop(struct seq_file *m, void *v)
-{
-}
-
-const struct seq_operations cpuinfo_op = {
-	.start	= c_start,
-	.next	= c_next,
-	.stop	= c_stop,
-	.show	= c_show
-};
-- 
1.7.9.5
