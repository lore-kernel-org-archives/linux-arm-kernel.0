From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 25 Mar 2016 17:30:09 +0800
Subject: [RFC PATCH 3/3] arm64: Expose cpu vender id and model name through
 cpuinfo
In-Reply-To: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458898209-7486-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is helpful to show the name of chip vendor and CPU model
to customers in cpuinfo, identify them by using CPU implementer
and CPU part is not intuitive(compared with x86).

We are complained for this several times, so expose them.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/cpu.h |  2 ++
 arch/arm64/kernel/cpuinfo.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 13a6103..b8c3d79 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -25,6 +25,8 @@
  */
 struct cpuinfo_arm64 {
 	struct cpu	cpu;
+	char		vendor[16];
+	char		model_name[16];
 	u32		reg_ctr;
 	u32		reg_cntfrq;
 	u32		reg_dczid;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 488d49a..da5f7df 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/elf.h>
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -100,6 +101,62 @@ static const char *const compat_hwcap2_str[] = {
 };
 #endif /* CONFIG_COMPAT */
 
+static void cpuinfo_get_vendor_model(struct cpuinfo_arm64 *info)
+{
+	char *vendor = info->vendor;
+	char *name = info->model_name;
+	u32 midr = info->reg_midr;
+	u32 impl = MIDR_IMPLEMENTOR(midr);
+	u32 part = MIDR_PARTNUM(midr);
+
+	switch (impl) {
+	case ARM_CPU_IMP_ARM:
+		strcpy(vendor, "ARM");
+		switch (part) {
+		case ARM_CPU_PART_AEM_V8:
+			strcpy(name, "AEM-V8");
+			break;
+		case ARM_CPU_PART_FOUNDATION:
+			strcpy(name, "Foundation");
+			break;
+		case ARM_CPU_PART_CORTEX_A53:
+			strcpy(name, "Cortex-A53");
+			break;
+		case ARM_CPU_PART_CORTEX_A57:
+			strcpy(name, "Cortex-A57");
+			break;
+		};
+		break;
+	case ARM_CPU_IMP_APM:
+		strcpy(vendor, "APM");
+		switch (part) {
+		case APM_CPU_PART_POTENZA:
+			strcpy(name, "Potenza");
+			break;
+		};
+		break;
+	case ARM_CPU_IMP_CAVIUM:
+		strcpy(vendor, "CAVIUM");
+		switch (part) {
+		case CAVIUM_CPU_PART_THUNDERX:
+			strcpy(name, "Thunderx");
+			break;
+		};
+		break;
+	case ARM_CPU_IMP_BRCM:
+		strcpy(vendor, "BROADCOM");
+		switch (part) {
+		case BRCM_CPU_PART_VULCAN:
+			strcpy(name, "Vulcan");
+			break;
+		};
+		break;
+	default:
+		strcpy(vendor, "Unknown");
+		strcpy(name, "Unknown");
+	}
+}
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
@@ -116,6 +173,9 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
+		seq_printf(m, "vendor_id\t: %s\n", cpuinfo->vendor);
+		seq_printf(m, "model name\t: %s rev %d (%s)\n", cpuinfo->model_name,
+			   MIDR_REVISION(midr), ELF_PLATFORM);
 
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 			   loops_per_jiffy / (500000UL/HZ),
@@ -238,6 +298,8 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
 	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
 
+	cpuinfo_get_vendor_model(info);
+
 	cpuinfo_detect_icache_policy(info);
 
 	check_local_cpu_errata();
-- 
1.7.12.4
