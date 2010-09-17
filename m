From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Sep 2010 14:12:03 +0100
Subject: [PATCH 3/4] ARM: plat-versatile: factor out common hotplug code
In-Reply-To: <1284729124-15297-1-git-send-email-will.deacon@arm.com>
References: <1284729124-15297-1-git-send-email-will.deacon@arm.com>
Message-ID: <1284729124-15297-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common hotplug routines for the Versatile Platforms can be factored
out under plat-versatile leaving only the platform_do_lowpower function
to be implemented by the BSP code.

This patch factors out the hotplug code and changes the RealView hotplug
implementation to use the new framework.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/hotplug.c               |   52 +--------------------
 arch/arm/plat-versatile/Makefile               |    1 +
 arch/arm/plat-versatile/hotplug.c              |   57 ++++++++++++++++++++++++
 arch/arm/plat-versatile/include/plat/hotplug.h |    6 +++
 4 files changed, 67 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/plat-versatile/hotplug.c
 create mode 100644 arch/arm/plat-versatile/include/plat/hotplug.h

diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index b90c15a..3577590 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -16,13 +16,12 @@
 
 #include <mach/board-eb.h>
 #include <mach/board-pbx.h>
+#include <plat/hotplug.h>
 
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v, smp_ctrl;
@@ -70,8 +69,9 @@ static inline void cpu_leave_lowpower(void)
 	isb();
 }
 
-static void __ref platform_do_lowpower(unsigned int cpu)
+void __ref platform_do_lowpower(unsigned int cpu)
 {
+	cpu_enter_lowpower();
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
@@ -102,51 +102,5 @@ static void __ref platform_do_lowpower(unsigned int cpu)
 		printk("CPU%u: spurious wakeup call\n", cpu);
 #endif
 	}
-}
-
-int platform_cpu_kill(unsigned int cpu)
-{
-	return wait_for_completion_timeout(&cpu_killed, 5000);
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void platform_cpu_die(unsigned int cpu)
-{
-#ifdef DEBUG
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-#endif
-
-	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
 	cpu_leave_lowpower();
 }
-
-int platform_cpu_disable(unsigned int cpu)
-{
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 5cf88e8..e0fad33 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -6,3 +6,4 @@ ifeq ($(CONFIG_LEDS_CLASS),y)
 obj-$(CONFIG_ARCH_REALVIEW) += leds.o
 obj-$(CONFIG_ARCH_VERSATILE) += leds.o
 endif
+obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
diff --git a/arch/arm/plat-versatile/hotplug.c b/arch/arm/plat-versatile/hotplug.c
new file mode 100644
index 0000000..15ed6bd
--- /dev/null
+++ b/arch/arm/plat-versatile/hotplug.c
@@ -0,0 +1,57 @@
+/*
+ *  linux/arch/arm/plat-versatile/hotplug.c
+ *
+ *  Copyright (C) 2010 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <plat/hotplug.h>
+
+static DECLARE_COMPLETION(cpu_killed);
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
+	/*
+	 * Call the CPU-specific low-power routine.
+	 */
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
diff --git a/arch/arm/plat-versatile/include/plat/hotplug.h b/arch/arm/plat-versatile/include/plat/hotplug.h
new file mode 100644
index 0000000..f36df1c
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/hotplug.h
@@ -0,0 +1,6 @@
+#ifndef PLAT_HOTPLUG_H
+#define PLAT_HOTPLUG_H
+
+void platform_do_lowpower(unsigned int cpu);
+
+#endif
-- 
1.7.0.4
