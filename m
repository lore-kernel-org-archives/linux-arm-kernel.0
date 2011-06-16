From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:29 +0100
Subject: [RFC PATCH 01/16] ARM: local timers: early device probing hooks
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce hooks to probe local timers registered as early devices.
Use the late_time_init hook to perform the probing. Since shmobile
is already using this hook, add an ARM specific arm_late_time_init
hook that platforms can use instead.

This is controlled by a new config option (LOCAL_TIMER_DEVICES)
which prevents LOCAL_TIMERS from being selected, as the two
clearly conflict.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                 |    5 ++++-
 arch/arm/include/asm/mach/time.h |    1 +
 arch/arm/kernel/time.c           |   15 +++++++++++++++
 arch/arm/mach-shmobile/timer.c   |    2 +-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdc89ed..dafb20a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1415,7 +1415,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP
+	depends on SMP && !LOCAL_TIMER_DEVICES
 	default y
 	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
@@ -1424,6 +1424,9 @@ config LOCAL_TIMERS
 	  accounting to be spread across the timer interval, preventing a
 	  "thundering herd" at every timer tick.
 
+config LOCAL_TIMER_DEVICES
+	bool
+
 source kernel/Kconfig.preempt
 
 config HZ
diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index d5adaae..f46ca39 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -43,5 +43,6 @@ struct sys_timer {
 };
 
 extern void timer_tick(void);
+extern void (* __initdata arm_late_time_init)(void);
 
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cb634c3..32d0df8 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -24,6 +24,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
+#include <linux/platform_device.h>
 
 #include <linux/mc146818rtc.h>
 
@@ -147,6 +148,19 @@ static int __init timer_init_syscore_ops(void)
 
 device_initcall(timer_init_syscore_ops);
 
+void (* __initdata arm_late_time_init)(void);
+
+static void __init __arm_late_time_init(void)
+{
+	if (arm_late_time_init)
+		arm_late_time_init();
+
+#ifdef CONFIG_LOCAL_TIMER_DEVICES
+	early_platform_driver_register_all("localtimer");
+	early_platform_driver_probe("localtimer", 1, 0);
+#endif
+}
+
 void __init time_init(void)
 {
 	system_timer = machine_desc->timer;
@@ -154,5 +168,6 @@ void __init time_init(void)
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
