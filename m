From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 3 Sep 2010 17:31:06 +0530
Subject: [PATCH 2/2] ux500: Add CPU hotplug support
In-Reply-To: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
References: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1283515266-25374-3-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/Makefile  |    1 +
 arch/arm/mach-ux500/hotplug.c |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/platsmp.c |    4 +++-
 3 files changed, 34 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/hotplug.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index ed180b8..c07a1e8 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_REGULATOR_AB8500)	+= board-mop500-regulators.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
new file mode 100644
index 0000000..b212857
--- /dev/null
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ * 	Based on ARM realview platform
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ *
+ */
+#include <asm/hotplug.h>
+#include <asm/cacheflush.h>
+
+extern volatile int pen_release;
+
+void platform_do_lowpower(unsigned int cpu)
+{
+	flush_cache_all();
+
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
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 438ef16..ade2e17 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -26,7 +26,7 @@
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int __cpuinitdata pen_release = -1;
+volatile int pen_release = -1;
 
 static unsigned int __init get_core_count(void)
 {
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
