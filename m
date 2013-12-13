From: vkale@apm.com (Vinayak Kale)
Date: Fri, 13 Dec 2013 14:13:42 +0530
Subject: [PATCH] arm64: print cpu frequency in /proc/cpuinfo
Message-ID: <1386924222-23169-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print the cpu frequency field in /proc/cpuinfo.

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 arch/arm64/kernel/setup.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index bd9bbd0..bca982b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -41,6 +41,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/cpufreq.h>
 
 #include <asm/cputype.h>
 #include <asm/elf.h>
@@ -278,9 +279,19 @@ static const char *hwcap_str[] = {
 	NULL
 };
 
+static unsigned int get_cpufreq_khz(unsigned int cpu)
+{
+#ifdef CONFIG_CPU_FREQ
+	return cpufreq_quick_get(cpu);
+#else
+	return 0;
+#endif
+}
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i;
+	unsigned int cpufreq_khz;
 
 	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
 		   cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
@@ -294,6 +305,10 @@ static int c_show(struct seq_file *m, void *v)
 #ifdef CONFIG_SMP
 		seq_printf(m, "processor\t: %d\n", i);
 #endif
+		cpufreq_khz = get_cpufreq_khz(i);
+		if (cpufreq_khz)
+			seq_printf(m, "cpu MHz\t\t: %u.%02u\n",
+				cpufreq_khz / 1000, (cpufreq_khz % 1000));
 	}
 
 	/* dump out the processor features */
-- 
1.5.6.3
