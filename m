From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 17 Sep 2010 14:13:08 +0900
Subject: [PATCH 2/2] ARM: S5PV310: Update CPU hotplug implementation
In-Reply-To: <1284700388-9394-1-git-send-email-kgene.kim@samsung.com>
References: <1284700388-9394-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1284700388-9394-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch updates CPU hotplug implementation to reduce CPU power consumption
and will turn off the CPU power when CPU1 is unplugged while previous CPU hotplug
used CPU idle.
This patch removes init memory freeing code to use CPU boot code when CPU1 is
plugged-in again and adds vfp_enable() call to allow to access CP10 and CP11.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 arch/arm/mach-s5pv310/hotplug.c |   12 +++++++-----
 arch/arm/mach-s5pv310/platsmp.c |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/mm/init.c              |    2 ++
 arch/arm/vfp/vfpmodule.c        |    2 +-
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-s5pv310/hotplug.c
index 03652c3..0e188fe 100644
--- a/arch/arm/mach-s5pv310/hotplug.c
+++ b/arch/arm/mach-s5pv310/hotplug.c
@@ -14,9 +14,12 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
+#include <linux/io.h>
 
 #include <asm/cacheflush.h>
 
+#include <mach/regs-pmu.h>
+
 extern volatile int pen_release;
 
 static DECLARE_COMPLETION(cpu_killed);
@@ -61,12 +64,11 @@ static inline void cpu_leave_lowpower(void)
 
 static inline void platform_do_lowpower(unsigned int cpu)
 {
-	/*
-	 * there is no power-control hardware on this platform, so all
-	 * we can do is put the core into WFI; this is safe as the calling
-	 * code will have already disabled interrupts
-	 */
 	for (;;) {
+		/* make cpu1 to be turned off at next WFI command */
+		if (cpu == 1)
+			__raw_writel(0, S5PV310_ARM_CORE1_CONF);
+
 		/*
 		 * here's the WFI
 		 */
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index d357c19..d10c4ad 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -28,8 +28,10 @@
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
+#include <mach/regs-pmu.h>
 
 extern void s5pv310_secondary_startup(void);
+extern void vfp_enable(void *unused);
 
 /*
  * control for which core is the next to come out of the secondary
@@ -47,6 +49,10 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
+#ifdef CONFIG_VFP
+	vfp_enable(NULL);
+#endif
+
 	trace_hardirqs_off();
 
 	/*
@@ -92,6 +98,27 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
 	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
 
+	if (!(__raw_readl(S5PV310_ARM_CORE1_STAT) & S5PV310_CORE_PWR_EN)) {
+		__raw_writel(S5PV310_CORE_PWR_EN,
+			     S5PV310_ARM_CORE1_CONF);
+
+		timeout = 10;
+
+		/* wait max 10 ms until cpu1 is on */
+		while ((__raw_readl(S5PV310_ARM_CORE1_STAT)
+			& S5PV310_CORE_PWR_EN) != S5PV310_CORE_PWR_EN) {
+			if (timeout-- == 0)
+				break;
+
+			mdelay(1);
+		}
+
+		if (timeout == 0) {
+			printk(KERN_ERR "cpu1 power-up failed");
+			return -ETIMEDOUT;
+		}
+	}
+
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
@@ -102,6 +129,13 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
+
+		if (!__raw_readl(S5P_VA_SYSRAM)) {
+			__raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)),
+				     S5P_VA_SYSRAM);
+			smp_cross_call(cpumask_of(cpu));
+		}
+
 		if (pen_release == -1)
 			break;
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7185b00..57c4c5c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -589,10 +589,12 @@ void free_initmem(void)
 				    "TCM link");
 #endif
 
+#ifndef CONFIG_HOTPLUG_CPU
 	if (!machine_is_integrator() && !machine_is_cintegrator())
 		totalram_pages += free_area(__phys_to_pfn(__pa(__init_begin)),
 					    __phys_to_pfn(__pa(__init_end)),
 					    "init");
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8063a32..eee8f67 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -364,7 +364,7 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 	preempt_enable();
 }
 
-static void vfp_enable(void *unused)
+void vfp_enable(void *unused)
 {
 	u32 access = get_copro_access();
 
-- 
1.6.2.5
