From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:32 +0100
Subject: [PATCH v1 17/18] ARM: simplify percpu_timer_setup
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all in-tree providers of local_timer_setup() are dynamically
registering their timers with the per cpu timer code, remove the
legacy timer selection code.

If no local timer is provided, a broadcast timer will be used
as a fallback.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |    5 -----
 arch/arm/include/asm/smp_twd.h    |    8 +-------
 arch/arm/kernel/percpu_timer.c    |   20 +-------------------
 arch/arm/kernel/smp_twd.c         |   12 ++----------
 4 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index f95e527..263c1cf 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -44,11 +44,6 @@ struct local_timer_ops {
 
 #ifdef CONFIG_LOCAL_TIMERS
 /*
- * Setup a local timer interrupt for a CPU.
- */
-int local_timer_setup(struct clock_event_device *);
-
-/*
  * Register a local timer.
  */
 void percpu_timer_register(struct local_timer_ops *);
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index d2abe52..2c01220 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -23,15 +23,9 @@
 extern void __iomem *twd_base;
 
 #ifdef CONFIG_HAVE_ARM_TWD
-struct local_timer_ops *local_timer_get_twd_ops(void);
 int twd_timer_register_setup(int (*setup)(struct clock_event_device *));
 #else
-static inline struct local_timer_ops *local_timer_get_twd_ops(void)
-{
-	return NULL;
-}
-
-static inline int twd_timer_register_setup(int (*setup)(struct clock_event_device *))
+static inline int twd_timer_register_setup(void (*setup)(struct clock_event_device *))
 {
 	return -ENODEV;
 }
diff --git a/arch/arm/kernel/percpu_timer.c b/arch/arm/kernel/percpu_timer.c
index 94315f5..f442d3f 100644
--- a/arch/arm/kernel/percpu_timer.c
+++ b/arch/arm/kernel/percpu_timer.c
@@ -15,7 +15,6 @@
 #include <linux/clockchips.h>
 
 #include <asm/localtimer.h>
-#include <asm/smp_twd.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void broadcast_timer_set_mode(enum clock_event_mode mode,
@@ -45,12 +44,7 @@ static struct local_timer_ops broadcast_timer_ops = {
 	.setup	= broadcast_timer_setup,
 };
 
-static struct local_timer_ops *timer_ops;
-
-int __attribute__ ((weak)) local_timer_setup(struct clock_event_device *evt)
-{
-	return -ENXIO;
-}
+static struct local_timer_ops *timer_ops = &broadcast_timer_ops;
 
 void percpu_timer_register(struct local_timer_ops *ops)
 {
@@ -108,18 +102,6 @@ void __cpuinit percpu_timer_setup(void)
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
 
-	/*
-	 * All this can go away once we've migrated all users to
-	 * properly register the timer they use, and broadcast can
-	 * become the fallback.
-	 */
-	if (!timer_ops)
-		timer_ops = local_timer_get_twd_ops();
-	if (!timer_ops)
-		timer_ops = &broadcast_timer_ops;
-	if (!timer_ops->plat_setup)
-		timer_ops->plat_setup = local_timer_setup;
-
 	evt->cpumask = cpumask_of(cpu);
 
 	if (timer_ops->pre_setup)
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 91296df..5773955 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -168,20 +168,12 @@ static struct local_timer_ops twd_timer_ops = {
 	.ack		= twd_timer_ack,
 };
 
-struct local_timer_ops *local_timer_get_twd_ops(void)
+int __init twd_timer_register_setup(int (*setup)(struct clock_event_device *))
 {
 	if (!twd_base) {
 		pr_warn("TWD base address not set\n");
-		return NULL;
-	}
-
-	return &twd_timer_ops;
-}
-
-int __init twd_timer_register_setup(int (*setup)(struct clock_event_device *))
-{
-	if (!twd_base)
 		return -ENODEV;
+	}
 
 	percpu_timer_register_setup(&twd_timer_ops, setup, NULL);
 	return 0;
-- 
1.7.0.4
