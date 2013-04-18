From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 19:25:34 +0100
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <20130418171801.GC14496@n2100.arm.linux.org.uk>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
 <1365251824-4852-2-git-send-email-kevin@bracey.fi>
 <20130418171801.GC14496@n2100.arm.linux.org.uk>
Message-ID: <20130418182534.GD14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 06:18:01PM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 06, 2013 at 03:37:04PM +0300, Kevin Bracey wrote:
> > When hotplugging out, both cpu_kill and cpu_die have always been called.
> > But when smp_send_stop was used in machine_shutdown or panic, only
> > cpu_kill was called.
> > 
> > This causes problems for co-ordination between cpu_kill and cpu_die, as
> > attempted by shmobile. So add cpu_die call to ipi_cpu_stop, to ensure
> > that cpu_kill and cpu_die calls always occur together.
> 
> Actually, I'd prefer to pull more code out of the platforms.  Now
> that we have flush_cache_louis(), we can flush the L1 cache for the
> CPU going down in cpu_die() itself.  We just need to be careful
> with that complete() call to ensure that becomes visible to other
> cores before power is cut to the L1 cache.
> 
> That's fine though - because it must become visible for __cpu_die()
> to continue (otherwise it will time out).
> 
> That should render shmobile's cpu_dead thing unnecessary, because the
> platform independent code will do the required synchronisation.

So, something like the below (which is a combined patch of three).  The
key points here being that:

1. We flush the L1 cache in cpu_die(), which pushes any dirty cache lines
   out of the L1 cache and invalidates it.  At the point this function
   completes, any data in the L1 cache has been pushed out and all
   cache lines are invalid.
2. We complete(), which allows __cpu_die() to proceed and call
   platform_cpu_kill().  This may create dirty cache lines which this
   CPU exclusively owns, but the CPU in __cpu_die() will gain those
   cache lines before wait_for_completion() can return - not only the
   completion counter but also the spinlock, which this CPU will have
   ended up reading and writing - and so can no longer be owned by the
   dying CPU.
3. The following mb() is belt and braces to ensure that the completion
   is visible.  It isn't strictly required because the spinlocks will
   do the necessary stuff to ensure this.
4. Any dirtying of the cache after this rellay doesn't matter _if_ only
   the stack is touched, or other data is only read.
5. I've left those platforms which disable the L1 cache, then flush
   alone; that _should_ be removable with this patch as well, but as
   a separate patch.

Now, with this patch applied, we guarantee that we push out any data
that matters from the dying CPU before platform_cpu_kill() is called.
That should mean that shmobile can remove that whole cpu_dead thing.

I've tested this on OMAP, and it appears to work from a simple test of
CPU hotplug.  This patch(set) also kills the cpu_disable() that tegra
has which is just a copy of the generic version.

 arch/arm/kernel/smp.c               |    4 ++++
 arch/arm/mach-exynos/hotplug.c      |    1 -
 arch/arm/mach-highbank/hotplug.c    |    4 ----
 arch/arm/mach-imx/hotplug.c         |    2 --
 arch/arm/mach-msm/hotplug.c         |    4 ----
 arch/arm/mach-omap2/omap-hotplug.c  |    3 ---
 arch/arm/mach-prima2/hotplug.c      |    3 ---
 arch/arm/mach-realview/hotplug.c    |    2 --
 arch/arm/mach-shmobile/smp-sh73a0.c |    8 --------
 arch/arm/mach-spear13xx/hotplug.c   |    2 --
 arch/arm/mach-tegra/common.h        |    1 -
 arch/arm/mach-tegra/hotplug.c       |   10 ----------
 arch/arm/mach-tegra/platsmp.c       |    1 -
 arch/arm/mach-ux500/hotplug.c       |    3 ---
 arch/arm/mach-vexpress/hotplug.c    |    2 --
 15 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 1f2cccc..d0cb2e1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -230,10 +230,14 @@ void __ref cpu_die(void)
 	idle_task_exit();
 
 	local_irq_disable();
+
+	/* Flush the data out of the L1 cache for this CPU. */
+	flush_cache_louis();
 	mb();
 
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
 	RCU_NONIDLE(complete(&cpu_died));
+	mb();
 
 	/*
 	 * actual CPU shutdown procedure is at least platform (if not
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index c3f825b..af90cfa 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -28,7 +28,6 @@ static inline void cpu_enter_lowpower_a9(void)
 {
 	unsigned int v;
 
-	flush_cache_all();
 	asm volatile(
 	"	mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
index f30c528..35dd42e 100644
--- a/arch/arm/mach-highbank/hotplug.c
+++ b/arch/arm/mach-highbank/hotplug.c
@@ -15,8 +15,6 @@
  */
 #include <linux/kernel.h>
 
-#include <asm/cacheflush.h>
-
 #include "core.h"
 #include "sysregs.h"
 
@@ -28,8 +26,6 @@ extern void secondary_startup(void);
  */
 void __ref highbank_cpu_die(unsigned int cpu)
 {
-	flush_cache_all();
-
 	highbank_set_cpu_jump(cpu, phys_to_virt(0));
 	highbank_set_core_pwr();
 
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 361a253..5e91112 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/errno.h>
-#include <asm/cacheflush.h>
 #include <asm/cp15.h>
 
 #include "common.h"
@@ -20,7 +19,6 @@ static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
 
-	flush_cache_all();
 	asm volatile(
 		"mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 750446f..326a872 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -10,16 +10,12 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
-#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
 #include "common.h"
 
 static inline void cpu_enter_lowpower(void)
 {
-	/* Just flush the cache. Changing the coherency is not yet
-	 * available on msm. */
-	flush_cache_all();
 }
 
 static inline void cpu_leave_lowpower(void)
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index e712d17..ceb30a5 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -35,9 +35,6 @@ void __ref omap4_cpu_die(unsigned int cpu)
 	unsigned int boot_cpu = 0;
 	void __iomem *base = omap_get_wakeupgen_base();
 
-	flush_cache_all();
-	dsb();
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
index f4b17cb..0ab2f8b 100644
--- a/arch/arm/mach-prima2/hotplug.c
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -10,13 +10,10 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
-#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
 static inline void platform_do_lowpower(unsigned int cpu)
 {
-	flush_cache_all();
-
 	/* we put the platform to just WFI */
 	for (;;) {
 		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 53818e5..ac22dd4 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
-#include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
@@ -20,7 +19,6 @@ static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
 
-	flush_cache_all();
 	asm volatile(
 	"	mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index acb46a9..2f1ef1b 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -119,14 +119,6 @@ static int sh73a0_cpu_kill(unsigned int cpu)
 
 static void sh73a0_cpu_die(unsigned int cpu)
 {
-	/*
-	 * The ARM MPcore does not issue a cache coherency request for the L1
-	 * cache when powering off single CPUs. We must take care of this and
-	 * further caches.
-	 */
-	dsb();
-	flush_cache_all();
-
 	/* Set power off mode. This takes the CPU out of the MP cluster */
 	scu_power_mode(scu_base_addr(), SCU_PM_POWEROFF);
 
diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear13xx/hotplug.c
index a7d2dd1..d97749c 100644
--- a/arch/arm/mach-spear13xx/hotplug.c
+++ b/arch/arm/mach-spear13xx/hotplug.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
-#include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
@@ -21,7 +20,6 @@ static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
 
-	flush_cache_all();
 	asm volatile(
 	"	mcr	p15, 0, %1, c7, c5, 0\n"
 	"	dsb\n"
diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
index 32f8eb3..5900cc4 100644
--- a/arch/arm/mach-tegra/common.h
+++ b/arch/arm/mach-tegra/common.h
@@ -2,4 +2,3 @@ extern struct smp_operations tegra_smp_ops;
 
 extern int tegra_cpu_kill(unsigned int cpu);
 extern void tegra_cpu_die(unsigned int cpu);
-extern int tegra_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index a599f6e..e8323bc 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -12,7 +12,6 @@
 #include <linux/smp.h>
 #include <linux/clk/tegra.h>
 
-#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
 #include "sleep.h"
@@ -47,15 +46,6 @@ void __ref tegra_cpu_die(unsigned int cpu)
 	BUG();
 }
 
-int tegra_cpu_disable(unsigned int cpu)
-{
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
-
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 extern void tegra20_hotplug_shutdown(void);
 void __init tegra20_hotplug_init(void)
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 2c6b3d5..ec33ec8 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -192,6 +192,5 @@ struct smp_operations tegra_smp_ops __initdata = {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= tegra_cpu_kill,
 	.cpu_die		= tegra_cpu_die,
-	.cpu_disable		= tegra_cpu_disable,
 #endif
 };
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index 2f6af25..1c55a55 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
-#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
 #include <mach/setup.h>
@@ -24,8 +23,6 @@
  */
 void __ref ux500_cpu_die(unsigned int cpu)
 {
-	flush_cache_all();
-
 	/* directly enter low power state, skipping secure registers */
 	for (;;) {
 		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index a141b98..f0ce6b8 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
-#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
@@ -20,7 +19,6 @@ static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
 
-	flush_cache_all();
 	asm volatile(
 		"mcr	p15, 0, %1, c7, c5, 0\n"
 	"	mcr	p15, 0, %1, c7, c10, 4\n"
