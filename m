From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:17 +0100
Subject: [PATCH v1 02/18] ARM: local timers: Add runtime registration interface
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current local timer code suffers from being resolved at link time,
preventing from having multiple implementations supported by the
same kernel.

Introduce a registration interface that the platform can call at
runtime. smp_twd.c now returns a set of operations that percpu_timer.c
can call.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |   48 +++++++++++++++-----------
 arch/arm/include/asm/smp_twd.h    |   27 +++++++++++++--
 arch/arm/kernel/percpu_timer.c    |   67 +++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/smp_twd.c         |   29 +++++++++++++++-
 4 files changed, 142 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index b3fd6ea..f95e527 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -29,39 +29,47 @@ irqreturn_t percpu_timer_handler(int irq, void *dev_id);
  */
 void percpu_timer_run(void);
 
-#ifdef CONFIG_LOCAL_TIMERS
-
-#ifdef CONFIG_HAVE_ARM_TWD
-
-#include "smp_twd.h"
-
-#define local_timer_ack()	twd_timer_ack()
-
-#else
-
-/*
- * Platform provides this to acknowledge a local timer IRQ.
- * Returns true if the local timer IRQ is to be processed.
- */
-int local_timer_ack(void);
-
-#endif
 /*
  * Stop a per-cpu timer
  */
 void percpu_timer_stop(void);
 
+struct local_timer_ops {
+	void	(*const pre_setup)(struct clock_event_device *clk);
+	int	(*plat_setup)(struct clock_event_device *clk);
+	void	(*plat_teardown)(struct clock_event_device *clk);
+	void	(*const setup)(struct clock_event_device *clk);
+	int	(*const ack)(void);
+};
+
+#ifdef CONFIG_LOCAL_TIMERS
 /*
  * Setup a local timer interrupt for a CPU.
  */
 int local_timer_setup(struct clock_event_device *);
 
+/*
+ * Register a local timer.
+ */
+void percpu_timer_register(struct local_timer_ops *);
 #else
-
-static inline int local_timer_setup(struct clock_event_device *evt)
+static inline void percpu_timer_register(void *dummy)
 {
-	return -ENXIO;
 }
 #endif
 
+static inline int percpu_timer_register_setup(struct local_timer_ops *ops,
+					      int (*plat_setup)(struct clock_event_device *),
+					      void (*plat_teardown)(struct clock_event_device *))
+{
+	if (ops) {
+		ops->plat_setup = plat_setup;
+		ops->plat_teardown = plat_teardown;
+		percpu_timer_register(ops);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 #endif
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index fed9981..4096736 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -1,6 +1,8 @@
 #ifndef __ASMARM_SMP_TWD_H
 #define __ASMARM_SMP_TWD_H
 
+#include <linux/clockchips.h>
+
 #define TWD_TIMER_LOAD			0x00
 #define TWD_TIMER_COUNTER		0x04
 #define TWD_TIMER_CONTROL		0x08
@@ -18,11 +20,28 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-struct clock_event_device;
-
 extern void __iomem *twd_base;
 
-int twd_timer_ack(void);
-void twd_timer_setup(struct clock_event_device *);
+#ifdef CONFIG_HAVE_ARM_TWD
+struct local_timer_ops *local_timer_get_twd_ops(void);
+int twd_timer_register_setup(int (*setup)(struct clock_event_device *));
+#else
+static inline struct local_timer_ops *local_timer_get_twd_ops(void)
+{
+	return NULL;
+}
+
+static inline int twd_timer_register_setup(int (*setup)(struct clock_event_device *))
+{
+	return -ENODEV;
+}
+#endif
+
+/*
+ * Dummy function, to be removed once there is no in-tree user anymore.
+ */
+static inline void twd_timer_setup(void *dummy)
+{
+}
 
 #endif
diff --git a/arch/arm/kernel/percpu_timer.c b/arch/arm/kernel/percpu_timer.c
index 4b6e230..94315f5 100644
--- a/arch/arm/kernel/percpu_timer.c
+++ b/arch/arm/kernel/percpu_timer.c
@@ -9,10 +9,13 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/irq.h>
+#include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
 
 #include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void broadcast_timer_set_mode(enum clock_event_mode mode,
@@ -38,6 +41,44 @@ static void broadcast_timer_setup(struct clock_event_device *evt)
 	clockevents_register_device(evt);
 }
 
+static struct local_timer_ops broadcast_timer_ops = {
+	.setup	= broadcast_timer_setup,
+};
+
+static struct local_timer_ops *timer_ops;
+
+int __attribute__ ((weak)) local_timer_setup(struct clock_event_device *evt)
+{
+	return -ENXIO;
+}
+
+void percpu_timer_register(struct local_timer_ops *ops)
+{
+	timer_ops = ops;
+}
+
+/*
+ * local_timer_ack: checks for a local timer interrupt.
+ *
+ * If a local timer interrupt has occurred, acknowledge and return 1.
+ * Otherwise, return 0.
+ *
+ * This can be overloaded by platform code that doesn't provide its
+ * timer in timer_fns way (msm at the moment). Once all platforms have
+ * migrated, the weak alias can be removed.
+ * If no ack() function has been registered, consider the acknowledgement
+ * to be done.
+ */
+static int percpu_timer_ack(void)
+{
+	if (timer_ops->ack)
+		return timer_ops->ack();
+
+	return 1;
+}
+
+int local_timer_ack(void) __attribute__ ((weak, alias("percpu_timer_ack")));
+
 /*
  * Timer (local or broadcast) support
  */
@@ -63,14 +104,32 @@ void percpu_timer_run(void)
 
 void __cpuinit percpu_timer_setup(void)
 {
+	int ret = 0;
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
 
+	/*
+	 * All this can go away once we've migrated all users to
+	 * properly register the timer they use, and broadcast can
+	 * become the fallback.
+	 */
+	if (!timer_ops)
+		timer_ops = local_timer_get_twd_ops();
+	if (!timer_ops)
+		timer_ops = &broadcast_timer_ops;
+	if (!timer_ops->plat_setup)
+		timer_ops->plat_setup = local_timer_setup;
+
 	evt->cpumask = cpumask_of(cpu);
-	evt->broadcast = smp_timer_broadcast;
 
-	if (local_timer_setup(evt))
-		broadcast_timer_setup(evt);
+	if (timer_ops->pre_setup)
+		timer_ops->pre_setup(evt);
+	if (timer_ops->plat_setup)
+		ret = timer_ops->plat_setup(evt);
+	if (ret)	/* Fallback to broadcast */
+		timer_ops = &broadcast_timer_ops;
+	if (timer_ops->setup)
+		timer_ops->setup(evt);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -85,5 +144,7 @@ void percpu_timer_stop(void)
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
 
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	if (timer_ops->plat_teardown)
+		timer_ops->plat_teardown(evt);
 }
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index aa99656..91296df 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
+#include <asm/localtimer.h>
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
@@ -74,7 +75,7 @@ static int twd_set_next_event(unsigned long evt,
  * If a local timer interrupt has occurred, acknowledge and return 1.
  * Otherwise, return 0.
  */
-int twd_timer_ack(void)
+static int twd_timer_ack(void)
 {
 	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
 		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
@@ -126,7 +127,7 @@ static void __cpuinit twd_calibrate_rate(void)
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static void __cpuinit twd_setup(struct clock_event_device *clk)
 {
 	int err;
 	bool *reqd;
@@ -161,3 +162,27 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	clockevents_register_device(clk);
 }
+
+static struct local_timer_ops twd_timer_ops = {
+	.setup		= twd_setup,
+	.ack		= twd_timer_ack,
+};
+
+struct local_timer_ops *local_timer_get_twd_ops(void)
+{
+	if (!twd_base) {
+		pr_warn("TWD base address not set\n");
+		return NULL;
+	}
+
+	return &twd_timer_ops;
+}
+
+int __init twd_timer_register_setup(int (*setup)(struct clock_event_device *))
+{
+	if (!twd_base)
+		return -ENODEV;
+
+	percpu_timer_register_setup(&twd_timer_ops, setup, NULL);
+	return 0;
+}
-- 
1.7.0.4
