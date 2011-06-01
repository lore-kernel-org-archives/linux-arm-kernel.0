From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  1 Jun 2011 15:03:26 +0100
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer running
	early
Message-ID: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the boot CPU has its local timer enabled long after
the delay loop has been calibrated. This makes it impossible to
boot a system that only uses local timers, like the A15.

Use late_time_init hook to initialize the boot CPU local timer.
Since shmobile is already using this hook, add an ARM specific
arm_late_time_init hook that platforms can use instead.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/mach/time.h |    1 +
 arch/arm/kernel/smp.c            |    6 ------
 arch/arm/kernel/time.c           |   14 ++++++++++++++
 arch/arm/mach-shmobile/timer.c   |    2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index d5adaae..f46ca39 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -43,5 +43,6 @@ struct sys_timer {
 };
 
 extern void timer_tick(void);
+extern void (* __initdata arm_late_time_init)(void);
 
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 344e52b..70badae 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -364,12 +364,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	if (max_cpus > 1) {
 		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-
-		/*
 		 * Initialise the SCU if there are more than one CPU
 		 * and let them know where to start.
 		 */
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cb634c3..ba85044 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/mc146818rtc.h>
 
 #include <asm/leds.h>
+#include <asm/localtimer.h>
 #include <asm/thread_info.h>
 #include <asm/sched_clock.h>
 #include <asm/stacktrace.h>
@@ -147,6 +148,18 @@ static int __init timer_init_syscore_ops(void)
 
 device_initcall(timer_init_syscore_ops);
 
+void (* __initdata arm_late_time_init)(void);
+
+static void __init __arm_late_time_init(void)
+{
+	if (arm_late_time_init)
+		arm_late_time_init();
+#ifdef CONFIG_LOCAL_TIMERS
+	/* Init the local timer on the boot CPU */
+	percpu_timer_setup();
+#endif
+}
+
 void __init time_init(void)
 {
 	system_timer = machine_desc->timer;
@@ -154,5 +167,6 @@ void __init time_init(void)
 #ifdef CONFIG_HAVE_SCHED_CLOCK
 	sched_clock_postinit();
 #endif
+	late_time_init = __arm_late_time_init;
 }
 
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 895794b..835baa4 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -38,7 +38,7 @@ static void __init shmobile_late_time_init(void)
 
 static void __init shmobile_timer_init(void)
 {
-	late_time_init = shmobile_late_time_init;
+	arm_late_time_init = shmobile_late_time_init;
 }
 
 struct sys_timer shmobile_timer = {
-- 
1.7.0.4
