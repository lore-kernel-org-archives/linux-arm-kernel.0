From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:50 -0400
Subject: [PATCH 01/12] ARM: clean up idle handlers
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's factor out the need_resched() check instead of having it duplicated
in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
was missing it already).

The forceful re-enablement of IRQs after pm_idle has returned can go.
The warning certainly doesn't trigger for existing users.  Similar for
the redundant  local_irq_disable() call in the OMAP implementations.

And finally move the comment explaining the reason for the turning off
of IRQs to a more proper location.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/process.c    |   19 ++++++++++---------
 arch/arm/mach-exynos4/cpu.c  |    4 +---
 arch/arm/mach-omap1/pm.c     |    6 ------
 arch/arm/mach-omap2/pm24xx.c |    1 -
 arch/arm/mach-omap2/pm34xx.c |    3 +--
 arch/arm/mach-s5p64x0/cpu.c  |   15 +++++++--------
 arch/arm/mach-s5pc100/cpu.c  |    4 +---
 arch/arm/mach-s5pv210/cpu.c  |    4 +---
 8 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1a347f481e..af395338db 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -158,13 +158,11 @@ void cpu_idle_wait(void)
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
 /*
- * This is our default idle handler.  We need to disable
- * interrupts here to ensure we don't miss a wakeup call.
+ * This is our default idle handler.
  */
 static void default_idle(void)
 {
-	if (!need_resched())
-		arch_idle();
+	arch_idle();
 	local_irq_enable();
 }
 
@@ -191,23 +189,26 @@ void cpu_idle(void)
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
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 746d6fc6d3..079b5bdadb 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -123,9 +123,7 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 
 static void exynos4_idle(void)
 {
-	if (!need_resched())
-		cpu_do_idle();
-
+	cpu_do_idle();
 	local_irq_enable();
 }
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 495b3987d4..c25b6b06be 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -108,13 +108,7 @@ void omap1_pm_idle(void)
 	__u32 use_idlect1 = arm_idlect1_mask;
 	int do_sleep = 0;
 
-	local_irq_disable();
 	local_fiq_disable();
-	if (need_resched()) {
-		local_fiq_enable();
-		local_irq_enable();
-		return;
-	}
 
 #ifdef CONFIG_OMAP_MPU_TIMER
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bf089e743e..3ada66c167 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -277,7 +277,6 @@ static int omap2_can_sleep(void)
 
 static void omap2_pm_idle(void)
 {
-	local_irq_disable();
 	local_fiq_disable();
 
 	if (!omap2_can_sleep()) {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9bce8..16292e5124 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -492,13 +492,12 @@ int omap3_can_sleep(void)
 
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
diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
index 8a938542c5..93e8b02f7a 100644
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -88,14 +88,13 @@ static void s5p64x0_idle(void)
 {
 	unsigned long val;
 
-	if (!need_resched()) {
-		val = __raw_readl(S5P64X0_PWR_CFG);
-		val &= ~(0x3 << 5);
-		val |= (0x1 << 5);
-		__raw_writel(val, S5P64X0_PWR_CFG);
-
-		cpu_do_idle();
-	}
+	val = __raw_readl(S5P64X0_PWR_CFG);
+	val &= ~(0x3 << 5);
+	val |= (0x1 << 5);
+	__raw_writel(val, S5P64X0_PWR_CFG);
+
+	cpu_do_idle();
+
 	local_irq_enable();
 }
 
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index fd2708e7d8..a5d42be262 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -94,9 +94,7 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 
 static void s5pc100_idle(void)
 {
-	if (!need_resched())
-		cpu_do_idle();
-
+	cpu_do_idle();
 	local_irq_enable();
 }
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 9114572082..c02adca897 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -101,9 +101,7 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 
 static void s5pv210_idle(void)
 {
-	if (!need_resched())
-		cpu_do_idle();
-
+	cpu_do_idle();
 	local_irq_enable();
 }
 
-- 
1.7.7.1.431.g10b2a
