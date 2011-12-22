From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:42 +0000
Subject: [PATCH v2 12/15] ARM: smp_twd: remove support for non-standalone
 version
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no in-tree platform using both CONFIG_LOCAL_TIMERS and
CONFIG_HAVE_ARM_TWD. As such, some code can be removed and some
exported functions of smp_twd.c can be made static.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                  |    1 -
 arch/arm/include/asm/localtimer.h |   10 ------
 arch/arm/include/asm/smp_twd.h    |    5 ---
 arch/arm/kernel/smp_twd.c         |   65 ++++++++++--------------------------
 4 files changed, 18 insertions(+), 63 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c37410a..c3732bb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1566,7 +1566,6 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && !ARM_SMP_TWD
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index c6a1842..5f21c37 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -22,21 +22,11 @@ void percpu_timer_setup(void);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
-#ifdef CONFIG_HAVE_ARM_TWD
-
-#include "smp_twd.h"
-
-#define local_timer_stop(c)	twd_timer_stop((c))
-
-#else
-
 /*
  * Stop the local timer
  */
 void local_timer_stop(struct clock_event_device *);
 
-#endif
-
 /*
  * Setup a local timer interrupt for a CPU.
  */
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 09c3b71..1479a6f 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -18,14 +18,9 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-struct clock_event_device;
 struct resource;
 struct of_device_id;
 
-extern void __iomem *twd_base;
-
-void twd_timer_setup(struct clock_event_device *);
-void twd_timer_stop(struct clock_event_device *);
 #ifdef CONFIG_HAVE_ARM_TWD
 int twd_timer_register(struct resource *res, int res_nr);
 int twd_timer_of_init(const struct of_device_id *twd_of_match);
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 98a6a59..aec1bc1 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -18,21 +18,18 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-
-/* set up by the platform code */
-void __iomem *twd_base;
 
+static void __iomem *twd_base;
+static struct clock_event_device __percpu *twd_clock_event;
+static int twd_ppi;
 static unsigned long twd_timer_rate;
 
-static struct clock_event_device __percpu **twd_evt;
-
 static void twd_set_mode(enum clock_event_mode mode,
 			struct clock_event_device *clk)
 {
@@ -87,7 +84,7 @@ int twd_timer_ack(void)
 	return 0;
 }
 
-void twd_timer_stop(struct clock_event_device *clk)
+static void twd_timer_stop(struct clock_event_device *clk)
 {
 	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 	disable_percpu_irq(clk->irq);
@@ -134,7 +131,7 @@ static void __cpuinit twd_calibrate_rate(void)
 
 static irqreturn_t twd_handler(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
+	struct clock_event_device *evt = dev_id;
 
 	if (twd_timer_ack()) {
 		evt->event_handler(evt);
@@ -147,28 +144,8 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
-	struct clock_event_device **this_cpu_clk;
-
-	if (!twd_evt) {
-		int err;
-
-		twd_evt = alloc_percpu(struct clock_event_device *);
-		if (!twd_evt) {
-			pr_err("twd: can't allocate memory\n");
-			return;
-		}
-
-		err = request_percpu_irq(clk->irq, twd_handler,
-					 "twd", twd_evt);
-		if (err) {
-			pr_err("twd: can't register interrupt %d (%d)\n",
-			       clk->irq, err);
-			return;
-		}
-	}
-
 	twd_calibrate_rate();
 
 	__raw_writel(0, twd_base + TWD_TIMER_CONTROL);		
@@ -183,26 +160,14 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
-
-	this_cpu_clk = __this_cpu_ptr(twd_evt);
-	*this_cpu_clk = clk;
+	clk->cpumask = cpumask_of(smp_processor_id());
+	clk->irq = twd_ppi;
 
 	clockevents_register_device(clk);
 
 	enable_percpu_irq(clk->irq, 0);
 }
 
-#ifdef CONFIG_ARM_SMP_TWD
-static struct clock_event_device __percpu *twd_clock_event;
-static int twd_ppi;
-
-static void __cpuinit twd_setup(struct clock_event_device *clk)
-{
-	clk->cpumask = cpumask_of(smp_processor_id());
-	clk->irq = twd_ppi;
-	twd_timer_setup(clk);
-}
-
 static void __cpuinit twd_teardown(void *data)
 {
 	struct clock_event_device *clk = data;
@@ -218,7 +183,7 @@ static int __cpuinit twd_cpu_notify(struct notifier_block *self,
 	switch (action) {
 	case CPU_STARTING:
 	case CPU_STARTING_FROZEN:
-		twd_setup(clk);
+		twd_timer_setup(clk);
 		break;
 
 	case CPU_DOWN_PREPARE:
@@ -250,9 +215,16 @@ static int __init twd_timer_common_init(void)
 		goto out_free;
 	}
 
+	err = request_percpu_irq(twd_ppi, twd_handler, "twd", twd_clock_event);
+	if (err) {
+		pr_err("twd: can't register interrupt %d (%d)\n",
+		       twd_ppi, err);
+		goto out_free;
+	}
+
 	/* Immediately configure the timer on the boot CPU */
 	clk = per_cpu_ptr(twd_clock_event, smp_processor_id());
-	twd_setup(clk);
+	twd_timer_setup(clk);
 
 	register_cpu_notifier(&twd_cpu_nb);
 
@@ -302,4 +274,3 @@ int __init twd_timer_of_init(const struct of_device_id *twd_of_match)
 	return twd_timer_common_init();
 }
 #endif
-#endif
-- 
1.7.7.1
