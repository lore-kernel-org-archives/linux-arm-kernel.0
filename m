From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:29 +0100
Subject: [PATCH v1 14/18] ARM: shmobile: dynamically register local timer
	setup function
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile     |    1 -
 arch/arm/mach-shmobile/localtimer.c |   26 --------------------------
 arch/arm/mach-shmobile/timer.c      |   16 +++++++++++++++-
 3 files changed, 15 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 612b270..82ec6e9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 
 # Pinmux setup
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
deleted file mode 100644
index e09fdd1..0000000
--- a/arch/arm/mach-shmobile/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * SMP support for R-Mobile / SH-Mobile - local timer portion
- *
- * Copyright (C) 2010  Magnus Damm
- *
- * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(29);
-	return 0;
-}
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 835baa4..0d23fa3 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -19,6 +19,9 @@
  *
  */
 #include <linux/platform_device.h>
+#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach/time.h>
 
 static void __init shmobile_late_time_init(void)
@@ -36,9 +39,20 @@ static void __init shmobile_late_time_init(void)
 	early_platform_driver_probe("earlytimer", 2, 0);
 }
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit shmobile_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = gic_ppi_to_vppi(29);
+	return 0;
+}
+#else
+#define shmobile_local_timer_setup	NULL
+#endif
+
 static void __init shmobile_timer_init(void)
 {
-	arm_late_time_init = shmobile_late_time_init;
+	twd_timer_register_setup(shmobile_local_timer_setup);
+	late_time_init = shmobile_late_time_init;
 }
 
 struct sys_timer shmobile_timer = {
-- 
1.7.0.4
