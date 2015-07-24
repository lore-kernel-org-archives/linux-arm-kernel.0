From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:50 +0100
Subject: [RFC PATCH 04/10] arm64: Consolidate cpuinfo handling
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch re-arranges the code a little bit to consolidate
the /proc/cpuinfo handling code to arch/arm64/kernel/cpuinfo.c.

No functional changes.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h |    1 +
 arch/arm64/kernel/cpuinfo.c  |  208 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c    |  207 -----------------------------------------
 3 files changed, 209 insertions(+), 207 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 8e797b2..a34de72 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -62,5 +62,6 @@ DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 
 void cpuinfo_store_cpu(void);
 void __init cpuinfo_store_boot_cpu(void);
+void __init setup_processor_features(void);
 
 #endif /* __ASM_CPU_H */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 75d5a86..a13468b 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -26,6 +26,9 @@
 #include <linux/kernel.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
+#include <linux/personality.h>
+#include <linux/seq_file.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 
 /*
@@ -254,3 +257,208 @@ void __init cpuinfo_store_boot_cpu(void)
 
 	boot_cpu_data = *info;
 }
+
+void __init setup_processor_features(void)
+{
+	u64 features, block;
+	u32 cwg;
+	int cls;
+
+	/*
+	 * Check for sane CTR_EL0.CWG value.
+	 */
+	cwg = cache_type_cwg();
+	cls = cache_line_size();
+	if (!cwg)
+		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
+			cls);
+	if (L1_CACHE_BYTES < cls)
+		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
+			L1_CACHE_BYTES, cls);
+
+	/*
+	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
+	 * The blocks we test below represent incremental functionality
+	 * for non-negative values. Negative values are reserved.
+	 */
+	features = read_cpuid(ID_AA64ISAR0_EL1);
+	block = (features >> 4) & 0xf;
+	if (!(block & 0x8)) {
+		switch (block) {
+		default:
+		case 2:
+			elf_hwcap |= HWCAP_PMULL;
+		case 1:
+			elf_hwcap |= HWCAP_AES;
+		case 0:
+			break;
+		}
+	}
+
+	block = (features >> 8) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap |= HWCAP_SHA1;
+
+	block = (features >> 12) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap |= HWCAP_SHA2;
+
+	block = (features >> 16) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap |= HWCAP_CRC32;
+
+#ifdef CONFIG_COMPAT
+	/*
+	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
+	 * the Aarch32 32-bit execution state.
+	 */
+	features = read_cpuid(ID_ISAR5_EL1);
+	block = (features >> 4) & 0xf;
+	if (!(block & 0x8)) {
+		switch (block) {
+		default:
+		case 2:
+			compat_elf_hwcap2 |= COMPAT_HWCAP2_PMULL;
+		case 1:
+			compat_elf_hwcap2 |= COMPAT_HWCAP2_AES;
+		case 0:
+			break;
+		}
+	}
+
+	block = (features >> 8) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA1;
+
+	block = (features >> 12) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA2;
+
+	block = (features >> 16) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_CRC32;
+#endif
+}
+
+static const char *hwcap_str[] = {
+	"fp",
+	"asimd",
+	"evtstrm",
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
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
+#ifdef CONFIG_SMP
+		seq_printf(m, "processor\t: %d\n", i);
+#endif
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
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 2a36d27..239e478 100644
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
@@ -45,7 +44,6 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/efi.h>
-#include <linux/personality.h>
 
 #include <asm/acpi.h>
 #include <asm/fixmap.h>
@@ -103,8 +101,6 @@ static struct resource mem_res[] = {
 	}
 };
 
-static void setup_processor_features(void);
-
 #define kernel_code mem_res[0]
 #define kernel_data mem_res[1]
 
@@ -226,88 +222,6 @@ void __init up_late_init(void)
 }
 #endif /* CONFIG_UP_LATE_INIT */
 
-static void __init setup_processor_features(void)
-{
-	u64 features, block;
-	u32 cwg;
-	int cls;
-
-	/*
-	 * Check for sane CTR_EL0.CWG value.
-	 */
-	cwg = cache_type_cwg();
-	cls = cache_line_size();
-	if (!cwg)
-		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
-			cls);
-	if (L1_CACHE_BYTES < cls)
-		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
-			L1_CACHE_BYTES, cls);
-
-	/*
-	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
-	 * The blocks we test below represent incremental functionality
-	 * for non-negative values. Negative values are reserved.
-	 */
-	features = read_cpuid(ID_AA64ISAR0_EL1);
-	block = (features >> 4) & 0xf;
-	if (!(block & 0x8)) {
-		switch (block) {
-		default:
-		case 2:
-			elf_hwcap |= HWCAP_PMULL;
-		case 1:
-			elf_hwcap |= HWCAP_AES;
-		case 0:
-			break;
-		}
-	}
-
-	block = (features >> 8) & 0xf;
-	if (block && !(block & 0x8))
-		elf_hwcap |= HWCAP_SHA1;
-
-	block = (features >> 12) & 0xf;
-	if (block && !(block & 0x8))
-		elf_hwcap |= HWCAP_SHA2;
-
-	block = (features >> 16) & 0xf;
-	if (block && !(block & 0x8))
-		elf_hwcap |= HWCAP_CRC32;
-
-#ifdef CONFIG_COMPAT
-	/*
-	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
-	 * the Aarch32 32-bit execution state.
-	 */
-	features = read_cpuid(ID_ISAR5_EL1);
-	block = (features >> 4) & 0xf;
-	if (!(block & 0x8)) {
-		switch (block) {
-		default:
-		case 2:
-			compat_elf_hwcap2 |= COMPAT_HWCAP2_PMULL;
-		case 1:
-			compat_elf_hwcap2 |= COMPAT_HWCAP2_AES;
-		case 0:
-			break;
-		}
-	}
-
-	block = (features >> 8) & 0xf;
-	if (block && !(block & 0x8))
-		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA1;
-
-	block = (features >> 12) & 0xf;
-	if (block && !(block & 0x8))
-		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA2;
-
-	block = (features >> 16) & 0xf;
-	if (block && !(block & 0x8))
-		compat_elf_hwcap2 |= COMPAT_HWCAP2_CRC32;
-#endif
-}
-
 static void __init setup_processor(void)
 {
 	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
@@ -449,124 +363,3 @@ static int __init topology_init(void)
 }
 subsys_initcall(topology_init);
 
-static const char *hwcap_str[] = {
-	"fp",
-	"asimd",
-	"evtstrm",
-	"aes",
-	"pmull",
-	"sha1",
-	"sha2",
-	"crc32",
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
-#ifdef CONFIG_SMP
-		seq_printf(m, "processor\t: %d\n", i);
-#endif
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
