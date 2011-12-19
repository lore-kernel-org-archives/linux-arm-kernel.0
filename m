From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:30 -0500
Subject: [PATCH 01/20] ARM: clean up idle handlers
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's factor out the need_resched() check instead of having it duplicated
in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
was missing it already).

The forceful re-enablement of IRQs after pm_idle has returned can go.
The warning certainly doesn't trigger for existing users.  Similar for
the redundant local_irq_disable() call in the OMAP implementations.

To get rid of the pm_idle calling convention oddity, let's introduce
arm_pm_idle() allowing for the local_irq_enable() to be factored out
from SOC specific implementations. The default pm_idle function becomes
a wrapper for arm_pm_idle and it takes care of enabling IRQs closer to
where they are initially disabled.

And finally move the comment explaining the reason for that turning off
of IRQs to a more proper location.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/system.h |    1 +
 arch/arm/kernel/process.c     |   23 +++++++++++++++--------
 arch/arm/mach-omap1/pm.c      |   19 ++++++-------------
 arch/arm/mach-omap2/pm24xx.c  |    5 ++---
 arch/arm/mach-omap2/pm34xx.c  |    7 +++----
 arch/arm/mach-omap2/pm44xx.c  |    2 ++
 arch/arm/mach-s5p64x0/cpu.c   |   16 +++++++---------
 7 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 03775b14be..8f1adbbbed 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -102,6 +102,7 @@ extern void cpu_init(void);
 
 void soft_restart(unsigned long);
 extern void (*arm_pm_restart)(char str, const char *cmd);
+extern void (*arm_pm_idle)(void);
 
 #define UDBG_UNDEFINED	(1 << 0)
 #define UDBG_SYSCALL	(1 << 1)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index a92ca50f6f..bf904624c5 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -151,12 +151,16 @@ void cpu_idle_wait(void)
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
 /*
- * This is our default idle handler.  We need to disable
- * interrupts here to ensure we don't miss a wakeup call.
+ * This is our default idle handler.
  */
+
+void (*arm_pm_idle)(void);
+
 static void default_idle(void)
 {
-	if (!need_resched())
+	if (arm_pm_idle)
+		arm_pm_idle();
+	else
 		arch_idle();
 	local_irq_enable();
 }
@@ -184,23 +188,26 @@ void cpu_idle(void)
 				cpu_die();
 #endif
 
+			/*
+			 * We need to disable interrupts here
+			 * to ensure we don't miss a wakeup call.
+			 */
 			local_irq_disable();
 			if (hlt_counter) {
 				local_irq_enable();
 				cpu_relax();
-			} else {
+			} else if (!need_resched()) {
 				stop_critical_timings();
 				if (cpuidle_idle_call())
 					pm_idle();
 				start_critical_timings();
 				/*
-				 * This will eventually be removed - pm_idle
-				 * functions should always return with IRQs
-				 * enabled.
+				 * pm_idle functions should always
+				 * return with IRQs enabled.
 				 */
 				WARN_ON(irqs_disabled());
+			} else
 				local_irq_enable();
-			}
 		}
 		leds_event(led_idle_end);
 		tick_nohz_restart_sched_tick();
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 89ea20ca0c..575950ef81 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -42,9 +42,10 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/atomic.h>
 
+#include <asm/system.h>
 #include <asm/irq.h>
-#include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
@@ -108,13 +109,7 @@ void omap1_pm_idle(void)
 	__u32 use_idlect1 = arm_idlect1_mask;
 	int do_sleep = 0;
 
-	local_irq_disable();
 	local_fiq_disable();
-	if (need_resched()) {
-		local_fiq_enable();
-		local_irq_enable();
-		return;
-	}
 
 #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
@@ -157,14 +152,12 @@ void omap1_pm_idle(void)
 		omap_writel(saved_idlect1, ARM_IDLECT1);
 
 		local_fiq_enable();
-		local_irq_enable();
 		return;
 	}
 	omap_sram_suspend(omap_readl(ARM_IDLECT1),
 			  omap_readl(ARM_IDLECT2));
 
 	local_fiq_enable();
-	local_irq_enable();
 }
 
 /*
@@ -592,8 +585,8 @@ static void (*saved_idle)(void) = NULL;
 static int omap_pm_prepare(void)
 {
 	/* We cannot sleep in idle until we have resumed */
-	saved_idle = pm_idle;
-	pm_idle = NULL;
+	saved_idle = arm_pm_idle;
+	arm_pm_idle = NULL;
 
 	return 0;
 }
@@ -630,7 +623,7 @@ static int omap_pm_enter(suspend_state_t state)
 
 static void omap_pm_finish(void)
 {
-	pm_idle = saved_idle;
+	arm_pm_idle = saved_idle;
 }
 
 
@@ -687,7 +680,7 @@ static int __init omap_pm_init(void)
 		return -ENODEV;
 	}
 
-	pm_idle = omap1_pm_idle;
+	arm_pm_idle = omap1_pm_idle;
 
 	if (cpu_is_omap7xx())
 		setup_irq(INT_7XX_WAKE_UP_REQ, &omap_wakeup_irq);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index ef8595c802..7903087182 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -34,6 +34,7 @@
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
+#include <asm/system.h>
 #include <asm/mach-types.h>
 
 #include <mach/irqs.h>
@@ -251,7 +252,6 @@ static int omap2_can_sleep(void)
 
 static void omap2_pm_idle(void)
 {
-	local_irq_disable();
 	local_fiq_disable();
 
 	if (!omap2_can_sleep()) {
@@ -268,7 +268,6 @@ static void omap2_pm_idle(void)
 
 out:
 	local_fiq_enable();
-	local_irq_enable();
 }
 
 #ifdef CONFIG_SUSPEND
@@ -488,7 +487,7 @@ static int __init omap2_pm_init(void)
 	}
 
 	suspend_set_ops(&omap_pm_ops);
-	pm_idle = omap2_pm_idle;
+	arm_pm_idle = omap2_pm_idle;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fa637dfdda..c4b3d7291b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -32,6 +32,7 @@
 #include <trace/events/power.h>
 
 #include <asm/suspend.h>
+#include <asm/system.h>
 
 #include <plat/sram.h>
 #include "clockdomain.h"
@@ -494,13 +495,12 @@ int omap3_can_sleep(void)
 
 static void omap3_pm_idle(void)
 {
-	local_irq_disable();
 	local_fiq_disable();
 
 	if (!omap3_can_sleep())
 		goto out;
 
-	if (omap_irq_pending() || need_resched())
+	if (omap_irq_pending())
 		goto out;
 
 	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
@@ -513,7 +513,6 @@ static void omap3_pm_idle(void)
 
 out:
 	local_fiq_enable();
-	local_irq_enable();
 }
 
 #ifdef CONFIG_SUSPEND
@@ -918,7 +917,7 @@ static int __init omap3_pm_init(void)
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
-	pm_idle = omap3_pm_idle;
+	arm_pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
 	/*
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8edb015f56..b02124ce14 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include <asm/system.h>
+
 #include "common.h"
 #include "powerdomain.h"
 
diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
index ecab40cf19..b776c2b167 100644
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mach/irq.h>
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
+#include <asm/system.h>
 
 #include <mach/hardware.h>
 #include <mach/map.h>
@@ -89,15 +90,12 @@ static void s5p64x0_idle(void)
 {
 	unsigned long val;
 
-	if (!need_resched()) {
-		val = __raw_readl(S5P64X0_PWR_CFG);
-		val &= ~(0x3 << 5);
-		val |= (0x1 << 5);
-		__raw_writel(val, S5P64X0_PWR_CFG);
+	val = __raw_readl(S5P64X0_PWR_CFG);
+	val &= ~(0x3 << 5);
+	val |= (0x1 << 5);
+	__raw_writel(val, S5P64X0_PWR_CFG);
 
-		cpu_do_idle();
-	}
-	local_irq_enable();
+	cpu_do_idle();
 }
 
 /*
@@ -209,7 +207,7 @@ int __init s5p64x0_init(void)
 	printk(KERN_INFO "S5P64X0(S5P6440/S5P6450): Initializing architecture\n");
 
 	/* set idle function */
-	pm_idle = s5p64x0_idle;
+	arm_pm_idle = s5p64x0_idle;
 
 	return sysdev_register(&s5p64x0_sysdev);
 }
-- 
1.7.7.1.431.g10b2a
