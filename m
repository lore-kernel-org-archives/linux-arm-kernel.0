From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Aug 2011 20:44:05 -0500
Subject: [PATCH v2 6/7] ARM: highbank: Add cpu hotplug support
In-Reply-To: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
Message-ID: <1314841446-11006-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Bogomolni <martin@calxeda.com>

This adds cpu hotplug for highbank. On highbank, a core is always reset and
boots up the same path as a cold boot.

Signed-off-by: Martin Bogomolni <martin@calxeda.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Changes in v2:
 - s/a9_base_addr/scu_base_addr/
 
 arch/arm/mach-highbank/Makefile  |    1 +
 arch/arm/mach-highbank/hotplug.c |   56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-highbank/hotplug.c

diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
index 311c0e8e..df30b0d 100644
--- a/arch/arm/mach-highbank/Makefile
+++ b/arch/arm/mach-highbank/Makefile
@@ -2,3 +2,4 @@ obj-y					:= clock.o highbank.o system.o
 obj-$(CONFIG_DEBUG_LL)			+= lluart.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
new file mode 100644
index 0000000..977cebb
--- /dev/null
+++ b/arch/arm/mach-highbank/hotplug.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright 2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/smp_scu.h>
+#include <asm/cacheflush.h>
+
+#include "core.h"
+
+extern void secondary_startup(void);
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+	flush_cache_all();
+
+	highbank_set_cpu_jump(cpu, secondary_startup);
+	scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
+
+	cpu_do_idle();
+
+	/* We should never return from idle */
+	panic("highbank: cpu %d unexpectedly exit from shutdown\n", cpu);
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * CPU0 should not be shut down via hotplug.  cpu_idle can WFI
+	 * or a proper shutdown or hibernate should be used.
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
-- 
1.7.4.1
