From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 18:03:05 +0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <AANLkTikZgWgwsWpxbuXGLRzPnwtrZyiSU7k2dXGfuc69@mail.gmail.com>
References: <AANLkTinMobeQBz_ruGAeOSoTWP_9-0Aw4-=8Sk3JxEjX@mail.gmail.com>
	<20110103104621.GF26785@n2100.arm.linux.org.uk>
	<AANLkTikZgWgwsWpxbuXGLRzPnwtrZyiSU7k2dXGfuc69@mail.gmail.com>
Message-ID: <20110103180305.GA4572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 06:39:56PM +0100, Vincent Guittot wrote:
> On 3 January 2011 11:46, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Dec 20, 2010 at 09:16:15AM +0100, Vincent Guittot wrote:
> >> I'm also interested in hotplug latency measurement and have done some
> >> on my CA9 platform u8500. I have the same kind of result for plugging
> >> a secondary cpu:
> >> ? total duration = 295ms
> >> ? 166 us for the low level cpu wake up
> >> ? 228ms between the return from platform_cpu_die and the cpu becomes online
> >>
> >> I have added some trace events for doing these measurements and I'd
> >> like to add some generic traces point in the cpu hotplug code like we
> >> already have in power management code (cpuidle, suspend, cpufreq ...)
> >> These traces could be used with power events for studying the impact
> >> of cpu hotplug in the complete power management scheme.
> >
> > Note that if you pass lpj=<number> to the kernel, you'll bypass the
> > calibration and have a faster response to CPU onlining.
> >
> 
> yes, the total duration decreases down to 40ms

I'm not sure that I believe it takes 40ms, as it's only taking about
104us to get to the calibration for me.  The calibration when disabled
is virtually a do-nothing, so shouldn't be taking 40ms.

The trace code may be hitting locks which are interfering with the
timing - this below is entirely lockless with a proper (and working)
sched_clock() implementation.

See mach-vexpress/platsmp.c for the things to add.  Also note that it
requires the SMP changes (and for good measure, the clksrc stuff too.)
Might be easier to apply on top of linux-next.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 11d6a94..0b3a15a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -40,6 +40,7 @@
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
 
+#include <asm/smp-debug.h>
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -47,6 +48,8 @@
  */
 struct secondary_data secondary_data;
 
+struct smp_debug smp_debug;
+
 enum ipi_msg_type {
 	IPI_TIMER = 2,
 	IPI_RESCHEDULE,
@@ -55,6 +58,24 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };
 
+static const char *debug_names[] = {
+	[D_START]		= "Start",
+	[D_BOOT_SECONDARY_CALL]	= "Booting",
+	[D_CROSS_CALL]		= "Cross call",
+	[D_PEN_RELEASED]	= "Pen released",
+	[D_UNLOCK]		= "Unlock",
+	[D_BOOT_SECONDARY_RET]	= "Boot returned",
+	[D_BOOT_DONE]		= "Boot complete",
+	[D_SEC_RESTART]		= "Sec: restart",
+	[D_SEC_UP]		= "Sec: up",
+	[D_SEC_PLAT_ENTER]	= "Sec: enter",
+	[D_SEC_PLAT_PEN_WRITE]	= "Sec: pen write",
+	[D_SEC_PLAT_PEN_DONE]	= "Sec: pen done",
+	[D_SEC_PLAT_EXIT]	= "Sec: exit",
+	[D_SEC_CALIBRATE]	= "Sec: calibrate",
+	[D_SEC_ONLINE]		= "Sec: online",
+};
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
@@ -111,7 +132,10 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	/*
 	 * Now bring the CPU into our world.
 	 */
+	smp_debug_mark(D_START);
+	smp_debug_mark(D_BOOT_SECONDARY_CALL);
 	ret = boot_secondary(cpu, idle);
+	smp_debug_mark(D_BOOT_SECONDARY_RET);
 	if (ret == 0) {
 		unsigned long timeout;
 
@@ -135,6 +159,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	} else {
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
+	smp_debug_mark(D_BOOT_DONE);
 
 	secondary_data.stack = NULL;
 	secondary_data.pgdir = 0;
@@ -148,6 +173,14 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	}
 
 	pgd_free(&init_mm, pgd);
+{
+	int i;
+	for (i = 0; i < D_NUM; i++) {
+		if (debug_names[i] && smp_debug.entry[i])
+			pr_info("SMP: %s: %llu\n", debug_names[i],
+				smp_debug.entry[i] - smp_debug.entry[0]);
+	}
+}
 
 	return ret;
 }
@@ -245,6 +278,8 @@ void __ref cpu_die(void)
 	 */
 	platform_cpu_die(cpu);
 
+	smp_debug_mark(D_SEC_RESTART);
+
 	/*
 	 * Do not return to the idle loop - jump back to the secondary
 	 * cpu initialisation.  There's some initialisation which needs
@@ -278,6 +313,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu = smp_processor_id();
 
+	smp_debug_mark(D_SEC_UP);
 	printk("CPU%u: Booted secondary processor\n", cpu);
 
 	/*
@@ -312,6 +348,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 */
 	percpu_timer_setup();
 
+	smp_debug_mark(D_SEC_CALIBRATE);
+
 	calibrate_delay();
 
 	smp_store_cpu_info(cpu);
@@ -320,6 +358,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 * OK, now it's safe to let the boot CPU continue
 	 */
 	set_cpu_online(cpu, true);
+	smp_debug_mark(D_SEC_ONLINE);
 
 	/*
 	 * OK, it's off to the idle thread for us
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index b1687b6..0a77a6b 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -27,7 +27,7 @@
 #include "core.h"
 
 extern void vexpress_secondary_startup(void);
-
+#include <asm/smp-debug.h>
 /*
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
@@ -56,6 +56,7 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
+	smp_debug_mark(D_SEC_PLAT_ENTER);
 	/*
 	 * if any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
@@ -67,13 +68,16 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
+	smp_debug_mark(D_SEC_PLAT_PEN_WRITE);
 	write_pen_release(-1);
+	smp_debug_mark(D_SEC_PLAT_PEN_DONE);
 
 	/*
 	 * Synchronise with the boot thread.
 	 */
 	spin_lock(&boot_lock);
 	spin_unlock(&boot_lock);
+	smp_debug_mark(D_SEC_PLAT_EXIT);
 }
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -99,6 +103,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
+	smp_debug_mark(D_CROSS_CALL);
 	smp_cross_call(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
@@ -109,12 +114,14 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		udelay(10);
 	}
+	smp_debug_mark(D_PEN_RELEASED);
 
 	/*
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
 	spin_unlock(&boot_lock);
+	smp_debug_mark(D_UNLOCK);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
--- /dev/null	2010-08-07 18:16:05.574112050 +0100
+++ arch/arm/include/asm/smp-debug.h	2010-12-18 22:03:23.622580304 +0000
@@ -0,0 +1,39 @@
+#include <linux/sched.h>
+
+enum {
+	D_START,
+	D_INIT_IDLE,
+	D_PGD_ALLOC,
+	D_IDMAP_ADD,
+	D_BOOT_SECONDARY_CALL,
+	D_CROSS_CALL,
+	D_PEN_RELEASED,
+	D_UNLOCK,
+	D_BOOT_SECONDARY_RET,
+	D_BOOT_DONE,
+	D_IDMAP_DEL,
+	D_PGD_FREE,
+
+	D_SEC = 16,
+	D_SEC_RESTART = D_SEC,
+	D_SEC_UP,
+	D_SEC_PLAT_ENTER,
+	D_SEC_PLAT_PEN_WRITE,
+	D_SEC_PLAT_PEN_DONE,
+	D_SEC_PLAT_EXIT,
+	D_SEC_CALIBRATE,
+	D_SEC_ONLINE,
+	
+	D_NUM,
+};
+
+struct smp_debug {
+	unsigned long long	entry[D_NUM];
+};
+
+extern struct smp_debug smp_debug;
+
+static inline void smp_debug_mark(int ent)
+{
+	smp_debug.entry[ent] = sched_clock();
+}
