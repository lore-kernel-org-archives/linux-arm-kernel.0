From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:47 +0300
Subject: [PATCH 1/8] arm: kdump: reserve memory for crashkernel
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <6d82fa1235472e9d510b9a09a10c868cbafc14d8.1271752135.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implemented ARM support for command line option "crashkernel=size at start" which
allows user to reserve some memory for a dump capture kernel.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/setup.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c91c77b..076454f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
 #include <linux/init.h>
+#include <linux/kexec.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -661,6 +662,55 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
+#ifdef CONFIG_KEXEC
+static inline unsigned long long get_total_mem(void)
+{
+	unsigned long total;
+
+	total = max_low_pfn - min_low_pfn;
+	return total << PAGE_SHIFT;
+}
+
+/**
+ * reserve_crashkernel() - reserves memory are for crash kernel
+ *
+ * This function reserves memory area given in "crashkernel=" kernel command
+ * line parameter. The memory reserved is used by a dump capture kernel when
+ * primary kernel is crashing.
+ */
+static void __init reserve_crashkernel(void)
+{
+	unsigned long long crash_size, crash_base;
+	unsigned long long total_mem;
+	int ret;
+
+	total_mem = get_total_mem();
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base);
+	if (ret)
+		return;
+
+	ret = reserve_bootmem(crash_base, crash_size, BOOTMEM_EXCLUSIVE);
+	if (ret < 0) {
+		printk(KERN_WARNING "crashkernel reservation failed - "
+		       "memory is in use (0x%lx)\n", (unsigned long)crash_base);
+		return;
+	}
+
+	printk(KERN_INFO "Reserving %ldMB of memory@%ldMB "
+	       "for crashkernel (System RAM: %ldMB)\n",
+	       (unsigned long)(crash_size >> 20),
+	       (unsigned long)(crash_base >> 20),
+	       (unsigned long)(total_mem >> 20));
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+}
+#else
+static inline void reserve_crashkernel(void) {}
+#endif /* CONFIG_KEXEC */
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
@@ -720,6 +770,7 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_SMP
 	smp_init_cpus();
 #endif
+	reserve_crashkernel();
 
 	cpu_init();
 	tcm_init();
-- 
1.5.6.5
