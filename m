From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2012 13:08:54 +0000
Subject: [PATCH 15/15] ARM: local timers: make the runtime registration
 interface mandatory
In-Reply-To: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326287334-1905-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all traces of the compile-time local timer interface,
and make the runtime selection mandatory.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |   26 --------------------------
 arch/arm/kernel/smp.c             |   10 ++++++----
 2 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 955eed1..f77ffc1 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -19,38 +19,12 @@ struct local_timer_ops {
 	void (*stop)(struct clock_event_device *);
 };
 
-/*
- * Setup a per-cpu timer, whether it be a local timer or dummy broadcast
- */
-void percpu_timer_setup(void);
-
 #ifdef CONFIG_LOCAL_TIMERS
 /*
- * Stop the local timer
- */
-void local_timer_stop(struct clock_event_device *);
-
-/*
- * Setup a local timer interrupt for a CPU.
- */
-int local_timer_setup(struct clock_event_device *);
-
-/*
  * Register a local timer driver
  */
 int local_timer_register(struct local_timer_ops *);
-
 #else
-
-static inline int local_timer_setup(struct clock_event_device *evt)
-{
-	return -ENXIO;
-}
-
-static inline void local_timer_stop(struct clock_event_device *evt)
-{
-}
-
 static inline int local_timer_register(struct local_timer_ops *ops)
 {
 	return -ENXIO;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d36c978..18e7878 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -260,6 +260,8 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
 	store_cpu_topology(cpuid);
 }
 
+static void percpu_timer_setup(void);
+
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
@@ -486,7 +488,7 @@ int local_timer_register(struct local_timer_ops *ops)
 	return 0;
 }
 
-int __attribute__ ((weak)) local_timer_setup(struct clock_event_device *clk)
+static int local_timer_setup(struct clock_event_device *clk)
 {
 	if (lt_ops)
 		return lt_ops->setup(clk);
@@ -494,13 +496,13 @@ int __attribute__ ((weak)) local_timer_setup(struct clock_event_device *clk)
 	return -ENXIO;
 }
 
-void __attribute__ ((weak)) local_timer_stop(struct clock_event_device *clk)
+static void local_timer_stop(struct clock_event_device *clk)
 {
 	if (lt_ops)
 		lt_ops->stop(clk);
 }
-	
-void __cpuinit percpu_timer_setup(void)
+
+static void __cpuinit percpu_timer_setup(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
-- 
1.7.7.1
