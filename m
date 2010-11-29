From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 29 Nov 2010 18:27:02 +0100
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <20101129104149.GA10703@n2100.arm.linux.org.uk>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
	<20101129104149.GA10703@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this patch is to remove as much duplicated code as
possible in each platform hotplug file. I have also tried to keep in
mind that current platform upstreamed code make nearly no power
management in their current implementation. I have added a new
interface and a new file in order to
 -Keep the current interface as it is. So each platform could move to
common code when they want
 -Have a dedicated file for arm hotplug function in which we can add
all code that must be executed on an arm core whatever the platform
(flushing cache, SCU disabling and handling spurious wake up as a
staring  point). I agree that the current code is quite small for now
and we can wonder if a dedicated file is useful, code might be put in
kernel/smp.c file.
The next step is also to add some hotplug tracepoints and I would
prefer to add the tracepoints only in a platform independent code.

With the common code, a new arm platform can have the hotplug feature
with less than 20 lines (power management not included) and can be
sure that minimal actions will be handled by the common Arm code.

We can also keep the platform_cpu_die has the platform entry point and
move the common part into kernel/smp.c file. We still have few
duplicated code (spurious wake-up) but this seems to be acceptable.

I have taken your example into account and have updated the patch accordingly

Vincent

On 29 November 2010 11:41, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 29, 2010 at 10:54:35AM +0100, Vincent Guittot wrote:
>> This patch extracts the common code of the cpu hotplug feature across
>> arm platforms. The goal is to only keep the specific stuff of the
>> platform in the sub-architecture. I have created a hotplug.c file in
>> the ?arm/common directory after studying the cpu hotplug code of
>> omap2, realview, s5pv310, ux500 and tegra. I have extracted 3 main
>> platform dependent functions:
>> ?-platform_enter_lowpower which prepares the platform for low power.
>> ?-platform_do_lowpower on which the cpu will loop until it becomes
>> really plugged (spurious wake up). This function must returned the cpu
>> Id in order to leave the unplug state.
>> ?-platform_leave_lowpower which restore the platform context.
>
> I still do not like this patch. ?The only thing that is worth doing is
> this. ?This leaves less than 256 bytes of object code in the Realview
> hotplug.c, most of which is the stuff to handle the low power mode
> which you haven't dealt with in your patch either.
>
> I see no point in adding another API on top of the already existing
> and simple API.
>

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/kernel/smp.c              |   35 ++++++++++++++++++++----
 arch/arm/mach-omap2/omap-hotplug.c |   28 -------------------
 arch/arm/mach-realview/hotplug.c   |   29 --------------------
 arch/arm/mach-s5pv310/hotplug.c    |   29 --------------------
 arch/arm/mach-tegra/hotplug.c      |   30 ---------------------
 arch/arm/mach-ux500/hotplug.c      |   51 +++++-------------------------------
 6 files changed, 36 insertions(+), 166 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8c19595..03042db 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
+#include <linux/completion.h>

 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -213,11 +214,13 @@ int __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct task_struct *p;
-	int ret;

-	ret = platform_cpu_disable(cpu);
-	if (ret)
-		return ret;
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	if (cpu == 0)
+		return -EPERM;

 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
@@ -252,14 +255,16 @@ int __cpu_disable(void)
 	return 0;
 }

+static DECLARE_COMPLETION(cpu_killed);
+
 /*
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!platform_cpu_kill(cpu))
-		printk("CPU%u: unable to kill\n", cpu);
+	if (!wait_for_completion_timeout(&cpu_killed, 5000))
+		printk(KERN_NOTICE "CPU%u: cpu didn't die\n", cpu);
 }

 /*
@@ -273,14 +278,32 @@ void __cpu_die(unsigned int cpu)
 void __ref cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
+#ifdef DEBUG
+	unsigned int this_cpu = hard_smp_processor_id();
+#endif

 	local_irq_disable();
 	idle_task_exit();

+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	complete(&cpu_killed);
+
+#ifdef DEBUG
+	if (cpu != this_cpu) {
+		printk(KERN_CRIT "Eek! platform_cpu_die is going to run on %u,
should be %u\n",
+			   this_cpu, cpu);
+		BUG();
+	}
+#endif
+
+	flush_cache_all();
+	wmb();
+
 	/*
 	 * actual CPU shutdown procedure is at least platform (if not
 	 * CPU) specific
 	 */
+
 	platform_cpu_die(cpu);

 	/*
diff --git a/arch/arm/mach-omap2/omap-hotplug.c
b/arch/arm/mach-omap2/omap-hotplug.c
index 6cee456..00f4190 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -17,35 +17,15 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>

-#include <asm/cacheflush.h>
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
 void platform_cpu_die(unsigned int cpu)
 {
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		pr_crit("platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-	pr_notice("CPU%u: shutdown\n", cpu);
-	complete(&cpu_killed);
-	flush_cache_all();
-	dsb();

 	/*
 	 * we're ready for shutdown now, so do it
@@ -69,11 +49,3 @@ void platform_cpu_die(unsigned int cpu)
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
index f95521a..580cf7c 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -11,19 +11,16 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>

 #include <asm/cacheflush.h>

 extern volatile int pen_release;

-static DECLARE_COMPLETION(cpu_killed);

 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;

-	flush_cache_all();
 	asm volatile(
 	"	mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
@@ -93,11 +90,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }

-int platform_cpu_kill(unsigned int cpu)
-{
-	return wait_for_completion_timeout(&cpu_killed, 5000);
-}
-
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -105,18 +97,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
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

 	/*
 	 * we're ready for shutdown now, so do it
@@ -130,12 +110,3 @@ void platform_cpu_die(unsigned int cpu)
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
index 03652c3..59eafad 100644
--- a/arch/arm/mach-s5pv310/hotplug.c
+++ b/arch/arm/mach-s5pv310/hotplug.c
@@ -13,19 +13,16 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>

 #include <asm/cacheflush.h>

 extern volatile int pen_release;

-static DECLARE_COMPLETION(cpu_killed);

 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;

-	flush_cache_all();
 	asm volatile(
 	"	mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
@@ -96,11 +93,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }

-int platform_cpu_kill(unsigned int cpu)
-{
-	return wait_for_completion_timeout(&cpu_killed, 5000);
-}
-
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -108,19 +100,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
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
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
@@ -134,11 +113,3 @@ void platform_cpu_die(unsigned int cpu)
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
index 8e7f115..7e5eb3d 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -11,17 +11,14 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>

 #include <asm/cacheflush.h>

-static DECLARE_COMPLETION(cpu_killed);

 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;

-	flush_cache_all();
 	asm volatile(
 	"	mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
@@ -92,11 +89,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }

-int platform_cpu_kill(unsigned int cpu)
-{
-	return wait_for_completion_timeout(&cpu_killed, 5000);
-}
-
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -104,19 +96,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
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
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
@@ -129,12 +108,3 @@ void platform_cpu_die(unsigned int cpu)
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
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index b782a03..37b443b 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -6,23 +6,22 @@
  *	Based on ARM realview platform
  *
  * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ * Author: vincent.guittot <vincent.guittot@stericsson.com>
  *
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <linux/completion.h>
-
-#include <asm/cacheflush.h>

 extern volatile int pen_release;

-static DECLARE_COMPLETION(cpu_killed);
-
-static inline void platform_do_lowpower(unsigned int cpu)
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
 {
-	flush_cache_all();
-
 	/* we put the platform to just WFI */
 	for (;;) {
 		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
@@ -36,40 +35,4 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }

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
-	/* directly enter low power state, skipping secure registers */
-	platform_do_lowpower(cpu);
-}

-int platform_cpu_disable(unsigned int cpu)
-{
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
-- 
1.7.0.4
