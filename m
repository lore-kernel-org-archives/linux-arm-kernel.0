From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 29 Nov 2010 10:55:14 +0100
Subject: [PATCH][ ARM cpu hotplug 2/2 ] Use common cpu hotplug code for UX500
In-Reply-To: <AANLkTinOdaYoztaHCkbFhfRtuo4XEVaC+K_7aAB0N28N@mail.gmail.com>
References: <AANLkTinOdaYoztaHCkbFhfRtuo4XEVaC+K_7aAB0N28N@mail.gmail.com>
Message-ID: <AANLkTi=fYYZTYz4uQZfbNBd057AbP4LVS_fYvp4+pMwZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extracts the common code of the cpu hotplug feature across
arm platforms. The goal is to only keep the specific stuff of the
platform in the sub-architecture. I have created a hotplug.c file in
the ?arm/common directory after studying the cpu hotplug code of
omap2, realview, s5pv310, ux500 and tegra. I have extracted 3 main
platform dependent functions:
?-platform_enter_lowpower which prepares the platform for low power.
?-platform_do_lowpower on which the cpu will loop until it becomes
really plugged (spurious wake up). This function must returned the cpu
Id in order to leave the unplug state.
?-platform_leave_lowpower which restore the platform context.

?An ux500 patch is available which uses the common/hotplug.c code.
This patch is quite short because the idle / power down functions are
not yet upstreamed

Signed-off-by: Vincent Guittot <vincent.guittot@stericsson.com>
---
?arch/arm/Kconfig ? ? ? ? ? ? ?| ? ?1 +
?arch/arm/mach-ux500/Makefile ?| ? ?2 +-
?arch/arm/mach-ux500/hotplug.c | ? 68 +++++++++-------------------------------
?arch/arm/mach-ux500/platsmp.c | ? ?2 +
?4 files changed, 20 insertions(+), 53 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ca96a44..ee74cf9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -797,6 +797,7 @@ config ARCH_U8500
? ? ? ?select GENERIC_CLOCKEVENTS
? ? ? ?select COMMON_CLKDEV
? ? ? ?select ARCH_REQUIRE_GPIOLIB
+ ? ? ? select USE_COMMON_ARM_HOTPLUG if HOTPLUG_CPU
? ? ? ?help
? ? ? ? ?Support for ST-Ericsson's Ux500 architecture

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 0612013..cb86197 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_UX500_SOC_DB8500) ?+= cpu-db8500.o
devices-db8500.o prcmu.o
?obj-$(CONFIG_MACH_U8500_MOP) ? += board-mop500.o board-mop500-sdi.o
?obj-$(CONFIG_MACH_U5500) ? ? ? += board-u5500.o
?obj-$(CONFIG_SMP) ? ? ? ? ? ? ?+= platsmp.o headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU) ? ? ?+= hotplug.o
+obj-$(CONFIG_USE_COMMON_ARM_HOTPLUG) ? += hotplug.o
?obj-$(CONFIG_LOCAL_TIMERS) ? ? += localtimer.o
?obj-$(CONFIG_REGULATOR_AB8500) += board-mop500-regulators.o
?obj-$(CONFIG_U5500_MODEM_IRQ) ?+= modem_irq.o
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index b782a03..14a614f 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -6,70 +6,34 @@
?* ? ? Based on ARM realview platform
?*
?* Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ * Author: Vincent Guittot <vincent.guittot@stericsson.com>
?*
+ * We only keep platform related code in the subarchitecture directory.
+ * The common code across platform has been moved into kernel/common directory
?*/
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <linux/completion.h>

-#include <asm/cacheflush.h>
+#include <asm/hotplug.h>

?extern volatile int pen_release;

-static DECLARE_COMPLETION(cpu_killed);
-
-static inline void platform_do_lowpower(unsigned int cpu)
-{
- ? ? ? flush_cache_all();
-
- ? ? ? /* we put the platform to just WFI */
- ? ? ? for (;;) {
- ? ? ? ? ? ? ? __asm__ __volatile__("dsb\n\t" "wfi\n\t"
- ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? : : : "memory");
- ? ? ? ? ? ? ? if (pen_release == cpu) {
- ? ? ? ? ? ? ? ? ? ? ? /*
- ? ? ? ? ? ? ? ? ? ? ? ?* OK, proper wakeup, we're done
- ? ? ? ? ? ? ? ? ? ? ? ?*/
- ? ? ? ? ? ? ? ? ? ? ? break;
- ? ? ? ? ? ? ? }
- ? ? ? }
-}
-
-int platform_cpu_kill(unsigned int cpu)
+/* Default implementation that will be used if not override
+ * by power specific implementation
+ */
+void __attribute__((weak)) platform_enter_lowpower(unsigned int cpu)
?{
- ? ? ? return wait_for_completion_timeout(&cpu_killed, 5000);
+ ? ? ? return;
?}

-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void platform_cpu_die(unsigned int cpu)
+int __attribute__((weak)) platform_do_lowpower(unsigned int cpu)
?{
-#ifdef DEBUG
- ? ? ? unsigned int this_cpu = hard_smp_processor_id();
-
- ? ? ? if (cpu != this_cpu) {
- ? ? ? ? ? ? ? printk(KERN_CRIT "Eek! platform_cpu_die running on %u,
should be %u\n",
- ? ? ? ? ? ? ? ? ? ? ? ? ?this_cpu, cpu);
- ? ? ? ? ? ? ? BUG();
- ? ? ? }
-#endif
-
- ? ? ? printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
- ? ? ? complete(&cpu_killed);
+ ? ? ? __asm__ __volatile__("dsb\n\t" "wfi\n\t"
+ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? : : : "memory");

- ? ? ? /* directly enter low power state, skipping secure registers */
- ? ? ? platform_do_lowpower(cpu);
+ ? ? ? return pen_release;
?}

-int platform_cpu_disable(unsigned int cpu)
+void __attribute__((weak)) platform_leave_lowpower(unsigned int cpu)
?{
- ? ? ? /*
- ? ? ? ?* we don't allow CPU 0 to be shutdown (it is still too special
- ? ? ? ?* e.g. clock tick interrupts)
- ? ? ? ?*/
- ? ? ? return cpu == 0 ? -EPERM : 0;
+ ? ? ? return;
?}
+
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 9e4c678..3074260 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -51,6 +51,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
? ? ? ? * pen, then head off into the C entry point
? ? ? ? */
? ? ? ?pen_release = -1;
+ ? ? ? smp_wmb();

? ? ? ?/*
? ? ? ? * Synchronise with the boot thread.
@@ -82,6 +83,7 @@ int __cpuinit boot_secondary(unsigned int cpu,
struct task_struct *idle)

? ? ? ?timeout = jiffies + (1 * HZ);
? ? ? ?while (time_before(jiffies, timeout)) {
+ ? ? ? ? ? ? ? smp_rmb();
? ? ? ? ? ? ? ?if (pen_release == -1)
? ? ? ? ? ? ? ? ? ? ? ?break;
? ? ? ?}
--
1.7.0.4
