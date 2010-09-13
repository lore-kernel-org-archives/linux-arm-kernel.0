From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Mon, 13 Sep 2010 16:45:59 +0530
Subject: [PATCH v2] ux500: add CPU hotplug support
Message-ID: <1284376559-7704-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---

v2:
 - revert pen_release as __cpuinitdata as per comments

 arch/arm/mach-ux500/Makefile  |    1 +
 arch/arm/mach-ux500/hotplug.c |   75 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/platsmp.c |    2 +
 3 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/hotplug.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 0097318..bb3e74e 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
new file mode 100644
index 0000000..b782a03
--- /dev/null
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *	Based on ARM realview platform
+ *
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <asm/cacheflush.h>
+
+extern volatile int pen_release;
+
+static DECLARE_COMPLETION(cpu_killed);
+
+static inline void platform_do_lowpower(unsigned int cpu)
+{
+	flush_cache_all();
+
+	/* we put the platform to just WFI */
+	for (;;) {
+		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
+				: : : "memory");
+		if (pen_release == cpu) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+	}
+}
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return wait_for_completion_timeout(&cpu_killed, 5000);
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+#ifdef DEBUG
+	unsigned int this_cpu = hard_smp_processor_id();
+
+	if (cpu != this_cpu) {
+		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
+			   this_cpu, cpu);
+		BUG();
+	}
+#endif
+
+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	complete(&cpu_killed);
+
+	/* directly enter low power state, skipping secure registers */
+	platform_do_lowpower(cpu);
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 438ef16..9e4c678 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -78,6 +78,8 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
 	outer_clean_range(__pa(&pen_release), __pa(&pen_release) + 1);
 
+	smp_cross_call(cpumask_of(cpu));
+
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		if (pen_release == -1)
-- 
1.7.2.dirty
