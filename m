From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 13:52:40 +0000
Subject: [PATCH v3 15/15] ARM: local timers: make the runtime registration
 interface mandatory
In-Reply-To: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
References: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326721960-2224-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all traces of the compile-time local timer interface,
and make the runtime selection mandatory.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |   26 --------------------------
 arch/arm/kernel/smp.c             |   23 ++++++-----------------
 2 files changed, 6 insertions(+), 43 deletions(-)

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
index 69d5f8b..09c720e 100644
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
@@ -488,21 +490,7 @@ int local_timer_register(struct local_timer_ops *ops)
 }
 #endif
 
-int __cpuinit __attribute__ ((weak)) local_timer_setup(struct clock_event_device *clk)
-{
-	if (lt_ops)
-		return lt_ops->setup(clk);
-
-	return -ENXIO;
-}
-
-void __attribute__ ((weak)) local_timer_stop(struct clock_event_device *clk)
-{
-	if (lt_ops)
-		lt_ops->stop(clk);
-}
-
-void __cpuinit percpu_timer_setup(void)
+static void __cpuinit percpu_timer_setup(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
@@ -510,7 +498,7 @@ void __cpuinit percpu_timer_setup(void)
 	evt->cpumask = cpumask_of(cpu);
 	evt->broadcast = smp_timer_broadcast;
 
-	if (local_timer_setup(evt))
+	if (!lt_ops || lt_ops->setup(evt))
 		broadcast_timer_setup(evt);
 }
 
@@ -525,7 +513,8 @@ static void percpu_timer_stop(void)
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
 
-	local_timer_stop(evt);
+	if (lt_ops)
+		lt_ops->stop(evt);
 }
 #endif
 
-- 
1.7.7.1
