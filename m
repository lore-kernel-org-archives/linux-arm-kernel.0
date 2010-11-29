From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Nov 2010 10:41:49 +0000
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
Message-ID: <20101129104149.GA10703@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 10:54:35AM +0100, Vincent Guittot wrote:
> This patch extracts the common code of the cpu hotplug feature across
> arm platforms. The goal is to only keep the specific stuff of the
> platform in the sub-architecture. I have created a hotplug.c file in
> the ?arm/common directory after studying the cpu hotplug code of
> omap2, realview, s5pv310, ux500 and tegra. I have extracted 3 main
> platform dependent functions:
> ?-platform_enter_lowpower which prepares the platform for low power.
> ?-platform_do_lowpower on which the cpu will loop until it becomes
> really plugged (spurious wake up). This function must returned the cpu
> Id in order to leave the unplug state.
> ?-platform_leave_lowpower which restore the platform context.

I still do not like this patch.  The only thing that is worth doing is
this.  This leaves less than 256 bytes of object code in the Realview
hotplug.c, most of which is the stuff to handle the low power mode
which you haven't dealt with in your patch either.

I see no point in adding another API on top of the already existing
and simple API.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8c19595..e8856aa 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
+#include <linux/completion.h>
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -252,12 +253,19 @@ int __cpu_disable(void)
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
+		printk("CPU%u: cpu didn't die\n");
+		return;
+	}
+
 	if (!platform_cpu_kill(cpu))
 		printk("CPU%u: unable to kill\n", cpu);
 }
@@ -277,6 +285,9 @@ void __ref cpu_die(void)
 	local_irq_disable();
 	idle_task_exit();
 
+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	complete(&cpu_died);
+
 	/*
 	 * actual CPU shutdown procedure is at least platform (if not
 	 * CPU) specific
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
