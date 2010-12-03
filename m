From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:25:22 +0000
Subject: [PATCH 19/22] ARM: CPU hotplug: move cpu_killed completion to core
	code
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcC2-0007sD-I3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We always need to wait for the dying CPU to reach a safe state before
taking it down, irrespective of the requirements of the platform.
Move the completion code into the ARM SMP hotplug code rather than
having each platform re-implement this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c              |   14 +++++++++++++-
 arch/arm/mach-omap2/omap-hotplug.c |    8 ++------
 arch/arm/mach-realview/hotplug.c   |    8 +-------
 arch/arm/mach-s5pv310/hotplug.c    |    8 +-------
 arch/arm/mach-tegra/hotplug.c      |    8 +-------
 arch/arm/mach-ux500/hotplug.c      |    8 +-------
 6 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 1f1de2b..bebe3bd 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
+#include <linux/completion.h>
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -238,12 +239,20 @@ int __cpu_disable(void)
 	return 0;
 }
 
+static DECLARE_COMPLETION(cpu_died);
+
 /*
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
 void __cpu_die(unsigned int cpu)
 {
+	if (wait_for_completion_timeout(&cpu_died, 5000)) {
+		printk(KERN_ERR "CPU%u: cpu didn't die\n", cpu);
+		return;
+	}
+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+
 	if (!platform_cpu_kill(cpu))
 		printk("CPU%u: unable to kill\n", cpu);
 }
@@ -263,9 +272,12 @@ void __ref cpu_die(void)
 	local_irq_disable();
 	idle_task_exit();
 
+	/* Tell __cpu_die() that this CPU is now safe to dispose of */
+	complete(&cpu_died);
+
 	/*
 	 * actual CPU shutdown procedure is at least platform (if not
-	 * CPU) specific
+	 * CPU) specific.
 	 */
 	platform_cpu_die(cpu);
 
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 6cee456..ace979d 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -17,16 +17,13 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>
 
 #include <asm/cacheflush.h>
 #include <mach/omap4-common.h>
 
-static DECLARE_COMPLETION(cpu_killed);
-
 int platform_cpu_kill(unsigned int cpu)
 {
-	return wait_for_completion_timeout(&cpu_killed, 5000);
+	return 1;
 }
 
 /*
@@ -42,8 +39,7 @@ void platform_cpu_die(unsigned int cpu)
 			   this_cpu, cpu);
 		BUG();
 	}
-	pr_notice("CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
+
 	flush_cache_all();
 	dsb();
 
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index f95521a..7d58c16 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -11,14 +11,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>
 
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -95,7 +92,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 
 int platform_cpu_kill(unsigned int cpu)
 {
-	return wait_for_completion_timeout(&cpu_killed, 5000);
+	return 1;
 }
 
 /*
@@ -115,9 +112,6 @@ void platform_cpu_die(unsigned int cpu)
 	}
 #endif
 
-	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-s5pv310/hotplug.c
index 03652c3..d7be70a 100644
--- a/arch/arm/mach-s5pv310/hotplug.c
+++ b/arch/arm/mach-s5pv310/hotplug.c
@@ -13,14 +13,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>
 
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -98,7 +95,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 
 int platform_cpu_kill(unsigned int cpu)
 {
-	return wait_for_completion_timeout(&cpu_killed, 5000);
+	return 1;
 }
 
 /*
@@ -118,9 +115,6 @@ void platform_cpu_die(unsigned int cpu)
 	}
 #endif
 
-	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 8e7f115..ecaa41c 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -11,12 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>
 
 #include <asm/cacheflush.h>
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -94,7 +91,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 
 int platform_cpu_kill(unsigned int cpu)
 {
-	return wait_for_completion_timeout(&cpu_killed, 5000);
+	return 1;
 }
 
 /*
@@ -114,9 +111,6 @@ void platform_cpu_die(unsigned int cpu)
 	}
 #endif
 
-	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index b782a03..7a4890b 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -11,14 +11,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>
 
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
 
-static DECLARE_COMPLETION(cpu_killed);
-
 static inline void platform_do_lowpower(unsigned int cpu)
 {
 	flush_cache_all();
@@ -38,7 +35,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 
 int platform_cpu_kill(unsigned int cpu)
 {
-	return wait_for_completion_timeout(&cpu_killed, 5000);
+	return 1;
 }
 
 /*
@@ -58,9 +55,6 @@ void platform_cpu_die(unsigned int cpu)
 	}
 #endif
 
-	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
-
 	/* directly enter low power state, skipping secure registers */
 	platform_do_lowpower(cpu);
 }
-- 
1.6.2.5
