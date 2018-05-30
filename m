From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 May 2018 17:15:28 +0200
Subject: [PATCH 3/3] ARM: shmobile: apmu: Remove platsmp-apmu.h
In-Reply-To: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
References: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527693328-10559-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the removal of the legacy SMP fallbacks, platsmp-apmu.h is no
longer needed outside platsmp-apmu.c.

Hence remove platsmp-apmu.h, and make the functions exported previously
static.  As the header file also provided forward declarations, the code
in platsmp-apmu.c must be reshuffled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 200 +++++++++++++++++-----------------
 arch/arm/mach-shmobile/platsmp-apmu.h |  24 ----
 2 files changed, 100 insertions(+), 124 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/platsmp-apmu.h

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 42c9405e556b14aa..9e1e85cf1899171d 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -23,7 +23,6 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include "common.h"
-#include "platsmp-apmu.h"
 #include "rcar-gen2.h"
 
 static struct {
@@ -87,6 +86,104 @@ static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu)
 	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
 }
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
+/* nicked from arch/arm/mach-exynos/hotplug.c */
+static inline void cpu_enter_lowpower_a15(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"       mrc     p15, 0, %0, c1, c0, 0\n"
+	"       bic     %0, %0, %1\n"
+	"       mcr     p15, 0, %0, c1, c0, 0\n"
+		: "=&r" (v)
+		: "Ir" (CR_C)
+		: "cc");
+
+	flush_cache_louis();
+
+	asm volatile(
+	/*
+	 * Turn off coherency
+	 */
+	"       mrc     p15, 0, %0, c1, c0, 1\n"
+	"       bic     %0, %0, %1\n"
+	"       mcr     p15, 0, %0, c1, c0, 1\n"
+		: "=&r" (v)
+		: "Ir" (0x40)
+		: "cc");
+
+	isb();
+	dsb();
+}
+
+static void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
+{
+
+	/* Select next sleep mode using the APMU */
+	apmu_wrap(cpu, apmu_power_off);
+
+	/* Do ARM specific CPU shutdown */
+	cpu_enter_lowpower_a15();
+}
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+static void shmobile_smp_apmu_cpu_die(unsigned int cpu)
+{
+	/* For this particular CPU deregister boot vector */
+	shmobile_smp_hook(cpu, 0, 0);
+
+	/* Shutdown CPU core */
+	shmobile_smp_apmu_cpu_shutdown(cpu);
+
+	/* jump to shared mach-shmobile sleep / reset code */
+	shmobile_smp_sleep();
+}
+
+static int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
+{
+	return apmu_wrap(cpu, apmu_power_off_poll);
+}
+#endif
+
+#if defined(CONFIG_SUSPEND)
+static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
+{
+	shmobile_smp_hook(cpu, __pa_symbol(cpu_resume), 0);
+	shmobile_smp_apmu_cpu_shutdown(cpu);
+	cpu_do_idle(); /* WFI selects Core Standby */
+	return 1;
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile("mrc    p15, 0, %0, c1, c0, 0\n"
+		     "       orr     %0, %0, %1\n"
+		     "       mcr     p15, 0, %0, c1, c0, 0\n"
+		     "       mrc     p15, 0, %0, c1, c0, 1\n"
+		     "       orr     %0, %0, %2\n"
+		     "       mcr     p15, 0, %0, c1, c0, 1\n"
+		     : "=&r" (v)
+		     : "Ir" (CR_C), "Ir" (0x40)
+		     : "cc");
+}
+
+static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
+{
+	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
+	cpu_leave_lowpower();
+	return 0;
+}
+
+void __init shmobile_smp_apmu_suspend_init(void)
+{
+	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
+}
+#endif
+
 #ifdef CONFIG_SMP
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
@@ -162,7 +259,8 @@ static void __init shmobile_smp_apmu_setup_boot(void)
 	shmobile_boot_fn_gen2 = shmobile_boot_fn;
 }
 
-int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
+					    struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
 	shmobile_smp_hook(cpu, __pa_symbol(shmobile_boot_apmu), 0);
@@ -189,101 +287,3 @@ static struct smp_operations apmu_smp_ops __initdata = {
 
 CPU_METHOD_OF_DECLARE(shmobile_smp_apmu, "renesas,apmu", &apmu_smp_ops);
 #endif /* CONFIG_SMP */
-
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
-/* nicked from arch/arm/mach-exynos/hotplug.c */
-static inline void cpu_enter_lowpower_a15(void)
-{
-	unsigned int v;
-
-	asm volatile(
-	"       mrc     p15, 0, %0, c1, c0, 0\n"
-	"       bic     %0, %0, %1\n"
-	"       mcr     p15, 0, %0, c1, c0, 0\n"
-		: "=&r" (v)
-		: "Ir" (CR_C)
-		: "cc");
-
-	flush_cache_louis();
-
-	asm volatile(
-	/*
-	 * Turn off coherency
-	 */
-	"       mrc     p15, 0, %0, c1, c0, 1\n"
-	"       bic     %0, %0, %1\n"
-	"       mcr     p15, 0, %0, c1, c0, 1\n"
-		: "=&r" (v)
-		: "Ir" (0x40)
-		: "cc");
-
-	isb();
-	dsb();
-}
-
-static void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
-{
-
-	/* Select next sleep mode using the APMU */
-	apmu_wrap(cpu, apmu_power_off);
-
-	/* Do ARM specific CPU shutdown */
-	cpu_enter_lowpower_a15();
-}
-#endif
-
-#if defined(CONFIG_HOTPLUG_CPU)
-void shmobile_smp_apmu_cpu_die(unsigned int cpu)
-{
-	/* For this particular CPU deregister boot vector */
-	shmobile_smp_hook(cpu, 0, 0);
-
-	/* Shutdown CPU core */
-	shmobile_smp_apmu_cpu_shutdown(cpu);
-
-	/* jump to shared mach-shmobile sleep / reset code */
-	shmobile_smp_sleep();
-}
-
-int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
-{
-	return apmu_wrap(cpu, apmu_power_off_poll);
-}
-#endif
-
-#if defined(CONFIG_SUSPEND)
-static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
-{
-	shmobile_smp_hook(cpu, __pa_symbol(cpu_resume), 0);
-	shmobile_smp_apmu_cpu_shutdown(cpu);
-	cpu_do_idle(); /* WFI selects Core Standby */
-	return 1;
-}
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile("mrc    p15, 0, %0, c1, c0, 0\n"
-		     "       orr     %0, %0, %1\n"
-		     "       mcr     p15, 0, %0, c1, c0, 0\n"
-		     "       mrc     p15, 0, %0, c1, c0, 1\n"
-		     "       orr     %0, %0, %2\n"
-		     "       mcr     p15, 0, %0, c1, c0, 1\n"
-		     : "=&r" (v)
-		     : "Ir" (CR_C), "Ir" (0x40)
-		     : "cc");
-}
-
-static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
-{
-	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
-	cpu_leave_lowpower();
-	return 0;
-}
-
-void __init shmobile_smp_apmu_suspend_init(void)
-{
-	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
-}
-#endif
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.h b/arch/arm/mach-shmobile/platsmp-apmu.h
deleted file mode 100644
index 70424572b9da2e70..0000000000000000
--- a/arch/arm/mach-shmobile/platsmp-apmu.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * rmobile apmu definition
- *
- * Copyright (C) 2014  Renesas Electronics Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef PLATSMP_APMU_H
-#define PLATSMP_APMU_H
-
-extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
-					    struct task_struct *idle);
-extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
-extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
-
-#endif /* PLATSMP_APMU_H */
-- 
2.7.4
