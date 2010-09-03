From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 3 Sep 2010 17:31:05 +0530
Subject: [PATCH 1/2] ARM: Generalize all CPU Hotplug code across platforms
In-Reply-To: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
References: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1283515266-25374-2-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor common cpu hotplug arcoss platforms and move hotplug to arch/arm/common.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/common/Makefile           |    1 +
 arch/arm/common/hotplug.c          |   57 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hotplug.h     |   18 +++++++++++
 arch/arm/mach-omap2/omap-hotplug.c |   24 +--------------
 arch/arm/mach-realview/hotplug.c   |   56 ++++-------------------------------
 arch/arm/mach-s5pv310/hotplug.c    |   56 ++++-------------------------------
 arch/arm/mach-tegra/hotplug.c      |   56 +++++------------------------------
 7 files changed, 100 insertions(+), 168 deletions(-)
 create mode 100644 arch/arm/common/hotplug.c
 create mode 100644 arch/arm/include/asm/hotplug.h

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e6e8664..d0a22d2 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/common/hotplug.c b/arch/arm/common/hotplug.c
new file mode 100644
index 0000000..a91d87f
--- /dev/null
+++ b/arch/arm/common/hotplug.c
@@ -0,0 +1,57 @@
+/*
+ *  arch/arm/common/hotplug.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  Copyright (C) 2010 ST-Ericsson
+ *
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+#include <linux/io.h>
+#include <asm/hotplug.h>
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
+		printk(KERN_CRIT "Eek! platform_cpu_die running on %u,\
+				should be %u\n", this_cpu, cpu);
+		BUG();
+	}
+#endif
+
+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	complete(&cpu_killed);
+
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
diff --git a/arch/arm/include/asm/hotplug.h b/arch/arm/include/asm/hotplug.h
new file mode 100644
index 0000000..6aed089
--- /dev/null
+++ b/arch/arm/include/asm/hotplug.h
@@ -0,0 +1,18 @@
+/*
+ *  arch/arm/common/hotplug.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  Copyright (C) 2010 ST-Ericsson
+ *
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_HOTPLUG_H
+#define __ASM_ARM_HOTPLUG_H
+
+void platform_do_lowpower(unsigned int cpu);
+
+#endif
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 6cee456..42ce438 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -13,27 +13,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <linux/completion.h>
-
+#include <asm/hotplug.h>
 #include <asm/cacheflush.h>
 #include <mach/omap4-common.h>
 
-static DECLARE_COMPLETION(cpu_killed);
-
-int platform_cpu_kill(unsigned int cpu)
-{
-	return wait_for_completion_timeout(&cpu_killed, 5000);
-}
-
 /*
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void platform_do_lowpower(unsigned int cpu)
 {
 	unsigned int this_cpu = hard_smp_processor_id();
 
@@ -69,11 +57,3 @@ void platform_cpu_die(unsigned int cpu)
 	}
 }
 
-int platform_cpu_disable(unsigned int cpu)
-{
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index f95521a..7609f9d 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -8,17 +8,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <linux/completion.h>
-
+#include <asm/hotplug.h>
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -56,9 +50,14 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu)
+void platform_do_lowpower(unsigned int cpu)
 {
 	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+
+	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
 	 * code will have already disabled interrupts
@@ -91,38 +90,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
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
 
 	/*
 	 * bring this CPU back into the world of cache
@@ -130,12 +97,3 @@ void platform_cpu_die(unsigned int cpu)
 	 */
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
diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-s5pv310/hotplug.c
index 03652c3..cc1c95e 100644
--- a/arch/arm/mach-s5pv310/hotplug.c
+++ b/arch/arm/mach-s5pv310/hotplug.c
@@ -9,18 +9,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <linux/completion.h>
-
+#include <asm/hotplug.h>
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -59,9 +52,14 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu)
+void platform_do_lowpower(unsigned int cpu)
 {
 	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+
+	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
 	 * code will have already disabled interrupts
@@ -94,38 +92,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
 		printk(KERN_WARN "CPU%u: spurious wakeup call\n", cpu);
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
 
 	/*
 	 * bring this CPU back into the world of cache
@@ -134,11 +100,3 @@ void platform_cpu_die(unsigned int cpu)
 	cpu_leave_lowpower();
 }
 
-int platform_cpu_disable(unsigned int cpu)
-{
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 8e7f115..c2bc392 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -8,15 +8,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <linux/completion.h>
-
+#include <asm/hotplug.h>
 #include <asm/cacheflush.h>
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -55,8 +49,14 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu)
+void platform_do_lowpower(unsigned int cpu)
 {
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
@@ -90,38 +90,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
 		printk(KERN_WARN "CPU%u: spurious wakeup call\n", cpu);
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
 
 	/*
 	 * bring this CPU back into the world of cache
@@ -130,11 +98,3 @@ void platform_cpu_die(unsigned int cpu)
 	cpu_leave_lowpower();
 }
 
-int platform_cpu_disable(unsigned int cpu)
-{
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
-- 
1.7.2.dirty
